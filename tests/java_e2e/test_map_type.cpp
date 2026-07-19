#include "../../include/JavaNativeLink/JavaGenerator.h"
#include <iostream>

struct Point {
    Point(int x, int y);
    void print();
    int add(int a, int b);
};

int main() {
    constexpr auto cls = ^^Point;
    constexpr size_t NC = JNL::count_constructors(cls);
    constexpr auto ctors = JNL::get_constructors<NC>(cls);
    std::vector<JNL::JavaMethodMeta> c_metas;
    JNL::fill_java_constructors<NC, ctors>(c_metas);
    for (const auto& m : c_metas) {
        std::cout << m.name << "(";
        for (const auto& p : m.params) {
            std::cout << p.type_map.java_type << " " << p.name << ", ";
        }
        std::cout << ")\n";
    }
    
    constexpr size_t NM = JNL::count_methods(cls);
    constexpr auto methods = JNL::get_methods<NM>(cls);
    std::vector<JNL::JavaMethodMeta> m_metas;
    JNL::fill_java_methods<NM, methods>(m_metas);
    for (const auto& m : m_metas) {
        std::cout << m.return_type_map.java_type << " " << m.name << "(";
        for (const auto& p : m.params) {
            std::cout << p.type_map.java_type << " " << p.name << ", ";
        }
        std::cout << ")\n";
    }
    return 0;
}
