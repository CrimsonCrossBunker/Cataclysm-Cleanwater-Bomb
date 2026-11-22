local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "fd_bile_adv",
    underwater_age_speedup_turns = 1500,
    decay_amount_factor = 2,
    half_life_turns = 86400,
    phase = "liquid",
    description_affix = "covered_in",
    looks_like = "fd_bile",
    splattering = true,
    accelerated_decay = true,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("thick bile splatter"),
    color = "pink",
}
definition:intensity {
    name = ccb.content.text("thick bile stain"),
    color = "pink",
    light_emitted = 1.0,
}
definition:intensity {
    name = ccb.content.text("puddle of thick bile"),
    color = "pink",
    light_emitted = 3.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_darkness",
    percent_spread = 50,
    half_life_turns = 10,
}
definition:intensity {
    name = ccb.content.text("darkness"),
    local_light_override = 0.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_fire_FAKE",
    priority = 4,
    half_life_turns = 1,
    phase = "plasma",
    looks_like = "fd_fire",
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("glittering embers"),
    symbol = "4",
    color = "yellow",
    light_emitted = 5.0,
    translucency = 0.7,
}
definition:intensity {
    name = ccb.content.text("spark shower"),
    symbol = "4",
    color = "light_red",
    light_emitted = 15.0,
    translucency = 0.4,
}
definition:intensity {
    name = ccb.content.text("wall of flames"),
    symbol = "4",
    color = "red",
    light_emitted = 40.0,
    translucency = 0.1,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_biolum",
    priority = 4,
    half_life_turns = 6,
    phase = "plasma",
    description_affix = "illuminated_by",
    has_electricity = true,
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("glimmer"),
    symbol = "6",
    color = "cyan",
    light_emitted = 4.0,
}
definition:intensity {
    name = ccb.content.text("glow"),
    symbol = "6",
    color = "cyan",
    light_emitted = 9.0,
}
definition:intensity {
    name = ccb.content.text("shine"),
    symbol = "6",
    color = "blue",
    light_emitted = 20.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_shadow",
    percent_spread = 50,
    half_life_turns = 10,
}
definition:intensity {
    name = ccb.content.text("shadow"),
    local_light_override = 3.7,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_hot_air_sauna",
    outdoor_age_speedup_turns = 1800,
    decay_amount_factor = 5,
    percent_spread = 40,
    priority = -1,
    half_life_turns = 300,
    phase = "gas",
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("hot air sauna"),
    symbol = "&",
    convection_temperature_modifier = 60,
}
definition:intensity {
    name = ccb.content.text("hot air sauna"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 70,
}
definition:intensity {
    name = ccb.content.text("hot air sauna"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 80,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_electricity_unlit",
    priority = 4,
    half_life_turns = 4,
    phase = "plasma",
    description_affix = "illuminated_by",
    looks_like = "fd_electricity",
    has_electricity = true,
    display_items = false,
    display_field = false,
}
definition:intensity {
    name = ccb.content.text("sparks"),
    symbol = "9",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("sparks"),
    symbol = "9",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("sparks"),
    symbol = "9",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("electric crackle"),
    symbol = "9",
    color = "cyan",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("electric crackle"),
    symbol = "9",
    color = "cyan",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("electric crackle"),
    symbol = "9",
    color = "cyan",
    dangerous = true,
}
definition:intensity {
    name = ccb.content.text("electric cloud"),
    symbol = "9",
    color = "blue",
    dangerous = true,
    light_emitted = 5.0,
}
definition:intensity {
    name = ccb.content.text("electric cloud"),
    symbol = "9",
    color = "blue",
    dangerous = true,
    light_emitted = 5.0,
}
definition:intensity {
    name = ccb.content.text("electric cloud"),
    symbol = "9",
    color = "blue",
    dangerous = true,
    light_emitted = 5.0,
}
definition:intensity {
    name = ccb.content.text("electric cloud"),
    symbol = "9",
    color = "blue",
    dangerous = true,
    light_emitted = 5.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_direction",
    priority = 10,
    half_life_turns = 1,
    phase = "gas",
    looks_like = "footstep",
    accelerated_decay = true,
    display_items = true,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("Detected something"),
    symbol = ".",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_churned_earth",
    half_life_turns = 60,
    phase = "solid",
    looks_like = "t_dirtmound",
    accelerated_decay = true,
    display_items = true,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("churned earth"),
    symbol = "^",
    color = "brown",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_last_known",
}
definition:intensity {
    name = ccb.content.text("last known position"),
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_construction_site",
    priority = 1,
    looks_like = "fd_shadow",
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("Construction site"),
    symbol = ".",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_air_conditioner_radiosphere",
    priority = -1,
    phase = "gas",
    display_field = false,
}
definition:intensity {
    name = ccb.content.text("warm air"),
    symbol = "&",
    convection_temperature_modifier = 40,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_mechanical_fluid",
    half_life_turns = 864000,
    phase = "liquid",
    description_affix = "covered_in",
    looks_like = "fd_sludge",
    splattering = true,
    moppable = true,
    display_field = true,
    mopsafe = true,
}
definition:intensity {
    name = ccb.content.text("mechanical fluid splatter"),
    color = "light_gray",
}
definition:intensity {
    name = ccb.content.text("mechanical fluid stain"),
    color = "light_gray",
}
definition:intensity {
    name = ccb.content.text("puddle of mechanical fluid"),
    color = "dark_gray",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_dirty_water",
    half_life_turns = 7200,
    phase = "liquid",
    description_affix = "covered_in",
    looks_like = "water",
    moppable = true,
    display_field = true,
    mopsafe = true,
}
definition:intensity {
    name = ccb.content.text("dirty water splatter"),
    color = "light_gray",
}
definition:intensity {
    name = ccb.content.text("dirty water stain"),
    color = "light_gray",
}
definition:intensity {
    name = ccb.content.text("puddle of dirty water"),
    color = "dark_gray",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_ammo_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("ammo loot zone"),
    symbol = "a",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_armor_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("armor loot zone"),
    symbol = "A",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_artifacts_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("artifacts loot zone"),
    symbol = "*",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_auto_drink_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("auto drink zone"),
    symbol = "D",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_auto_eat_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("auto eat zone"),
    symbol = "E",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_basecamp_food_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("basecamp food zone"),
    symbol = "F",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_basecamp_storage_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("basecamp storage zone"),
    symbol = "S",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_bionics_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("bionics loot zone"),
    symbol = "b",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_books_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("books loot zone"),
    symbol = "B",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_chemical_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("chemical loot zone"),
    symbol = "C",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_chop_trees_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("chop trees zone"),
    symbol = "T",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_clothing_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("clothing loot zone"),
    symbol = "c",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_construction_blueprint_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("construction blueprint zone"),
    symbol = "#",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_containers_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("containers loot zone"),
    symbol = ">",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_corpses_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("corpses loot zone"),
    symbol = "@",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_currency_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("currency loot zone"),
    symbol = "$",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_custom_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("custom loot zone"),
    symbol = "?",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_default_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("default loot zone"),
    symbol = "!",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_disassembly_work_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("disassembly work zone"),
    symbol = "-",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_drink_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("drink loot zone"),
    symbol = "d",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_drugs_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("drugs loot zone"),
    symbol = "+",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_farm_plot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("farm plot zone"),
    symbol = "P",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_filthy_armor_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("filthy armor loot zone"),
    symbol = "/",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_filthy_clothing_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("filthy clothing loot zone"),
    symbol = "\\",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_firewood_source_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("firewood source zone"),
    symbol = "6",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_fishing_spot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("fishing spot zone"),
    symbol = "W",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_food_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("food loot zone"),
    symbol = "f",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_fuel_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("fuel loot zone"),
    symbol = "'",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_guns_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("guns loot zone"),
    symbol = "g",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_ignore_favorites_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("ignore favorites loot zone"),
    symbol = "I",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_ignore_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("ignore loot zone"),
    symbol = "i",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_item_group_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("item group loot zone"),
    symbol = "9",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_keys_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("keys loot zone"),
    symbol = "k",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_magazines_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("magazines loot zone"),
    symbol = "m",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_manuals_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("manuals loot zone"),
    symbol = "M",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_maps_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("maps loot zone"),
    symbol = "e",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_martial_arts_manuals_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("martial arts manuals loot zone"),
    symbol = "O",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_mine_terrain_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mine terrain zone"),
    symbol = "x",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_mods_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mods loot zone"),
    symbol = "h",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_mop_tile_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mop tile zone"),
    symbol = "~",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_mutagens_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mutagens loot zone"),
    symbol = "H",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_no_auto_pickup_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("no auto pickup zone"),
    symbol = "1",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_no_npc_pickup_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("no NPC pickup zone"),
    symbol = "2",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_npc_ignore_sounds_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("npc_ignore_sounds zone"),
    symbol = "3",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_npc_investigation_area_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("NPC investigation area zone"),
    symbol = "4",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_npc_no_go_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("NPC no-go zone"),
    symbol = "X",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_npc_retreat_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("NPC retreat zone"),
    symbol = "5",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_other_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("other loot zone"),
    symbol = "o",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_perishable_drink_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("perishable drink loot zone"),
    symbol = "p",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_perishable_food_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("perishable food loot zone"),
    symbol = "P",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_seeds_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("seeds loot zone"),
    symbol = "s",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_spare_parts_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("spare parts loot zone"),
    symbol = "S",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_start_point_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("start point zone"),
    symbol = "7",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_strip_corpses_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("strip_corpses loot zone"),
    symbol = "j",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_tools_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("tools loot zone"),
    symbol = "t",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_tool_magazines_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("tool_magazines loot zone"),
    symbol = "J",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_traps_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("traps loot zone"),
    symbol = "^",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_unload_everything_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("unload everything loot zone"),
    symbol = "u",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_unsorted_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("unsorted loot zone"),
    symbol = "U",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_vehicle_deconstruct_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("vehicle deconstruct zone"),
    symbol = "y",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_vehicle_parts_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("vehicle parts loot zone"),
    symbol = "v",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_vehicle_patrol_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("vehicle patrol zone"),
    symbol = "8",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_study_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("study zone"),
    symbol = "S",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_vehicle_repair_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("vehicle repair zone"),
    symbol = "Y",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_vehicle_service_output_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("vehicle service output zone"),
    symbol = "V",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_weapons_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("weapons loot zone"),
    symbol = "w",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_wood_loot_zone",
    priority = 1,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("wood loot zone"),
    symbol = ";",
}
content.add(definition)
end
