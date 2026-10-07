// RUN: %check_clang_tidy %s cata-test-filename %t_test -- --load=%cata_plugin -warnings-as-errors=cata-test-filename -system-headers -header-filter=.* -- -isystem %test_include

#include "benchmark_test_case.h"

TEST_CASE( "direct_test", "" )
// CHECK-FIXES: TEST_CASE( "direct_test", "" )
BENCHMARK_TEST_CASE( "wrapped_test", "" )
// CHECK-FIXES: BENCHMARK_TEST_CASE( "wrapped_test", "" )
