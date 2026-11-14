# Optional for single-player/cross builds; desktop multiplayer needs this runtime.
# Cross toolchains must opt in with a matching Rust target/runtime packaging.
ifeq ($(NATIVE),emscripten)
  RUST_COOP ?= 0
else ifneq ($(strip $(CROSS)$(OSXCROSS)),)
  RUST_COOP ?= 0
else
  RUST_COOP ?= 1
endif
RUST_COOP_PROFILE ?= release
RUST_COOP_TARGET ?=
RUST_COOP_JOBS ?= 2
RUST_COOP_TARGET_DIR ?= $(abspath $(BUILD_PREFIX)coop-rust)
RUST_COOP_BUILD_FLAGS ?=
CARGO ?= cargo

ifeq ($(TARGETSYSTEM),LINUX)
  LDFLAGS += -ldl
endif
ifeq ($(TARGETSYSTEM),WINDOWS)
  COOP_LIBRARY_NAME := ccb_bevy_ecs_coop.dll
else ifeq ($(NATIVE),osx)
  COOP_LIBRARY_NAME := libccb_bevy_ecs_coop.dylib
else
  COOP_LIBRARY_NAME := libccb_bevy_ecs_coop.so
endif
COOP_LIBRARY := $(dir $(TARGET))$(COOP_LIBRARY_NAME)

ifeq ($(RUST_COOP),1)
  ifneq ($(strip $(CROSS)$(OSXCROSS)),)
    ifeq ($(RUST_COOP_TARGET),)
      $(error Set RUST_COOP_TARGET to the Rust target triple for this cross build, or RUST_COOP=0 for single-player)
    endif
  endif
  BINDIST_EXTRAS += $(COOP_LIBRARY)
  $(COOP_LIBRARY): coop-runtime
	@
  $(TARGET): | coop-runtime
  .PHONY: coop-runtime
coop-runtime:
	python3 build-scripts/build-coop-runtime.py --cargo "$(CARGO)" \
	  --profile "$(RUST_COOP_PROFILE)" --target "$(RUST_COOP_TARGET)" \
	  --target-dir "$(RUST_COOP_TARGET_DIR)" --library-dir "$(abspath $(dir $(TARGET)))" \
	  --jobs "$(RUST_COOP_JOBS)" $(RUST_COOP_BUILD_FLAGS)
endif
