local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("afs_toxin_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if not value(services.creatures.has_flag_text(target, "BIO_IMMUNE"))
        or not value(services.creatures.has_flag_text(target, "BIOLOGICALPROOF"))
    then
        value(services.effects.add(
            target,
            services.types.id("effect", "afs_badpoison"),
            services.time.duration(300),
            { body_part = services.types.id("body_part", "torso") }
        ))
    end
end, 1)

if not content.is_mod_active("mindovermatter") then
    ccb.runtime.handler("afs_psi_telekinetic_on_damage", function(payload)
        local target = payload.target
        if not target or payload.damage_taken <= 0 then
            return
        end
        if services.random.native_probability(1, 5) then
            value(services.effects.add(
                target,
                services.types.id("effect", "downed"),
                services.time.duration(1)
            ))
        end
        if services.random.native_probability(2, 5) then
            value(services.effects.add(
                target,
                services.types.id("effect", "staggered"),
                services.time.duration(2)
            ))
        end
    end, 1)

    ccb.runtime.handler("afs_psi_telepathic_on_damage", function(payload)
        local target = payload.target
        if not target then
            return
        end
        local target_kind = value(services.creatures.snapshot(target)).kind
        local char_target = target_kind ~= "monster"
        local hive_mind = value(services.creatures.has_flag_text(target, "HIVE_MIND"))
        local blocked = hive_mind
            or value(services.creatures.has_flag_text(target, "TEEP_IMMUNE"))
            or value(services.creatures.has_flag_text(target, "TEEPSHIELD"))
        local psyshield_flag = services.types.id("json_flag", "PSYSHIELD_PARTIAL")
        local psyshield_effect = services.types.id("effect", "effect_psyshield_protection")

        if char_target
            and payload.damage_taken > -2
            and not blocked
            and psyshield_flag:is_valid()
            and psyshield_effect:is_valid()
            and value(services.inventory.has_worn_flag(target, psyshield_flag))
            and value(services.effects.has(target, psyshield_effect))
        then
            if services.random.native_probability(1, 2) then
                if target_kind == "avatar" then
                    services.messages.add(
                        "Your head prickles.  It feels like spiders crawling across the surface of your brain.",
                        "bad"
                    )
                end
                value(services.effects.remove(target, psyshield_effect))
            else
                value(services.effects.remove(target, psyshield_effect))
                local self_spell = services.types.id("spell", "telepathic_self_damage")
                if self_spell:is_valid() then
                    value(services.characters.cast_spell(target, self_spell, { hit_self = true }))
                end
                if target_kind == "avatar" then
                    services.messages.add("Your mind reels!", "bad")
                end
            end
        elseif payload.damage_taken > 0 and not blocked then
            if services.random.native_probability(1, 3) then
                value(services.effects.add(
                    target,
                    services.types.id("effect", "psi_stunned"),
                    services.time.duration(1)
                ))
            end
            if services.random.native_probability(2, 3) then
                local psi_dazed = services.types.id("effect", "psi_dazed")
                if psi_dazed:is_valid() then
                    value(services.effects.add(target, psi_dazed, services.time.duration(2)))
                end
            end
            if services.random.native_probability(1, 20) then
                value(services.effects.add(
                    target,
                    services.types.id("effect", "downed"),
                    services.time.duration(1)
                ))
            end
        end

        if payload.damage_taken > 0 and hive_mind and services.random.native_probability(1, 6) then
            value(services.effects.add(
                target,
                services.types.id("effect", "psi_stunned"),
                services.time.duration(5)
            ))
        end
    end, 1)
end

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "afs_plasma",
    name = ccb.content.text("plasma", { context = "damage_type" }),
    magic_color = "pink",
    bash_conversion_factor = 0.4,
    physical = true,
}
definition:derived("heat", 0.4)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_laser",
    name = ccb.content.text("laser", { context = "damage_type" }),
    magic_color = "red",
    bash_conversion_factor = 0.4,
    physical = true,
}
definition:derived("heat", 1)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_heat_melee",
    name = ccb.content.text("heat", { context = "damage_type" }),
    skill = "cutting",
    magic_color = "red",
    bash_conversion_factor = 0.7,
    melee_crit_dmg_mult = 0.25,
    melee_crit_dmg_mult_per_skill = 0.02,
    melee_crit_armor_mult = 0.75,
    melee_crit_armor_penetration = 5,
    melee_only = true,
    physical = true,
    monster_difficulty = true,
    edged = true,
}
definition:derived("heat", 1)
definition:immune_character_flag("CUT_IMMUNE")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_toxin_pierce",
    name = ccb.content.text("toxic pierce"),
    skill = "stabbing",
    magic_color = "light_green",
    melee_crit_dmg_mult_per_skill = 0.1,
    melee_crit_armor_mult = 0.66,
    melee_only = true,
    physical = true,
    edged = true,
}
definition:derived("stab", 1)
definition:immune_character_flag("STAB_IMMUNE")
definition:on_damage("afs_toxin_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_toxin_bullet",
    name = ccb.content.text("toxic ballistic"),
    magic_color = "light_green",
    physical = true,
}
definition:derived("bullet", 1)
definition:immune_character_flag("BULLET_IMMUNE")
definition:on_damage("afs_toxin_on_damage")
content.add(definition)
end
if not content.is_mod_active("mindovermatter") then
do
local definition = content.DamageType {
    id = "psi_telekinetic_damage",
    name = ccb.content.text("telekinetic", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "yellow",
    bash_conversion_factor = 0.9,
    physical = false,
}
definition:derived("bash", 0.9)
definition:immune_character_flag("TELEKIN_SHIELD")
definition:immune_monster_flag("TELEKIN_IMMUNE")
definition:on_damage("afs_psi_telekinetic_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "psi_telepathic_damage",
    name = ccb.content.text("telepathic", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "white",
    physical = false,
}
definition:immune_character_flag("TEEPSHIELD")
definition:immune_character_flag("PSYSHIELD_PROTECT")
definition:immune_monster_flag("TEEP_IMMUNE")
definition:on_damage("afs_psi_telepathic_on_damage")
content.add(definition)
end
end
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "afs_plasma",
    display = "basic",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 407, true)
definition:section("protection", 307, true)
definition:section("pet_protection", 307, true)
definition:section("melee", 407, true)
definition:section("ablative", 307, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_laser",
    display = "basic",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 393, true)
definition:section("protection", 293, true)
definition:section("pet_protection", 293, true)
definition:section("melee", 393, true)
definition:section("ablative", 293, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_heat_melee",
    display = "detailed",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 200, true)
definition:section("protection", 200, false)
definition:section("pet_protection", 200, false)
definition:section("melee", 200, true)
definition:section("ablative", 200, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_toxin_pierce",
    display = "detailed",
    verb = ccb.content.text("shooting"),
}
definition:section("bionic", 407, false)
definition:section("protection", 307, false)
definition:section("pet_protection", 307, false)
definition:section("melee", 407, true)
definition:section("ablative", 307, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_toxin_bullet",
    display = "detailed",
    verb = ccb.content.text("shooting"),
}
definition:section("bionic", 401, false)
definition:section("protection", 301, false)
definition:section("pet_protection", 301, false)
definition:section("melee", 401, false)
definition:section("ablative", 301, false)
content.add(definition)
end
if not content.is_mod_active("mindovermatter") then
local definition = content.DamageInfoOrder {
    id = "psi_telekinetic_damage",
    display = "detailed",
    verb = ccb.content.text("buffeting"),
}
definition:section("bionic", 999899, false)
definition:section("protection", 999899, false)
definition:section("pet_protection", 999899, false)
definition:section("melee", 999899, false)
definition:section("ablative", 999899, false)
content.add(definition)
end
if not content.is_mod_active("mindovermatter") then
local definition = content.DamageInfoOrder {
    id = "psi_telepathic_damage",
    display = "detailed",
    verb = ccb.content.text("mindblasting"),
}
definition:section("bionic", 999900, false)
definition:section("protection", 999900, false)
definition:section("pet_protection", 999900, false)
definition:section("melee", 999900, false)
definition:section("ablative", 999900, false)
content.add(definition)
end
