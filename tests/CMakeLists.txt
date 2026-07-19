add_executable(test_core test_core.cpp)
target_link_libraries(test_core PRIVATE JavaNativeLink)
add_test(NAME core_test COMMAND test_core)
