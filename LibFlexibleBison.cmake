#
# some helper functions for using bison // flex together
#
# both functions are just a simple add_custom_command wrapper:
#

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

function(GENERATE_LEXER)
    set(oneValueArgs INPUT_FILE OUTPUT_SRC)
    cmake_parse_arguments(GENERATE_LEXER "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    add_custom_command(
            OUTPUT ${GENERATE_LEXER_OUTPUT_SRC}
            COMMAND ${FLEX_EXECUTABLE} -o ${GENERATE_LEXER_OUTPUT_SRC} ${GENERATE_LEXER_INPUT_FILE}
            COMMENT "Generating lexer"
    )
endfunction(GENERATE_LEXER)

function(GENERATE_PARSER)
    set(oneValueArgs INPUT_FILE OUTPUT_SRC OUTPUT_INC)
    cmake_parse_arguments(GENERATE_PARSER "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    add_custom_command(
            OUTPUT ${GENERATE_PARSER_OUTPUT_SRC} ${GENERATE_PARSER_OUTPUT_INC}
            COMMAND ${BISON_EXECUTABLE} -o ${GENERATE_PARSER_OUTPUT_SRC} ${GENERATE_PARSER_INPUT_FILE}
            COMMENT "Generating parser"
    )
endfunction(GENERATE_PARSER)
