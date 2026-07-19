#pragma once

#include <string_view>
#include <vector>
#include <iostream>
#include <meta>
#include <array>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <cstring>
#include <cstdlib>
#include <string>
#include <functional>

#ifdef _WIN32
    #ifdef JNL_EXPORTS
        #define JNL_EXPORT __declspec(dllexport)
    #else
        #define JNL_EXPORT __declspec(dllimport)
    #endif
#else
    #define JNL_EXPORT __attribute__((visibility("default")))
#endif

extern "C" {

struct JNLMethod {
    const char* name;
    void* func_ptr;
};

struct JNLField {
    const char* name;
    void* getter_ptr;
    void* setter_ptr;
};

struct JNLThreadError {
    bool has_error;
    char message[1024];
};

struct JNLClassRegistry {
    const char* class_name;
    
    JNLMethod* methods;
    size_t num_methods;
    
    JNLMethod* constructors;
    size_t num_constructors;
    
    void* destructor;
    
    JNLField* fields;
    size_t num_fields;
};

// Global registration function that FFM can call
JNL_EXPORT const JNLClassRegistry* JNL_GetRegistry(const char* class_name);
JNL_EXPORT void* JNL_GetLastError();
JNL_EXPORT void JNL_ClearLastError();
JNL_EXPORT void JNL_Free(void* ptr);

} // extern "C"

namespace jnl {

JNL_EXPORT void set_error(const char* msg);

// Registration function used by the macro
JNL_EXPORT void register_class(const JNLClassRegistry& reg);

// --- Core Reflection Wrappers ---

// TypeMapper maps C++ types to ABI-safe C types for FFM
template <typename T, typename Enable = void>
struct TypeMapper {
    // Default for by-value objects (pointers passed from Java)
    using NativeType = void*;
    static T to_cpp(NativeType val) {
        return *static_cast<T*>(val);
    }
    static NativeType to_native(T val) {
        return new T(std::move(val));
    }
};

template <typename T>
struct TypeMapper<T, std::enable_if_t<std::is_arithmetic_v<T>>> {
    using NativeType = T;
    static T to_cpp(NativeType val) { return val; }
    static NativeType to_native(T val) { return val; }
};

template <>
struct TypeMapper<std::string> {
    using NativeType = const char*;
    static std::string to_cpp(NativeType val) {
        return val ? std::string(val) : std::string();
    }
    // We cannot safely return dynamically allocated C strings without a free mechanism,
    // but for now we strdup. The Java side is expected to free it or we use arenas.
    // For now we just strdup it to avoid lifetime issues (a leak if not freed by caller).
    static NativeType to_native(const std::string& val) {
        char* cstr = (char*)malloc(val.size() + 1);
        std::strcpy(cstr, val.c_str());
        return cstr;
    }
};

template <typename T>
struct TypeMapper<T&> {
    using NativeType = T*;
    static T& to_cpp(NativeType val) { return *val; }
    static NativeType to_native(T& val) { return &val; }
};

template <typename T>
struct TypeMapper<const T&> {
    using NativeType = const T*;
    static const T& to_cpp(NativeType val) { return *val; }
    static NativeType to_native(const T& val) { return &val; }
};

template <typename T>
struct TypeMapper<T*> {
    using NativeType = T*;
    static T* to_cpp(NativeType val) { return val; }
    static NativeType to_native(T* val) { return val; }
};

template <typename T>
struct TypeMapper<const T*> {
    using NativeType = const T*;
    static const T* to_cpp(NativeType val) { return val; }
    static NativeType to_native(const T* val) { return val; }
};

template <>
struct TypeMapper<void> {
    using NativeType = void;
};

template <typename Ret, typename... Args>
struct TypeMapper<std::function<Ret(Args...)>> {
    using NativeType = void*; // Function pointer
    using CFuncType = typename TypeMapper<Ret>::NativeType (*)(typename TypeMapper<Args>::NativeType...);
    
    static std::function<Ret(Args...)> to_cpp(NativeType val) {
        if (!val) return nullptr;
        CFuncType c_func = reinterpret_cast<CFuncType>(val);
        return [c_func](Args... args) -> Ret {
            if constexpr (std::is_void_v<Ret>) {
                c_func(TypeMapper<Args>::to_native(args)...);
            } else {
                return TypeMapper<Ret>::to_cpp(c_func(TypeMapper<Args>::to_native(args)...));
            }
        };
    }
    
    static NativeType to_native(const std::function<Ret(Args...)>& val) {
        // Passing std::function from C++ to Java is not supported dynamically without libffi closures.
        return nullptr;
    }
};


// Non-const member function wrapper
template<typename Class, typename Ret, typename... Args>
struct MethodWrapper {
    template<auto MemPtr>
    static typename TypeMapper<Ret>::NativeType wrapper(void* obj, typename TypeMapper<Args>::NativeType... args) {
        try {
            if constexpr (std::is_void_v<Ret>) {
                (static_cast<Class*>(obj)->*MemPtr)(TypeMapper<Args>::to_cpp(args)...);
            } else {
                return TypeMapper<Ret>::to_native((static_cast<Class*>(obj)->*MemPtr)(TypeMapper<Args>::to_cpp(args)...));
            }
        } catch (const std::exception& e) {
            set_error(e.what());
            if constexpr (!std::is_void_v<Ret>) return typename TypeMapper<Ret>::NativeType{};
        } catch (...) {
            set_error("Unknown C++ exception");
            if constexpr (!std::is_void_v<Ret>) return typename TypeMapper<Ret>::NativeType{};
        }
    }
};

// Const member function wrapper
template<typename Class, typename Ret, typename... Args>
struct ConstMethodWrapper {
    template<auto MemPtr>
    static typename TypeMapper<Ret>::NativeType wrapper(void* obj, typename TypeMapper<Args>::NativeType... args) {
        try {
            if constexpr (std::is_void_v<Ret>) {
                (static_cast<const Class*>(obj)->*MemPtr)(TypeMapper<Args>::to_cpp(args)...);
            } else {
                return TypeMapper<Ret>::to_native((static_cast<const Class*>(obj)->*MemPtr)(TypeMapper<Args>::to_cpp(args)...));
            }
        } catch (const std::exception& e) {
            set_error(e.what());
            if constexpr (!std::is_void_v<Ret>) return typename TypeMapper<Ret>::NativeType{};
        } catch (...) {
            set_error("Unknown C++ exception");
            if constexpr (!std::is_void_v<Ret>) return typename TypeMapper<Ret>::NativeType{};
        }
    }
};

template<typename Class, typename Signature>
struct SignatureTraits;

template<typename Class, typename Ret, typename... Args>
struct SignatureTraits<Class, Ret(Class::*)(Args...)> {
    using Wrapper = MethodWrapper<Class, Ret, Args...>;
};

template<typename Class, typename Ret, typename... Args>
struct SignatureTraits<Class, Ret(Class::*)(Args...) const> {
    using Wrapper = ConstMethodWrapper<Class, Ret, Args...>;
};

template<typename Class, typename Ret, typename... Args>
struct SignatureTraits<Class, Ret(Class::*)(Args...) noexcept> {
    using Wrapper = MethodWrapper<Class, Ret, Args...>;
};

template<typename Class, typename Ret, typename... Args>
struct SignatureTraits<Class, Ret(Class::*)(Args...) const noexcept> {
    using Wrapper = ConstMethodWrapper<Class, Ret, Args...>;
};

consteval bool is_exported_method(std::meta::info mem) {
    if (!std::meta::is_function(mem)) return false;
    if (std::meta::is_constructor(mem)) return false;
    if (std::meta::is_destructor(mem)) return false;
    if (std::meta::is_operator_function(mem)) return false;
    if (!std::meta::has_identifier(mem)) return false;
    return true;
}

consteval size_t count_methods(std::meta::info cls) {
    size_t count = 0;
    for (auto mem : std::meta::members_of(cls, std::meta::access_context::unchecked())) {
        if (is_exported_method(mem)) count++;
    }
    return count;
}

template<size_t N>
consteval std::array<std::meta::info, N> get_methods(std::meta::info cls) {
    std::array<std::meta::info, N> arr{};
    size_t i = 0;
    for (auto mem : std::meta::members_of(cls, std::meta::access_context::unchecked())) {
        if (is_exported_method(mem)) {
            if (i < N) arr[i++] = mem;
        }
    }
    return arr;
}

template<typename T, size_t N, std::array<std::meta::info, N> Methods, size_t I = 0>
void fill_methods(JNLMethod* out) {
    if constexpr (I < N) {
        constexpr auto mem = Methods[I];
        constexpr auto ptr = &[: mem :];
        using Sig = std::remove_const_t<decltype(ptr)>;
        using Traits = SignatureTraits<T, Sig>;
        
        out[I].name = std::meta::identifier_of(mem).data();
        out[I].func_ptr = (void*)&Traits::Wrapper::template wrapper<ptr>;
        
        fill_methods<T, N, Methods, I + 1>(out);
    }
}

// --- Constructors ---

consteval bool is_exported_constructor(std::meta::info mem) {
    if (!std::meta::is_constructor(mem)) return false;
    if (std::meta::is_special_member_function(mem)) {
        if (std::meta::parameters_of(mem).size() > 0) return false;
    }
    return true;
}

consteval size_t count_constructors(std::meta::info cls) {
    size_t count = 0;
    for (auto mem : std::meta::members_of(cls, std::meta::access_context::unchecked())) {
        if (is_exported_constructor(mem)) count++;
    }
    return count;
}

template<size_t N>
consteval std::array<std::meta::info, N> get_constructors(std::meta::info cls) {
    std::array<std::meta::info, N> arr{};
    size_t i = 0;
    for (auto mem : std::meta::members_of(cls, std::meta::access_context::unchecked())) {
        if (is_exported_constructor(mem)) {
            if (i < N) arr[i++] = mem;
        }
    }
    return arr;
}

template<size_t N>
consteval std::array<std::meta::info, N> get_params_of(std::meta::info mem) {
    std::array<std::meta::info, N> arr{};
    if constexpr (N > 0) {
        auto params = std::meta::parameters_of(mem);
        for(size_t i=0; i<N; ++i) arr[i] = params[i];
    }
    return arr;
}

template<typename Class, typename... Args>
struct ConstructorWrapper {
    static void* wrapper(typename TypeMapper<Args>::NativeType... args) {
        try {
            return new Class(TypeMapper<Args>::to_cpp(args)...);
        } catch (const std::exception& e) {
            set_error(e.what());
            return nullptr;
        } catch (...) {
            set_error("Unknown C++ exception in constructor");
            return nullptr;
        }
    }
};

template<typename Class, size_t M, std::array<std::meta::info, M> Params>
struct ConstructorInvoker {
    template<size_t... I>
    static void* invoke(std::index_sequence<I...>) {
        return (void*)&ConstructorWrapper<Class, typename [: std::meta::type_of(Params[I]) :]...>::wrapper;
    }
    
    static void* get_wrapper() {
        return invoke(std::make_index_sequence<M>{});
    }
};

template<typename T, size_t N, std::array<std::meta::info, N> Constructors, size_t I = 0>
void fill_constructors(JNLMethod* out) {
    if constexpr (I < N) {
        constexpr auto mem = Constructors[I];
        
        constexpr auto get_param_count = [](std::meta::info m) consteval {
            return std::meta::parameters_of(m).size();
        };
        constexpr size_t M = get_param_count(mem);
        constexpr auto params = get_params_of<M>(mem);
        
        out[I].name = "<init>";
        out[I].func_ptr = ConstructorInvoker<T, M, params>::get_wrapper();
        
        fill_constructors<T, N, Constructors, I + 1>(out);
    }
}

// Destructor wrapper
template<typename T>
void destroy_wrapper(void* obj) {
    delete static_cast<T*>(obj);
}

// Fields
template<typename Class, std::meta::info Field>
struct FieldGetter {
    using FieldType = typename [: std::meta::type_of(Field) :];
    static typename TypeMapper<FieldType>::NativeType wrapper(void* obj) {
        try { return TypeMapper<FieldType>::to_native(static_cast<Class*>(obj)->[: Field :]); }
        catch (...) { return typename TypeMapper<FieldType>::NativeType{}; }
    }
};

template<typename Class, std::meta::info Field>
struct FieldSetter {
    using FieldType = typename [: std::meta::type_of(Field) :];
    static void wrapper(void* obj, typename TypeMapper<FieldType>::NativeType val) {
        try { static_cast<Class*>(obj)->[: Field :] = TypeMapper<FieldType>::to_cpp(val); }
        catch (...) { }
    }
};

template<std::meta::info ClassMeta>
consteval size_t count_fields() {
    size_t count = 0;
    for (auto mem : std::meta::members_of(ClassMeta, std::meta::access_context::unchecked())) {
        if (std::meta::is_nonstatic_data_member(mem)) {
            count++;
        }
    }
    return count;
}

template<size_t N, std::meta::info ClassMeta>
consteval std::array<std::meta::info, N> get_fields() {
    std::array<std::meta::info, N> arr{};
    size_t i = 0;
    for (auto mem : std::meta::members_of(ClassMeta, std::meta::access_context::unchecked())) {
        if (std::meta::is_nonstatic_data_member(mem)) {
            arr[i++] = mem;
        }
    }
    return arr;
}

template<size_t N, std::array<std::meta::info, N> Fields, typename Class, size_t I = 0>
void fill_fields(JNLField* out) {
    if constexpr (I < N) {
        constexpr auto field = Fields[I];
        out[I].name = std::meta::identifier_of(field).data();
        
        using FieldType = typename [: std::meta::type_of(field) :];
        
        out[I].getter_ptr = reinterpret_cast<void*>(&FieldGetter<Class, field>::wrapper);
        
        if constexpr (!std::is_const_v<FieldType> && !std::is_reference_v<FieldType>) {
            out[I].setter_ptr = reinterpret_cast<void*>(&FieldSetter<Class, field>::wrapper);
        } else {
            out[I].setter_ptr = nullptr;
        }
        
        fill_fields<N, Fields, Class, I + 1>(out);
    }
}

// Main class exporter
template<typename T>
struct ClassExporter {
    static const JNLClassRegistry& get(const char* explicit_name = nullptr) {
        constexpr auto cls = ^^T;
        
        constexpr size_t M = count_methods(cls);
        constexpr auto methods = get_methods<M>(cls);
        static JNLMethod method_array[M == 0 ? 1 : M];
        
        constexpr size_t C = count_constructors(cls);
        constexpr auto constructors = get_constructors<C>(cls);
        static JNLMethod constructor_array[C == 0 ? 1 : C];

        constexpr size_t F = count_fields<cls>();
        constexpr auto fields = get_fields<F, cls>();
        static JNLField field_array[F == 0 ? 1 : F];
        
        static bool initialized = false;
        if (!initialized) {
            if constexpr (M > 0) fill_methods<T, M, methods>(method_array);
            if constexpr (C > 0) fill_constructors<T, C, constructors>(constructor_array);
            if constexpr (F > 0) fill_fields<F, fields, T>(field_array);
            initialized = true;
        }
        
        static JNLClassRegistry reg {
            .class_name = explicit_name ? explicit_name : std::meta::identifier_of(cls).data(),
            .methods = method_array,
            .num_methods = M,
            .constructors = constructor_array,
            .num_constructors = C,
            .destructor = (void*)&destroy_wrapper<T>,
            .fields = field_array,
            .num_fields = F
        };
        return reg;
    }
};

} // namespace jnl

// Macro to export a class
#define JNL_EXPORT_CLASS(ClassName) \
    __attribute__((constructor)) static void ClassName##_JNL_Exporter_Func() { \
        printf("JNL_EXPORT_CLASS constructor running for %s\n", #ClassName); \
        jnl::register_class(jnl::ClassExporter<ClassName>::get(#ClassName)); \
    }
