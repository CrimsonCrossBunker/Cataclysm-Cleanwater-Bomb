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
  ifeq ($(NATIVE):$(UNIVERSAL_BINARY):$(strip $(CROSS)$(OSXCROSS)),osx:1:)
    COOP_MACOS_UNIVERSAL := 1
    ifneq ($(strip $(RUST_COOP_TARGET)),)
      $(error Leave RUST_COOP_TARGET unset for a universal macOS build)
    endif
  endif
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
  BUILD_COOP_RUNTIME = python3 build-scripts/build-coop-runtime.py --cargo "$(CARGO)" \
    --profile "$(RUST_COOP_PROFILE)" --target-dir "$(RUST_COOP_TARGET_DIR)" \
    --jobs "$(RUST_COOP_JOBS)" $(RUST_COOP_BUILD_FLAGS)
coop-runtime:
ifeq ($(COOP_MACOS_UNIVERSAL),1)
	@set -eu; \
	  for target in x86_64-apple-darwin aarch64-apple-darwin; do \
	    $(BUILD_COOP_RUNTIME) --target "$$target" --library-dir "$(RUST_COOP_TARGET_DIR)/$$target"; \
	  done; \
	  mkdir -p "$(dir $(COOP_LIBRARY))"; \
	  tmp="$(COOP_LIBRARY).tmp"; \
	  trap 'rm -f "$$tmp"' EXIT; \
	  lipo -create "$(RUST_COOP_TARGET_DIR)/x86_64-apple-darwin/$(COOP_LIBRARY_NAME)" \
	    "$(RUST_COOP_TARGET_DIR)/aarch64-apple-darwin/$(COOP_LIBRARY_NAME)" -output "$$tmp"; \
	  lipo "$$tmp" -verify_arch x86_64 arm64; \
	  if ! cmp -s "$$tmp" "$(COOP_LIBRARY)"; then mv -f "$$tmp" "$(COOP_LIBRARY)"; fi
else
	$(BUILD_COOP_RUNTIME) --target "$(RUST_COOP_TARGET)" --library-dir "$(abspath $(dir $(TARGET)))"
endif
endif
