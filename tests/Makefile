# Make any tests, and possibly run them.
# A selection of variables are exported from the master Makefile.

# Both suites use the same engine library, test runner and object directory.
# Restricting sources avoids compiling unrelated tests for a Lua batch.
CATA_ENABLE_LUA_PLATFORM ?= 0
CATA_TEST_SUITE ?= all
ifeq ($(CATA_TEST_SUITE),all)
SOURCES = $(wildcard *.cpp)
else ifeq ($(CATA_TEST_SUITE),lua)
ifneq ($(CATA_ENABLE_LUA_PLATFORM),1)
$(error CATA_TEST_SUITE=lua requires CATA_ENABLE_LUA_PLATFORM=1)
endif
SOURCES = $(sort $(wildcard lua_platform*.cpp) $(shell cat test_support_sources.txt))
else
$(error CATA_TEST_SUITE must be all or lua)
endif
OBJS = $(sort $(SOURCES:%.cpp=$(ODIR)/%.o))

CATA_LIB=../$(BUILD_PREFIX)cataclysm.a

# If you invoke this makefile directly and the parent directory was
# built with BUILD_PREFIX set, you must set it for this invocation as well.
ODIR ?= obj

LDFLAGS += -lpthread -L.

# Enabling benchmarks
DEFINES += -DCATCH_CONFIG_ENABLE_BENCHMARKING

# Allow use of any header files from cataclysm.
# Catch sections throw unused variable warnings.
# Add no-sign-compare to fix MXE issue when compiling
# Catch also uses "#pragma gcc diagnostic", which is not recognized on some supported compilers.
# Clang and mingw are warning about Catch macros around perfectly normal boolean operations.
CPPFLAGS += -I. -I../src -I../src/lua -isystem ../src/third-party
CXXFLAGS += -Wno-unused-variable -Wno-sign-compare -Wno-unknown-pragmas -Wno-parentheses
CXXFLAGS += -Wall -Wextra

ifndef PCH
  PCH = 1
endif

ifndef CLANG
  CLANG = 0
endif

# clang 22 bug results in non-trivially supressable error about counter with -Wc2y-extensions
# see https://github.com/llvm/llvm-project/issues/189645
# Root Makefile may set CLANG to the compiler name (e.g. "clang++-22") rather than "1",
# so trigger on any clang and (when detectable) restrict to clang >= 22 to match CMake.
ifneq ($(CLANG), 0)
  CLANG_MAJOR := $(shell $(CXX) -dM -E -x c++ /dev/null 2>/dev/null | sed -n 's/^\#define __clang_major__ //p')
  ifeq ($(CLANG_MAJOR),)
    DEFINES += -DCATCH_CONFIG_NO_COUNTER
  else ifeq ($(shell test $(CLANG_MAJOR) -ge 22 && echo yes),yes)
    DEFINES += -DCATCH_CONFIG_NO_COUNTER
  endif
endif

ifeq ($(PCH), 1)
PCHFLAGS += -DCATA_CATCH_PCH
PCH_H = pch/tests-pch.hpp
ifeq ($(CLANG), 0)
PCH_P = $(ODIR)/$(PCH_H).gch
else
PCH_P = $(ODIR)/$(PCH_H).pch
CXXFLAGS += -Wno-unused-macros
endif
endif

ifeq ($(TARGETSYSTEM), WINDOWS)
  TEST_TARGET = $(BUILD_PREFIX)cata_test.exe
else
  TEST_TARGET = $(BUILD_PREFIX)cata_test
endif

tests: $(TEST_TARGET)

$(TEST_TARGET): $(OBJS) $(CATA_LIB) $(ODIR)/.test-suite Makefile test_support_sources.txt
	+$(CXX) $(W32FLAGS) -o $@ $(DEFINES) $(OBJS) $(CATA_LIB) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS)

# Relink when switching suites or removing sources, even if the omitted objects
# are older than the executable. Unchanged selections do not invalidate the link.
$(ODIR)/.test-suite: FORCE
	@if [ ! -f "$@" ] || [ "$$(cat "$@")" != "$(CATA_TEST_SUITE) $(sort $(SOURCES))" ]; then \
		printf '%s\n' "$(CATA_TEST_SUITE) $(sort $(SOURCES))" > "$@"; \
	fi

$(PCH_P): $(PCH_H)
	-$(CXX) $(CPPFLAGS) $(DEFINES) $(CXXFLAGS) -MMD -MP -Wno-error -Wno-non-virtual-dtor -Wno-unused-macros -I. -c $(PCH_H) -o $(PCH_P)

TEST_BATCHES = "crafting_skill_gain" "[slow]\ ~crafting_skill_gain" "~[slow]\ ~[.]"
ifeq ($(CATA_TEST_SUITE),lua)
TEST_BATCHES = "[lua][platform]"
TEST_FILTER = '[lua][platform]'
endif

$(TEST_BATCHES): $(TEST_TARGET)
	cd .. && tests/$(TEST_TARGET) --min-duration 0.2 --rng-seed time --order lex --user-dir test_user_dir_$$$$ $@

check: $(TEST_TARGET) $(TEST_BATCHES)

check-single: $(TEST_TARGET)
	cd .. && tests/$(TEST_TARGET) --min-duration 0.2 --rng-seed time --order lex --warn NoTests $(TEST_FILTER)

clean:
	rm -rf *obj *objwin *obj-lua
	rm -f *cata_test

#Unconditionally create object directory on invocation.
$(shell mkdir -p $(ODIR) $(dir $(PCH_P)))

# Adding ../tests/ so that the directory appears in __FILE__ for log messages
$(ODIR)/%.o: %.cpp $(PCH_P)
	$(CXX) $(CPPFLAGS) $(DEFINES) $(CXXFLAGS) -MMD -MP $(subst main-pch,tests-pch,$(PCHFLAGS)) -c ../tests/$< -o $@

$(ODIR)/%.inc: %.cpp
	$(CXX) $(CPPFLAGS) $(DEFINES) $(CXXFLAGS) -H -E $< -o /dev/null 2> $@

.PHONY: includes
includes: $(OBJS:.o=.inc)

.PHONY: clean check check-single tests precompile_header FORCE

.SECONDARY: $(OBJS)

-include ${OBJS:.o=.d}
