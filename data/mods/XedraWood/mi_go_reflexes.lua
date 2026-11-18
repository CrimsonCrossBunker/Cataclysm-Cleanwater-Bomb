local ccb = require("ccb")
local services = ccb.services
local effect = services.types.id("effect", "effect_monster_heightened_reflex_enhanced")

ccb.runtime.handler("mi_go_heightened_reflexes", function(impact)
    local turns = services.random.native_float(270, 1530)
    local applied = services.effects.add(impact.caster, effect, services.time.duration(math.modf(turns), "turn"))
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
end)

ccb.content.upsert_spell(ccb.content.Spell {
    id = "biokinetic_heightened_reflexes_enhanced_monster",
    name = "Heightened Reflexes enemy check",
    description = "Applies an even stronger version of Heightened Reflexes when a hostile target is detected.",
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    shape = "blast",
    min_range = 60,
    max_range = 60,
}:lua_impact("mi_go_heightened_reflexes"))
