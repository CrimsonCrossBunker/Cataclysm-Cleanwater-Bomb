local ccb = require("ccb")
local services = ccb.services
local effects = services.effects
local time = services.time
local variables = services.variables
local tasks = ccb.tasks
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function clock()
    return (time.now() - time.turn_zero()).turns
end

local function variable(character, key)
    return checked(variables.get_number(character, key)).value or 0
end

local function set_variable(character, key, value)
    checked(variables.set(character, key, value, { include_before = false }))
end

local function message(character, translate, severity)
    if character.subtype == "avatar" then
        services.messages.add(translate(), severity)
    end
end

local function intensity(character, effect)
    local current = effects.get(character, effect, id("body_part", "bp_null"))
    if not current.ok and current.error.code == "not_found" then
        return -1
    end
    return checked(current).intensity
end

local function apply(character, buff, strength, duration, limit)
    local effect = id("effect", buff.effect)
    local exists = checked(effects.has(character, effect))
    local current = exists and intensity(character, effect) or -1
    if not exists or strength > current then
        if exists then
            checked(effects.remove(character, effect))
        end
        local applied = effects.add(character, effect, time.duration_from_turns(1),
            { intensity = math.min(strength, buff.maximum), permanent = true })
        if not applied.ok and applied.error.code ~= "rejected" then checked(applied) end
        set_variable(character, buff.end_key, clock() + math.min(duration, limit))
    elseif strength == current then
        set_variable(character, buff.end_key, math.min(
            variable(character, buff.end_key) + duration, clock() + limit))
    end
    message(character, buff.applied_message, "good")
end

local function tick(character, buff)
    local effect = id("effect", buff.effect)
    if not checked(effects.has(character, effect)) then return end
    if buff.name == "detoxification" then
        local toxin = id("vitamin", "mutant_toxin")
        local amount = checked(services.needs.get_vitamin(character, toxin))
        checked(services.needs.set_vitamin(character, toxin, math.max(amount - 15 * intensity(character, effect), 0)))
    end
    if clock() >= variable(character, buff.end_key) then
        checked(effects.remove(character, effect))
        set_variable(character, buff.stacks_key, 0)
        if not checked(effects.has(character, effect)) then
            message(character, buff.expired_message, "mixed")
        end
    end
end

local function serving(name, strength, duration, limit)
    return { name = name, strength = strength, duration = duration, limit = limit }
end

local buffs = {
    {
        name = "strength", effect = "cd_delight_strength_enhancement", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("A blazing surge of strength races through your arms, and your muscles seem to sing with excitement!") end,
        expired_message = function() return ccb.services.translate("That surging strength fades like a tide, and your arms return to their usual state.") end,
    },
    {
        name = "dexterity", effect = "cd_delight_dexterity_enhancement", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("Your body becomes incredibly light, as if the air itself is making way for you!") end,
        expired_message = function() return ccb.services.translate("The lightness gradually fades, and the air returns to its usual resistance.") end,
    },
    {
        name = "perception", effect = "cd_delight_perception_enhancement", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("The world suddenly becomes vividly clear, and even the faintest sounds and scents are impossible to miss!") end,
        expired_message = function() return ccb.services.translate("Your senses grow cloudy again, and the world becomes less sharp.") end,
    },
    {
        name = "intelligence", effect = "cd_delight_intelligence_enhancement", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("Thoughts streak through your mind like lightning, and complex problems suddenly become clear!") end,
        expired_message = function() return ccb.services.translate("The spark of inspiration gradually fades, and your mind returns to a calm state.") end,
    },
    {
        name = "detoxification", effect = "cd_delight_detoxification", period = 900, maximum = 20,
        applied_message = function() return ccb.services.translate("A cool sensation flows through your veins, like a gentle stream washing away the filth inside you.") end,
        expired_message = function() return ccb.services.translate("The last trace of coolness fades from your body, and the detoxifying power is gone.") end,
    },
    {
        name = "focus", effect = "cd_delight_focus_regen", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("Distracting thoughts recede like a tide, and your mind becomes more focused than ever!") end,
        expired_message = function() return ccb.services.translate("Your focused state quietly breaks apart, and your thoughts begin to wander again.") end,
    },
    {
        name = "satiety", effect = "cd_delight_satiety", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("A warm sense of satiety spreads through your stomach, and every part of you is filled with renewed energy!") end,
        expired_message = function() return ccb.services.translate("The feeling of fullness gradually fades, and your body returns to its usual tired rhythm.") end,
    },
    {
        name = "nourishment", effect = "cd_delight_nourishment", period = 5, maximum = 10,
        applied_message = function() return ccb.services.translate("A warm vitality flows through your veins, and your wounds seem to rejoice as they heal!") end,
        expired_message = function() return ccb.services.translate("That warm vitality quietly fades, and your body returns to its ordinary healing speed.") end,
    },
}

local by_name = {}
for _, buff in ipairs(buffs) do
    by_name[buff.name] = buff
    local key = "cd_delight_" .. buff.name
    buff.end_key = key .. "_end"
    buff.stacks_key = key .. "_stacks"
    buff.handler = "tick_" .. buff.name
    ccb.runtime.handler(buff.handler, function(payload)
        local character = payload.character
        tick(character, buff)
        tasks.after_character_turn(character, buff.period, buff.handler)
    end)
end

ccb.runtime.handler("start_food_buff_timers", function(event)
    local character = event.actors.character
    for _, buff in ipairs(buffs) do
        if not tasks.has_character_turn(character, buff.handler) then
            tasks.after_character_turn(character, buff.period, buff.handler)
        end
    end
end)
ccb.runtime.on("character_ready", "start_food_buff_timers")

local dishes = {
    {
        handler = "drink_detoxifying_milk",
        notice = function() return ccb.services.translate("Warm milk glides down your throat, like a gentle hand soothing your weary insides.") end,
        serving("detoxification", 1, 3600, 21600),
    },
    { handler = "eat_royal_beef",
        serving("satiety", 3, 21600, 21600),
        serving("nourishment", 3, 21600, 21600),
    },
    { handler = "eat_meat_fried",
        serving("satiety", 2, 3600, 3600),
    },
    { handler = "eat_lahmacun",
        serving("satiety", 2, 2700, 10800),
        serving("nourishment", 2, 2700, 10800),
        serving("strength", 2, 2700, 10800),
    },
    { handler = "eat_sushi_meatroll",
        serving("satiety", 1, 18000, 18000),
    },
    { handler = "eat_meatball",
        serving("satiety", 1, 18000, 18000),
    },
    { handler = "eat_scrapple",
        serving("satiety", 1, 2250, 18000),
    },
    { handler = "eat_pelmeni",
        serving("satiety", 1, 18000, 18000),
    },
    { handler = "eat_soup_lobsterstew",
        serving("focus", 2, 5400, 10800),
        serving("intelligence", 2, 5400, 10800),
    },
    { handler = "eat_amatriciana_pasta",
        serving("satiety", 3, 2700, 10800),
        serving("intelligence", 2, 2700, 10800),
    },
    { handler = "eat_pasta_carbonara",
        serving("satiety", 3, 2700, 10800),
        serving("strength", 2, 2700, 10800),
    },
    { handler = "eat_spaghetti_bolognese",
        serving("satiety", 3, 3600, 10800),
        serving("nourishment", 2, 3600, 10800),
    },
    { handler = "eat_gateau_st_honore",
        serving("intelligence", 5, 1800, 18000),
        serving("focus", 3, 1800, 18000),
    },
    { handler = "eat_religieuse_au_chocolat",
        serving("intelligence", 3, 1500, 15000),
        serving("focus", 2, 1500, 15000),
    },
    { handler = "eat_cake2",
        serving("focus", 3, 1500, 18000),
        serving("intelligence", 2, 1500, 18000),
    },
    { handler = "eat_baklava",
        serving("focus", 2, 1200, 8400),
    },
    { handler = "eat_brownie",
        serving("focus", 2, 1800, 7200),
    },
    { handler = "eat_foie_gras",
        serving("perception", 3, 3600, 3600),
    },
    { handler = "eat_confit_meat",
        serving("strength", 3, 7200, 7200),
        serving("satiety", 3, 7200, 7200),
    },
    { handler = "eat_sarma",
        serving("strength", 3, 1800, 7200),
        serving("satiety", 3, 1800, 7200),
    },
    { handler = "eat_kiymali_pide",
        serving("strength", 2, 1200, 7200),
        serving("satiety", 3, 1200, 7200),
    },
    { handler = "eat_manti",
        serving("strength", 2, 720, 7200),
        serving("satiety", 2, 720, 7200),
    },
    { handler = "eat_lasagne",
        serving("satiety", 3, 2700, 10800),
        serving("nourishment", 2, 2700, 10800),
    },
    { handler = "eat_spaghetti_pesto",
        serving("intelligence", 2, 3600, 3600),
    },
}

for _, dish in ipairs(dishes) do
    ccb.runtime.handler(dish.handler, function(context)
        local character = context.character
        if dish.notice then message(character, dish.notice, "good") end
        for _, bonus in ipairs(dish) do
            apply(character, by_name[bonus.name], bonus.strength, bonus.duration, bonus.limit)
        end
    end)
end
