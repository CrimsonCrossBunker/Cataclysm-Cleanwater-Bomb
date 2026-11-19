local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local proficiency = require("spell_proficiencies")
local id = services.types.id
local duration = services.time.duration

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function is_character(actor)
    return actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character"
end

local function spell_level(actor, spell)
    if not is_character(actor) then return 0 end
    return checked(services.spells.effective_level(actor, spell))
end

local function add_effect(actor, effect, turns)
    local result = services.effects.add(actor, effect, duration(math.modf(turns), "turn"))
    if not result.ok and result.error.code ~= "rejected" then error(result.error.message) end
end

local grasp_id = "druid_veggrasp"
local entangled = id("effect", "entangled")

ccb.runtime.handler("vegetative_grasp_impact", function(impact)
    local target = impact.target_creature
    if not target then return end
    local caster = impact.caster
    local level = spell_level(caster, grasp_id)
    local modifier = 1
    if is_character(caster) then
        for _, rank in ipairs { "beginner", "apprentice", "master" } do
            if checked(services.proficiencies.has_id_text(caster, "prof_magic_evocation_" .. rank)) then
                modifier = modifier + 0.1
            end
        end
    end
    local options = { include_before = false }
    checked(services.variables.set(target, "vegetative_grasp_affected_level", level, options))
    checked(services.variables.set(target, "evocation_spell_affected_proficiency", modifier, options))
    add_effect(target, entangled, 10 + level * 5)
end)

ccb.runtime.handler("vegetative_grasp_min_damage", function(context)
    return spell_level(context.speaker, grasp_id) * 0.1 + 1
end)
ccb.runtime.handler("vegetative_grasp_max_damage", function(context)
    return spell_level(context.speaker, grasp_id) * 0.4 + 2
end)

content.add(content.Spell {
    id = grasp_id,
    name = ccb.content.text("Vegetative Grasp"),
    description = ccb.content.text("This spell causes roots and vines to burst forth from the ground and grab your foes, slowing them and doing a small amount of damage as they dig in.\n\nLarger targets will be <color_yellow>less affected</color> by the spell, and it has <color_red>no effect</color> on targets not on natural ground."),
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "hostile", "ground" },
    flags = { "EVOCATION_SPELL", "LOUD", "SOMATIC", "VERBAL", "RANDOM_DAMAGE", "NO_LEGS", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    shape = "blast",
    spell_class = "DRUID",
    base_casting_time = 100,
    base_energy_cost = 175,
    magic_type = "magiclysm_evocation_magic",
    difficulty = 2,
    max_level = 20,
    min_damage = 1,
    max_damage = 2,
    min_aoe = 2,
    max_aoe = 8,
    aoe_increment = 0.5,
    min_range = 3,
    max_range = 10,
    range_increment = 1.0,
    min_duration = 1000,
    max_duration = 10000,
    duration_increment = 500,
    min_pierce = 1,
    max_pierce = 5,
    pierce_increment = 0.25,
    min_dot = 0.1,
    max_dot = 0.3,
    dot_increment = 0.01,
    damage_type = "stab",
}:dynamic_stat("min_damage", "vegetative_grasp_min_damage")
    :dynamic_stat("max_damage", "vegetative_grasp_max_damage")
    :lua_impact("vegetative_grasp_impact")
    :extra_spell { id = "eoc_evocation_setup", hit_self = true })

local commune_id = "druid_natures_commune"
local commune = id("effect", "natures_commune")
local forest_morale = id("morale", "morale_forest_unity")

ccb.runtime.handler("can_commune_with_nature", function(context)
    local caster = checked(services.creatures.snapshot(context.speaker))
    if not caster.outside then return false end
    local position = caster.position
    local natural = services.environment.terrain_has_flag(position, "SHRUB")
        or services.environment.terrain_has_flag(position, "DIGGABLE")
        or services.environment.terrain_has_flag(position, "YOUNG")
    return natural and not services.overmap.matches_location_near(position:project_to("omt"), "road", 1)
end)

ccb.runtime.handler("commune_with_nature_impact", function(impact)
    local actor = impact.target_creature
    local level = spell_level(actor, commune_id)
    local modifier = proficiency.channeling_modifier(actor)
    local turns = (300 + level * 165) * modifier
    add_effect(actor, commune, turns)
    if is_character(actor) then
        checked(services.morale.remove(actor, forest_morale))
        level = spell_level(actor, commune_id)
        modifier = proficiency.channeling_modifier(actor)
        local base_duration = 300 + level * 165
        local bonus = math.modf(5 + level * 3 * modifier)
        checked(services.morale.add(actor, forest_morale, bonus, 50, {
            duration = duration(math.modf(base_duration * modifier), "turn"),
            decay_start = duration(math.modf(base_duration / 2 * modifier), "turn"),
        }))
    end
end)

content.add(content.Spell {
    id = commune_id,
    name = ccb.content.text("Communion with Nature"),
    description = ccb.content.text("You focus on the bounty of nature around you and commune with it, improving your health and mood and calming nearby wildlife.  This spell may only be cast outdoors away from civilization."),
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    shape = "blast",
    flags = { "CHANNELING_SPELL", "CONCENTRATE", "SOMATIC", "VERBAL", "NO_LEGS", "NO_HANDS" },
    magic_type = "magiclysm_channeling_magic",
    spell_class = "DRUID",
    difficulty = 4,
    base_casting_time = 12000,
    base_energy_cost = 250,
    final_energy_cost = 400,
    energy_increment = 10,
    max_level = 20,
    min_duration = 30000,
    max_duration = 360000,
    duration_increment = 16500,
}:caster_when("can_commune_with_nature", ccb.content.text("You must be surrounded by nature to commune with nature."))
    :lua_impact("commune_with_nature_impact")
    :extra_spell { id = "eoc_channeling_setup", hit_self = true })

local tree_communion = id("mutation", "TREE_COMMUNION")

ccb.runtime.handler("druid_whisper_leaves_due", function(payload)
    checked(services.mutations.erase(payload.character, tree_communion))
end, 1)

ccb.runtime.handler("druid_whisper_leaves_impact", function(impact)
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
    if character then ccb.tasks.after_character_turn(actor, delay, "druid_whisper_leaves_due") end
end)

content.add(content.Spell {
    id = "druid_whisper_leaves",
    name = ccb.content.text("Whisper of the Leaves"),
    description = ccb.content.text("This spell allows you to hear the trees' wisdom in the rustle of the leaves and the creaking of their roots, discerning the layout of the forest."),
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    flags = { "CHANNELING_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    spell_class = "DRUID",
    difficulty = 6,
    max_level = 15,
    base_casting_time = 6000,
    final_casting_time = 1000,
    casting_time_increment = -350,
    base_energy_cost = 800,
    final_energy_cost = 500,
    energy_increment = -40,
    min_duration = 6000,
    max_duration = 6000,
}:lua_impact("druid_whisper_leaves_impact")
    :extra_spell { id = "eoc_channeling_setup", hit_self = true })

local goodberry = id("item", "item_druid_goodberry")
ccb.runtime.handler("druid_goodberry_impact", function(impact)
    if is_character(impact.target_creature) then
        checked(services.inventory.receive_item(impact.target_creature, goodberry, 1))
    end
end)

content.add(content.Spell {
    id = "druid_goodberry",
    name = ccb.content.text("Goodberry"),
    description = ccb.content.text("Enchant a set of berries, transforming them into magical fruit that will provide a hearty meal's worth of nutrition and a small amount of healing when eaten.  The goodberries will rot away within 24 hours if not eaten."),
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    shape = "blast",
    flags = { "TRANSFORMATION_SPELL", "SOMATIC", "VERBAL" },
    components = "spell_components_goodberry",
    spell_class = "DRUID",
    magic_type = "magiclysm_transformation_magic",
    difficulty = 3,
    base_casting_time = 30000,
    base_energy_cost = 350,
    max_level = 15,
    min_duration = 8640000,
    max_duration = 8640000,
}:lua_impact("druid_goodberry_impact")
    :extra_spell { id = "eoc_transformation_setup", hit_self = true })
