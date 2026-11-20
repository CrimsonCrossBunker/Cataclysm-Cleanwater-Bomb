function(ccb_msvc_dependencies)
    set(probe_dir "${CMAKE_BINARY_DIR}/CMakeFiles/ccb-showincludes")
    file(WRITE "${probe_dir}/probe.h" "\n")
    file(WRITE "${probe_dir}/probe.cpp" "#include \"probe.h\"\n")
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E env VSLANG=1033
                "${CMAKE_CXX_COMPILER}" ${CMAKE_CXX_COMPILER_ARG1}
                /nologo /utf-8 /showIncludes /Zs probe.cpp
        WORKING_DIRECTORY "${probe_dir}"
        OUTPUT_VARIABLE output
        ERROR_VARIABLE errors
        RESULT_VARIABLE status
        ENCODING NONE)
    if (NOT status EQUAL 0 OR NOT output MATCHES
            "(^|\n)([^:\n][^:\n]+:[^:\n]*[^: \n][^: \n]:?[ \t]+)([A-Za-z]:\\\\|\\./|\\.\\\\|/)")
        message(FATAL_ERROR "Cannot detect the MSVC /showIncludes prefix: ${output}${errors}")
    endif ()
    set(CMAKE_CL_SHOWINCLUDES_PREFIX "${CMAKE_MATCH_2}" PARENT_SCOPE)
    foreach (language C CXX)
        set(launcher "${CMAKE_${language}_COMPILER_LAUNCHER}")
        list(PREPEND launcher "${CMAKE_COMMAND}" -E env VSLANG=1033)
        set(CMAKE_${language}_COMPILER_LAUNCHER "${launcher}" PARENT_SCOPE)
    endforeach ()
endfunction()

