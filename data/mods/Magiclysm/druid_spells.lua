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

local brambles_id = "druid_summon_brambles"
local brambles_arc = "druid_summon_brambles_arc"
local brambles_line = "druid_summon_brambles_line"

ccb.runtime.handler("druid_choose_brambles", function(impact)
    local selection = services.interaction.choose({
        { id = brambles_arc, hotkey = "1", label = ccb.services.translate("Thorny Arc"),
            description = ccb.services.translate("Summon a spray of brambles to entrap an enemy.") },
        { id = brambles_line, hotkey = "2", label = ccb.services.translate("Wall of Brambles"),
            description = ccb.services.translate("Summon a wall of thorns to fortify a location.") },
    }, { title = ccb.services.translate("Select an option."), allow_cancel = false, show_descriptions = true })
    if not selection.accepted then return end
    local actor = impact.target_creature
    local spell = id("spell", selection.id)
    local options = { targeted = true }
    if is_character(actor) then
        checked(services.characters.cast_spell(actor, spell, options))
    elseif actor.subtype == "monster" then
        checked(services.monsters.cast_spell(actor, spell, options))
    end
end)

local brambles_stats = {
    { "druid_brambles_arc_range", 0.6 },
    { "druid_brambles_line_range", 1 },
    { "druid_brambles_arc_width", 1.9 },
}
for _, stat in ipairs(brambles_stats) do
    local handler, multiplier = stat[1], stat[2]
    ccb.runtime.handler(handler, function(context)
        local actor = context.speaker
        return (spell_level(actor, brambles_id) * multiplier) * proficiency.evocation_modifier(actor)
    end)
end

local renew_forest_id = "druid_renew_forest_spell"
local renew_forest = id("terrain_furniture_transform", "ter_druid_renew_forest")
local renew_forest_cost = "renew_forest_hp_cost"
local body_parts = {
    id("body_part", "arm_l"), id("body_part", "arm_r"), id("body_part", "leg_l"),
    id("body_part", "leg_r"), id("body_part", "torso"), id("body_part", "head"),
}

ccb.runtime.handler("druid_renew_forest_outside", function(context)
    return checked(services.creatures.snapshot(context.speaker)).outside
end)

ccb.runtime.handler("druid_renew_forest_impact", function(impact)
    local actor = impact.target_creature
    local creature = checked(services.creatures.snapshot(actor))
    if creature.position.z ~= 0 then
        if actor.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You must be on the surface and not on a building's upper stories to cast Renewing the Forest!"), "bad")
        end
        return
    end
    local level = spell_level(actor, renew_forest_id)
    local cost = math.max(25 - level / 2, 15)
    checked(services.variables.set(actor, renew_forest_cost, cost, { include_before = false }))
    local character = is_character(actor)
    for _, part in ipairs(body_parts) do
        local hp = character and checked(services.characters.hp(actor, part)) or creature.hp
        if hp <= cost then
            if actor.subtype == "avatar" then
                services.messages.add(ccb.services.translate("You do not have enough life force to donate it to renew the forest!"), "bad")
            end
            return
        end
    end
    local scale = services.random.native_float(0.8, 1.2)
    local offset = services.random.native_float(1.5, 4)
    local radius = math.modf((level * scale + offset) * proficiency.channeling_modifier(actor))
    checked(services.world.transform_radius(creature.position, radius, renew_forest))
    if character then
        for _, part in ipairs(body_parts) do
            local hp = checked(services.characters.hp(actor, part))
            local current_cost = checked(services.variables.get_number(actor, renew_forest_cost)).value or 0
            checked(services.characters.set_hp(actor, part, math.modf(hp - current_cost), true))
        end
    end
end)

local function nearby_tiles(position)
    return services.world.points_nearby(position, { max_radius = 1 }).items
end

local function choose_terrain(center, flag, message, failure_message)
    local candidates = {}
    for _, tile in ipairs(nearby_tiles(center)) do
        if services.environment.terrain_has_flag(tile.position, flag) then
            candidates[#candidates + 1] = tile.position
        end
    end
    return services.targeting.choose_adjacent_where_at(center, message, failure_message, candidates, false, true)
end

local log = id("item", "log")
ccb.runtime.handler("druid_shape_wood_impact", function(impact)
    local actor = impact.target_creature
    local center = checked(services.creatures.snapshot(actor)).position
    local tree = choose_terrain(center, "TREE", ccb.services.translate("Select nearby tree"),
        ccb.services.translate("You must be near a tree to shape it."))
    if not tree then
        if actor.subtype == "avatar" then services.messages.add(ccb.services.translate("Never mind.")) end
        return
    end
    if actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate("The wood of the tree grows and forms as you cast the spell and when it ends, there is a log lying on the ground, entirely covered in bark but otherwise straight and ready to be used in other projects."), "good")
    end
    if is_character(actor) then checked(services.inventory.receive_item(actor, log, 1)) end
end)

local disinfectant = id("item", "item_druid_disinfectant")
ccb.runtime.handler("druid_disinfectant_cleanup", function(payload)
    checked(services.inventory.remove_type(payload.character, disinfectant))
end, 1)

ccb.runtime.handler("druid_disinfectant_impact", function(impact)
    local actor = impact.target_creature
    local character = is_character(actor)
    if character then
        checked(services.inventory.receive_item(actor, disinfectant, 1))
        local items = checked(services.inventory.items_of_type(actor, disinfectant, true))
        if #items > 0 then
            local position = checked(services.creatures.snapshot(actor)).position
            checked(services.items.activate(items[#items], actor, "heal", { target = position }))
        end
    end
    local delay = services.random.native_int(1, 1)
    if character then ccb.tasks.after_character_turn(actor, delay, "druid_disinfectant_cleanup") end
end)

local spring_id = "druid_create_temporary_spring"
local create_spring = id("terrain_furniture_transform", "ter_druid_create_spring")
local remove_spring = id("terrain_furniture_transform", "ter_druid_remove_spring")

ccb.runtime.handler("druid_create_spring_impact", function(impact)
    local actor = impact.target_creature
    local center = checked(services.creatures.snapshot(actor)).position
    local earth = choose_terrain(center, "DIGGABLE", ccb.services.translate("Select natural earth"),
        ccb.services.translate("You can only call up a spring on natural earth."))
    if not earth then
        if actor.subtype == "avatar" then services.messages.add(ccb.services.translate("Canceled")) end
        return
    end
    checked(services.world.transform_radius(earth, 0, create_spring))
    local turns = (spell_level(actor, spring_id) * 150 + 300) * proficiency.channeling_modifier(actor)
    checked(services.world.transform_radius(earth, 60, remove_spring, {
        delay = duration(math.modf(turns), "turn"),
    }))
end)

local awaken_id = "druid_turn_tree_into_treant"
local treant = "mon_treant_druid"
local treant_type = id("monster", treant)
local awaken_tree = id("terrain_furniture_transform", "ter_druid_tree_guardian_turn")
local root_tree = id("terrain_furniture_transform", "ter_druid_tree_guardian_turn_back")

ccb.runtime.handler("druid_awaken_tree_impact", function(impact)
    local actor = impact.target_creature
    local center = checked(services.creatures.snapshot(actor)).position
    for _, tile in ipairs(nearby_tiles(center)) do
        local position = tile.position
        if services.environment.terrain_has_flag(position, "TREE") then
            checked(services.world.transform_radius(position, 0, awaken_tree))
            local turns = (spell_level(actor, awaken_id) * 70 + 150) * proficiency.transformation_modifier(actor)
            checked(services.spawns.population(treant_type, position, {
                min_radius = 0, max_radius = 0, temporary_drop_items = true,
                lifespan = duration(math.modf(turns), "turn"),
            }))
            return
        end
    end
end)

ccb.runtime.handler("druid_treant_roots", function(payload)
    local where = payload.position
    local position = services.coords.tripoint_abs_ms(where.x, where.y, where.z)
    checked(services.world.transform_radius(position, 0, root_tree))
end)
content.bind_monster_death("mon_treant", "druid_treant_roots")
content.bind_monster_death(treant, "druid_treant_roots")

content.add(content.Spell {
    id = brambles_id,
    name = ccb.content.text("Stranglethorns"),
    description = ccb.content.text("Call up thick, swiftly growing brambles, either in a line to form a wall or an arc to trap an enemy."),
    valid_targets = { "self" },
    shape = "blast",
    flags = { "EVOCATION_SPELL", "SOMATIC", "VERBAL" },
    spell_class = "DRUID",
    magic_type = "magiclysm_evocation_magic",
    difficulty = 5,
    base_casting_time = 150,
    base_energy_cost = 400,
    max_level = 15,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:lua_impact("druid_choose_brambles")
    :extra_spell { id = "eoc_evocation_setup", hit_self = true })

content.add(content.Spell {
    id = brambles_arc,
    name = ccb.content.text("Summon Brambles Arc"),
    description = ccb.content.text("Call up thick, swiftly growing brambles, either in a line to form a wall or an arc to trap an enemy."),
    valid_targets = { "ground", "hostile" },
    effect = "ter_transform",
    effect_str = "druid_summoned_brambles",
    shape = "cone",
    flags = { "EVOCATION_SPELL", "SILENT", "NO_PROJECTILE" },
    spell_class = "DRUID",
    magic_type = "magiclysm_evocation_magic",
    max_level = 15,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:dynamic_stat("min_range", "druid_brambles_arc_range")
    :dynamic_stat("max_range", "druid_brambles_arc_range")
    :dynamic_stat("min_aoe", "druid_brambles_arc_width")
    :dynamic_stat("max_aoe", "druid_brambles_arc_width"))

content.add(content.Spell {
    id = brambles_line,
    name = ccb.content.text("Summon Brambles Line"),
    description = ccb.content.text("Call up thick, swiftly growing brambles, either in a line to form a wall or an arc to trap an enemy."),
    valid_targets = { "ground", "hostile" },
    effect = "ter_transform",
    effect_str = "druid_summoned_brambles",
    shape = "line",
    flags = { "EVOCATION_SPELL", "SILENT", "NO_PROJECTILE" },
    spell_class = "DRUID",
    magic_type = "magiclysm_evocation_magic",
    max_level = 15,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:dynamic_stat("min_range", "druid_brambles_line_range")
    :dynamic_stat("max_range", "druid_brambles_line_range"))

content.add(content.Spell {
    id = renew_forest_id,
    name = ccb.content.text("Renewing the Forest"),
    description = ccb.content.text("While outdoors and not underground, the druid can create a profusion of life around themselves, causing grass to grow through pavement, bushes and flowers to sprout, and trees to grow to full height in moments.\n\nIn <color_yellow>addition to</color> mana, this spell also requires <color_red>hit points</color> to cast and <color_yellow>will fail</color> if you are too injured."),
    flags = { "CHANNELING_SPELL", "SOMATIC", "VERBAL" },
    valid_targets = { "self" },
    max_level = 25,
    spell_class = "DRUID",
    shape = "blast",
    difficulty = 10,
    magic_type = "magiclysm_channeling_magic",
    base_energy_cost = 150,
    base_casting_time = 6000,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:caster_when("druid_renew_forest_outside", ccb.content.text("You must be outside to cast Renewing the Forest."))
    :lua_impact("druid_renew_forest_impact")
    :extra_spell { id = "eoc_channeling_setup", hit_self = true })

content.add(content.Spell {
    id = "druid_wood_living_tree_spell",
    name = ccb.content.text("Shape Wood"),
    description = ccb.content.text("Using druidic magic, shape living wood into a log that you can use for other projects without harming the tree.  You must cast this spell on a living tree."),
    flags = { "CHANNELING_SPELL", "CONCENTRATE", "SILENT", "VERBAL" },
    valid_targets = { "self" },
    spell_class = "DRUID",
    difficulty = 5,
    max_level = 15,
    shape = "blast",
    magic_type = "magiclysm_channeling_magic",
    base_casting_time = 180000,
    base_energy_cost = 600,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:lua_impact("druid_shape_wood_impact")
    :extra_spell { id = "eoc_channeling_setup", hit_self = true })

content.add(content.Spell {
    id = "druid_disinfectant",
    name = ccb.content.text("Wash the Wounds Clean"),
    description = ccb.content.text("Transform a bit of water into a magical disinfectant as you pour it over your wounds."),
    valid_targets = { "self" },
    spell_class = "DRUID",
    flags = { "TRANSFORMATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    shape = "blast",
    components = "spell_components_druid_anti_heat",
    difficulty = 4,
    max_level = 15,
    magic_type = "magiclysm_transformation_magic",
    base_energy_cost = 200,
    base_casting_time = 1000,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:lua_impact("druid_disinfectant_impact")
    :extra_spell { id = "eoc_transformation_setup", hit_self = true })

content.add(content.Spell {
    id = spring_id,
    name = ccb.content.text("Fountain of the Depths"),
    description = ccb.content.text("Call to the waters beneath the earth and bring them to the surface, creating a natural spring.  The waters will subside when the spell's duration ends."),
    flags = { "CHANNELING_SPELL", "CONCENTRATE", "SILENT", "VERBAL" },
    valid_targets = { "self" },
    spell_class = "DRUID",
    difficulty = 9,
    max_level = 15,
    shape = "blast",
    min_duration = 30000,
    max_duration = 255000,
    duration_increment = 15000,
    magic_type = "magiclysm_channeling_magic",
    base_casting_time = 9000,
    base_energy_cost = 750,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:lua_impact("druid_create_spring_impact")
    :extra_spell { id = "eoc_channeling_setup", hit_self = true })

content.add(content.Spell {
    id = awaken_id,
    name = ccb.content.text("Awakening of the Forest Guardian"),
    description = ccb.content.text("Grant a nearby tree awareness and mobility, letting it shake free from the soil and rise up to crush your enemies.  It will root itself again when the spell expires.\n\nYou must be <color_yellow>standing next to a tree</color> for the spell to take effect."),
    flags = { "TRANSFORMATION_SPELL", "CONCENTRATE", "SILENT", "VERBAL" },
    valid_targets = { "self" },
    spell_class = "DRUID",
    difficulty = 12,
    max_level = 20,
    shape = "blast",
    min_duration = 15000,
    max_duration = 155000,
    duration_increment = 7000,
    magic_type = "magiclysm_transformation_magic",
    base_casting_time = 500,
    base_energy_cost = 850,
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
}:lua_impact("druid_awaken_tree_impact")
    :extra_spell { id = "eoc_transformation_setup", hit_self = true })
