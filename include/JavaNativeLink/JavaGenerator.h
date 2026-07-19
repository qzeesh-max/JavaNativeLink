#pragma once

#include <iostream>
#include <string>
#include <string_view>
#include <meta>
#include <vector>
#include <array>
#include <type_traits>
#include "JavaNativeLink/Exporter.h"

namespace JNL {

struct JavaTypeMapping {
    std::string_view java_type;
    std::string_view ffm_type;
    std::string_view value_layout;
    std::string_view cast_to_ffm;
    std::string_view cast_from_ffm;
    bool is_array;
    std::string_view array_layout;
    bool is_string = false;
    bool is_object = false;
    std::string_view object_class_name = "";
};

template<bool HasId, std::meta::info Info>
struct IdGetter;

template<std::meta::info Info>
struct IdGetter<true, Info> {
    static consteval std::string_view get() { return std::meta::identifier_of(Info); }
};

template<std::meta::info Info>
struct IdGetter<false, Info> {
    static consteval std::string_view get() { return ""; }
};


template<typename Base>
consteval JavaTypeMapping map_type_actual() {
    if constexpr (std::is_void_v<Base>) return {"void", "void", "", "", "", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, int>) return {"int", "int", "ValueLayout.JAVA_INT", "(int)", "(int)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, unsigned int>) return {"long", "int", "ValueLayout.JAVA_INT", "(int)", " & 0xFFFFFFFFL", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, short>) return {"short", "short", "ValueLayout.JAVA_SHORT", "(short)", "(short)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, unsigned short>) return {"int", "short", "ValueLayout.JAVA_SHORT", "(short)", " & 0xFFFF", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, char> || std::is_same_v<Base, signed char>) return {"byte", "byte", "ValueLayout.JAVA_BYTE", "(byte)", "(byte)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, unsigned char>) return {"short", "byte", "ValueLayout.JAVA_BYTE", "(byte)", " & 0xFF", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, long> || std::is_same_v<Base, long long>) return {"long", "long", "ValueLayout.JAVA_LONG", "(long)", "(long)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, unsigned long> || std::is_same_v<Base, unsigned long long>) return {"long", "long", "ValueLayout.JAVA_LONG", "(long)", "(long)", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, float>) return {"float", "float", "ValueLayout.JAVA_FLOAT", "(float)", "(float)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, double>) return {"double", "double", "ValueLayout.JAVA_DOUBLE", "(double)", "(double)", false, "", false, false, ""};
    if constexpr (std::is_same_v<Base, bool>) return {"boolean", "boolean", "ValueLayout.JAVA_BOOLEAN", "(boolean)", "(boolean)", false, "", false, false, ""};
    
    if constexpr (std::is_same_v<Base, std::string>) return {"String", "MemorySegment", "ValueLayout.ADDRESS", "", "", false, "", true, false, ""};
    
    if constexpr (std::is_class_v<Base>) {
        constexpr std::string_view id = IdGetter<std::meta::has_identifier(^^Base), ^^Base>::get();
        if constexpr (!id.empty()) {
            return {id.data(), "MemorySegment", "ValueLayout.ADDRESS", "", "", false, "", false, true, id.data()};
        }
        return {"MemorySegment", "MemorySegment", "ValueLayout.ADDRESS", "", "", false, "", false, false, ""};
    }
    
    return {"MemorySegment", "MemorySegment", "ValueLayout.ADDRESS", "(MemorySegment)", "(MemorySegment)", false, "", false, false, ""};
}

template<typename T>
consteval JavaTypeMapping map_type() {
    constexpr bool is_ptr = std::is_pointer_v<std::remove_reference_t<T>>;
    constexpr bool is_ref = std::is_reference_v<T>;
    
    if constexpr (is_ptr || is_ref) {
        using Inner = std::remove_cvref_t<std::remove_pointer_t<std::remove_reference_t<T>>>;
        
        if constexpr (std::is_same_v<Inner, int>) return {"int[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_INT"};
        if constexpr (std::is_same_v<Inner, unsigned int>) return {"long[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_INT"};
        if constexpr (std::is_same_v<Inner, short>) return {"short[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_SHORT"};
        if constexpr (std::is_same_v<Inner, unsigned short>) return {"int[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_SHORT"};
        if constexpr (std::is_same_v<Inner, char> || std::is_same_v<Inner, signed char>) return {"byte[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_BYTE"};
        if constexpr (std::is_same_v<Inner, unsigned char>) return {"short[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_BYTE"};
        if constexpr (std::is_same_v<Inner, long> || std::is_same_v<Inner, long long>) return {"long[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_LONG"};
        if constexpr (std::is_same_v<Inner, unsigned long> || std::is_same_v<Inner, unsigned long long>) return {"long[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_LONG"};
        if constexpr (std::is_same_v<Inner, float>) return {"float[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_FLOAT"};
        if constexpr (std::is_same_v<Inner, double>) return {"double[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_DOUBLE"};
        if constexpr (std::is_same_v<Inner, bool>) return {"boolean[]", "MemorySegment", "ValueLayout.ADDRESS", "", "", true, "ValueLayout.JAVA_BOOLEAN"};
        
        return {"MemorySegment", "MemorySegment", "ValueLayout.ADDRESS", "", "", false, ""};
    } else {
        return map_type_actual<std::remove_cvref_t<T>>();
    }
}

struct JavaParamMeta {
    std::string name;
    JavaTypeMapping type_map;
};

struct JavaMethodMeta {
    std::string name;
    JavaTypeMapping return_type_map;
    std::vector<JavaParamMeta> params;
};

template<size_t M, std::array<std::meta::info, M> Params, size_t J = 0>
void fill_params(std::vector<JavaParamMeta>& out) {
    if constexpr (J < M) {
        constexpr auto param = Params[J];
        constexpr auto ptype = std::meta::type_of(param);
        
        JavaParamMeta pm;
        pm.name = "arg" + std::to_string(J);
        constexpr std::string_view id = IdGetter<std::meta::has_identifier(param), param>::get();
        if constexpr (!id.empty()) {
            pm.name = id.data();
        }
        pm.type_map = map_type<typename [: ptype :]>();
        out.push_back(pm);
        
        fill_params<M, Params, J + 1>(out);
    }
}

template<size_t N, std::array<std::meta::info, N> Methods, size_t I = 0>
void fill_java_methods(std::vector<JavaMethodMeta>& out) {
    if constexpr (I < N) {
        constexpr auto mem = Methods[I];
        
        JavaMethodMeta jm;
        jm.name = std::meta::identifier_of(mem).data();
        
        constexpr auto rtype = std::meta::return_type_of(mem);
        jm.return_type_map = map_type<typename [: rtype :]>();
        
        constexpr auto get_param_count = [](std::meta::info m) consteval {
            return std::meta::parameters_of(m).size();
        };
        constexpr size_t M = get_param_count(mem);
        constexpr auto params = get_params_of<M>(mem);
        
        fill_params<M, params>(jm.params);
        
        out.push_back(jm);
        
        fill_java_methods<N, Methods, I + 1>(out);
    }
}

struct JavaFieldMeta {
    std::string_view name;
    JavaTypeMapping type_map;
};

template<size_t N, std::array<std::meta::info, N> Fields, size_t... Is>
consteval std::array<JavaFieldMeta, N> generate_field_metas_impl(std::index_sequence<Is...>) {
    return std::array<JavaFieldMeta, N>{
        JavaFieldMeta{
            std::meta::identifier_of(Fields[Is]),
            map_type<typename [: std::meta::type_of(Fields[Is]) :]>(),
        }...
    };
}

template<size_t N, std::array<std::meta::info, N> Fields>
consteval std::array<JavaFieldMeta, N> generate_field_metas() {
    if constexpr (N == 0) return std::array<JavaFieldMeta, 0>{};
    else return generate_field_metas_impl<N, Fields>(std::make_index_sequence<N>{});
}

template<size_t N, std::array<std::meta::info, N> Constructors, size_t I = 0>
void fill_java_constructors(std::vector<JavaMethodMeta>& out) {
    if constexpr (I < N) {
        constexpr auto mem = Constructors[I];
        JavaMethodMeta jm;
        jm.name = "<init>";
        jm.return_type_map = {"MemorySegment", "MemorySegment", "ValueLayout.ADDRESS", "", "", false, ""};
        
        constexpr auto get_param_count = [](std::meta::info m) consteval {
            return std::meta::parameters_of(m).size();
        };
        constexpr size_t M = get_param_count(mem);
        constexpr auto params = get_params_of<M>(mem);
        
        fill_params<M, params>(jm.params);
        out.push_back(jm);
        
        fill_java_constructors<N, Constructors, I + 1>(out);
    }
}

template<typename T>
void generate_java(std::ostream& out, const std::string& package_name = "", const std::string& library_name = "JavaNativeLinkTest") {
    constexpr auto cls = ^^T;
    std::string class_name = std::meta::identifier_of(cls).data();
    
    if (!package_name.empty()) {
        out << "package " << package_name << ";\n\n";
    }
    
    out << "import java.lang.foreign.*;\n";
    out << "import java.lang.invoke.*;\n";
    out << "import java.util.Optional;\n\n";
    
    out << "public class " << class_name << " implements AutoCloseable {\n";
    out << "    private final MemorySegment ptr;\n";
    out << "    private final Arena arena;\n\n";
    
    out << "    public " << class_name << "(MemorySegment ptr, Arena arena) {\n";
    out << "        this.ptr = ptr;\n";
    out << "        this.arena = arena;\n";
    out << "    }\n\n";
    
    out << "    public MemorySegment getPointer() { return ptr; }\n\n";
    
    constexpr size_t NM = count_methods(cls);
    constexpr auto methods = get_methods<NM>(cls);
    std::vector<JavaMethodMeta> m_metas;
    fill_java_methods<NM, methods>(m_metas);
    
    constexpr size_t NC = count_constructors(cls);
    constexpr auto constructors = get_constructors<NC>(cls);
    std::vector<JavaMethodMeta> c_metas;
    fill_java_constructors<NC, constructors>(c_metas);
    
    constexpr size_t NF = count_fields<cls>();
    constexpr auto fields = get_fields<NF, cls>();
    
    out << "    // --- Method Handles ---\n";
    out << "    private static final Linker LINKER = Linker.nativeLinker();\n";
    out << "    private static final SymbolLookup LOOKUP;\n";
    out << "    static {\n";
    out << "        System.loadLibrary(\"JavaNativeLink\");\n";
    out << "        System.loadLibrary(\"" << library_name << "\");\n";
    out << "        LOOKUP = SymbolLookup.loaderLookup();\n";
    out << "    }\n\n";
    
    for (size_t i = 0; i < c_metas.size(); ++i) {
        out << "    private static MethodHandle mh_init_" << i << ";\n";
    }
    for (size_t i = 0; i < m_metas.size(); ++i) {
        out << "    private static MethodHandle mh_" << m_metas[i].name << "_" << i << ";\n";
    }
    
    constexpr auto fmetas = generate_field_metas<NF, fields>();
    
    for (size_t i = 0; i < NF; ++i) {
        std::string fname(fmetas[i].name);
        out << "    private static MethodHandle mh_get_" << fname << ";\n";
        out << "    private static MethodHandle mh_set_" << fname << ";\n";
    }
    
    out << "    private static MethodHandle mh_dtor;\n";
    out << "    private static MethodHandle mh_getLastError;\n";
    out << "    private static MethodHandle mh_clearLastError;\n";
    out << "    private static MethodHandle mh_JNL_Free;\n";
    
    out << "\n    static {\n";
    out << "        try {\n";
    out << "            mh_JNL_Free = LINKER.downcallHandle(\n";
    out << "                LOOKUP.find(\"JNL_Free\").orElseThrow(),\n";
    out << "                FunctionDescriptor.ofVoid(ValueLayout.ADDRESS)\n";
    out << "            );\n";
    out << "            mh_getLastError = LINKER.downcallHandle(\n";
    out << "                LOOKUP.find(\"JNL_GetLastError\").orElseThrow(),\n";
    out << "                FunctionDescriptor.of(ValueLayout.ADDRESS)\n";
    out << "            );\n";
    out << "            mh_clearLastError = LINKER.downcallHandle(\n";
    out << "                LOOKUP.find(\"JNL_ClearLastError\").orElseThrow(),\n";
    out << "                FunctionDescriptor.ofVoid()\n";
    out << "            );\n";
    
    out << "            final MethodHandle getRegistryMH = LINKER.downcallHandle(\n";
    out << "                LOOKUP.find(\"JNL_GetRegistry\").orElseThrow(),\n";
    out << "                FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS)\n";
    out << "            );\n";
    
    out << "            try (Arena tempArena = Arena.ofConfined()) {\n";
    out << "                MemorySegment cName = tempArena.allocateFrom(\"" << class_name << "\");\n";
    out << "                MemorySegment regPtr = (MemorySegment) getRegistryMH.invokeExact(cName);\n";
    out << "                if (regPtr.equals(MemorySegment.NULL)) throw new RuntimeException(\"Registry not found for " << class_name << "\");\n";
    out << "                regPtr = regPtr.reinterpret(64);\n\n";
    
    out << "                MemorySegment methodsArray = regPtr.get(ValueLayout.ADDRESS, 8);\n";
    out << "                long numMethods = regPtr.get(ValueLayout.JAVA_LONG, 16);\n";
    out << "                methodsArray = methodsArray.reinterpret(numMethods * 16);\n";
    out << "                for (long i = 0; i < numMethods; i++) {\n";
    out << "                    MemorySegment methodPtr = methodsArray.asSlice(i * 16, 16);\n";
    out << "                    MemorySegment namePtr = methodPtr.get(ValueLayout.ADDRESS, 0).reinterpret(1024);\n";
    out << "                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);\n";
    out << "                    String name = namePtr.getString(0);\n";
    
    for (size_t i = 0; i < m_metas.size(); ++i) {
        const auto& m = m_metas[i];
        out << "                    if (name.equals(\"" << m.name << "\") && mh_" << m.name << "_" << i << " == null) {\n";
        
        std::string fd = "FunctionDescriptor.of(";
        if (!m.return_type_map.value_layout.empty()) fd += std::string(m.return_type_map.value_layout);
        else fd = "FunctionDescriptor.ofVoid(";
        
        if (fd.back() == '(') fd += "ValueLayout.ADDRESS";
        else fd += ", ValueLayout.ADDRESS";
        
        for (const auto& p : m.params) {
            fd += ", ";
            fd += p.type_map.value_layout;
        }
        fd += ")";
        
        out << "                        mh_" << m.name << "_" << i << " = LINKER.downcallHandle(funcPtr, " << fd << ");\n";
        out << "                    }\n";
    }
    
    out << "                }\n\n";
    
    out << "                MemorySegment constructorsArray = regPtr.get(ValueLayout.ADDRESS, 24);\n";
    out << "                long numConstructors = regPtr.get(ValueLayout.JAVA_LONG, 32);\n";
    out << "                constructorsArray = constructorsArray.reinterpret(numConstructors * 16);\n";
    out << "                for (long i = 0; i < numConstructors; i++) {\n";
    out << "                    MemorySegment methodPtr = constructorsArray.asSlice(i * 16, 16);\n";
    out << "                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);\n";
    
    for (size_t i = 0; i < c_metas.size(); ++i) {
        const auto& m = c_metas[i];
        out << "                    if (i == " << i << ") {\n";
        std::string fd = "FunctionDescriptor.of(ValueLayout.ADDRESS";
        for (const auto& p : m.params) {
            fd += ", ";
            fd += p.type_map.value_layout;
        }
        fd += ")";
        out << "                        mh_init_" << i << " = LINKER.downcallHandle(funcPtr, " << fd << ");\n";
        out << "                    }\n";
    }
    
    out << "                }\n\n";
    
    out << "                MemorySegment fieldsArray = regPtr.get(ValueLayout.ADDRESS, 48);\n";
    out << "                long numFields = regPtr.get(ValueLayout.JAVA_LONG, 56);\n";
    out << "                fieldsArray = fieldsArray.reinterpret(numFields * 24);\n";
    out << "                for (long i = 0; i < numFields; i++) {\n";
    out << "                    MemorySegment fieldPtr = fieldsArray.asSlice(i * 24, 24);\n";
    out << "                    MemorySegment namePtr = fieldPtr.get(ValueLayout.ADDRESS, 0).reinterpret(1024);\n";
    out << "                    MemorySegment getPtr = fieldPtr.get(ValueLayout.ADDRESS, 8);\n";
    out << "                    MemorySegment setPtr = fieldPtr.get(ValueLayout.ADDRESS, 16);\n";
    out << "                    String name = namePtr.getString(0);\n";
                    for (size_t fi = 0; fi < NF; fi++) {
                        std::string fname(fmetas[fi].name);
                        std::string fvalL(fmetas[fi].type_map.value_layout);
                        if (fvalL.empty()) fvalL = "ValueLayout.ADDRESS";
                        out << "                    if (name.equals(\"" << fname << "\") && mh_get_" << fname << " == null) {\n";
                        out << "                        mh_get_" << fname << " = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(" << fvalL << ", ValueLayout.ADDRESS));\n";
                        out << "                        if (!setPtr.equals(MemorySegment.NULL)) {\n";
                        out << "                            mh_set_" << fname << " = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, " << fvalL << "));\n";
                        out << "                        }\n";
                        out << "                    }\n";
                    }
    out << "                }\n\n";
    
    out << "                MemorySegment destructorPtr = regPtr.get(ValueLayout.ADDRESS, 40);\n";
    out << "                mh_dtor = LINKER.downcallHandle(destructorPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));\n";
    
    out << "            }\n";
    out << "        } catch (Throwable e) {\n";
    out << "            throw new RuntimeException(\"Failed to initialize bindings\", e);\n";
    out << "        }\n";
    out << "    }\n\n";
    
    out << "    private static void checkError() {\n";
    out << "        try {\n";
    out << "            MemorySegment err = (MemorySegment) mh_getLastError.invokeExact();\n";
    out << "            err = err.reinterpret(1025);\n";
    out << "            boolean hasError = err.get(ValueLayout.JAVA_BOOLEAN, 0);\n";
    out << "            if (hasError) {\n";
    out << "                String msg = err.getString(1);\n";
    out << "                mh_clearLastError.invokeExact();\n";
    out << "                throw new RuntimeException(\"C++ Exception: \" + msg);\n";
    out << "            }\n";
    out << "        } catch (RuntimeException e) {\n";
    out << "            throw e;\n";
    out << "        } catch (Throwable e) {\n";
    out << "            throw new RuntimeException(\"Error checking C++ exception state\", e);\n";
    out << "        }\n";
    out << "    }\n\n";
    
    // Constructors in Java
    for (size_t i = 0; i < c_metas.size(); ++i) {
        const auto& m = c_metas[i];
        out << "    public " << class_name << "(";
        for (size_t j = 0; j < m.params.size(); ++j) {
            out << m.params[j].type_map.java_type << " " << m.params[j].name;
            if (j < m.params.size() - 1) out << ", ";
        }
        out << ") {\n";
        out << "        try {\n";
        
        out << "            try (Arena _tempArena = Arena.ofConfined()) {\n";
        for (size_t j = 0; j < m.params.size(); ++j) {
            if (m.params[j].type_map.is_array) {
                out << "                MemorySegment _seg_" << m.params[j].name << " = _tempArena.allocateFrom(" << m.params[j].type_map.array_layout << ", " << m.params[j].name << ");\n";
            } else if (m.params[j].type_map.is_string) {
                out << "                MemorySegment _seg_" << m.params[j].name << " = _tempArena.allocateFrom(" << m.params[j].name << ");\n";
            }
        }
        
        out << "                this.ptr = (MemorySegment) mh_init_" << i << ".invokeExact(";
        for (size_t j = 0; j < m.params.size(); ++j) {
            if (m.params[j].type_map.is_array) {
                out << "_seg_" << m.params[j].name;
            } else if (m.params[j].type_map.is_string) {
                out << "_seg_" << m.params[j].name;
            } else if (m.params[j].type_map.is_object) {
                out << m.params[j].name << ".getPointer()";
            } else {
                out << m.params[j].type_map.cast_to_ffm << m.params[j].name;
            }
            if (j < m.params.size() - 1) out << ", ";
        }
        out << ");\n";
        out << "                checkError();\n";
        out << "                this.arena = Arena.ofAuto();\n"; 
        
        for (size_t j = 0; j < m.params.size(); ++j) {
            if (m.params[j].type_map.is_array) {
                out << "                MemorySegment.copy(_seg_" << m.params[j].name << ", " << m.params[j].type_map.array_layout << ", 0, " << m.params[j].name << ", 0, " << m.params[j].name << ".length);\n";
            }
        }
        out << "            }\n";
        out << "        } catch (RuntimeException e) { throw e; } catch (Throwable e) {\n";
        out << "            throw new RuntimeException(\"Native constructor failed\", e);\n";
        out << "        }\n";
        out << "    }\n\n";
    }
    
    // Wrapper Methods
    for (size_t i = 0; i < m_metas.size(); ++i) {
        const auto& m = m_metas[i];
        out << "    public " << m.return_type_map.java_type << " " << m.name << "(";
        
        for (size_t j = 0; j < m.params.size(); ++j) {
            out << m.params[j].type_map.java_type << " " << m.params[j].name;
            if (j < m.params.size() - 1) out << ", ";
        }
        out << ") {\n";
        
        out << "        try {\n";
        out << "            try (Arena _tempArena = Arena.ofConfined()) {\n";
        
        for (size_t j = 0; j < m.params.size(); ++j) {
            if (m.params[j].type_map.is_array) {
                out << "                MemorySegment _seg_" << m.params[j].name << " = _tempArena.allocateFrom(" << m.params[j].type_map.array_layout << ", " << m.params[j].name << ");\n";
            } else if (m.params[j].type_map.is_string) {
                out << "                MemorySegment _seg_" << m.params[j].name << " = _tempArena.allocateFrom(" << m.params[j].name << ");\n";
            }
        }
        
        out << "                ";
        if (m.return_type_map.java_type != "void") {
            out << m.return_type_map.ffm_type << " _res = (" << m.return_type_map.ffm_type << ") ";
        }
        out << "mh_" << m.name << "_" << i << ".invokeExact((MemorySegment)this.ptr";
        
        for (const auto& p : m.params) {
            if (p.type_map.is_array) {
                out << ", _seg_" << p.name;
            } else if (p.type_map.is_string) {
                out << ", _seg_" << p.name;
            } else if (p.type_map.is_object) {
                out << ", " << p.name << ".getPointer()";
            } else {
                out << ", " << p.type_map.cast_to_ffm << p.name;
            }
        }
        out << ");\n";
        
        out << "                checkError();\n";
        
        for (size_t j = 0; j < m.params.size(); ++j) {
            if (m.params[j].type_map.is_array) {
                out << "                MemorySegment.copy(_seg_" << m.params[j].name << ", " << m.params[j].type_map.array_layout << ", 0, " << m.params[j].name << ", 0, " << m.params[j].name << ".length);\n";
            }
        }
        
        if (m.return_type_map.java_type != "void") {
            if (m.return_type_map.is_string) {
                out << "                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);\n";
                out << "                mh_JNL_Free.invokeExact(_res);\n";
                out << "                return _retStr;\n";
            } else if (m.return_type_map.is_object) {
                out << "                return new " << m.return_type_map.object_class_name << "(_res, Arena.ofAuto());\n";
            } else if (!m.return_type_map.cast_from_ffm.empty()) {
                if (m.return_type_map.cast_from_ffm.find("&") != std::string_view::npos) {
                    // Suffix mask e.g. " & 0xFFFFFFFFL"
                    out << "                return (long)_res" << m.return_type_map.cast_from_ffm << ";\n";
                } else if (m.return_type_map.cast_from_ffm == "(int)" && m.return_type_map.java_type == "int") {
                    out << "                return (int)_res;\n";
                } else {
                    out << "                return " << m.return_type_map.cast_from_ffm << "_res;\n";
                }
            } else {
                out << "                return _res;\n";
            }
        }
        
        out << "            }\n";
        out << "        } catch (RuntimeException e) { throw e; } catch (Throwable e) {\n";
        out << "            throw new RuntimeException(\"Native call failed\", e);\n";
        out << "        }\n";
        out << "    }\n\n";
    }
    
    // Field Getters and Setters
    for (size_t i = 0; i < NF; ++i) {
        std::string fname(fmetas[i].name);
        const auto& fmap = fmetas[i].type_map;
        
        // Getter
        out << "    public " << fmap.java_type << " get_" << fname << "() {\n";
        out << "        try {\n";
        out << "            try (Arena _tempArena = Arena.ofConfined()) {\n";
        out << "                " << fmap.ffm_type << " _res = (" << fmap.ffm_type << ") mh_get_" << fname << ".invokeExact((MemorySegment)this.ptr);\n";
        out << "                checkError();\n";
        if (fmap.is_string) {
            out << "                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);\n";
            out << "                mh_JNL_Free.invokeExact(_res);\n";
            out << "                return _retStr;\n";
        } else if (fmap.is_object) {
            out << "                return new " << fmap.object_class_name << "(_res, Arena.ofAuto());\n";
        } else if (!fmap.cast_from_ffm.empty()) {
            if (fmap.cast_from_ffm.find("&") != std::string_view::npos) {
                out << "                return (long)_res" << fmap.cast_from_ffm << ";\n";
            } else if (fmap.cast_from_ffm == "(int)" && fmap.java_type == "int") {
                out << "                return (int)_res;\n";
            } else {
                out << "                return " << fmap.cast_from_ffm << "_res;\n";
            }
        } else {
            out << "                return _res;\n";
        }
        out << "            }\n";
        out << "        } catch (RuntimeException e) { throw e; } catch (Throwable e) {\n";
        out << "            throw new RuntimeException(\"Native field get failed\", e);\n";
        out << "        }\n";
        out << "    }\n\n";
        
        // Setter
        out << "    public void set_" << fname << "(" << fmap.java_type << " val) {\n";
        out << "        try {\n";
        out << "            if (mh_set_" << fname << " == null) throw new UnsupportedOperationException(\"Field is const\");\n";
        out << "            try (Arena _tempArena = Arena.ofConfined()) {\n";
        if (fmap.is_string) {
            out << "                MemorySegment _seg_val = _tempArena.allocateFrom(val);\n";
            out << "                mh_set_" << fname << ".invokeExact((MemorySegment)this.ptr, _seg_val);\n";
        } else if (fmap.is_object) {
            out << "                mh_set_" << fname << ".invokeExact((MemorySegment)this.ptr, val.getPointer());\n";
        } else if (fmap.is_array) {
            out << "                MemorySegment _seg_val = _tempArena.allocateFrom(" << fmap.array_layout << ", val);\n";
            out << "                mh_set_" << fname << ".invokeExact((MemorySegment)this.ptr, _seg_val);\n";
        } else {
            out << "                mh_set_" << fname << ".invokeExact((MemorySegment)this.ptr, " << fmap.cast_to_ffm << "val);\n";
        }
        out << "                checkError();\n";
        out << "            }\n";
        out << "        } catch (RuntimeException e) { throw e; } catch (Throwable e) {\n";
        out << "            throw new RuntimeException(\"Native field set failed\", e);\n";
        out << "        }\n";
        out << "    }\n\n";
    }
    
    out << "    @Override\n";
    out << "    public void close() {\n";
    out << "        try {\n";
    out << "            mh_dtor.invokeExact(this.ptr);\n";
    out << "        } catch (Throwable e) {\n";
    out << "            throw new RuntimeException(\"Destructor failed\", e);\n";
    out << "        }\n";
    out << "    }\n";
    
    out << "}\n";
}

} // namespace JNL
