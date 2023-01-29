cmake_minimum_required (VERSION 3.15)

project(freetype_beef)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_subdirectory(submodules/freetype)

if (MSVC)
	set_property(TARGET freetype PROPERTY
				MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
	set_property(TARGET freetype PROPERTY
				MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Release>:>")
endif()

