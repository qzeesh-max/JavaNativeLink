#include <iostream>
#include "JavaNativeLink/Exporter.h"

struct Point {
    int x;
    int y;
    
    Point() : x(0), y(0) { std::cout << "Point()\n"; }
    Point(int x, int y) : x(x), y(y) { std::cout << "Point(" << x << ", " << y << ")\n"; }
    ~Point() { std::cout << "~Point()\n"; }
    
    void print() { std::cout << "print: " << x << "," << y << "\n"; }
    int add(int a, int b) { return a + b; }
};

JNL_EXPORT_CLASS(Point);

int main() {
    std::cout << "Starting test_core...\n";
    const JNLClassRegistry* reg = JNL_GetRegistry("Point");
    if (!reg) {
        std::cerr << "Registry not found!\n";
        return 1;
    }
    
    std::cout << "Class: " << reg->class_name << "\n";
    std::cout << "Constructors: " << reg->num_constructors << "\n";
    for(size_t i=0; i<reg->num_constructors; ++i) {
        std::cout << "  " << reg->constructors[i].name << " -> " << reg->constructors[i].func_ptr << "\n";
    }
    
    std::cout << "Methods: " << reg->num_methods << "\n";
    for(size_t i=0; i<reg->num_methods; ++i) {
        std::cout << "  " << reg->methods[i].name << " -> " << reg->methods[i].func_ptr << "\n";
    }
    
    // Invoke default constructor (first one)
    auto ctor0 = (void*(*)())reg->constructors[0].func_ptr;
    void* obj1 = ctor0();
    
    // Invoke parameterized constructor (second one)
    auto ctor1 = (void*(*)(int, int))reg->constructors[1].func_ptr;
    void* obj2 = ctor1(10, 20);
    
    // Find print and invoke on obj2
    void (*print_func)(void*) = nullptr;
    for(size_t i=0; i<reg->num_methods; ++i) {
        if (std::string(reg->methods[i].name) == "print") {
            print_func = (void(*)(void*))reg->methods[i].func_ptr;
        }
    }
    
    if (print_func) {
        print_func(obj2);
    }
    
    // Destroy
    auto dtor = (void(*)(void*))reg->destructor;
    dtor(obj1);
    dtor(obj2);
    
    std::cout << "Finished test_core.\n";
    return 0;
}
