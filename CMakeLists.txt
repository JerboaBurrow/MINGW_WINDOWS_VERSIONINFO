cmake_minimum_required(VERSION 3.22)
project(TEST_VERSION_INFO)

set(PRODUCT 0)
set(MAJOR 0)
set(MINOR 0)
set(PATCH 1)

set(COMPANY "THIS_IS_A_TEST_COMPANY_NAME")
set(PRODUCT_NAME "THIS_IS_A_TEST_PRODUCT_NAME")
set(DESCRIPTION "THIS_IS_A_TEST_DESCRIPTION")
set(COPYRIGHT "THIS_IS_A_TEST_COPYRIGHT")

set(CMAKE_RC_COMPILER "x86_64-w64-mingw32-windres")

# process .in by replacing _TEXT_ elements.
#   This is insanity, but for some reason the -D's passed to windres completely
#   fail... maybe you can make that work...
file(READ versioninfo.rc.in FILE_CONTENTS)
string(REPLACE "_COMPANY_" "${COMPANY}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_PRODUCT_NAME_" "${PRODUCT_NAME}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_DESCRIPTION_" "${DESCRIPTION}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_COPYRIGHT_" "${COPYRIGHT}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_MAJOR_" "${MAJOR}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_MINOR_" "${MINOR}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_PATCH_" "${PATCH}" FILE_CONTENTS "${FILE_CONTENTS}")
string(REPLACE "_PRODUCT_" "${PRODUCT}" FILE_CONTENTS "${FILE_CONTENTS}")
file(WRITE versioninfo.rc "${FILE_CONTENTS}")

add_library(versioninfo OBJECT "versioninfo.rc")

add_executable(testVersionInfo "main.cpp")

target_link_libraries(testVersionInfo versioninfo)

file(GLOB DLL "${PROJECT_SOURCE_DIR}/*.dll")
file(COPY ${DLL} DESTINATION "${CMAKE_BINARY_DIR}/")