# `data/mods/` agent instructions

- Each bundled mod is an independent compatibility surface.  Read its README,
  `modinfo.json`, tests, and dependencies before editing it.
- Avoid cross-mod IDs or implicit load-order dependencies unless explicitly
  declared.
- Keep spoilers and player-facing text in their existing documentation domain.
- Validate the changed mod and the core JSON loader; do not reformat unrelated
  mod files.

```sh
make -j2 json-check
```

内置 MOD 是独立兼容性边界；先阅读本 MOD 的说明和依赖，再做最小范围修改。
