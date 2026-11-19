local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local duration = services.time.duration

local unity_spell = "forest_unity_nature"
local deduction = id("skill", "deduction")
local commune = id("effect", "natures_commune")
local unity_morale = id("morale", "morale_forest_unity")
local tree_communion = id("mutation", "TREE_COMMUNION")
local lose_whisper_due = "lose_whisper_leaves_due"

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function is_character(actor)
    return actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character"
end

local function unity_levels(actor)
    if not is_character(actor) then return 0, 0 end
    local level = checked(services.spells.effective_level(actor, unity_spell))
    local skill = math.modf(checked(services.skills.level(actor, deduction)).practical_effective)
    return level, skill
end

ccb.runtime.handler("unity_nature_min_duration", function(context)
    local level, skill = unity_levels(context.speaker)
    return 35501 + level * 12681 + skill * 23085
end)

ccb.runtime.handler("unity_nature_max_duration", function(context)
    local level, skill = unity_levels(context.speaker)
    return 85815 + level * 38044 + skill * 56085
end)

ccb.runtime.handler("unity_nature_impact", function(impact)
    local actor = impact.target_creature
    local level, skill = unity_levels(actor)
    local turns = services.random.native_float(355.01 + level * 126.81 + skill * 230.85,
        858.15 + level * 380.44 + skill * 560.85)
    local length = duration(math.modf(turns), "turn")
    local applied = services.effects.add(actor, commune, length)
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
    if is_character(actor) then
        checked(services.morale.remove(actor, unity_morale))
        checked(services.morale.add(actor, unity_morale, 5 + level * 3, 50, {
            duration = length,
            decay_start = duration(math.modf(turns / 2), "turn"),
        }))
    end
end)

content.add(content.Spell {
    id = unity_spell,
    name = ccb.content.text("Unity with Nature"),
    description = ccb.content.text("Reaching out to the forest, you absorb some of its serenity and peace into yourself."),
    message = ccb.content.text("You close your eyes and listen to the leaves rustling in the wind as you solemnly intone the incantation."),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    skill = "deduction",
    spell_class = "FOREST_MAGIC",
    flags = { "SOMATIC", "VERBAL", "RANDOM_DURATION" },
    max_level = 15,
    shape = "blast",
    difficulty = 3,
    min_duration = 35501,
    max_duration = 85815,
    magic_type = "xedrawood_forest_magic",
    base_casting_time = 180000,
    base_energy_cost = 600,
    final_energy_cost = 400,
    energy_increment = -10,
}:dynamic_stat("min_duration", "unity_nature_min_duration")
    :dynamic_stat("max_duration", "unity_nature_max_duration")
    :lua_impact("unity_nature_impact"))

ccb.runtime.handler("whisper_leaves_in_forest", function(context)
    local position = checked(services.creatures.snapshot(context.speaker)).position:project_to("omt")
    return services.overmap.matches_location(position, "forest")
        or services.overmap.matches_location(position, "forest_thick")
end)

ccb.runtime.handler(lose_whisper_due, function(payload)
    checked(services.mutations.erase(payload.character, tree_communion))
end, 1)

ccb.runtime.handler("whisper_leaves_impact", function(impact)
    local actor = impact.target_creature
    local character = is_character(actor)
    if character and checked(services.mutations.has_id_text(actor, "TREE_COMMUNION")) then
        if actor.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You are already in tune with the rhythms of the forest.  Further magic cannot deepen your bond."), "good")
        end
        return
    end
    if character then
        checked(services.mutations.replace(actor, tree_communion))
        checked(services.mutations.invoke_activation(actor, tree_communion, true))
    end
    local delay = services.random.native_int(1, 1)
    if character then ccb.tasks.after_character_turn(actor, delay, lose_whisper_due) end
end)

content.add(content.Spell {
    id = "forest_whisper_leaves",
    name = ccb.content.text("Whisper of the Leaves"),
    description = ccb.content.text("Reach out to the forest spirits and ask them to teach you the lay of the land.  The longer you remain in the trance, the more you will learn.  You must be standing near a tree in a forest or the ritual will fail."),
    message = ccb.content.text("You place a hand on the tree and close your eyes as you reach out to the spirits of the forest."),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    skill = "deduction",
    spell_class = "FOREST_MAGIC",
    flags = { "VERBAL", "SOMATIC" },
    max_level = 15,
    shape = "blast",
    difficulty = 6,
    magic_type = "xedrawood_forest_magic",
    base_casting_time = 18000,
    base_energy_cost = 800,
    final_energy_cost = 500,
    energy_increment = -40,
}:caster_when("whisper_leaves_in_forest", ccb.content.text("You must be in a forest to commune with the forest spirits."))
    :lua_impact("whisper_leaves_impact"))
