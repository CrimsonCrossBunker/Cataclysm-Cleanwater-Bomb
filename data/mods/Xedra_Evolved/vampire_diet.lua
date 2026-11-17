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

local function give_feeding_calories(character, donor)
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
end

local function drink_from_donor(character, donor, cooldown_days)
    if has_trait(donor, "FAE_CREATURE") then
        set_number(character, fae_blood, 1)
    end
    receive_living_blood(character)
    give_feeding_calories(character, donor)
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

local feeding_activity = "ACT_VAMPIRE_DRINKING_BLOOD"
ccb.content.add(ccb.content.ActivityType {
    id = feeding_activity,
    verb = ccb.content.text("drinking blood"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
})

ccb.runtime.handler("interrupt_blood_feeding", function(event)
    if event.data.activity == feeding_activity and event.data.canceled then
        local character = event.actors.character or services.characters.avatar()
        message(character, ccb.services.translate("You cancelled drinking blood and thus get no blood."), "debug")
        value(services.effects.remove(character, id("effect", "effect_vampire_blood_drinking")))
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "interrupt_blood_feeding")

local timers = require("character_timers")
timers.register("vampire_blood_display_timer", "vampire_blood_display_due",
    function() return 1 end,
    function(character)
        return has_trait(character, "DHAMPIR_TRAIT") or has_trait(character, "VAMPIRE") or
            has_effect(character, "vampire_virus")
    end,
    function(character)
        local blood = id("vitamin", "human_blood_vitamin")
        local amount = value(services.needs.get_vitamin(character, blood))
        local extra_storage = has_trait(character, "VAMPIRE_STORE_MORE_BLOOD")
        local upgraded_storage = has_trait(character, "VAMPIRE_STORE_MORE_BLOOD_UPGRADE")
        local limit = 5600 + (extra_storage and 2300 or 0) + (upgraded_storage and 5600 or 0)
        set_number(character, "blood_amount_for_graph", amount)
        set_number(character, "max_blood_amount_for_graph", limit)
        if amount >= limit then
            value(services.needs.set_vitamin(character, blood,
                upgraded_storage and 13500 or extra_storage and 7900 or 5600))
        end
    end)

local function add_effect(character, effect, turns)
    value(services.effects.add(character, id("effect", effect), duration(turns, "turn")))
end

local function has_species(creature, species)
    local species_id = id("species", species)
    return species_id:is_valid() and value(services.creatures.has_species(creature, species_id))
end

local function is_incapacitated(target)
    for _, effect in ipairs({ "stunned", "dazed", "sleep", "effect_vampire_hypnotism", "effect_vampire_blood_drinking_target" }) do
        if has_effect(target, effect) then
            return true
        end
    end
    return ccb.content.is_mod_active("mindovermatter") and has_effect(target, "psi_stunned")
end

local function handle_holy_symbol(caster, target)
    local ward = id("json_flag", "WARDING_SYMBOL")
    if value(services.inventory.has_worn_flag(target, ward)) and has_trait(caster, "VAMPIRE_WEAKNESS_HOLY_BURN") then
        message(caster, ccb.services.translate("The holy symbol they wear burns you!"), "bad")
        value(services.needs.modify_raw_pain(caster, math.floor(random.native_float(10, 15))))
    end
end

local combat_reward = "finish_combat_blood_feeding"
ccb.runtime.handler(combat_reward, function(payload)
    local character = payload.character
    if has_effect(character, "effect_vampire_blood_drinking") then
        receive_living_blood(character)
        give_feeding_calories(character)
        message(character, ccb.services.translate("You drink some blood."), "good")
    end
end, 1)

local function begin_combat_drinking(caster, target)
    add_effect(target, "effect_vampire_blood_drinking_target", math.floor(random.native_float(3, 4)))
    add_effect(target, "dazed", math.floor(random.native_float(3, 4)))
    add_effect(caster, "effect_vampire_blood_drinking", 4)
    value(services.activities.assign_timed(caster, id("activity", feeding_activity), duration(3, "turn")))
end

local disgusting_species = { "MIGO", "ZOMBIE", "HORROR", "INSECT", "INSECT_FLYING",
    "CENTIPEDE", "SPIDER", "MOLLUSK", "WORM" }

ccb.runtime.handler("combat_blood_feeding", function(payload)
    local caster = payload.caster
    local target = payload.target_creature
    if not target then
        return
    end
    if not is_incapacitated(target) then
        message(caster, ccb.services.translate("You can only drink blood from an incapacitated or sleeping target."), "bad")
        return
    end

    local is_npc = target.subtype == "npc"
    local is_character = is_npc or target.subtype == "avatar"
    local is_fae = is_character and has_trait(target, "FAE_CREATURE")
    local is_vampire = is_character and has_trait(target, "VAMPIRE")
    local is_saint = is_character and has_trait(target, "BLOOD_OF_SAINTS")
    if is_npc and not is_fae and not is_vampire and not is_saint then
        ccb.tasks.after_character_turn(caster, 2, combat_reward)
        change_vitamin(target, "blood", -750 - random.native_int(0, 450))
        change_vitamin(target, "redcells", -750 - random.native_int(0, 450))
        value(services.npcs.modify_opinion(target, {
            value = -2 - random.native_int(0, 2),
            trust = -2 - random.native_int(0, 2),
            fear = 2 + random.native_int(0, 2),
            anger = 2 + random.native_int(0, 2),
        }))
        begin_combat_drinking(caster, target)
        services.messages.add(ccb.services.translate("You are drinking from an NPC."), "debug")
        handle_holy_symbol(caster, target)
        if value(services.needs.get_vitamin(target, id("vitamin", "blood"))) <= -40000 or
            value(services.needs.get_vitamin(target, id("vitamin", "redcells"))) <= -40000 then
            value(services.characters.die(target))
        end
        return
    end

    local human = has_species(target, "HUMAN")
    local zombie = has_species(target, "ZOMBIE")
    local vampire_species = has_species(target, "VAMPIRE")
    local feral = has_species(target, "FERAL")
    local renfield = has_species(target, "RENFIELD")
    local changeling = has_species(target, "CHANGELING")
    local homullus = has_species(target, "HOMULLUS")
    if not is_vampire and not is_saint and
        ((human and not zombie and not vampire_species) or feral or renfield or
            (changeling and not zombie) or homullus or is_fae) then
        if changeling or homullus or is_fae then
            set_number(caster, fae_blood, 1)
        end
        if is_npc then
            handle_holy_symbol(caster, target)
        end
        ccb.tasks.after_character_turn(caster, 2, combat_reward)
        add_effect(target, "effect_vampire_drunk_from_in_combat", 48 * 60 * 60)
        begin_combat_drinking(caster, target)
        services.messages.add(ccb.services.translate("You are drinking from a human-type monster."), "debug")
    elseif not is_npc and (not human or zombie or vampire_species) and
        not feral and not changeling and not renfield and not homullus and not is_fae then
        if vampire_species then
            message(caster, ccb.services.translate("The vampire's blood refuses to leave its veins, no matter how hard you try to drain it."), "bad")
        else
            message(caster, ccb.services.translate("You get a taste of blood but stop drinking when you realize it cannot sustain you."), "bad")
        end
        services.messages.add(ccb.services.translate("You are drinking from an inhuman monster."), "debug")
        for _, species in ipairs(disgusting_species) do
            if has_species(target, species) then
                message(caster, ccb.services.translate("…and it tastes absolutely disgusting!"), "bad")
                change_vitamin(caster, "bad_food", math.floor(random.native_float(10, 15)))
                break
            end
        end
    else
        if is_vampire then
            message(caster, ccb.services.translate("The vampire's blood refuses to leave its veins, no matter how hard you try to drain it."), "bad")
        end
        if is_saint then
            message(caster, ccb.services.translate("This blood is the foulest thing you ever tasted!"), "bad")
            change_vitamin(caster, "bad_food", math.floor(random.native_float(20, 25)))
        end
    end
end, 1)

ccb.content.add(ccb.content.Spell {
    id = "vampire_drink_blood_with_fangs_spell",
    name = ccb.content.text("Drink Blood"),
    description = ccb.content.text("Your fangs allow you to drink blood from an incapacitated or sleeping target."),
    message = "",
    teachable = false,
    magic_type = "xe_vampire_blood_powers",
    shape = "blast",
    valid_targets = { "ally", "hostile" },
    flags = { "NO_HANDS", "SILENT", "NO_FAIL" },
    skill = "deduction",
    spell_class = "VAMPIRE_BLOOD_ARTS",
    base_energy_cost = 0,
    base_casting_time = 0,
    difficulty = 1,
    min_range = 1,
}:lua_impact("combat_blood_feeding"))
