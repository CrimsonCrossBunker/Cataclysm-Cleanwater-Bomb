local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local time = services.time
local native_int = services.random.native_int
local native_float = services.random.native_float

local activity = "ACT_XEDRAWOOD_HEDGE_MAGIC_SPIRIT_QUEST"
local questing = "effect_xedrawood_hedge_magic_spirit_questing"
local completed = "effect_xedrawood_hedge_magic_spirit_quest_completed"
local hallucinations = questing .. "_hallu_tracker"
local thirst = questing .. "_thirst_tracker"
local hunger = questing .. "_hunger_tracker"

local lesser_mysteries = {
    "hedge_ward_off_rain",
    "hedge_summon_witchlight",
    "hedge_make_plants_grow",
    "hedge_light_fire",
    "hedge_see_fae_necklace",
    "hedge_see_nether_eye_paste",
    "hedge_stunning_spell",
    "hedge_cure_cold_or_flu",
    "hedge_evil_eye_ward",
    "hedge_extra_lock_door",
    "hedge_luck_spell",
    "hedge_clairvoyance_cone",
    "hedge_increase_healing_rate",
    "hedge_increase_bandaging_rate",
    "hedge_hide_in_forest",
    "hedge_no_nightmares",
    "hedge_turn_into_bear",
    "hedge_walk_on_water",
    "hedge_bless_steel_weapon",
    "hedge_astral_projection",
    "hedge_protect_the_mind",
    "hedge_extinguish_fire_spell",
    "hedge_raziel_amulet_protection",
    "hedge_prevent_wild_animal_attacks",
    "hedge_chicken_sacrifice_make_rain",
    "hedge_scare_shabriri",
}

local water_locations = {
    "generic_river_bank",
    "generic_river",
    "river_center",
    "river",
    "river_c_not_ne",
    "river_c_not_nw",
    "river_c_not_se",
    "river_c_not_sw",
    "river_ne",
    "river_se",
    "river_sw",
    "river_nw",
    "lake_shore",
    "lake_surface",
    "ocean_surface",
    "ocean_shore",
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, kind)
    if character.subtype == "avatar" then
        services.messages.add(text, kind)
    end
end

local function skill(character, name)
    return checked(services.skills.level(character, name))
end

local function grant_missing(character, kind, pool)
    local candidates = {}
    for index, entry in ipairs(pool) do
        candidates[index] = id(kind, entry)
    end
    return checked(services.progression.grant_random_missing(character, kind, candidates)).granted
end

local function return_notes(character)
    checked(services.inventory.receive_item(character, id("item", "used_occult_notes"), 1))
end

local function failed_research(character)
    message(character, ccb.services.translate("You really thought you had something here, but it's just a dead end.  You'll have to try again with a new approach."), "bad")
    return_notes(character)
end

local function passes_research(character)
    local die = native_int(1, 10)
    local check = skill(character, "deduction") + native_float(-2, 8) + native_float(-2, 8)
    return die + check > 10
end

ccb.runtime.handler("study_occult_research_notes", function(craft)
    local character = craft.character
    for _ = 1, craft.batch do
        if passes_research(character) then
            message(character, ccb.services.translate("You were right, there is something here!  If you compiled a reference for all your notes, you'd have the foundation for a greater exploration of the Unseen World."), "good")
            return_notes(character)
            checked(services.recipes.learn(character, id("recipe", "magical_grimoire_apprentice")))
        else
            failed_research(character)
        end
    end
end, 1)

local function overmap_matches(position, locations)
    local omt = position:project_to("omt")
    for _, terrain in ipairs(locations) do
        if services.overmap.matches_location(omt, terrain) then
            return true
        end
    end
    return false
end

local function cloudy()
    local weather = services.weather.current().weather.value
    return weather ~= "sunny" and weather ~= "clear"
end

local function register_site(element, name, description, eligible)
    local recipe = "assemble_" .. element .. "_research_materials"
    local output = element .. "_research_materials"
    local handler = "finish_" .. recipe
    ccb.runtime.handler(handler, function(craft)
        local character = craft.character
        for _ = 1, craft.batch do
            local site = checked(services.creatures.snapshot(character))
            if eligible(site) then
                message(character, ccb.services.translate("You successfully assemble your varied notes and samples into a coherent plan for research."), "good")
                checked(services.inventory.receive_item(character, id("item", output), 1))
            else
                message(character, ccb.services.translate("Without the proper conditions, your observations aren't acute enough to form the foundation for any further research."), "bad")
            end
        end
    end, 1)
    content.add(content.Recipe {
        id = recipe,
        name = name,
        description = description,
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_RESEARCH",
        difficulty = 5,
        skill = "deduction",
        duration_moves = 2160000,
        activity_level = 2,
        scripted_output = true,
    }:quality("MAGICAL_RESEARCH", 1, 1)
        :requirement("writing_standard", 5)
        :component("paper", 50)
        :proficiency("prof_occult_exploration", { required = true })
        :proficiency("prof_thaumatology", { required = false })
        :on_complete(handler))
end

register_site("forest",
    ccb.content.text("assemble forest research materials"),
    ccb.content.text("Conduct observation of the trees and grass and study herbs to develop a corpus of research for the lesser mysteries.  You must be in a forest to conduct your research."),
    function(site)
        return site.outside and overmap_matches(site.position, { "forest", "forest_thick" })
    end)

register_site("earth",
    ccb.content.text("assemble earth research materials"),
    ccb.content.text("Conduct observation of the soil quality and study magical minerals to develop a corpus of research for lesser mysteries.  You must be underground to conduct your research."),
    function(site)
        return site.position.z <= -1
    end)

register_site("moon",
    ccb.content.text("assemble moon research materials"),
    ccb.content.text("Conduct observation of the moon and study astrological charts to develop a corpus of research for lesser mysteries.  You must be outdoors at night to conduct your research."),
    function(site)
        return site.outside and services.gameplay.environment.is_night()
    end)

register_site("sky",
    ccb.content.text("assemble sky research materials"),
    ccb.content.text("Conduct observation of the sky and study weather recordings develop a corpus of research for lesser mysteries.  You must be outdoors on a day with clouds to conduct your research."),
    function(site)
        return site.outside and cloudy()
    end)

register_site("sea",
    ccb.content.text("assemble sea research materials"),
    ccb.content.text("Conduct observation of the waves and study tidal records to develop a corpus of research for lesser mysteries.  You must be near a large body of water to conduct your research."),
    function(site)
        return overmap_matches(site.position, water_locations)
    end)

local site_recipes = {
    "assemble_forest_research_materials",
    "assemble_earth_research_materials",
    "assemble_moon_research_materials",
    "assemble_sky_research_materials",
    "assemble_sea_research_materials",
}
ccb.runtime.handler("prepare_hedge_magic_research", function(craft)
    local character = craft.character
    for _ = 1, craft.batch do
        if passes_research(character) then
            message(character, ccb.services.translate("You've discovered an avenue that deserves for further research."), "good")
            return_notes(character)
            if grant_missing(character, "recipe", site_recipes) then
                message(character, ccb.services.translate("Study of the natural world could prove beneficial."), "good")
            else
                message(character, ccb.services.translate("If you assembled all your research together, you could probably combine it into something really worthwhile.  Time to study."), "good")
                checked(services.recipes.learn(character, id("recipe", "learn_hedge_magic_spells")))
            end
        else
            failed_research(character)
        end
    end
end, 1)

local function discover_spell(character)
    if not grant_missing(character, "spell", lesser_mysteries) then
        message(character, ccb.services.translate("You've learned all you can about thaumaturgy for now."), "mixed")
    end
    message(character, ccb.services.translate("You learn a secret of the lesser mysteries."), "good")
end

ccb.runtime.handler("finish_combined_hedge_research", function(craft)
    for _ = 1, craft.batch do
        discover_spell(craft.character)
    end
end, 1)

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function add_effect(character, effect, duration, unit)
    checked(services.effects.add(character, id("effect", effect), time.duration(duration, unit)))
end

local function recover_from_quest(character, days)
    checked(services.spells.set_mana_raw(character, 0))
    add_effect(character, completed, days, "day")
    checked(services.effects.remove(character, id("effect", questing)))
end

ccb.runtime.handler("start_hedge_spirit_quest", function(craft)
    local character = craft.character
    for _ = 1, craft.batch do
        if checked(services.spells.mana(character)).current > 0 then
            if has_effect(character, "hallu") or has_effect(character, "datura") then
                add_effect(character, hallucinations, 9, "hour")
            end
            if checked(services.needs.get(character)).instant_thirst > 240 then
                add_effect(character, thirst, 9, "hour")
            end
            if has_effect(character, "hunger_near_starving") or has_effect(character, "hunger_starving")
                or has_effect(character, "hunger_famished") then
                add_effect(character, hunger, 9, "hour")
            end
            add_effect(character, questing, 9, "hour")
            local assigned = services.activities.assign_timed(character, id("activity", activity), time.duration(8, "hour"))
            if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
                checked(assigned)
            end
        else
            message(character, ccb.services.translate("Your spirit has still not recovered.  You must wait before attempting another spirit-quest."), "bad")
        end
    end
end, 1)

local function quest_check(character)
    return skill(character, "deduction") + skill(character, "speech") / 2
        + native_float(-2, 8) + native_float(-2, 8)
end

local function quest_bonus(character, tracker)
    local effect = services.effects.get(character, id("effect", tracker), id("body_part", "bp_null"))
    if not effect.ok and effect.error.code == "not_found" then
        return 0
    end
    return checked(effect).intensity > -1 and 1 or 0
end

ccb.runtime.handler("finish_hedge_spirit_quest", function(context)
    local character = context.character
    local first_roll = native_int(1, 10)
    if first_roll + quest_check(character) <= 14 then
        -- The finish event applies the interrupted-quest recovery when the first check fails.
        return
    end
    local result = quest_check(character) + quest_bonus(character, hallucinations)
        + quest_bonus(character, thirst) + quest_bonus(character, hunger)
    local debug_text = checked(services.text.expand_for(
        ccb.services.translate("You rolled a <context_val:roll_results> vs difficulty 15."),
        character, nil, nil, { roll_results = result }, true))
    services.messages.add(debug_text, "debug")
    if native_int(1, 10) + result > 15 then
        discover_spell(character)
        message(character, ccb.services.translate("Your spirit returns with knowledge from the Unseen World."), "good")
    else
        message(character, ccb.services.translate("Your spirit returns in failure.  You have gained no new knowledge from your quest."), "bad")
    end
    recover_from_quest(character, 7)
end, 1)

ccb.runtime.handler("stop_hedge_spirit_quest", function(event)
    if event.data.activity == activity then
        local character = event.actors.character or services.characters.avatar()
        if has_effect(character, questing) then
            message(character, ccb.services.translate("You break off your quest into the spirit world."), "mixed")
            recover_from_quest(character, 2)
        end
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "stop_hedge_spirit_quest")

content.add(content.ActivityType {
    id = activity,
    verb = ccb.content.text("seeking knowledge from the Unseen World"),
    rooted = true,
    based_on = "time",
    can_resume = false,
    activity_level = 1,
}:on_finish("finish_hedge_spirit_quest"))

content.add(content.EffectType {
    id = completed,
    name = ccb.content.text("Underwent Spirit-Quest"),
    description = ccb.content.text("You underwent a quest to the Unseen World and your spirit is depleted.  You cannot use either the lesser or greater mysteries until it recovers."),
    remove_message = ccb.content.text("Your spirit has recovered from your quest."),
    rating = "mixed",
}:enchantment("INLINE_ENCH_effect_xedrawood_hedge_magic_spirit_quest_completed_0")
    :flag("NO_HEDGE_MAGICK"))

content.add(content.EffectType {
    id = questing,
    name = ccb.content.text("Spirit-Questing"),
    description = ccb.content.text("You are questing in the spirit world."),
    rating = "mixed",
}:flag("BLIND"):flag("DEAF"))

for _, tracker in ipairs { hallucinations, thirst, hunger } do
    content.add(content.EffectType { id = tracker })
end

content.add(content.Recipe {
    id = "study_occult_research",
    name = ccb.content.text("study occult research notes"),
    description = ccb.content.text("There's more you could learn from those notes you took.  You just need to go over them again and separate the truth from the lies."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    difficulty = 3,
    duration_moves = 2160000,
    activity_level = 2,
    autolearn = true,
    flags = { "BLIND_HARD" },
    scripted_output = true,
}:component("occult_research_minor", 1)
    :proficiency("prof_occult_exploration", { required = false, time_multiplier = 3 })
    :on_complete("study_occult_research_notes"))

content.add(content.Recipe {
    id = "study_hedge_magic",
    name = ccb.content.text("delve into the lesser mysteries"),
    description = ccb.content.text("There's power in the natural world.  You can see that now.  Using your compiled notes and studying previous observations, you're sure you can find out how to access it."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    difficulty = 4,
    duration_moves = 2880000,
    activity_level = 2,
    flags = { "BLIND_HARD" },
    scripted_output = true,
}:book("magical_grimoire_apprentice", 4)
    :quality("MAGICAL_RESEARCH", 1, 1)
    :component("occult_research_minor", 1)
    :proficiency("prof_occult_exploration", { required = false, time_multiplier = 3 })
    :on_complete("prepare_hedge_magic_research"))

content.add(content.Recipe {
    id = "learn_hedge_magic_spells",
    name = ccb.content.text("study combined research materials"),
    description = ccb.content.text("Take all your observations and study them, trying to learn the deeper secrets of the world."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    difficulty = 5,
    duration_moves = 4320000,
    activity_level = 2,
    scripted_output = true,
}:quality("MAGICAL_RESEARCH", 1, 1)
    :requirement("writing_standard", 20)
    :component("paper", 150)
    :component("sea_research_materials", 1)
    :component("sky_research_materials", 1)
    :component("moon_research_materials", 1)
    :component("earth_research_materials", 1)
    :component("forest_research_materials", 1)
    :proficiency("prof_occult_exploration", { required = true })
    :proficiency("prof_thaumatology", { required = true })
    :on_complete("finish_combined_hedge_research"))

content.add(content.Recipe {
    id = "learn_hedge_magic_spells_wise",
    name = ccb.content.text("spirit-quest to unlock the lesser mysteries"),
    description = ccb.content.text("Enter a trance and cast your spirit forth, seeking guidance in the Unseen World to unlock a secret of the lesser mysteries.  Doing so will debilitate you for a time afterward, rendering you unable to call on either the lesser or greater mysteries."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    difficulty = 5,
    duration_moves = 0,
    activity_level = 2,
    scripted_output = true,
}:proficiency("prof_occult_exploration", { required = true })
    :proficiency("prof_thaumatology", { required = true })
    :on_complete("start_hedge_spirit_quest"))
