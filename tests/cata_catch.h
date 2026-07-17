#pragma once
#ifndef CATA_TESTS_CATA_CATCH_H
#define CATA_TESTS_CATA_CATCH_H

// To avoid ODR violations, it's important that whenever a file includes
// catch.hpp it also includes stringmaker.h, so that all specializations of
// StringMaker match.  Therefore, all test code should include catch.hpp via
// this file.

// IWYU pragma: begin_exports
#include "catch/catch.hpp"
#include "stringmaker.h"
// IWYU pragma: end_exports

// All microbenchmarks use one discoverable entry point and remain hidden from
// the default correctness suite.  Keep subsystem tags in the owning test file
// so a benchmark can still share its fixtures and helpers.
#define BENCHMARK_TEST_CASE( name, tags ) TEST_CASE( name, "[.][benchmark]" tags )

#endif // CATA_TESTS_CATA_CATCH_H
