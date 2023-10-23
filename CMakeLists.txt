cmake_minimum_required (VERSION 3.5)

set(CMAKE_CXX_STANDARD 17)

project (HelloCI_C C)
add_executable(HelloCI_C  source/hello_c.c)
target_compile_options(HelloCI_C PRIVATE -Wall)
target_include_directories(HelloCI_C PUBLIC include)

# Test build workflows: detect build, runtime and test failures
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_COMPILE)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_LINK)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_RUN)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_TEST)
target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_COVER)


include(CTest)

# enable testing functionality
enable_testing()

# define tests
add_test(
  NAME HelloCI_C
  COMMAND $<TARGET_FILE:HelloCI_C>
  )

