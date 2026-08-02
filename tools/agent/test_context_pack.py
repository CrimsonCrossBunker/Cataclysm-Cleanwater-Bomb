from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "agent"))

from benchmark_context_pack import benchmark  # noqa: E402
from build_context_pack import build_pack  # noqa: E402


class ContextPackTests(unittest.TestCase):
    def test_lua_route_contains_contract_and_validation(self) -> None:
        pack = build_pack(
            "Change Lua manifest capabilities",
            [],
            ["data/lua/manifest.schema.json"],
            4000,
        )
        self.assertIn("lua-api", pack["selected_routes"])
        self.assertIn("api.lua.v5.reference.modules", pack["documentation_ids"])
        self.assertIn("lua-contract", {entry["id"] for entry in pack["tests"]})
        self.assertIn("src/main.cpp", pack["source_paths"])
        self.assertIn("src/game_io.cpp", pack["source_paths"])
        self.assertLessEqual(pack["estimated_tokens"], 4000)

    def test_untracked_and_obj_lua_paths_are_rejected(self) -> None:
        for path in ("does-not-exist.cpp", "obj-lua/cache.o"):
            with self.subTest(path=path), self.assertRaisesRegex(
                ValueError, "not tracked"
            ):
                build_pack("navigate", [], [path], 2000)

    def test_small_pack_respects_token_limit(self) -> None:
        pack = build_pack("repository navigation", [], ["AGENTS.md"], 1000)
        self.assertLessEqual(pack["estimated_tokens"], 1000)
        self.assertTrue(pack["truncated"])

    def test_benchmark_has_no_hallucinated_paths_or_commands(self) -> None:
        report = benchmark()
        metrics = report["metrics"]
        self.assertEqual(metrics["hallucinated_paths"], 0)
        self.assertEqual(metrics["hallucinated_commands"], 0)
        self.assertEqual(metrics["upstream_divergence_regressions"], 0)
        self.assertEqual(metrics["correct_path_hit_rate"], 1.0)
        self.assertEqual(metrics["first_pass_validation"], 1.0)


if __name__ == "__main__":
    unittest.main()
