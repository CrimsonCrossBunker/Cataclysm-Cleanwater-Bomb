local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local duration = services.time.duration

local function apply_effect(actor, effect, length, options)
    local applied = services.effects.add(actor, effect, length, options)
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
end

local function caster_buff(spell_id, name, description, effect_id, minimum, maximum)
    local effect = id("effect", effect_id)
    ccb.runtime.handler(spell_id, function(impact)
        local turns = services.random.native_float(minimum, maximum)
        apply_effect(impact.caster, effect, duration(math.modf(turns), "turn"))
    end)
    return content.Spell {
        id = spell_id,
        name = name,
        description = description,
        message = ccb.content.text("You cast %s!"),
        sound_description = ccb.content.text("an explosion."),
        flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
        valid_targets = { "hostile" },
        max_level = 1,
        shape = "blast",
        min_range = 60,
        max_range = 60,
    }:lua_impact(spell_id)
end

content.add(caster_buff("biokinetic_heightened_reflexes_monster", "Heightened Reflexes enemy check",
    "Applies Enhanced Reflexes when a hostile target is detected.", "effect_monster_heightened_reflex", 180, 990))
content.upsert_spell(caster_buff("biokinetic_heightened_reflexes_enhanced_monster", "Heightened Reflexes enemy check",
    "Applies an even stronger version of Heightened Reflexes when a hostile target is detected.",
    "effect_monster_heightened_reflex_enhanced", 270, 1530))
content.add(caster_buff("electrokinetic_neuro_acceleration_monster", "Neuro-Acceleration monster enemy check",
    "Applies Neuro-Acceleration when a hostile target is detected.", "effect_monster_neuro_acceleration", 225, 742))
content.add(caster_buff("electrokinetic_neuro_acceleration_enhanced_monster", "Neuro-Acceleration Enhanced monster enemy check",
    "Applies an enhanced version of Neuro-Acceleration when a hostile target is detected.",
    "effect_monster_neuro_acceleration_enhanced", 225, 742))

local mindsight_5 = id("effect", "eff_mind_seeing_bonus_5")
local mindsight_10 = id("effect", "eff_mind_seeing_bonus_10")
local mindsight_30 = id("effect", "eff_mind_seeing_bonus_30")

ccb.runtime.handler("whispering_amalgamation_mindsight", function(impact)
    local length = duration(9000, "turn")
    apply_effect(impact.target_creature, mindsight_30, length)
    apply_effect(impact.target_creature, mindsight_10, length)
end)

content.add(content.Spell {
    id = "whispering_amalgamation_apply_mindsight",
    name = "Eater apply mindsight",
    description = ccb.content.text("Add the effect to give the whispering_amalgamation mindsight."),
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "MUST_HAVE_CLASS_TO_LEARN", "HIDDEN_SPELL" },
    valid_targets = { "self" },
    max_level = 1,
    shape = "blast",
    min_duration = 900000,
    max_duration = 900000,
    min_range = 0,
    max_range = 0,
}:lua_impact("whispering_amalgamation_mindsight"))

local silent_one_effects = { mindsight_5, mindsight_10, mindsight_30,
    id("effect", "effect_nether_silent_one_resistances") }

ccb.runtime.handler("silent_one_buff", function(impact)
    local length = duration(1, "turn")
    for _, effect in ipairs(silent_one_effects) do
        apply_effect(impact.target_creature, effect, length, { permanent = true })
    end
end)

content.add(content.Spell {
    id = "silent_one_apply_buffs",
    name = "[Ψ]Silent One Applying Buffs attack",
    description = "Silent One's applying buffs to itself.  It's a bug if you have it.",
    message = "",
    sound_description = ccb.content.text("an explosion."),
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
}:lua_impact("silent_one_buff"))
