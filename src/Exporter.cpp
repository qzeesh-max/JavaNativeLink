#include "JavaNativeLink/Exporter.h"
#include <unordered_map>
#include <string>
#include <cstring>

extern "C" {
    thread_local JNLThreadError jnl_tls_error = {false, ""};

    JNLThreadError* JNL_GetLastError() {
        return &jnl_tls_error;
    }

    void JNL_ClearLastError() {
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
        get_global_registry()[reg.class_name] = reg;
    }
}

extern "C" {
    const JNLClassRegistry* JNL_GetRegistry(const char* class_name) {
        auto& reg = jnl::get_global_registry();
        auto it = reg.find(class_name);
        if (it != reg.end()) {
            return &it->second;
        }
        return nullptr;
    }
}
