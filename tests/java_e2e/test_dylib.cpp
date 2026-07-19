#include <iostream>
#include <dlfcn.h>
#include "JavaNativeLink/Exporter.h"

int main() {
    void* handle = dlopen("./libPoint.dylib", RTLD_NOW);
    if (!handle) {
        std::cerr << "dlopen failed: " << dlerror() << "\n";
        return 1;
    }
    
    typedef const JNLClassRegistry* (*GetRegFunc)(const char*);
    GetRegFunc func = (GetRegFunc)dlsym(handle, "JNL_GetRegistry_Special");
    if (!func) {
        std::cerr << "dlsym failed: " << dlerror() << "\n";
        return 1;
    }
    std::cout << "dlsym JNL_GetRegistry address: " << (void*)func << "\n";
    
    const JNLClassRegistry* reg = func("Point");
    if (reg) {
        std::cout << "Found Point registry: " << reg->num_fields << " fields\n";
    } else {
        std::cout << "Point registry not found\n";
    }
    
    return 0;
}
