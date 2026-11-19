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
