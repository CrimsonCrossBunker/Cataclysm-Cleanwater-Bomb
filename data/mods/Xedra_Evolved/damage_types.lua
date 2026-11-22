local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("xe_shadow_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if value(services.creatures.has_flag_text(target, "SHADOW_CHAR_IMMUNE"))
        or value(services.creatures.has_flag_text(target, "SHADOW_MONSTER_IMMUNE"))
    then
        return
    end
    if value(services.creatures.snapshot(target)).kind ~= "monster"
        and value(services.mutations.has_id_text(target, "SHADOWED"))
    then
        return
    end
    local blind = services.types.id("effect", "blind")
    if services.random.native_probability(1, 5) then
        value(services.effects.add(target, blind, services.time.duration(3)))
    end
    if services.random.native_probability(1, 24) then
        if payload.source and value(services.creatures.snapshot(payload.source)).kind == "avatar" then
            services.messages.add("A bit of shadowstuff settles over your eyes, blocking your vision!", "bad")
        end
        value(services.effects.add(target, blind, services.time.duration(10)))
    end
end, 1)

ccb.runtime.handler("xe_withering_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if value(services.creatures.has_flag_text(target, "WITHERINGPROOF"))
        or value(services.creatures.has_flag_text(target, "WITHERING_IMMUNE"))
    then
        return
    end
    if services.random.native_probability(1, 10) then
        value(services.effects.add(
            target,
            services.types.id("effect", "effect_withering_healing_down"),
            services.time.duration(1800 + services.random.native_int(0, 3600))
        ))
    end
end, 1)

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "xe_cold_iron_cut_damage",
    name = ccb.content.text("cold iron cut"),
    skill = "cutting",
    magic_color = "light_gray",
    bash_conversion_factor = 0.75,
    melee_crit_dmg_mult = 0.25,
    melee_crit_dmg_mult_per_skill = 0.02,
    melee_crit_armor_mult = 0.75,
    melee_crit_armor_penetration = 5,
    physical = true,
}
definition:derived("cut", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "xe_cold_iron_bash_damage",
    name = ccb.content.text("cold iron bash"),
    skill = "bashing",
    magic_color = "light_gray",
    bash_conversion_factor = 1.0,
    melee_crit_dmg_mult = 0.5,
    melee_crit_armor_mult = 0.5,
    physical = true,
}
definition:derived("bash", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "xe_cold_iron_stab_damage",
    name = ccb.content.text("cold iron stab"),
    skill = "stabbing",
    magic_color = "light_gray",
    bash_conversion_factor = 0.6,
    melee_crit_dmg_mult_per_skill = 0.1,
    melee_crit_armor_mult = 0.66,
    physical = true,
}
definition:derived("stab", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "xe_shadow_damage",
    name = ccb.content.text("sharp edged shadows"),
    skill = "cutting",
    magic_color = "dark_gray",
    physical = false,
}
definition:derived("cut", 0.8)
definition:immune_character_flag("SHADOW_CHAR_IMMUNE")
definition:immune_monster_flag("SHADOW_MONSTER_IMMUNE")
definition:on_damage("xe_shadow_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "withering_damage",
    name = ccb.content.text("withering"),
    skill = "deduction",
    magic_color = "light_gray",
    physical = false,
}
definition:immune_character_flag("WITHERING_IMMUNE")
definition:immune_monster_flag("WITHERINGPROOF")
definition:on_damage("xe_withering_on_damage")
content.add(definition)
end
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_cut_damage",
    display = "detailed",
    verb = ccb.content.text("cutting"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_bash_damage",
    display = "detailed",
    verb = ccb.content.text("bashing"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_stab_damage",
    display = "detailed",
    verb = ccb.content.text("piercing"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_shadow_damage",
    display = "detailed",
    verb = ccb.content.text("umbrous"),
}
definition:section("bionic", 999903, false)
definition:section("protection", 999903, false)
definition:section("pet_protection", 999903, false)
definition:section("melee", 999903, false)
definition:section("ablative", 999903, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "withering_damage",
    display = "detailed",
    verb = ccb.content.text("withering"),
}
definition:section("bionic", 999905, false)
definition:section("protection", 999905, false)
definition:section("pet_protection", 999905, false)
definition:section("melee", 999905, false)
definition:section("ablative", 999905, false)
content.add(definition)
end
