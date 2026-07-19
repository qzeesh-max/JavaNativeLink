#include <iostream>
#include <meta>
#include <array>
#include <utility>

template<typename... Args>
void print_sizes() {
    ((std::cout << sizeof(Args) << " "), ...);
    std::cout << "\n";
}

constexpr std::array<std::meta::info, 2> types = {^^int, ^^double};

template<size_t... I>
void call_print_sizes(std::index_sequence<I...>) {
    print_sizes<typename [: types[I] :]...>();
}

int main() {
    call_print_sizes(std::make_index_sequence<2>{});
    return 0;
}
