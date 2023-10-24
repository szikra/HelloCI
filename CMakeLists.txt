cmake_minimum_required (VERSION 3.5)

project (HelloCI_C C)
set(CMAKE_CXX_STANDARD 17)

# cmake info
message("MSVC = ${MSVC}")
message("CMAKE_C_COMPILER = ${CMAKE_C_COMPILER}")
message("CMAKE_C_COMPILER_ID = ${CMAKE_C_COMPILER_ID}")
message("CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")
message("CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}")
message("CMAKE_C_FLAGS = ${CMAKE_C_FLAGS}")
message("CMAKE_C_FLAGS_DEBUG = ${CMAKE_C_FLAGS_DEBUG}")
message("CMAKE_C_FLAGS_RELEASE = ${CMAKE_C_FLAGS_RELEASE}")


# Compiler and build specific options
# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html
if (CMAKE_C_COMPILER_ID STREQUAL "Clang")
  # using Clang
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")
elseif (CMAKE_C_COMPILER_ID STREQUAL "GNU")
  # using GCC
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O1")
elseif (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
endif()

# https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html#variables-that-describe-the-system
if(MSVC)
    # warning level 4
    add_compile_options(/W4)
else()
    # additional warnings
    add_compile_options(-Wall -Wextra --coverage)
    add_link_options(--coverage)

	#message("CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
	if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
		message("Configuring for Debug build")
	    #add_compile_options(-O0)
	else()
		message("Configuring for Release build")
	    #add_compile_options(-O2)

		if ( (CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR (CMAKE_HOST_LINUX) )
	  		# clang doesn't support -pg on Windows, only add profiling if using GCC or Linux
		    add_compile_options(-pg -no-pie)
	    	add_link_options(-pg)
		endif()
	endif()
endif()

add_executable(HelloCI_C  source/hello_c.c)
#target_compile_options(HelloCI_C PRIVATE -Wall)
target_include_directories(HelloCI_C PUBLIC include)

# Test build workflows: detect build, runtime and test failures
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_COMPILE)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_LINK)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_RUN)
#target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_TEST)
target_compile_definitions(HelloCI_C PUBLIC TEST_FAIL_TO_COVER)



# enable testing functionality
include(CTest)
enable_testing()

# define tests
add_test(
  NAME HelloCI_C
  COMMAND $<TARGET_FILE:HelloCI_C>
  )

