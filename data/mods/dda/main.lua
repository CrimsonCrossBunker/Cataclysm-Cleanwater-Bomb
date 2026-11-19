require("item_migrations")

require("region_settings")

require("dimensions")

require("imperial_road")

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
require("psionic_base_effects")
require("native_effects")
require("dialogue_effects")
require("legacy_effects")
require("serum_effects")
require("world_effects")

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

-- Magiclysm and XedraWood both used the same saved task ID for this temporary trait.
ccb.runtime.handler("restore_whisper_leaves_cleanup", function(payload)
    local mutation = ccb.services.types.id("mutation", "TREE_COMMUNION")
    local result = ccb.services.mutations.erase(payload.character, mutation)
    if not result.ok then error(result.error.message) end
end, 1)

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

require("lixa_hallway")
require("spell_traps")

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

require("food_recipes.alcohol")
require("food_recipes.baking")
require("food_recipes.bread")
require("food_recipes.brewing")
require("food_recipes.canned")
require("food_recipes.carnivore")
require("food_recipes.casseroles")
require("food_recipes.corn")
require("food_recipes.curing")
require("food_recipes.dairy_products")
require("food_recipes.distill")
require("food_recipes.drink_other")
require("food_recipes.drinks")
require("food_recipes.dry")
require("food_recipes.egg")
require("food_recipes.frozen")
require("food_recipes.fruit_dishes")
require("food_recipes.junkfood")
require("food_recipes.meat_dishes")
require("food_recipes.milling")
require("food_recipes.mushroom")
require("food_recipes.nuts")
require("food_recipes.offal_dishes")
require("food_recipes.other")
require("food_recipes.other_food")
require("food_recipes.pasta")
require("food_recipes.protein")
require("food_recipes.raw_grain")
require("food_recipes.sandwich")
require("food_recipes.seed")
require("food_recipes.soup")
require("food_recipes.spice")
require("food_recipes.vegetable_dishes")
require("food_recipes.wheat")

require("stepped_recipes.ammo_components")
require("stepped_recipes.armor_legs")
require("stepped_recipes.armor_other")
require("stepped_recipes.armor_torso")
require("stepped_recipes.food_bread")
require("stepped_recipes.food_drinks")
require("stepped_recipes.food_dry")
require("stepped_recipes.food_egg")
require("stepped_recipes.food_pasta")
require("stepped_recipes.food_soup")
require("stepped_recipes.food_spice")
require("stepped_recipes.other_materials")
require("stepped_recipes.other_other")
require("stepped_recipes.tools_tools_hand")
require("stepped_recipes.weapon_bashing")
require("stepped_recipes.weapon_cutting")
require("stepped_recipes.weapon_piercing")

require("crafting_recipes.ammo_shot")
require("crafting_recipes.armor_arms")
require("crafting_recipes.armor_bespoke_armor_survivor")
require("crafting_recipes.armor_feet")
require("crafting_recipes.armor_gambeson_crafts")
require("crafting_recipes.armor_hands")
require("crafting_recipes.armor_head")
require("crafting_recipes.armor_legs")
require("crafting_recipes.armor_suit")
require("crafting_recipes.armor_torso")

require("weapon_recipes.ammo_40x46mm")
require("weapon_recipes.ammo_40x53mm")
require("weapon_recipes.ammo_cannon")
require("weapon_recipes.ammo_components")
require("weapon_recipes.ammo_pistol")
require("weapon_recipes.ammo_rifle")
require("weapon_recipes.ammo_shot")
require("weapon_recipes.ammo_sling-ready_grenade")
require("weapon_recipes.ammo_sling_bullet")
require("weapon_recipes.ammo_weldgas")
require("weapon_recipes.armor_hands")
require("weapon_recipes.other_parts")
require("weapon_recipes.other_parts_construction")
require("weapon_recipes.recipe_ammo")
require("weapon_recipes.recipe_medsandchemicals")
require("weapon_recipes.skyfarer")
require("weapon_recipes.tools_tools_hand")
require("weapon_recipes.weapon_bashing")
require("weapon_recipes.weapon_cutting")
require("weapon_recipes.weapon_explosive")
require("weapon_recipes.weapon_magazines")
require("weapon_recipes.weapon_mods")
require("weapon_recipes.weapon_piercing")
require("weapon_recipes.weapon_ranged")

require("armor_recipes.armor_arms")
require("armor_recipes.armor_bespoke_armor_nomad")
require("armor_recipes.armor_bespoke_armor_survivor")
require("armor_recipes.armor_cardboard")
require("armor_recipes.armor_combat_exoskeleton_armor")
require("armor_recipes.armor_feet")
require("armor_recipes.armor_gambeson_crafts")
require("armor_recipes.armor_hands")
require("armor_recipes.armor_head")
require("armor_recipes.armor_jewelry")
require("armor_recipes.armor_legs")
require("armor_recipes.armor_mutant_clothing")
require("armor_recipes.armor_other")
require("armor_recipes.armor_pets_cow")
require("armor_recipes.armor_pets_dog")
require("armor_recipes.armor_pets_horse")
require("armor_recipes.armor_storage")
require("armor_recipes.armor_suit")
require("armor_recipes.armor_torso")
require("armor_recipes.items_armor_jewelry")
require("armor_recipes.tools_containers")

require("craft_recipes.appliances_oven")
require("craft_recipes.chem_chemicals")
require("craft_recipes.chem_drugs")
require("craft_recipes.chem_fuel")
require("craft_recipes.chem_mutagens")
require("craft_recipes.chem_other")
require("craft_recipes.electronics_parts")
require("craft_recipes.electronics_toolmod")
require("craft_recipes.items_armor_jewelry")
require("craft_recipes.obsoletion_and_migration_0.J_generic")
require("craft_recipes.other_bamboo")
require("craft_recipes.other_bots")
require("craft_recipes.other_cords_and_ropes")
require("craft_recipes.other_materials")
require("craft_recipes.other_medical")
require("craft_recipes.other_microscope_samples")
require("craft_recipes.other_other")
require("craft_recipes.other_parts")
require("craft_recipes.other_parts_construction")
require("craft_recipes.other_parts_rigs")
require("craft_recipes.other_power_supplies")
require("craft_recipes.other_vehicle")
require("craft_recipes.recipe_ammo")
require("craft_recipes.recipe_appliance")
require("craft_recipes.recipe_furniture")
require("craft_recipes.recipe_medsandchemicals")
require("craft_recipes.recipe_music_instruments")
require("craft_recipes.recipe_others")
require("craft_recipes.recipe_traps")
require("craft_recipes.recipe_vehicle")
require("craft_recipes.recipes_holiday")
require("craft_recipes.skyfarer")
require("craft_recipes.tools_containers")
require("craft_recipes.tools_lights")
require("craft_recipes.tools_tool")
require("craft_recipes.tools_tools_electronic")
require("craft_recipes.tools_tools_hand")
require("craft_recipes.tools_tools_primitive")
require("craft_recipes.vehicleparts_modular_tools")

require("camp_recipes.basecamps_base_fbmc_fire_lookout_tower_recipe_modular_fire_lookout_tower_beds")
require("camp_recipes.basecamps_base_fbmc_fire_lookout_tower_recipe_modular_fire_lookout_tower_common")
require("camp_recipes.basecamps_base_fbmc_fire_lookout_tower_recipe_modular_fire_lookout_tower_construction")
require("camp_recipes.basecamps_base_fbmc_helipad_recipe_modular_helipad_common")
require("camp_recipes.basecamps_base_fbmc_helipad_recipe_modular_helipad_garage")
require("camp_recipes.basecamps_base_fbmc_lighthouse_recipe_modular_lighthouse_common")
require("camp_recipes.basecamps_base_fbmc_lightindustry_recipe_modular_lightindustry_00")
require("camp_recipes.basecamps_base_fbmc_lightindustry_recipe_modular_lightindustry_00_beds")
require("camp_recipes.basecamps_base_fbmc_lightindustry_recipe_modular_lightindustry_10")
require("camp_recipes.basecamps_base_fbmc_lightindustry_recipe_modular_lightindustry_10_beds")
require("camp_recipes.basecamps_base_fbmc_lightindustry_recipe_modular_lightindustry_workshop")
require("camp_recipes.basecamps_base_fbmc_mansion_fbmc_mansion__1")
require("camp_recipes.basecamps_base_fbmc_mansion_fbmc_mansion__2")
require("camp_recipes.basecamps_base_fbmc_mansion_fbmc_mansion__3")
require("camp_recipes.basecamps_base_fbmc_mansion_fbmc_mansion__4")
require("camp_recipes.basecamps_base_fbmc_mansion_fbmc_mansion_expansion_surveys")
require("camp_recipes.basecamps_base_fbmc_outpost_recipe_modular_outpost_normal")
require("camp_recipes.basecamps_base_fbmc_pottery_cottage_recipe_pottery_cottage_blacksmith")
require("camp_recipes.basecamps_base_fbmc_pottery_cottage_recipe_pottery_cottage_common")
require("camp_recipes.basecamps_base_fbmc_radio_tower_recipe_modular_radio_tower_beds")
require("camp_recipes.basecamps_base_fbmc_radio_tower_recipe_modular_radio_tower_common")
require("camp_recipes.basecamps_base_fbmc_radio_tower_recipe_modular_radio_tower_construction")
require("camp_recipes.basecamps_base_fbmc_sealab_small_recipe_sealab_small_common")
require("camp_recipes.basecamps_base_recipe_bare_bones_basecamp_recipe_bare_bones_basecamp")
require("camp_recipes.basecamps_base_recipe_modular_firestation_1_recipe_modular_firestation1")
require("camp_recipes.basecamps_base_recipe_modular_firestation_1_recipe_modular_firestation_walls_all")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_1_recipe_modular_field_common")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_1_recipe_modular_field_construction")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_1_recipe_modular_field_defenses")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_1_recipe_modular_field_tent")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_1_recipe_primitive_field")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_2_recipe_modular_field_common")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_2_recipe_modular_field_construction")
require("camp_recipes.basecamps_base_recipe_modular_hub_version_2_recipe_modular_field_tent")
require("camp_recipes.basecamps_base_recipe_modular_shelter_1_recipe_modular_shelter_1_common")
require("camp_recipes.basecamps_base_recipe_modular_shelter_1_recipe_modular_shelter_1_construction")
require("camp_recipes.basecamps_base_recipe_modular_shelter_2_recipe_modular_shelter_2_common")
require("camp_recipes.basecamps_base_recipe_modular_shelter_2_recipe_modular_shelter_2_construction")
require("camp_recipes.basecamps_base_recipe_modular_shelter_recipe_modular_shelter_common")
require("camp_recipes.basecamps_base_recipe_modular_shelter_recipe_modular_shelter_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_canteen_version_1_recipe_modular_canteen_common")
require("camp_recipes.basecamps_expansion_recipe_modular_canteen_version_1_recipe_modular_canteen_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_canteen_version_2_recipe_modular_canteen_common")
require("camp_recipes.basecamps_expansion_recipe_modular_canteen_version_2_recipe_modular_canteen_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_farm_version_1_recipe_primitive_farm")
require("camp_recipes.basecamps_expansion_recipe_modular_farm_version_2_recipe_modular_farm_common")
require("camp_recipes.basecamps_expansion_recipe_modular_garage_version_1_recipe_primitive_garage")
require("camp_recipes.basecamps_expansion_recipe_modular_garage_version_2_recipe_modular_garage_common")
require("camp_recipes.basecamps_expansion_recipe_modular_garage_version_2_recipe_modular_garage_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_livestock_version_1_recipe_modular_livestock_common")
require("camp_recipes.basecamps_expansion_recipe_modular_livestock_version_1_recipe_modular_livestock_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_livestock_version_2_recipe_modular_livestock_common")
require("camp_recipes.basecamps_expansion_recipe_modular_livestock_version_2_recipe_modular_livestock_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_saltworks_version_1_recipe_modular_saltworks_common")
require("camp_recipes.basecamps_expansion_recipe_modular_saltworks_version_1_recipe_modular_saltworks_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_storehouse_version_1_recipe_modular_storehouse_common")
require("camp_recipes.basecamps_expansion_recipe_modular_storehouse_version_1_recipe_modular_storehouse_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_storehouse_version_2_recipe_modular_storehouse_common")
require("camp_recipes.basecamps_expansion_recipe_modular_storehouse_version_2_recipe_modular_storehouse_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_storehouse_version_2_recipe_modular_storehouse_storage")
require("camp_recipes.basecamps_expansion_recipe_modular_workshop_version_1_recipe_modular_workshop_common")
require("camp_recipes.basecamps_expansion_recipe_modular_workshop_version_1_recipe_modular_workshop_construction")
require("camp_recipes.basecamps_expansion_recipe_modular_workshop_version_2_recipe_modular_workshop_common")
require("camp_recipes.basecamps_expansion_recipe_modular_workshop_version_2_recipe_modular_workshop_construction")
require("camp_recipes.basecamps_special_hardcoded")
require("camp_recipes.obsoletion_and_migration_0_I_obsolete_recipe_modular_workshop_salt_water_pipe")

require("practice_completion")
require("practice_recipes.practice_aircraft")
require("practice_recipes.practice_applied_science")
require("practice_recipes.practice_athletics")
require("practice_recipes.practice_computers")
require("practice_recipes.practice_devices")
require("practice_recipes.practice_electronics")
require("practice_recipes.practice_fabrication")
require("practice_recipes.practice_health")
require("practice_recipes.practice_mechanics")
require("practice_recipes.practice_melee")
require("practice_recipes.practice_ranged")
require("practice_recipes.practice_social")
require("practice_recipes.practice_survival")
require("practice_recipes.practice_tailoring")

require("craft_recipes.recipe_companion")

require("activity_types")

require("phone_recovery")

require("item_groups")

require("item_group_changes")

require("book_items")

require("generic_items")

require("powered_tools")

require("instrument_actions")

require("inherited_items")

require("active_items")

require("contact_lenses")

require("fidget_spinner")

require("saline_infusion")

require("injection_serums")

require("map_item_actions")

require("readable_files")

require("tarot_cards")

require("dimension_orbs")

require("vitrification_return")

require("terrain_transforms")

require("monster_groups")
