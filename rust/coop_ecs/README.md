# CCB co-op runtime

This is the first implementation batch of the CECP multiplayer port. The source
baseline and imported-file hashes are in `UPSTREAM.json`. CCB maintains the C ABI
in `include/ccb_coop_ffi.h`; no V120 executable, DLL, object file or 3D renderer is
used to build the game.

The current game connects through this runtime, with version/password checks,
pre-creation world/seed handoff, deferred join, authenticated delivery, compression,
disconnect handling and targeted peer delivery. **The gameplay layer still has
one remote-player state.** It therefore admits only one remote player, even though
the transport supports multiple peers. Per-player replication and ACK state,
realtime world ticks, independent reality regions, region reset/handoff and their
Lua lifecycle acceptance are subsequent batches, not implemented parity claims.
The imported ECS baseline APIs are available but not yet wired into gameplay.

The 2026-11-02 CCB integration was built as Linux SDL3 Release with Lua Platform
v1 and a Rust release runtime. Its fixed carrier, exploration and room comparison
covered 24 actual single-player runs / 976 simulation calls without a detected
regression at the declared gates. A separate controlled-schedule comparison ran
the old TCP and new UDP builds as real host/client pairs: 32 remote wait actions
per pair, exact grant/ACK sequence, and matching gameplay/save state. Only checked
build-labelled load/start events and multiplayer wall-clock markers were allowed
to differ. This does not establish unrestricted scheduling, reconnect/save parity,
additional remote players, other gameplay actions, or a performance improvement.

## Build

Desktop native Make builds enable `RUST_COOP=1` by default. Cargo uses the checked-in
lockfile and builds a release runtime beside the executable. For SDL3 on Linux:

```sh
make -j2 RELEASE=1 TILES=1 SOUND=1 TESTS=0 RUST_COOP=1
```

Use `RUST_COOP=0` for a single-player build without Cargo. CMake has the equivalent
`CATA_BUILD_COOP_RUNTIME` option, plus `CATA_COOP_PROFILE` (`release` or `dev`),
`CATA_COOP_TARGET_DIR` and `CATA_COOP_JOBS`. The runtime is copied beside the game
and included in desktop install/bindist targets. It loads lazily, so single-player
startup works without the library.

Cross builds default to omitting the runtime. Opting in requires a matching Rust
target (`RUST_COOP_TARGET` / `CATA_COOP_RUST_TARGET`) and an appropriately configured
Cargo linker. Android packaging and device acceptance remain pending. Windows
and macOS paths are implemented but have not been built or run in this batch.

The standalone builder also supports `--offline` and repeatable `--cargo-config`.
No registry mirror, proxy, credential or developer-specific path is checked in.

## Protocol boundary

The wire profile is `ccb-renet-1`, with a distinct netcode protocol ID and C ABI
version 1. This is not a promise of compatibility with CECP V120 or the old CCB
TCP protocol. TCP port probes have been removed; the default game port is UDP 8080.
The five-second connection deadline starts after hostname resolution.

The runtime provides unreliable (0), reliable unordered (1), reliable ordered
control (2), and reliable ordered bulk (3) channels, with scheduling priority
2, 1, 3, 0. Existing CCB world/map/vehicle messages remain on ordered channel 2
until sequence guards and region readiness can safely permit the V120 split.
Chat/visual events retain the imported unordered route. Packet boundaries are
provided by Renet; large gameplay JSON can be sent as a native zstd frame.
Uncompressed gameplay packets are bounded to 8 MiB. Buffer exhaustion terminates
the affected path explicitly instead of silently dropping ordered state.

The transport worker owns Bevy/Renet pumping. C++ owns authoritative gameplay
objects and never hands engine pointers to Rust. Library-allocated buffers are
returned through the matching library free function. The loader checks the ABI
before creating a runtime, and resolves the adjacent desktop library independently
of the current working directory.

## Focused acceptance

```sh
cargo test --locked --manifest-path rust/coop_ecs/Cargo.toml
cmake -S tests/network_transport -B out/network-tests
cmake --build out/network-tests -j2
python3 build-scripts/build-coop-runtime.py --profile dev \
  --target-dir out/coop-rust --library-dir out/network-tests
ctest --test-dir out/network-tests --output-on-failure
```

The native harness compiles the production server, client, protocol parser,
compression, queue and dynamic adapter. It substitutes game callbacks and one
JSON diagnostic string helper; it does not simulate game turns or save loading.
Rust tests exercise three concurrent peers, four channels, 96 KiB reliable binary
messages, targeted replies, disconnect/rehost and backpressure ordering. This is
transport evidence, not multiplayer gameplay, WAN performance or save acceptance.
