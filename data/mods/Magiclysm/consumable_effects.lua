local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function apply_effect(character, effect, turns, options)
    local result = services.effects.add(character, id("effect", effect),
        services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

ccb.runtime.handler("consume_potion_fruit_apple", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_heal", 150 + services.random.native_int(0, 350))
end)

ccb.runtime.handler("consume_potion_fruit_apricot", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_vision", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_blackberries", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_thorns", 500 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_cherry", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_nobleed", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_cranberries", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_purge", 1)
end)

ccb.runtime.handler("consume_potion_fruit_elderberries", function(context)
    local character = context.character
    local needs = checked(services.needs.get(character))
    checked(services.needs.set(character, { sleepiness = needs.sleepiness - 25 }))
end)

ccb.runtime.handler("consume_potion_fruit_huckleberries", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_dodge", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_mayapple", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_eat_poison", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_peach", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_cure", 1)
end)

ccb.runtime.handler("consume_potion_fruit_pear", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_attack_speed", 250 + services.random.native_int(0, 1500))
end)

ccb.runtime.handler("consume_potion_fruit_raspberries", function(context)
    local character = context.character
    checked(services.needs.modify_raw_pain(character, -3))
end)

ccb.runtime.handler("consume_potion_fruit_strawberries", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_keep_warm", 500 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("consume_potion_fruit_wintergreen", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_nightvision", 500 + services.random.native_int(0, 5000))
end)

ccb.runtime.handler("eat_potion_fruit_grapes", function(context)
    local character = context.character
    apply_effect(character, "effect_pfruit_no_drunk", 1)
    local pain = checked(services.creatures.snapshot(character)).perceived_pain
    checked(services.needs.modify_pain(character, pain + 10))
end)

ccb.runtime.handler("eat_potion_fruit_solomon_seal", function(context)
    local character = context.character
    local current = checked(services.spells.mana(character)).current
    local mana = math.modf(current + services.random.native_float(200, 600))
    checked(services.spells.set_mana_raw(character, mana))
end)

ccb.runtime.handler("eat_druid_goodberry", function(context)
    local character = context.character
    for _, part in ipairs({ "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r" }) do
        local body_part = id("body_part", part)
        local hp = checked(services.characters.hp(character, body_part))
        if hp > 0 then
            checked(services.characters.set_hp(character, body_part, hp + 3, true))
        end
    end
end)
