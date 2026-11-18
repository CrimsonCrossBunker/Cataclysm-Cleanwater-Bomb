local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local duration = services.time.duration
local id = services.types.id
local random = services.random
local effects = services.effects
local tasks = ccb.tasks

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_effect(character, name)
    return value(effects.has(character, id("effect", name)))
end

local function intensity(character, name)
    local result = effects.get(character, id("effect", name))
    if not result.ok and result.error.code == "not_found" then return -1 end
    return value(result).intensity
end

local function add_effect(character, name, turns)
    value(effects.add(character, id("effect", name), duration(math.modf(turns), "turn")))
end

local function after(character, handler, low, high)
    tasks.after_character_turn(character, high and random.native_int(low, high) or low, handler)
end

local function on_due(handler, callback)
    ccb.runtime.handler(handler, function(payload)
        callback(payload.character)
    end, 1)
end

local function one_in(chance)
    return random.native_int(0, chance - 1) == 0
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function say_to_player(character, text)
    if value(services.creatures.snapshot(character)).kind == "avatar" then
        services.messages.add(text, "bad")
    end
end

-- Xedra used to override the serum duration formula. The multiplier applies only
-- in worlds with Xedra selected, and combines all matching traits.
local xedra_duration_factors = {
    { "VAMPIRE4", 0 },
    { "WEREWOLF_MANA_TRAIT", 0 },
    { "VAMPIRE3", 0.5 },
    { "CHANGELING_MAGIC", 0.5 },
    { "ARVORE", 0.25 },
    { "IERDE", 0 },
    { "HOMULLUS", 0.5 },
    { "SALAMANDER", 0 },
    { "SYLPH", 0.25 },
    { "UNDINE", 0.25 },
    { "LILIN_TRAITS", 0.5 },
    { "THRESH_LILIN", 0 },
    { "GRACKEN", 0.25 },
    { "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD", 0.666 },
    { "DHAMPIR_WEAKNESS_SLOW_HEALING", 0.75 },
}

local function duration_factor(character)
    local factor = 1
    if content.is_mod_active("xedra_evolved") then
        for _, entry in ipairs(xedra_duration_factors) do
            if has_trait(character, entry[1]) then
                factor = factor * entry[2]
            end
        end
    end
    return factor
end

local syringe = id("item", "syringe")
local bio_syringe = id("bionic", "bio_syringe")
local function inject(effect, minimum, maximum, on_injected)
    return function(ctx)
        local character = ctx.character
        if not character then return 1 end
        local supplies = value(services.inventory.resources(character, syringe, 1))
        if supplies.charges == 0 and not supplies.has_amount
            and not value(services.bionics.has(character, bio_syringe)) then
            ctx:message(ccb.services.translate("You need a syringe to inject the liquid."), "bad")
            return 1
        end
        if has_effect(character, "regen_serum_main") or has_effect(character, "regen_serum_crash_cardio")
            or has_effect(character, "regen_serum_crash_fatigue") then
            ctx:message(ccb.services.translate("You would not dare to inject two of them at once."), "bad")
            return 1
        end

        value(services.inventory.consume_by_type(character, id("item", ctx.item_id), 1, 0))
        local turns = random.native_float(minimum, maximum) * duration_factor(character)
        add_effect(character, effect, turns)
        if on_injected then on_injected(character, turns) end
        return 1
    end
end

local function after_regeneration(character, turns)
    add_effect(character, "regen_serum_crash_cardio", turns * random.native_float(1.5, 2.5))
    after(character, "serum_regen_pain", 3600, 21600)
    after(character, "serum_regen_rejection", 3600, 21600)
end

local function schedule_first_side_effect(effect, handler, low, high)
    return function(character)
        if intensity(character, effect) <= 1 then
            after(character, handler, low, high)
        end
    end
end

on_due("serum_regen_pain", function(character)
    if not has_effect(character, "regen_serum_main") then return end
    say_to_player(character, ccb.services.translate(
        "You feel an immense pain, when something within your bloodstream moves eerily."
    ))
    local pain = value(services.creatures.snapshot(character)).perceived_pain
    value(services.characters.adjust(character, { pain = math.floor(pain + random.native_float(15, 55)) }))
    after(character, "serum_regen_pain", 3600, 21600)
end)

on_due("serum_regen_rejection", function(character)
    if not one_in(5) then return end
    if one_in(2) then
        value(services.mutations.mutate_category(character, id("mutation_category", "HUMAN"), false, false))
    else
        value(services.mutations.mutate(character, 1, false))
    end
end)

local resilience_effects = {
    [8] = "resilience_serum_side_effect_jittery",
    [9] = "resilience_serum_side_effect_badmood",
    [10] = "resilience_serum_side_effect_hallucinations",
}

on_due("serum_resilience_side_effects", function(character)
    if not has_effect(character, "resilience_serum_main") then return end
    local effect = resilience_effects[random.native_int(0, 10)]
    if effect then add_effect(character, effect, 3600 + random.native_int(0, 3600)) end
    after(character, "serum_resilience_side_effects", 1800, 5400)
end)

on_due("serum_resilience_paralysis", function(character)
    if not has_effect(character, "resilience_serum_crash") then return end
    if random.native_probability(1, 2) then
        add_effect(character, "resilience_serum_side_effect_downed", random.native_int(1, 3))
    end
    after(character, "serum_resilience_paralysis", 7200, 18000)
end)

on_due("serum_learning_hallucinations", function(character)
    if not has_effect(character, "learning_serum_main") and not has_effect(character, "learning_serum_crash") then
        return
    end
    if random.native_int(0, 3) == 3 then
        add_effect(character, "resilience_serum_side_effect_hallucinations", 1800 + random.native_int(0, 1800))
    end
    after(character, "serum_learning_hallucinations", 1800, 5400)
end)

local grip = id("limb_score", "grip")
local balance = id("limb_score", "balance")
local function loses_grip(character, dexterity)
    local score = value(services.characters.limb_score(character, grip, "hand"))
    score = score + random.native_int(0, dexterity) * 0.1
    if has_trait(character, "CLUMSY") then score = score - 0.2 end
    if intensity(character, "shakes") > -1 then score = score - 0.2 end
    if has_trait(character, "DEFT") then score = score + 0.1 end
    return score < 0.6
end

local function loses_balance(character, dexterity)
    local score = value(services.characters.limb_score(character, balance))
    score = score + random.native_int(0, dexterity) * 0.1
    if has_trait(character, "BADKNEES") then score = score - 0.1 end
    if has_trait(character, "REALLYBADKNEES") then score = score - 0.4 end
    return score < 0.6
end

on_due("serum_speed_side_effects", function(character)
    if not has_effect(character, "speed_serum_main") then return end
    after(character, "serum_speed_side_effects", 1500, 3900)

    if has_effect(character, "valium") then return end
    local roll = random.native_int(0, 5)
    if roll ~= 4 and roll ~= 5 then return end
    if has_effect(character, "sleep") then return end
    local snapshot = value(services.characters.snapshot(character))
    local dexterity = snapshot.stats.dexterity
    if roll == 4 then
        if value(services.creatures.snapshot(character)).has_weapon and loses_grip(character, dexterity) then
            add_effect(character, "effect_zero_manip", 0)
            say_to_player(character, ccb.services.translate("Your hands suddenly twitch, releasing your grip!"))
        end
    elseif loses_balance(character, dexterity) then
        add_effect(character, "downed", 5)
        say_to_player(character, ccb.services.translate("Your legs twitch and you fall to the ground!"))
    end
end)

on_due("serum_night_ops_phobia", function(character)
    if not has_effect(character, "night_ops_serum_crash") then return end
    if random.native_probability(1, 2) and not has_effect(character, "betablock") then
        add_effect(character, "night_ops_serum_crash_nyctophobia", random.native_int(1800, 3600))
    end
    after(character, "serum_night_ops_phobia", 1200, 7200)
end)

local crash_handlers = {}

local function register_crash(main_effect, handler, crash_effect, low, high, aftermath)
    crash_handlers[main_effect] = handler
    on_due(handler, function(character)
        add_effect(character, crash_effect, random.native_int(low, high))
        if aftermath then aftermath(character) end
    end)
end

register_crash("regen_serum_main", "serum_regen_crash", "regen_serum_crash_fatigue", 432000, 864000)
register_crash("super_soldier_serum_main", "serum_super_soldier_crash", "super_soldier_serum_crash", 172800, 259200)
register_crash("resilience_serum_main", "serum_resilience_crash", "resilience_serum_crash", 86400, 172800)
register_crash("learning_serum_main", "serum_learning_crash", "learning_serum_crash", 10800, 21600)
register_crash("speed_serum_main", "serum_speed_crash", "speed_serum_crash", 86400, 172800)
register_crash("night_ops_serum_main", "serum_night_ops_crash", "night_ops_serum_crash", 7200, 14400, function(character)
    after(character, "serum_night_ops_phobia", 1200, 7200)
end)

ccb.runtime.handler("schedule_serum_crash", function(event)
    local handler = crash_handlers[event.data.effect]
    if not handler then return end
    local character = event.actors.character or services.creatures.avatar()
    -- The removal event fires before the serum is removed from the character.
    after(character, handler, 1)
    if event.data.effect == "resilience_serum_main" then
        value(services.needs.modify_raw_pain(character, 5 + random.native_int(0, 20)))
        after(character, "serum_resilience_paralysis", 7200, 18000)
    end
end, 1)
ccb.runtime.on("game:character_loses_effect", "schedule_serum_crash")

ccb.runtime.handler("inject_serum_regen", inject("regen_serum_main", 86400, 172800, after_regeneration))

do
    local item = content.Item {
        id = "serum_regen",
        category = "drugs",
        name = ccb.content.plural_text("48x-\"Locutus\"", "48x-\"Locutus\""),
        description = ccb.content.text("A little, sealed ampule with some white, semi-transparent liquid of unknown origin.  The label on it says \"48x-\"Locutus\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "white",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_regen", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end

ccb.runtime.handler("inject_serum_super_soldier", inject("super_soldier_serum_main", 604800, 691200))

do
    local item = content.Item {
        id = "serum_super_soldier",
        category = "drugs",
        name = ccb.content.plural_text("29x-\"Noonien\"", "29x-\"Noonien\""),
        description = ccb.content.text("A little, sealed ampule with some reddish, semi-transparent liquid of unknown origin.  The label on it says \"29x-\"Noonien\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "red",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_super_soldier", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end

ccb.runtime.handler("inject_serum_resilience", inject("resilience_serum_main", 86400, 172800, schedule_first_side_effect("resilience_serum_main", "serum_resilience_side_effects", 1800, 5400)))

do
    local item = content.Item {
        id = "serum_resilience",
        category = "drugs",
        name = ccb.content.plural_text("16x-\"Armus\"", "16x-\"Armus\""),
        description = ccb.content.text("A little, sealed ampule with some grayish, semi-transparent liquid of unknown origin.  The label on it says \"16x-\"Armus\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "light_gray",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_resilience", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end

ccb.runtime.handler("inject_serum_learning", inject("learning_serum_main", 43200, 86400, schedule_first_side_effect("learning_serum_main", "serum_learning_hallucinations", 1800, 5400)))

do
    local item = content.Item {
        id = "serum_learning",
        category = "drugs",
        name = ccb.content.plural_text("76x-\"Lore\"", "76x-\"Lore\""),
        description = ccb.content.text("A little, sealed ampule with some blue, semi-transparent liquid of unknown origin.  The label on it says \"76x-\"Lore\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "blue",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_learning", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end

ccb.runtime.handler("inject_serum_speed", inject("speed_serum_main", 259200, 518400, schedule_first_side_effect("speed_serum_main", "serum_speed_side_effects", 1500, 3900)))

do
    local item = content.Item {
        id = "serum_speed",
        category = "drugs",
        name = ccb.content.plural_text("51x-\"Landru\"", "51x-\"Landru\""),
        description = ccb.content.text("A little, sealed ampule with some yellow, semi-transparent liquid of unknown origin.  The label on it says \"51x-\"Landru\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "yellow",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_speed", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end

ccb.runtime.handler("inject_serum_night_operations", inject("night_ops_serum_main", 21600, 43200))

do
    local item = content.Item {
        id = "serum_night_operations",
        category = "drugs",
        name = ccb.content.plural_text("09x-\"Anaximander\"", "09x-\"Anaximander\""),
        description = ccb.content.text("A little, sealed ampule with some black, semi-transparent liquid of unknown origin.  The label on it says \"09x-\"Anaximander\"\", whatever that means."),
        display_type = "BY_VOLUME",
        mass_milligrams = 7000,
        volume_ml = 10,
        symbol = "[",
        color = "black",
    }
    item:material("alien_liquid", 1)
    item:clear_use_actions()
    item:on_use("inject_serum_night_operations", ccb.content.text("Inject"), ccb.content.text("Inject the liquid."))
    content.add(item)
end
