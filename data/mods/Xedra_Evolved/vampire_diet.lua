local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local duration = services.time.duration
local random = services.random

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return value(services.effects.has(character, id("effect", effect)))
end

local function message(character, text, type)
    if character.subtype == "avatar" then
        services.messages.add(text, type)
    end
end

local function add_blood_morale(character, bonus, maximum, minutes, decay)
    value(services.morale.add(character, id("morale", "morale_drank_blood"),
        bonus, maximum, {
            duration = duration(minutes, "minute"),
            decay_start = duration(decay, "minute"),
        }))
end

local function blood_morale(character)
    if has_trait(character, "BLOOD_FUN_UPGRADE") then
        add_blood_morale(character, 90, 180, 60, 30)
    else
        add_blood_morale(character, 30, 60, 20, 10)
    end
end

local function number(character, key)
    return value(services.variables.get_number(character, key)).value or 0
end

local function set_number(character, key, amount)
    value(services.variables.set(character, key, amount, { include_before = false }))
end

local function change_vitamin(character, vitamin, amount)
    value(services.needs.modify_vitamin(character, id("vitamin", vitamin), amount))
end

-- Nyctophobia and pyromania are excluded from this pool.
local mental_weaknesses = {
    "BADTEMPER", "CHEMIMBALANCE", "SHOUT3", "JITTERY", "SEASONAL_AFFECTIVE",
    "SCHIZOPHRENIC", "MOODSWINGS", "INSOMNIA", "JEKYLL", "NOMAD2",
    "HATES_BOOKS", "INATTENTIVE", "PACIFIST", "SAVANT", "SLOWLEARNER",
    "UNOBSERVANT", "SQUEAMISH", "SLOWREADER", "TABLEMANNERS",
}

local function apply_mind_chaos(character)
    local key = "counter_anathema_mind_chaos"
    local count = number(character, key)
    if random.native_float(0, 1) > count / 100 then
        set_number(character, key, count + 1)
        return
    end

    local candidates = {}
    for index, trait in ipairs(mental_weaknesses) do
        candidates[index] = id("mutation", trait)
    end
    if value(services.progression.grant_random_missing(character, "mutation", candidates)).granted then
        message(character, ccb.services.translate("The chaos within your head coalesces and destabilizes your mind."), "bad")
    else
        message(character, ccb.services.translate("The chaos within your head coalesces but it cannot latch on your mind, so it will remain there until it decoheres."), "bad")
        local chaos = id("effect", "effect_anathema_mind_chaos")
        local current = services.effects.get(character, chaos)
        local intensity = 0
        if current.ok or current.error.code ~= "not_found" then
            intensity = value(current).intensity + 1
        end
        value(services.effects.add(character, chaos, duration(86400 + random.native_int(0, 259200), "turn"),
            { intensity = intensity }))
    end
    set_number(character, key, 0)
end

local function drink_vampire_blood(character)
    if not has_trait(character, "VAMPIRE_ANATHEMA") then
        message(character, ccb.services.translate("You need the blood of the living, not the blood of the dead."), "bad")
        return
    end

    local nourished = has_trait(character, "VAMPIRE_DRINK_VAMPIRE_BLOOD")
    if nourished then
        change_vitamin(character, "human_blood_vitamin", 400 + random.native_int(0, 100))
    end
    change_vitamin(character, "vampire_blood_vitamin", 30 + random.native_int(0, 20))

    if nourished then
        message(character, ccb.services.translate("This blood is the best you could drink.  You want more."), "good")
        if has_trait(character, "BLOOD_FUN") then
            blood_morale(character)
        end
    else
        message(character, ccb.services.translate("Though it cannot sustain you, this blood can empower you."), "mixed")
    end
    if has_trait(character, "ANATHEMA_WEAKNESS_MIND_CHAOS") then
        apply_mind_chaos(character)
    end
    if has_trait(character, "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") then
        value(services.effects.add(character, id("effect", "effect_recent_vampire_drink"), duration(4, "day")))
        value(services.effects.remove(character, id("effect", "effect_anathema_need_vampire_blood")))
    end
end

local fae_blood = "vampire_just_drank_fae_blood"
local times_fed = "dhampir_have_ever_drunk_blood"
local shed_morality = "shed_morality"

local function remove_drowned_morals(character)
    if not has_trait(character, "VAMPIRE4") then
        return
    end
    local count = number(character, shed_morality)
    if has_trait(character, "VEGAN") then
        value(services.mutations.erase(character, id("mutation", "VEGAN")))
        if count > 0 then
            message(character, ccb.services.translate("A wave of crimson drowns your empathy for lesser beings."), "mixed")
        end
    end
    if has_trait(character, "SPIRITUAL") then
        value(services.mutations.erase(character, id("mutation", "SPIRITUAL")))
        if count > 0 then
            message(character, ccb.services.translate("There are no wonders and nothing beyond sight, only the thirst and how you will sate it."), "mixed")
        end
    end
    if has_trait(character, "PACIFIST") then
        value(services.mutations.erase(character, id("mutation", "PACIFIST")))
        if count > 0 then
            message(character, ccb.services.translate("Your disdain for violence melts as you drink your fill."), "mixed")
        end
    end
    if not has_trait(character, "PSYCHOPATH") then
        value(services.mutations.replace(character, id("mutation", "PSYCHOPATH")))
        if count > 0 then
            message(character, ccb.services.translate("The blood in your mouth makes you realise that anything that isn't blood isn't worth caring about."), "mixed")
        end
    end
    set_number(character, shed_morality, count + 1)
end

-- Order matters when the native random stream selects a missing mutation.
local dhampir_weaknesses = {
    "DHAMPIR_WEAKNESS_SUN_SENSITIVITY",
    "DHAMPIR_WEAKNESS_SUN_SLEEPINESS",
    "DHAMPIR_WEAKNESS_SLOW_HEALING",
    "DHAMPIR_WEAKNESS_ANIMAL_DISCORD",
    "DHAMPIR_WEAKNESS_WATER_PAIN",
    "DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR",
    "DHAMPIR_WEAKNESS_BLOODTHIRST",
    "DHAMPIR_WEAKNESS_OVERWHELMING_ARROGANCE",
    "DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN",
    "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD",
    "DHAMPIR_WEAKNESS_BURNED_BY_THE_SUN",
}

local function progress_dhampir(character)
    local count = number(character, times_fed)
    if count == 0 then
        count = 1
        set_number(character, times_fed, count)
        message(character, ccb.services.translate("The blood hits your tongue with a wash of warmth and for a moment the world goes white.  The taste is indescribable.  It's better than nectar, better than ambrosia, better than anything you've ever tasted in your life.  You know at this moment that you have crossed a river and there will never be any going back."), "mixed")
        add_blood_morale(character, 45, 45, 60, 30)
    end
    if count <= 0 then
        return
    end
    count = count + 1
    set_number(character, times_fed, count)

    local weaknesses = 0
    for _, trait in ipairs(dhampir_weaknesses) do
        if trait ~= "DHAMPIR_WEAKNESS_SUN_SLEEPINESS" and
            trait ~= "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD" and has_trait(character, trait) then
            weaknesses = weaknesses + 1
        end
    end
    if weaknesses >= 4 then
        return
    end
    local chance = count / random.native_float(500, 10000)
    if random.native_float(0, 1) <= chance then
        local candidates = {}
        for index, trait in ipairs(dhampir_weaknesses) do
            candidates[index] = id("mutation", trait)
        end
        if value(services.progression.grant_random_missing(character, "mutation", candidates)).granted then
            message(character, ccb.services.translate("Your use of your vampiric powers has caused you to gain a new frailty."), "bad")
        end
        message(character, ccb.services.translate("As the blood hits your tongue, something inside you shifts."), "bad")
        set_number(character, times_fed, 1)
    end
end

local function receive_living_blood(character)
    if has_trait(character, "VAMPIRE") or has_effect(character, "vampire_virus") then
        change_vitamin(character, "human_blood_vitamin", 400 + random.native_int(0, 100))
        value(services.effects.add(character, id("effect", "effect_drank_blood_recently"),
            duration(600 + random.native_int(0, 600), "turn"), { intensity = 1 }))
        value(services.morale.remove(character, id("morale", "morale_vw_no_fun")))
        if has_trait(character, "BLOOD_FUN") then
            blood_morale(character)
        end
    else
        change_vitamin(character, "human_blood_vitamin", 250 + random.native_int(0, 100))
    end
    if has_trait(character, "DHAMPIR_WEAKNESS_BLOODTHIRST") then
        value(services.morale.remove(character, id("morale", "morale_craving_human_blood")))
        value(services.effects.remove(character, id("effect", "effect_dhampir_bloodlust_cravings")))
        add_blood_morale(character, 30, 60, 20, 10)
    end
    if has_trait(character, "VAMPIRE_BLOOD_TEMPORARY_BOOST") then
        value(services.effects.add(character, id("effect", "effect_vampire_drank_blood_power_boost"), duration(1, "hour")))
    end
    if number(character, fae_blood) == 1 then
        change_vitamin(character, "drank_fae_blood", 5)
        set_number(character, fae_blood, 0)
    end
    remove_drowned_morals(character)
    if has_trait(character, "DHAMPIR_TRAIT") then
        progress_dhampir(character)
    end
end

local function drink_from_donor(character, donor, cooldown_days)
    if has_trait(donor, "FAE_CREATURE") then
        set_number(character, fae_blood, 1)
    end
    receive_living_blood(character)
    if has_trait(character, "DHAMPIR_TRAIT") then
        local calories = 300 + random.native_int(0, 150)
        value(services.needs.modify_calories(character, calories, true))
        if has_trait(character, "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD") then
            value(services.needs.modify_calories(character, calories // 2, true))
        end
        if character.subtype == "avatar" then
            local text = ccb.services.translate("You are gaining <context_val:temp_val> calories from the blood you drank.")
            local expanded = value(services.text.expand_for(text, character, donor, nil, { temp_val = calories }, true))
            message(character, expanded, "debug")
        end
    end
    value(services.effects.add(donor, id("effect", "feed_from_recently"), duration(cooldown_days, "day")))
    change_vitamin(donor, "blood", -400 - random.native_int(0, 100))
    change_vitamin(donor, "redcells", -400 - random.native_int(0, 100))
end

local function register_donor_topic(topic, ready_line, waiting_line, cooldown_days, return_topic, opinion)
    local function feed(context)
        drink_from_donor(context:speaker(), context:interlocutor(), cooldown_days)
    end
    ccb.dialogue.register_topic {
        id = topic,
        dynamic_line = function(context)
            return has_effect(context:interlocutor(), "feed_from_recently") and waiting_line() or ready_line()
        end,
        responses = function(context)
            if has_effect(context:interlocutor(), "feed_from_recently") then
                return {
                    { text = ccb.services.translate("Got it.  Can we talk about something else?"), topic = return_topic },
                    { text = ccb.services.translate("Got it.  See you later."), topic = "TALK_DONE" },
                }
            end
            return {
                { text = ccb.services.translate("[Drink from them] Thank you.  Can we talk about something else?"),
                    topic = "TALK_NONE", on_action = feed, success_opinion = opinion },
                { text = ccb.services.translate("[Drink from them] Thank you.  See you later."),
                    topic = "TALK_DONE", on_action = feed, success_opinion = opinion },
                { text = ccb.services.translate("I changed my mind.  Keep your blood."), topic = "TALK_DONE" },
            }
        end,
    }
end

register_donor_topic("TALK_FRIEND_FOLLOWER_BLOODFEED_YES",
    function() return ccb.services.translate("Sure!  Anything to help you feel better.") end,
    function() return ccb.services.translate("It'll have to wait, unfortunately.  If I let you do that too often it'll be very bad for my health.") end,
    5, "TALK_NONE")
register_donor_topic("TALK_FRIEND_FOLLOWER_BLOODFEED_KINDA",
    function() return ccb.services.translate("If you really need to, then sure you can.  Don't make an habit out of it, however.") end,
    function() return ccb.services.translate("I'm not letting you do that this soon after last time.  I need that blood too, you know?") end,
    10, "TALK_FRIEND", { trust = -1, value = -1 })

local partial_nourishment = { demihuman_blood = true, mutant_human_blood = true, fae_blood = true }

ccb.runtime.handler("apply_vampire_diet", function(event)
    local item = event.data.itype
    local animal_blood = item == "animal_blood" or item == "blood_tainted"
    local living_blood = item == "blood" or partial_nourishment[item]
    if item ~= "vampire_blood" and not animal_blood and not living_blood then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if item == "vampire_blood" then
        if has_trait(character, "VAMPIRE") or has_effect(character, "vampire_virus") then
            drink_vampire_blood(character)
        end
        if not has_effect(character, "vampire_virus") then
            message(character, ccb.services.translate("As you drink, some of the vampire blood enters your gums."), "mixed")
            value(services.effects.add(character, id("effect", "vampire_virus"), duration(1, "turn"),
                { intensity = 1, permanent = true }))
        end
    elseif animal_blood then
        if has_trait(character, "VAMPIRE") or has_effect(character, "vampire_virus") then
            message(character, ccb.services.translate("You still feel as hungry as before.  This blood cannot sustain you."), "bad")
        end
    else
        if has_trait(character, "DHAMPIR_TRAIT") or has_trait(character, "VAMPIRE") or
            has_effect(character, "vampire_virus") then
            if has_trait(character, "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD") then
                value(services.needs.modify_calories(character, 350 + random.native_int(0, 150), true))
            end
            if item == "fae_blood" then
                set_number(character, fae_blood, 1)
            end
            value(services.morale.remove(character, id("morale", "morale_vw_no_fun")))
            receive_living_blood(character)
        end
        if partial_nourishment[item] and has_trait(character, "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD") then
            change_vitamin(character, "human_blood_vitamin", -200 - random.native_int(0, 50))
        end
    end
end, 1)
ccb.runtime.on("game:character_eats_item", "apply_vampire_diet")

-- New vampires receive enough blood to avoid immediate withdrawal.
ccb.runtime.handler("grant_blood_on_vampire_infection", function(event)
    if event.data.effect == "vampire_virus" then
        local character = event.actors.character or services.characters.avatar()
        change_vitamin(character, "human_blood_vitamin", 1200)
    end
end, 1)
ccb.runtime.on("game:character_gains_effect", "grant_blood_on_vampire_infection")
