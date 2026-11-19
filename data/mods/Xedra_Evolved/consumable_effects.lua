local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function apply_effect(character, effect, turns, options)
    checked(services.effects.add(character, id("effect", effect),
        services.time.duration_from_turns(turns), options))
end

ccb.runtime.handler("consume_abyssal_coffee", function(context)
    local character = context.character
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You drink the coffee.  It may be the most bitter thing you've ever drunk."), "info")
    end
    apply_effect(character, "effect_xe_abyssal_coffee", 21600)
end)

ccb.runtime.handler("consume_goblin_fruit_adrenaline", function(context)
    local character = context.character
    apply_effect(character, "adrenaline", 1200)
end)

ccb.runtime.handler("consume_goblin_fruit_altitude_speed", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_altitude_speed", 3000 + services.random.native_int(0, 2000))
end)

ccb.runtime.handler("consume_goblin_fruit_amplification_instant", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_amplification_instant", 60, { intensity = 10 })
end)

ccb.runtime.handler("consume_goblin_fruit_attack_speed", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_speed", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_awake", function(context)
    local character = context.character
    local needs = checked(services.needs.get(character))
    checked(services.needs.set(character, { sleepiness = needs.sleepiness - 25 }))
end)

ccb.runtime.handler("consume_goblin_fruit_blind_flash", function(context)
    local character = context.character
    checked(services.characters.cast_spell(character, id("spell", "goblin_fruit_blind_flash"), { min_level = 0, max_level = 0 }))
end)

ccb.runtime.handler("consume_goblin_fruit_carry_boost", function(context)
    local character = context.character
    apply_effect(character, "goblin_fruit_carry_boost", 8000 + services.random.native_int(0, 8000))
end)

ccb.runtime.handler("consume_goblin_fruit_climb", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_climb", 3000 + services.random.native_int(0, 1000))
end)

ccb.runtime.handler("consume_goblin_fruit_cold_resist", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_cold_resist", 2500 + services.random.native_int(0, 3000))
end)

ccb.runtime.handler("consume_goblin_fruit_combat_skill_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_combat_skill_boost", 2000 + services.random.native_int(0, 3000))
end)

ccb.runtime.handler("consume_goblin_fruit_craft_skill_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_craft_skill_boost", 15000 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_goblin_fruit_craft_speed_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_craft_speed_boost", 5000 + services.random.native_int(0, 10000))
end)

ccb.runtime.handler("consume_goblin_fruit_dodge", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_dodge", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_dodge_instant", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_dodge_instant", 10 + services.random.native_int(0, 5))
end)

ccb.runtime.handler("consume_goblin_fruit_feather_fall", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_featherfall", 150 + services.random.native_int(0, 250))
end)

ccb.runtime.handler("consume_goblin_fruit_focus_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_focus_boost", 15000 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_goblin_fruit_healing", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_heal", 150 + services.random.native_int(0, 350))
end)

ccb.runtime.handler("consume_goblin_fruit_heat_blast", function(context)
    local character = context.character
    checked(services.characters.cast_spell(character, id("spell", "goblin_fruit_heat_blasts"), { min_level = 0, max_level = 0 }))
end)

ccb.runtime.handler("consume_goblin_fruit_illness", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_cure", 1)
end)

ccb.runtime.handler("consume_goblin_fruit_immovable", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_immovable", 90 + services.random.native_int(0, 45))
end)

ccb.runtime.handler("consume_goblin_fruit_mana_restore", function(context)
    local character = context.character
    checked(services.characters.cast_spell(character, id("spell", "potion_recover_mana_xe"), { min_level = 4, max_level = 6 }))
end)

ccb.runtime.handler("consume_goblin_fruit_map", function(context)
    local character = context.character
    checked(services.characters.cast_spell(character, id("spell", "goblin_fruit_map_reveal")))
end)

ccb.runtime.handler("consume_goblin_fruit_night_vision", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_nightvision", 500 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_goblin_fruit_no_bleed", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_nobleed", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_no_drunk", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_no_drunk", 1)
    checked(services.needs.modify_raw_pain(character, 10))
end)

ccb.runtime.handler("consume_goblin_fruit_no_rotten_food", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_eat_poison", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_pain", function(context)
    local character = context.character
    checked(services.needs.modify_raw_pain(character, -5))
end)

ccb.runtime.handler("consume_goblin_fruit_perception", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_perception", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_purge_blood", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_purge_blood", 1)
end)

ccb.runtime.handler("consume_goblin_fruit_slowing_armor", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_slowing_armor", 400 + services.random.native_int(0, 200))
end)

ccb.runtime.handler("consume_goblin_fruit_social_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_social_boost", 1200 + services.random.native_int(0, 1200))
end)

ccb.runtime.handler("consume_goblin_fruit_soothing", function(context)
    local character = context.character
    local goblin_fruit_soothe_duration = 10000 + services.random.native_int(0, 5000)
    checked(services.variables.set_global("goblin_fruit_soothe_duration", goblin_fruit_soothe_duration, { include_before = false }))
    apply_effect(character, "took_xanax", goblin_fruit_soothe_duration)
    apply_effect(character, "took_prozac", goblin_fruit_soothe_duration)
    apply_effect(character, "took_thorazine", goblin_fruit_soothe_duration)
end)

ccb.runtime.handler("consume_goblin_fruit_stealth", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_stealth", 100 + services.random.native_int(0, 50))
end)

ccb.runtime.handler("consume_goblin_fruit_super_clairvoyance", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_super_clairvoyance", 1)
end)

ccb.runtime.handler("consume_goblin_fruit_teleport", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_teleport", 2 + services.random.native_int(0, 5))
end)

ccb.runtime.handler("consume_goblin_fruit_thorns", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_thorns", 500 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_goblin_fruit_warmth", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_keep_warm", 500 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_goblin_fruit_water_breathing", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_water_breathing", 500 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_goblin_fruit_wild_travel_boost", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_wild_travel_boost", 3000 + services.random.native_int(0, 4000))
end)

ccb.runtime.handler("consume_item_hedge_nether_eye_paste", function(context)
    local character = context.character
    apply_effect(character, "effect_hedge_nether_eye_paste", 1800 * services.random.native_float(0.6, 1.4))
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You rub the paste on your eyes and feel it tingle."), "neutral")
    end
end)

ccb.runtime.handler("consume_oxygen_jelly_long", function(context)
    local character = context.character
    apply_effect(character, "effect_oxygen_jelly_long", 600 + services.random.native_int(0, 600))
end)

ccb.runtime.handler("consume_shadow_fruit", function(context)
    local character = context.character
    apply_effect(character, "effect_goblin_fruit_shadow", 500 + services.random.native_int(0, 5000))
end)
