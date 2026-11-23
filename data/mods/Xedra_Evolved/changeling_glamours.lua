local ccb = require("ccb")
local services = ccb.services
local runtime = ccb.runtime
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function event_character(event)
    return event.actors.speaker or event.actors.character or event.actors.attacker or services.characters.avatar()
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    local effect_id = id("effect", effect)
    if not effect_id:is_valid() then return false end
    return checked(services.effects.has(character, effect_id, id("body_part", "bp_null"), -1))
end

local function remove_effect(character, effect)
    local effect_id = id("effect", effect)
    if not effect_id:is_valid() then return end
    checked(services.effects.remove(character, effect_id))
end

local function add_effect(character, effect, turns, options)
    local effect_id = id("effect", effect)
    if not effect_id:is_valid() then return end
    local result = services.effects.add(character, effect_id, services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local disguises = {
    "CHANGELING_DISGUISE_AS_NATURE_BUSH", "CHANGELING_DISGUISE_AS_NATURE_TREE",
    "CHANGELING_DISGUISE_AS_NATURE_POND", "CHANGELING_DISGUISE_AS_NATURE_GRASS",
    "CHANGELING_DISGUISE_AS_NATURE_ROCK",
}

local function disguised(character)
    for _, trait in ipairs(disguises) do
        if has_trait(character, trait) then return true end
    end
    return false
end

local function clear_disguise(character)
    for _, trait in ipairs(disguises) do
        local mut = id("mutation", trait)
        if mut:is_valid() then checked(services.mutations.erase(character, mut)) end
    end
end

local running = "effect_changeling_summer_run_for_long_periods"
local feigning = "effect_changeling_winter_feign_death"
local frozen = "effect_changeling_autumn_freeze_in_place_self"
local combat_glamours = {
    "effect_changeling_invisibility", "effect_changeling_right_of_passage", running, feigning, frozen,
}

local function in_glamour(character)
    for _, effect in ipairs(combat_glamours) do
        if has_effect(character, effect) then return true end
    end
    return disguised(character)
end

runtime.handler("break_glamours_in_combat", function(event)
    local character = event_character(event)
    if in_glamour(character) then
        services.messages.add(services.translate("Effects are being removed"), "debug")
        for _, effect in ipairs(combat_glamours) do remove_effect(character, effect) end
        clear_disguise(character)
    end
    if has_trait(character, "BROWNIE_EASY_OVERLOOK") or has_trait(character, "BROWNIE_EASY_OVERLOOK2") then
        add_effect(character, "effect_brownie_attacked_someone", 5)
    end
end)
for _, event in ipairs({
    "character_melee_attacks_monster", "character_melee_attacks_character",
    "character_ranged_attacks_monster", "character_ranged_attacks_character", "character_takes_damage",
}) do
    runtime.on("game:" .. event, "break_glamours_in_combat")
end

runtime.handler("break_glamours_on_cast", function(event)
    local character = event_character(event)
    local checker = "effect_changeling_using_glamour_removes_checker"
    if not has_effect(character, checker) then return end
    if has_effect(character, running) or has_effect(character, feigning) or has_effect(character, frozen) then
        services.messages.add(services.translate("You cast a spell and effects are being removed"), "debug")
        remove_effect(character, checker)
        remove_effect(character, running)
        remove_effect(character, feigning)
        remove_effect(character, frozen)
    else
        remove_effect(character, checker)
    end
end)
runtime.on("game:spellcasting_finish", "break_glamours_on_cast")

local function end_disguise(character)
    if disguised(character) and character.subtype == "avatar" then
        services.messages.add(services.translate("The glamour disguising you fades."), "bad")
    end
    clear_disguise(character)
end

runtime.handler("break_glamours_on_move", function(event)
    local character = event_character(event)
    if has_effect(character, feigning) or has_effect(character, frozen) or disguised(character) then
        services.messages.add(services.translate("You moved and effects are being removed"), "debug")
        remove_effect(character, feigning)
        remove_effect(character, frozen)
        end_disguise(character)
    end
end)
runtime.on("game:avatar_moves", "break_glamours_on_move")

local function is_character(creature)
    return creature and (creature.subtype == "avatar" or creature.subtype == "npc" or creature.subtype == "character")
end

local function gramarye(character)
    if not is_character(character) then return 0 end
    return math.modf(checked(services.skills.level(character, "gramarye")))
end

local function trait_count(character, school)
    return checked(services.mutations.category_count(character, id("mutation_category", "FAIR_FOLK_" .. school),
        "ALL", true))
end

local function heritage_count(character, noble_only)
    if not is_character(character) then return 0 end
    if noble_only then return trait_count(character, "NOBLE") end
    local count = 0
    for _, school in ipairs({ "NOBLE", "COMMONER_BROWNIE", "COMMONER_POOKA", "COMMONER_SELKIE", "COMMONER_TROW" }) do
        if has_trait(character, "UNKNOWING_CHANGELING_" .. school) then count = count + trait_count(character, school) end
    end
    return count
end

local function player_message(character, message, tone)
    if character.subtype == "avatar" then services.messages.add(message, tone) end
end

local function mutation_ids(traits)
    local values = {}
    for index, trait in ipairs(traits) do values[index] = id("mutation", trait) end
    return values
end

local immortal_traits = {
    "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "VAMPIRE", "LILIN_TRAITS", "CHANGELING_MAGIC",
}
runtime.handler("sleeping_mortal_glamour_target", function(context)
    local target = context.interlocutor
    if not is_character(target) or not has_effect(target, "sleep") then return false end
    for _, trait in ipairs(immortal_traits) do
        if has_trait(target, trait) then return false end
    end
    return true
end)

local trauma_traits = {
    "NUMB", "BADTEMPER", "SHOUT2", "CHEMIMBALANCE", "MOODSWINGS", "FORGETFUL",
    "ADDICTIVE", "NARCOLEPTIC", "JITTERY", "INSOMNIA", "HEAVYSLEEPER2",
}
local dream_cooldown = "effect_changeling_gain_dreamdross_from_dreams"
local dream_trauma = "effect_changeling_banquet_of_dreams_damage"

runtime.handler("harvest_mortal_dreams", function(impact)
    local target, caster = impact.target_creature, impact.caster
    if not is_character(target) then return end
    if has_effect(target, dream_cooldown) then
        player_message(caster, services.translate("The mortal's dreams are fragile, evanescent things, not suitable for the harvest."), "bad")
        return
    end
    local damaged = has_effect(target, dream_trauma)
    local feast = not damaged and (has_effect(caster, "effect_changeling_active_banquet_of_dreams")
        or (has_effect(caster, "effect_changeling_temporary_psychopath") and services.random.native_probability(1, 5)))
    local skill = gramarye(caster)
    local cooldown = 518400 + services.random.native_int(0, 259200) - (skill * 28800) * services.random.native_float(0.66666, 1.333333)
    add_effect(target, dream_cooldown, cooldown)

    local scraps, message
    if damaged then
        scraps = services.random.native_int(0, 2)
        message = services.translate("You reach into the mortal's feeble dreams and pull what few scraps of dreamdross out as you can.")
    elseif feast then
        add_effect(target, dream_trauma, 1, { permanent = true })
        local traits = mutation_ids(trauma_traits)
        for _ = 1, 3 do checked(services.progression.grant_random_missing(target, "mutation", traits)) end
        scraps = 12
        for _ = 1, 5 do scraps = scraps + 4 + services.random.native_int(0, 4) end
        message = services.translate("You reach into the mortal's and rip them out whole, filling both hands with a cascade of shining dreamdross.")
    else
        local doubled = services.random.native_probability(skill, 50)
        scraps = 1 + services.random.native_int(0, 4)
        if doubled then scraps = scraps + 1 + services.random.native_int(0, 4) end
        message = services.translate("You reach into the mortal's dreams and coalesce them into shining dreamdross.")
    end
    if is_character(caster) then checked(services.inventory.receive_item(caster, id("item", "scrap_dreamdross"), scraps)) end
    player_message(caster, message, "good")
end)

runtime.handler("disguise_changeling_as_nature", function(impact)
    local target = impact.target_creature
    if not is_character(target) then return end
    if not checked(services.creatures.snapshot(target)).outside then
        player_message(target, services.translate("You need to be among nature to disguise yourself within nature."), "bad")
        return
    end
    checked(services.progression.grant_random_missing(target, "mutation", mutation_ids(disguises)))
    player_message(target, services.translate("You wrap yourself up in a glamour."), "good")
    local traits, skill = heritage_count(target), gramarye(target)
    local low = math.modf(traits * 22.5 + skill * 230 + 351)
    local high = math.modf(traits * 57.5 + skill * 560 + 789)
    ccb.tasks.after_character_turn(target, services.random.native_int(low, high), "end_changeling_nature_disguise")
end)
runtime.handler("end_changeling_nature_disguise", function(task) end_disguise(task.character) end)

local function scaling(base, per_trait, per_skill, minimum)
    return function(traits, skill)
        local result = base + per_trait * traits + per_skill * skill
        return minimum and math.max(minimum, result) or result
    end
end

local spell_scaling = {
    changeling_disguise_as_nature_spell = {
        min_duration = scaling(35100, 2250, 23400), max_duration = scaling(78900, 5750, 56300),
        base_energy_cost = scaling(150, -2, -3, 50), base_casting_time = scaling(100, -1, -3, 30),
    },
    changeling_invisibility_spell = {
        min_duration = scaling(2600, 50, 500), max_duration = scaling(13900, 163, 1200),
        base_energy_cost = scaling(750, -5, -20, 350), base_casting_time = scaling(250, -3, -8, 50),
    },
    changeling_summon_will_o_the_wisps_spell = {
        min_duration = scaling(16500, 190, 3980), max_duration = scaling(39800, 608, 9750),
        base_energy_cost = scaling(300, -3, -10, 100), base_casting_time = scaling(100, -1, -3, 50),
    },
    changeling_stop_nether_conditions_spell = {
        min_duration = scaling(18952, 5095, 12185), max_duration = scaling(42915, 13091, 29051),
        base_energy_cost = scaling(550, -4, -9, 250), base_casting_time = scaling(1000, -7, -13, 500),
    },
    changeling_noble_cure_bad_conditions_spell = {
        noble = true, base_energy_cost = scaling(600, -5, -35, 200), base_casting_time = scaling(250, -2, -5, 150),
    },
    changeling_noble_burning_weapon_spell = {
        noble = true, base_energy_cost = scaling(400, -3, -20, 200), base_casting_time = scaling(250, -1, -5, 150),
        min_duration = scaling(27800, 240, 2600), max_duration = scaling(91500, 880, 17500),
    },
}
runtime.handler("changeling_glamour_stat", function(context)
    local character = context.speaker
    local spell = spell_scaling[context.spell.value]
    return spell[context.stat](heritage_count(character, spell.noble), gramarye(character))
end)

runtime.handler("kindle_changeling_weapon", function(impact)
    local character = impact.target_creature
    if not is_character(character) then return end
    local traits, skill = heritage_count(character, true), gramarye(character)
    if checked(services.creatures.snapshot(character)).has_weapon then
        player_message(character, services.translate("Your weapon kindles into white-gold flame."), "good")
        local duration = services.random.native_float(traits * 2.4 + skill * 26 + 278, traits * 8.8 + skill * 175 + 915)
        add_effect(character, "effect_changeling_noble_burning_weapon", duration)
    else
        player_message(character, services.translate("Fires of Bealtaine requires a weapon to affect in order to take hold."), "bad")
        local refund = spell_scaling.changeling_noble_burning_weapon_spell.base_energy_cost(traits, skill)
        checked(services.spells.set_mana_raw(character, checked(services.spells.mana(character)).current + refund))
    end
end)

local limbs = { "head", "torso", "arm_r", "arm_l", "leg_r", "leg_l" }
local cures = {
    { "dermatik", 50 }, { "dermatik_visible", 125 }, { "poison", 20, limbs = true }, { "badpoison", 50, limbs = true },
    { "venom_dmg", 35 }, { "venom_weaken", 40 }, { "venom_blind", 30 }, { "venom_pain", 40 }, { "paralyzepoison", 45 },
    { "pre_common_cold", 25, immunity = true }, { "common_cold", 50, immunity = true }, { "pre_flu", 40, immunity = true },
    { "flu", 80, immunity = true }, { "conjunctivitis", 35, part = "eyes" }, { "tetanus", 75 }, { "rat_bite_fever", 60 },
    { "bloodworms", 50 }, { "brainworms", 60 }, { "tapeworm", 75 }, { "fungus", 150 }, { "blood_spiders", 125 },
    { "vampire_virus", 200, mortal = true },
}

local function heal_condition(target, cure, part)
    local effect = id("effect", cure[1])
    if not effect:is_valid() then return end
    local body_part = id("body_part", part or "bp_null")
    if not checked(services.effects.has(target, effect, body_part, -1)) then return end
    if cure.mortal and is_character(target) and has_trait(target, "VAMPIRE") then return end
    checked(services.effects.remove(target, effect, body_part))
    if cure.immunity then add_effect(target, "effect_hedge_cure_cold_or_flu", 864000) end
    if is_character(target) then
        checked(services.needs.set(target, { sleepiness = checked(services.needs.get(target)).sleepiness + cure[2] }))
    end
end

runtime.handler("heal_changeling_conditions", function(impact)
    local target = impact.target_creature
    if not target then return end
    for _, cure in ipairs(cures) do
        heal_condition(target, cure, cure.part)
        if cure.limbs then
            for _, part in ipairs(limbs) do heal_condition(target, cure, part) end
        end
    end
end)
