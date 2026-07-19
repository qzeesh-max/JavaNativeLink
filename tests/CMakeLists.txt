find_package(Boost REQUIRED)
add_executable(test_core test_core.cpp)
target_include_directories(test_core PRIVATE ${Boost_INCLUDE_DIRS})
target_link_libraries(test_core PRIVATE JavaNativeLink)
add_test(NAME core_test COMMAND test_core)

# Experimental compiler feature tests
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_executable(test_inject test_inject.cpp)
    add_test(NAME inject_test COMMAND test_inject)

    add_executable(test_reflection test_reflection.cpp)
    add_test(NAME reflection_test COMMAND test_reflection)
endif()
