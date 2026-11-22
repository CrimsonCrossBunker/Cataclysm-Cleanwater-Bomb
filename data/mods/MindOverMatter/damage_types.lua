local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function is_character_kind(kind)
    return kind ~= "monster"
end

ccb.runtime.handler("mom_photokinetic_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if value(services.creatures.has_flag_text(target, "PHOTOKIN_CHAR_IMMUNE"))
        or value(services.creatures.has_flag_text(target, "PHOTOKIN_MONSTER_IMMUNE"))
    then
        return
    end
    if is_character_kind(value(services.creatures.snapshot(target)).kind)
        and value(services.mutations.has_id_text(target, "PHOTOKINETIC"))
    then
        return
    end
    local blind = services.types.id("effect", "blind")
    if services.random.native_probability(2, 5) then
        value(services.effects.add(target, blind, services.time.duration(3)))
    end
    if services.random.native_probability(1, 20) then
        value(services.effects.add(target, blind, services.time.duration(10)))
    end
end, 1)

ccb.runtime.handler("mom_telekinetic_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    local concussive = 0
    if payload.source
        and is_character_kind(value(services.creatures.snapshot(payload.source)).kind)
        and value(services.mutations.has_id_text(payload.source, "perk_concussive_blasts"))
    then
        concussive = 1
    end
    if services.random.native_probability(1 + concussive, 5) then
        value(services.effects.add(
            target,
            services.types.id("effect", "downed"),
            services.time.duration(1)
        ))
    end
    if services.random.native_probability(2 + concussive * 2, 5) then
        value(services.effects.add(
            target,
            services.types.id("effect", "staggered"),
            services.time.duration(2)
        ))
    end
end, 1)

ccb.runtime.handler("mom_telepathic_on_damage", function(payload)
    local target = payload.target
    if not target then
        return
    end
    local target_kind = value(services.creatures.snapshot(target)).kind
    local char_target = is_character_kind(target_kind)
    local hive_mind = value(services.creatures.has_flag_text(target, "HIVE_MIND"))
    local blocked = hive_mind
        or value(services.creatures.has_flag_text(target, "TEEP_IMMUNE"))
        or value(services.creatures.has_flag_text(target, "TEEPSHIELD"))
    local psyshield_effect = services.types.id("effect", "effect_psyshield_protection")

    if char_target
        and payload.damage_taken > -2
        and not blocked
        and value(services.inventory.has_worn_flag(target, services.types.id("json_flag", "PSYSHIELD_PARTIAL")))
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
            value(services.characters.cast_spell(
                target,
                services.types.id("spell", "telepathic_self_damage"),
                { hit_self = true }
            ))
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
            value(services.effects.add(
                target,
                services.types.id("effect", "psi_dazed"),
                services.time.duration(2)
            ))
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

ccb.runtime.handler("mom_teleporting_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if value(services.creatures.has_flag_text(target, "TELEPORT_IMMUNE"))
        or value(services.creatures.has_flag_text(target, "DIMENSIONAL_ANCHOR"))
        or value(services.creatures.has_flag_text(target, "TELESTOP"))
    then
        return
    end
    local blink = services.types.id("spell", "teleport_damage_type_blink")
    if is_character_kind(value(services.creatures.snapshot(target)).kind) then
        value(services.characters.cast_spell(target, blink, { min_level = 10 }))
    else
        value(services.monsters.cast_spell(target, blink, { min_level = 10 }))
    end
end, 1)

ccb.runtime.handler("mom_enervation_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if value(services.creatures.has_flag_text(target, "LIFESHIELD"))
        or value(services.creatures.has_flag_text(target, "ENERVATE_IMMUNE"))
    then
        return
    end
    local target_kind = value(services.creatures.snapshot(target)).kind
    local drain_spell = services.types.id("spell", "eater_drain_health")
    if is_character_kind(target_kind) then
        local mana = value(services.spells.mana(target)).current
        if mana >= 150 then
            value(services.spells.set_mana_raw(target, mana - services.random.native_int(100, 200)))
            if target_kind == "avatar" then
                services.messages.add("You feel a sudden sense of loss.", "bad")
            end
            return
        end
        local stamina = value(services.needs.get(target)).stamina
        if stamina >= 200 then
            value(services.needs.set(target, {
                stamina = stamina - services.random.native_int(100, 300),
            }))
            if target_kind == "avatar" then
                services.messages.add("For a moment, you feel exhausted.", "bad")
            end
            return
        end
        value(services.characters.cast_spell(target, drain_spell))
        if target_kind == "avatar" then
            services.messages.add("You feel your life draining away!", "bad")
        end
    else
        value(services.monsters.cast_spell(target, drain_spell))
    end
end, 1)

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "psi_photokinetic_damage",
    name = ccb.content.text("focused light", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "yellow",
    physical = false,
}
definition:derived("heat", 0.8)
definition:immune_character_flag("PHOTOKIN_CHAR_IMMUNE")
definition:immune_monster_flag("PHOTOKIN_MONSTER_IMMUNE")
definition:on_damage("mom_photokinetic_on_damage")
content.add(definition)
end
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
definition:on_damage("mom_telekinetic_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "psi_telepathic_damage",
    name = ccb.content.text("telepathic", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "white",
    bash_conversion_factor = 0.0,
    physical = false,
}
definition:immune_character_flag("TEEPSHIELD")
definition:immune_character_flag("PSYSHIELD_PROTECT")
definition:immune_monster_flag("TEEP_IMMUNE")
definition:on_damage("mom_telepathic_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "psi_teleporter_teleporting_damage",
    name = ccb.content.text("spacial realignment", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "blue",
    physical = false,
}
definition:immune_character_flag("DIMENSIONAL_ANCHOR")
definition:immune_character_flag("TELESTOP")
definition:immune_monster_flag("TELEPORT_IMMUNE")
definition:on_damage("mom_teleporting_on_damage")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "psi_enervation_damage",
    name = ccb.content.text("enervation", { context = "damage_type" }),
    skill = "metaphysics",
    magic_color = "red_green",
    physical = false,
}
definition:immune_character_flag("LIFESHIELD")
definition:immune_monster_flag("ENERVATE_IMMUNE")
definition:on_damage("mom_enervation_on_damage")
content.add(definition)
end

-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "psi_photokinetic_damage",
    display = "detailed",
    verb = ccb.content.text("dazzling"),
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
do
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
do
local definition = content.DamageInfoOrder {
    id = "psi_teleporter_teleporting_damage",
    display = "detailed",
    verb = ccb.content.text("recalibrating"),
}
definition:section("bionic", 999901, false)
definition:section("protection", 999901, false)
definition:section("pet_protection", 999901, false)
definition:section("melee", 999901, false)
definition:section("ablative", 999901, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "psi_enervation_damage",
    display = "detailed",
    verb = ccb.content.text("enervating"),
}
definition:section("bionic", 999902, false)
definition:section("protection", 999902, false)
definition:section("pet_protection", 999902, false)
definition:section("melee", 999902, false)
definition:section("ablative", 999902, false)
content.add(definition)
end
