#
# some helper functions for cpp projects
#
# setup_cxx_target sets the properties and target compile options for the targetname
#
# setup_cxx_library/executable takes the TARGET_NAME argument and passes the other arguments through
# to the add_library/executable call. furthermore it calls setup_cxx_target.
#

set(CXX_VERSION 14 CACHE INTEGER "C++ version to compile with. (will be required from the compiler, sets the CXX_STANDARD variable.)")

function(SETUP_CXX_TARGET TARGET_NAME)
    set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD ${CXX_VERSION})
    set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)
    target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra)
    target_compile_options(${TARGET_NAME} PRIVATE $<$<CONFIG:DEBUG>:-ggdb -O2>)
    target_compile_options(${TARGET_NAME} PRIVATE $<$<CONFIG:RELEASE>:-O3>)
endfunction(SETUP_CXX_TARGET)

function(SETUP_CXX_LIBRARY)
  set(oneValueArgs TARGET_NAME)
  cmake_parse_arguments(SETUP_CXX_LIBRARY "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )
  add_library(${SETUP_CXX_LIBRARY_TARGET_NAME} ${SETUP_CXX_LIBRARY_UNPARSED_ARGUMENTS})
  setup_cxx_target(${SETUP_CXX_LIBRARY_TARGET_NAME})
endfunction(SETUP_CXX_LIBRARY)

function(SETUP_CXX_EXECUTABLE)
  set(oneValueArgs TARGET_NAME)
  cmake_parse_arguments(SETUP_CXX_EXECUTABLE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )
  add_executable(${SETUP_CXX_EXECUTABLE_TARGET_NAME} ${SETUP_CXX_EXECUTABLE_UNPARSED_ARGUMENTS})
  setup_cxx_target(${SETUP_CXX_EXECUTABLE_TARGET_NAME})
endfunction(SETUP_CXX_EXECUTABLE)
