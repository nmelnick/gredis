cmake_minimum_required (VERSION 2.8)
cmake_policy(VERSION 2.8)
project(GRedis)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )
enable_testing()

find_package(Vala REQUIRED)
include(ValaVersion)
include(ValaPrecompile)
ensure_vala_version("0.22.0" MINIMUM)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
	SET(CMAKE_INSTALL_PREFIX "/usr" CACHE PATH "install prefix" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

IF(LIB_INSTALL_DIR)
ELSE()
SET(LIB_INSTALL_DIR lib)
ENDIF()

set (PKGNAME gredis)
set (PKGVERSION 0.1)
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (DOLLAR "$")

set (VAPIDIRS 
	--vapidir='${CMAKE_SOURCE_DIR}'
	--vapidir='${CMAKE_CURRENT_BINARY_DIR}/src'
	--vapidir='${CMAKE_SOURCE_DIR}/vapi'
)
set (DEFAULT_VALA_OPTIONS
	${VAPIDIRS}
	--enable-experimental
	--target-glib=2.32
	--debug
	-g
)

SET( DEFAULT_PACKAGES
	glib-2.0
	gio-2.0
	gmodule-2.0
	gee-0.8
	hiredis
)
find_package(PkgConfig)
pkg_check_modules(CORE_DEPS REQUIRED ${DEFAULT_PACKAGES} glib-2.0>=2.32)
SET( CMAKE_BUILD_TYPE Debug )
SET( CORE_DEPS_CFLAGS_ALL
	${CORE_DEPS_CFLAGS}
	${CORE_DEPS_CFLAGS_OTHER}
)

add_subdirectory (src)
add_subdirectory (test)
