#include "JavaNativeLink/Exporter.h"
#include <unordered_map>
#include <string>
#include <cstring>

extern "C" {
    thread_local JNLThreadError jnl_tls_error = {false, ""};

    JNL_EXPORT void* JNL_GetLastError() {
        return &jnl_tls_error;
    }

    JNL_EXPORT void JNL_ClearLastError() {
        jnl_tls_error.has_error = false;
        jnl_tls_error.message[0] = '\0';
    }
}

namespace jnl {
    void set_error(const char* msg) {
        jnl_tls_error.has_error = true;
        std::strncpy(jnl_tls_error.message, msg, sizeof(jnl_tls_error.message) - 1);
        jnl_tls_error.message[sizeof(jnl_tls_error.message) - 1] = '\0';
    }

    std::unordered_map<std::string, JNLClassRegistry>& get_global_registry() {
        static std::unordered_map<std::string, JNLClassRegistry> registry;
        return registry;
    }

    void register_class(const JNLClassRegistry& reg) {
        std::cout << "Registering class: '" << reg.class_name << "'" << std::endl;
        get_global_registry()[reg.class_name] = reg;
    }
}

extern "C" {
    JNL_EXPORT const JNLClassRegistry* JNL_GetRegistry(const char* class_name) {
        auto& reg = jnl::get_global_registry();
        std::cout << "Looking up registry for: '" << class_name << "', total registered: " << reg.size() << std::endl;
        for (const auto& pair : reg) {
            std::cout << "  Registered: '" << pair.first << "'" << std::endl;
        }
        auto it = reg.find(class_name);
        if (it != reg.end()) {
            return &it->second;
        }
        return nullptr;
    }

    JNL_EXPORT void JNL_Free(void* ptr) {
        free(ptr);
    }
}
