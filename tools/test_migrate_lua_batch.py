"""Run a generated batch larger than Lua's per-function local limit."""

from pathlib import Path
import shutil
import subprocess
import unittest

from migrate_lua_first import SourceObject, migrate


class LuaBatchTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which("lua"), "Lua is unavailable")
    def test_large_batch_registers_definitions_and_calls_forward_handler(self):
        ids = [f"batch_{i}" for i in range(230)]
        records = [
            {"type": "overmap_terrain", "id": ids, "name": "Batch terrain"},
            {"type": "effect_on_condition", "id": "caller",
             "eoc_type": "EVENT", "required_event": "character_melee_attacks_character",
             "effect": {"run_eocs": "callee"}},
        ]
        for i in ids:
            records.extend((
                {"type": "ITEM", "id": i, "name": i},
                {"type": "recipe", "id": i, "result": i},
                {"type": "effect_on_condition", "id": i,
                 "effect": {"message": "other"}},
            ))
        records.append({"type": "effect_on_condition", "id": "callee",
                        "eoc_type": "EVENT", "required_event": "character_melee_attacks_character",
                        "effect": {"message": "reached later handler"}})
        sources = [
            SourceObject(Path("batch.json"), i, value)
            for i, value in enumerate(records)
        ]
        generated = migrate(sources, "batch").files[Path("main.lua")]
        script = '''
local handlers, counts, messages = {}, {}, {}
local content = {add = function(def) counts[def.kind] = (counts[def.kind] or 0) + 1 end}
for _, kind in ipairs({"Item", "Recipe", "OvermapTerrain"}) do
    content[kind] = function(options) return {kind = kind, id = options.id} end
end
local ccb = {
    content = content,
    runtime = {handler = function(id, fn) handlers[id] = fn end, on = function() end},
    services = {
        message = function(text) table.insert(messages, text) end,
        translate = function(text) return text end,
        text = {expand_for = function(text) return {ok = true, value = text} end},
    },
}
package.preload.ccb = function() return ccb end
''' + generated + '''
for _, kind in ipairs({"Item", "Recipe", "OvermapTerrain"}) do
    assert(counts[kind] == 230, kind .. ": " .. tostring(counts[kind]))
end
handlers["migrated.caller"]({actors = {attacker = {}, interlocutor = {}}, data = {}})
assert(#messages == 1 and messages[1] == "reached later handler", table.concat(messages, ", "))
'''
        run = subprocess.run(["lua", "-"], input=script, text=True,
                             capture_output=True, timeout=10)
        self.assertEqual(run.returncode, 0, run.stderr)
