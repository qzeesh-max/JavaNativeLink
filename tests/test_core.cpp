#define BOOST_TEST_MODULE JavaNativeLinkCoreTest
#include <boost/test/included/unit_test.hpp>
#include "JavaNativeLink/Exporter.h"

struct SimpleClass {
    int value = 42;
    void increment() { value++; }
};

JNL_EXPORT_CLASS(SimpleClass)

BOOST_AUTO_TEST_CASE(registry_contains_simple_class) {
    const JNLClassRegistry* reg = JNL_GetRegistry("SimpleClass");
    BOOST_REQUIRE(reg != nullptr);
    BOOST_CHECK_EQUAL(std::string(reg->class_name), "SimpleClass");
}

BOOST_AUTO_TEST_CASE(registry_has_correct_methods) {
    const JNLClassRegistry* reg = JNL_GetRegistry("SimpleClass");
    BOOST_REQUIRE(reg != nullptr);
    BOOST_CHECK(reg->num_methods > 0);
    BOOST_CHECK(reg->num_constructors > 0);
    BOOST_CHECK(reg->num_fields == 1);
}
