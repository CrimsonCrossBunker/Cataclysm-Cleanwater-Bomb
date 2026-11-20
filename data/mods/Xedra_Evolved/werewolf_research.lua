local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local threshold_key = "werewolf_xp_threshold"
local increase_key = "werewolf_xp_threshold_updater"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function under_moonlight(character)
    return services.gameplay.environment.is_night()
        and checked(services.creatures.snapshot(character)).outside
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

ccb.runtime.handler("check_moon_gift_research", function(activity)
    local character = activity.character
    if under_moonlight(character) then
        return
    end
    if character.subtype == "avatar" then
        services.messages.add(services.translate("You can only learn a new Gift of the Moon under the moon's light."),
            "mixed")
    end
    checked(services.activities.cancel(character))
end, 1)

ccb.runtime.handler("finish_moon_gift_research", function(activity)
    local character = activity.character
    if not under_moonlight(character) then
        return
    end
    local trait = checked(services.variables.get_string(character, "xe_werewolf_power_to_gain")).value
    checked(services.mutations.replace(character, id("mutation", trait)))
    local increase = number(character, increase_key)
    store(character, threshold_key, number(character, threshold_key) + increase)
    store(character, increase_key, increase + 25)
    checked(services.effects.remove(character, id("effect", "effect_werewolf_gain_more_powers")))
    if character.subtype == "avatar" then
        services.messages.add(services.translate("You learned a new Gift of the Moon."), "good")
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_WEREWOLF_LEARNING_MOON_GIFT",
    verb = content.text("learning a new gift"),
    based_on = "time",
    can_resume = false,
}:on_turn("check_moon_gift_research"):on_finish("finish_moon_gift_research"))

local gifts = require("lunar_gifts")
local ready = "effect_werewolf_gain_more_powers"
local experience = "werewolf_exp"
local outsiders = {
    NETHER = true, NETHER_BURROWING = true, NETHER_EMANATION = true, PLANT = true,
    ARVORE = true, CHANGELING = true, CHANGELING_NOBLE = true, IERDE = true,
    HOMULLUS = true, SALAMANDER = true, SYLPH = true, UNDINE = true,
    VAMPIRE = true, VAMPIRE_ANATHEMA = true,
}

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function message(character, text, severity)
    if character.subtype == "avatar" then services.messages.add(text, severity) end
end

local function reward_hunt(character, exp)
    if has_trait(character, "WEREWOLF_MANA_TRAIT") then
        local total = number(character, experience) + exp
        store(character, experience, total)
        message(character, ccb.services.translate("You feel the Moon's favor stir within you."), "info")
        if total > number(character, threshold_key) then
            local added = services.effects.add(character, id("effect", ready), services.time.duration_from_turns(1),
                { permanent = true })
            if not added.ok and added.error.code ~= "rejected" then checked(added) end
        end
    end
    -- The basic unarmed kill reward also applies before acquiring a werewolf trait.
    local mana = checked(services.spells.mana(character)).current
    checked(services.spells.set_mana_raw(character, mana + 25))
    if has_trait(character, "WEREWOLF_MANA_BONUS_AFTER_KILL") then
        mana = checked(services.spells.mana(character)).current
        checked(services.spells.set_mana_raw(character, mana + 50))
    end
end

local function is_outsider(event)
    -- The slain monster's captured species remain available after its handle expires.
    local victim = event.participants.interlocutor
    if not victim then return false end
    for _, species in ipairs(victim.species) do
        if outsiders[species] then return true end
    end
    if victim.kind == "npc" or victim.kind == "avatar" then
        local character = event.actors.interlocutor
        return character and character:is_valid() and has_trait(character, "VAMPIRE")
    end
    return false
end

ccb.runtime.handler("reward_unarmed_outsider_hunt", function(event)
    local character = event.actors.speaker or event.actors.killer
    if character and is_outsider(event)
        and (checked(services.martial_arts.current(character)).force_unarmed
             or not checked(services.inventory.wielded(character))) then
        reward_hunt(character, event.data.exp)
    end
end)
ccb.runtime.on("game:character_kills_monster", "reward_unarmed_outsider_hunt")

local function choice(character, entries, label, description, enabled)
    local function expand(text)
        return checked(services.text.expand_for(text, character, nil, nil, nil, true))
    end
    local key = tostring(#entries + 1)
    entries[#entries + 1] = {
        id = key, hotkey = key, label = expand(label), description = expand(description), enabled = enabled,
    }
end

local function select_tier(character)
    local entries = {}
    local xp = number(character, experience)
    for _, tier in ipairs(gifts) do
        choice(character, entries, tier.label(), tier.description(), not tier.threshold or xp > tier.threshold)
    end
    choice(character, entries, ccb.services.translate("Not Now"), ccb.services.translate("Do nothing for now"), true)
    return services.interaction.choose(entries, { allow_cancel = false, show_descriptions = true }).index
end

local function select_gift(character, index)
    local tier = gifts[index]
    local entries = {}
    for _, gift in ipairs(tier.gifts) do
        choice(character, entries, gift.label(), gift.description(), not has_trait(character, gift.trait))
    end
    choice(character, entries, ccb.services.translate("Go Back."),
        ccb.services.translate("Go back to the Gift level selection."), true)
    local pick = services.interaction.choose(entries, { allow_cancel = true, show_descriptions = true }).index
    if pick == #entries then return true end
    if pick then
        store(character, "xe_werewolf_power_to_gain", tier.gifts[pick].trait)
        local turns = services.random.native_int(index * 3600, index * 5400)
        local result = services.activities.assign_timed(character, id("activity", "ACT_WEREWOLF_LEARNING_MOON_GIFT"),
            services.time.duration_from_turns(turns))
        if not result.ok and result.error.code ~= "assignment_rejected" then checked(result) end
    end
    return false
end

ccb.runtime.handler("choose_lunar_gift", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE") then
        message(character, ccb.services.translate("Your mind can't focus on the Moon.  You can only think about blood and how it's the only thing worth having."), "bad")
    elseif not checked(services.effects.has(character, id("effect", ready), id("body_part", "bp_null"), -1)) then
        message(character, ccb.services.translate("You are not get ready for another Gift of the Moon.  Continue the hunt."), "mixed")
    elseif not under_moonlight(character) then
        message(character, ccb.services.translate("You must be outside under the moon to learn another Gift of the Moon."), "mixed")
    else
        repeat
            local index = select_tier(character)
            if not gifts[index] then return end
        until not select_gift(character, index)
    end
end)
