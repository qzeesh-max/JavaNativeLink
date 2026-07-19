#include <fstream>
#include "JavaNativeLink/JavaGenerator.h"

#include "CardGame.cpp"

int main() {
    std::ofstream out("CardGame.java");
    JNL::generate_java<CardGame>(out, "", "CardGame");
    std::cout << "Generated CardGame.java\n";
    return 0;
}
