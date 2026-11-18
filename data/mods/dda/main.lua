require("item_migrations")

require("region_settings")

require("dimensions")

local ccb = require("ccb")

local function mounted_charge_available(context)
    return context.mounted
        and context.mount_kind == "animal"
        and context.moves > 0
        and (
            not context.activity_active
            or (
                context.phase ~= "menu"
                and context.activity_id == "ACT_MOUNTED_CHARGE"
            )
        )
        and not context.grabbed
        and not context.auto_moving
        and not context.hauling
        and not context.in_vehicle
        and not context.controlling_vehicle
        and not context.crouching
        and not context.prone
        and not context.in_shell
        and not context.phase_movement
        and context.can_attack
        and context.can_move
end

ccb.runtime.handler(
    "ccb_mounted_charge_available",
    mounted_charge_available,
    1
)

local function mounted_charge_damage(context)
    local momentum = math.min(5, math.max(0, context.completed_steps))
    local speed_factor = math.max(0, context.mount_speed) / 300
    return math.min(
        context.max_multiplier,
        1 + context.multiplier_per_step * momentum * speed_factor
    )
end

ccb.runtime.handler("ccb_mounted_charge_damage", mounted_charge_damage, 1)

local mounted_charge = ccb.content.Technique {
    id = "MOUNTED_CHARGE",
    name = ccb.content.text("Mounted Charge"),
    description = ccb.content.text(
        "Charge forward while mounted and strike the first creature in your path."
    ),
    avatar_message = ccb.content.text("You charge into %s"),
    npc_message = ccb.content.text("<npcname> charges into %s"),
    manual_activation = true,
    cooldown_seconds = 10,
    melee_allowed = true,
    active_when = "ccb_mounted_charge_available",
    charge_damage = "ccb_mounted_charge_damage",
}
mounted_charge:attack_vector("vector_null")
ccb.content.replace(mounted_charge)

require("grappling")
require("position_techniques")
require("combat_techniques")
require("nested_recipes")

require("exodii_crash_mapgen")

require("morale_types")

require("flags")
require("vehicle_part_flags")
require("monster_flags")

require("speech")

require("ammunition_types")

require("ammo_effects")
require("mutation_snippets")
require("mutation_artifact")

require("tool_qualities")

require("vitamins")

require("snippets")

require("requirements")

require("enchantments")

require("enchantment_variables")

require("quadruped_enchantments")

require("vision_enchantments")

require("effect_enchantments")

require("mutation_enchantments")

require("inline_enchantment_conditions")

require("inline_enchantment_values")

require("inline_enchantment_physiology")

require("inherited_enchantments")

require("attribute_scaling")

require("environment_enchantments")

require("overlay_enchantments")

require("inline_special_vision")

require("thermal_scaling")

require("innate_enchantments")

require("body_enchantments")

require("contextual_enchantments")

require("world_enchantments")

require("chance_enchantments")

require("bionic_enchantments")

require("item_enchantments")

require("weather_generators")

require("weather_types")

require("portal_storm_scenarios")

require("portal_storm_interactions")

require("portal_storm_timers")

require("portal_storm_cycle")

require("labyrinth_returns")

require("labyrinth_return_topics")

require("void_spider_death")

require("void_spider_spells")

require("yrax_science_spells")

require("anomalous_mp3")

require("string_dimension_hypercube")

require("inner_cabin_door")

require("portal_active_effects")

require("portal_passive_effects")

require("nre_recorder")

require("science_items")

require("portal_storm_dungeon")

require("portal_storm_dialogue")

require("highland_incense_content")

require("highland_incense")

require("scenario_filters")

require("construction_categories")
require("construction_groups")
require("vehicle_part_categories")

require("overmap_locations")

require("field_emissions")

require("sub_body_parts")
require("bionic_sub_body_parts")
require("mutation_sub_body_parts")

require("anatomies")
require("body_graphs")

require("body_parts")
require("bionic_body_parts")
require("mutation_body_parts")
require("prosthetic_body_parts")

require("disassembly.clothing")
require("disassembly.ammunition")
require("disassembly.appliances")
require("disassembly.miscellaneous")
require("disassembly.bionics")
require("disassembly.food")
require("disassembly.deconstruction")
require("disassembly.tools")
require("disassembly.vehicle")
