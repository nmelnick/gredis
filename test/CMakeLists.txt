set (BINNAME test-gredis)

include(ValaPrecompile)

vala_precompile(VALA_C 
	test-runner.vala
	maintest.vala
	hashtest.vala
	listtest.vala
	redismaptest.vala
	cleanuptest.vala
PACKAGES
	${DEFAULT_PACKAGES}
	posix
	hiredis
	${PKGNAME}-${PKGVERSION}
OPTIONS
	${DEFAULT_VALA_OPTIONS}
)

set(CFLAGS
	${CORE_DEPS_CFLAGS_ALL}
	-I${CMAKE_BINARY_DIR}/src
	-w
)
set(LIB_PATHS
	${CORE_DEPS_LIBRARY_DIRS}
	${CMAKE_BINARY_DIR}/src
)
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

add_executable(${BINNAME} ${VALA_C})
include_directories(${BINSOURCE})
add_dependencies(${BINNAME} ${PKGNAME}-${PKGVERSION})
target_link_libraries(${BINNAME} ${DEPS_LIBRARIES} gthread-2.0 ${PKGNAME}-${PKGVERSION})
include(Tests)
add_test_executable(${BINNAME})
set(ENV{LD_LIBRARY_PATH} "${CMAKE_BINARY_DIR}/src:$ENV{LD_LIBRARY_PATH}")
