local ccb = require("ccb")
local content = ccb.content

-- Native zone-type definitions
do
local definition = content.ZoneType {
    id = "LOOT_AMMO",
    name = ccb.content.text("Loot: Ammo"),
    description = ccb.content.text("Destination for ammo."),
    display_field = "fd_ammo_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_ARMOR",
    name = ccb.content.text("Loot: Armor"),
    description = ccb.content.text("Destination for armor.  Does include filthy armor if such zone is not specified."),
    display_field = "fd_armor_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_ARTIFACTS",
    name = ccb.content.text("Loot: Artifacts"),
    description = ccb.content.text("Destination for artifacts."),
    display_field = "fd_artifacts_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_BIONICS",
    name = ccb.content.text("Loot: Bionics"),
    description = ccb.content.text("Destination for Compact Bionic Modules, a.k.a. CBMs."),
    display_field = "fd_bionics_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_BOOKS",
    name = ccb.content.text("Loot: Books"),
    description = ccb.content.text("Destination for books and magazines."),
    display_field = "fd_books_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CHEMICAL",
    name = ccb.content.text("Loot: Chemical"),
    description = ccb.content.text("Destination for chemicals."),
    display_field = "fd_chemical_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CLOTHING",
    name = ccb.content.text("Loot: Clothing"),
    description = ccb.content.text("Destination for clothing.  Does include filthy clothing if such zone is not specified."),
    display_field = "fd_clothing_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CONTAINERS",
    name = ccb.content.text("Loot: Containers"),
    description = ccb.content.text("Destination for empty containers."),
    display_field = "fd_containers_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CORPSE",
    name = ccb.content.text("Loot: Corpses"),
    description = ccb.content.text("Destination for corpses."),
    display_field = "fd_corpses_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CURRENCY",
    name = ccb.content.text("Loot: Currency"),
    description = ccb.content.text("Destination for currency."),
    display_field = "fd_currency_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_CUSTOM",
    name = ccb.content.text("Loot: Custom"),
    description = ccb.content.text("Destination for loot with a custom filter that you can modify."),
    display_field = "fd_custom_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_DEFAULT",
    name = ccb.content.text("Loot: Default"),
    description = ccb.content.text("Destination for any loot without a more specific zone defined."),
    display_field = "fd_default_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_DRINK",
    name = ccb.content.text("Loot: Drink"),
    description = ccb.content.text("Destination for drinks.  Does include perishable drinks if such zone is not specified."),
    display_field = "fd_drink_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_DRUGS",
    name = ccb.content.text("Loot: Drugs"),
    description = ccb.content.text("Destination for drugs and other medical items."),
    display_field = "fd_drugs_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_FARMOR",
    name = ccb.content.text("Loot: Filthy Armor"),
    description = ccb.content.text("Destination for filthy armor."),
    display_field = "fd_filthy_armor_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_FCLOTHING",
    name = ccb.content.text("Loot: Filthy Clothing"),
    description = ccb.content.text("Destination for filthy clothing."),
    display_field = "fd_filthy_clothing_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_FOOD",
    name = ccb.content.text("Loot: Food"),
    description = ccb.content.text("Destination for comestibles.  If more specific food zone is not defined, all food is moved here."),
    display_field = "fd_food_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_FUEL",
    name = ccb.content.text("Loot: Fuel"),
    description = ccb.content.text("Destination for gasoline, diesel, kerosene and other substances used as a fuel."),
    display_field = "fd_fuel_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_GUNS",
    name = ccb.content.text("Loot: Guns"),
    description = ccb.content.text("Destination for guns, bows and similar weapons."),
    display_field = "fd_guns_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_IGNORE",
    name = ccb.content.text("Loot: Ignore"),
    description = ccb.content.text("Items inside of this zone are ignored by \"sort out loot\" zone-action."),
    display_field = "fd_ignore_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_IGNORE_FAVORITES",
    name = ccb.content.text("Loot: Ignore Favorites"),
    description = ccb.content.text("Favorite items inside of this zone are ignored by \"sort out loot\" zone-action."),
    display_field = "fd_ignore_favorites_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_ITEM_GROUP",
    name = ccb.content.text("Loot: Item Group"),
    description = ccb.content.text("Destination for items from an item group."),
    display_field = "fd_item_group_loot_zone",
    can_be_personal = false,
    hidden = true,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_KEYS",
    name = ccb.content.text("Loot: Keys"),
    description = ccb.content.text("Destination for keys."),
    display_field = "fd_keys_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MAGAZINES",
    name = ccb.content.text("Loot: Magazines"),
    description = ccb.content.text("Destination for gun magazines."),
    display_field = "fd_magazines_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MANUALS",
    name = ccb.content.text("Loot: Manuals"),
    description = ccb.content.text("Destination for instructional books and magazines."),
    display_field = "fd_manuals_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MAPS",
    name = ccb.content.text("Loot: Maps"),
    description = ccb.content.text("Destination for maps."),
    display_field = "fd_maps_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MA_MANUALS",
    name = ccb.content.text("Loot: Martial arts manuals"),
    description = ccb.content.text("Destination for manuals for martial arts."),
    display_field = "fd_martial_arts_manuals_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MODS",
    name = ccb.content.text("Loot: Mods"),
    description = ccb.content.text("Destination for firearm modifications and similar items."),
    display_field = "fd_mods_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_MUTAGENS",
    name = ccb.content.text("Loot: Mutagens"),
    description = ccb.content.text("Destination for mutagens, serums, and purifiers."),
    display_field = "fd_mutagens_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_OTHER",
    name = ccb.content.text("Loot: Other"),
    description = ccb.content.text("Destination for other miscellaneous items."),
    display_field = "fd_other_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_PDRINK",
    name = ccb.content.text("Loot: Perishable Drink"),
    description = ccb.content.text("Destination for perishable drinks."),
    display_field = "fd_perishable_drink_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_PFOOD",
    name = ccb.content.text("Loot: Perishable Food"),
    description = ccb.content.text("Destination for perishable comestibles.  Does include perishable drinks if such zone is not specified."),
    display_field = "fd_perishable_food_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_SEEDS",
    name = ccb.content.text("Loot: Seeds"),
    description = ccb.content.text("Destination for seeds, stems and similar items."),
    display_field = "fd_seeds_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_SPARE_PARTS",
    name = ccb.content.text("Loot: Spare Parts"),
    description = ccb.content.text("Destination for spare parts."),
    display_field = "fd_spare_parts_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_TOOL_MAGAZINE",
    name = ccb.content.text("Loot: Tool Magazines"),
    description = ccb.content.text("Destination for tool magazines."),
    display_field = "fd_tool_magazines_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_TOOLS",
    name = ccb.content.text("Loot: Tools"),
    description = ccb.content.text("Destination for tools."),
    display_field = "fd_tools_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_TRAPS",
    name = ccb.content.text("Loot: Traps"),
    description = ccb.content.text("Destination for traps."),
    display_field = "fd_traps_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_UNSORTED",
    name = ccb.content.text("Loot: Unsorted"),
    description = ccb.content.text("Place to drop unsorted loot.  You can use \"sort out loot\" zone-action to sort items inside.  It can overlap with Loot zones of different types."),
    display_field = "fd_unsorted_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_VEHICLE_PARTS",
    name = ccb.content.text("Loot: Vehicle Parts"),
    description = ccb.content.text("Destination for vehicle parts."),
    display_field = "fd_vehicle_parts_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_WEAPONS",
    name = ccb.content.text("Loot: Weapons"),
    description = ccb.content.text("Destination for melee weapons."),
    display_field = "fd_weapons_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "LOOT_WOOD",
    name = ccb.content.text("Loot: Wood"),
    description = ccb.content.text("Destination for firewood and items that can be used as such."),
    display_field = "fd_wood_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "STRIP_CORPSES",
    name = ccb.content.text("Loot: Strip Corpses"),
    description = ccb.content.text("Corpses in this zone you don't otherwise sort will have everything taken off them and dropped on the same tile."),
    display_field = "fd_strip_corpses_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "UNLOAD_ALL",
    name = ccb.content.text("Loot: Unload Everything"),
    description = ccb.content.text("Any containers in this zone you don't otherwise sort will have their contents dumped out and placed on the same tile.  This includes corpses, magazines, and magazine wells."),
    display_field = "fd_unload_everything_loot_zone",
    can_be_personal = true,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "AUTO_DRINK",
    name = ccb.content.text("Auto Drink"),
    description = ccb.content.text("Items in this zone will be automatically consumed during a long activity if you get thirsty."),
    display_field = "fd_auto_drink_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "AUTO_EAT",
    name = ccb.content.text("Auto Eat"),
    description = ccb.content.text("Items in this zone will be automatically eaten during a long activity if you get hungry."),
    display_field = "fd_auto_eat_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "CAMP_FOOD",
    name = ccb.content.text("Basecamp: Food"),
    description = ccb.content.text("Items in this zone will be added to a basecamp's food supply in the Distribute Food mission."),
    display_field = "fd_basecamp_food_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "CAMP_STORAGE",
    name = ccb.content.text("Basecamp: Storage"),
    description = ccb.content.text("Items in this zone will be added to a basecamp's inventory for use by its workers."),
    display_field = "fd_basecamp_storage_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "CHOP_TREES",
    name = ccb.content.text("Work: Chop Trees"),
    description = ccb.content.text("Designate a zone to chop down trees."),
    display_field = "fd_chop_trees_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "CONSTRUCTION_BLUEPRINT",
    name = ccb.content.text("Work: Construction Blueprint"),
    description = ccb.content.text("Designate a zone to build a construction on each tile."),
    display_field = "fd_construction_blueprint_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "DISASSEMBLE",
    name = ccb.content.text("Work: Disassembly"),
    description = ccb.content.text("Items in this zone are marked for disassembly."),
    display_field = "fd_disassembly_work_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "FARM_PLOT",
    name = ccb.content.text("Work: Farm Plot"),
    description = ccb.content.text("Designate a farm zone for tilling, planting, fertilizing, and harvesting a seed type."),
    display_field = "fd_farm_plot_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "FISHING_SPOT",
    name = ccb.content.text("Work: Fishing Spot"),
    description = ccb.content.text("Designate a zone to fish from."),
    display_field = "fd_fishing_spot_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "MINING",
    name = ccb.content.text("Work: Mine Terrain"),
    description = ccb.content.text("Designate a zone to mine."),
    display_field = "fd_mine_terrain_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "MOPPING",
    name = ccb.content.text("Work: Mop Tile"),
    description = ccb.content.text("Designate a zone to mop tiles clean."),
    display_field = "fd_mop_tile_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NO_AUTO_PICKUP",
    name = ccb.content.text("No Auto Pickup"),
    description = ccb.content.text("You won't auto-pickup items inside the zone."),
    display_field = "fd_no_auto_pickup_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NO_NPC_PICKUP",
    name = ccb.content.text("No NPC Pickup"),
    description = ccb.content.text("Friendly NPCs don't pickup items inside the zone."),
    display_field = "fd_no_npc_pickup_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NPC_NO_INVESTIGATE",
    name = ccb.content.text("NPC Ignore Sounds"),
    description = ccb.content.text("Friendly NPCs won't investigate unseen sounds coming from this zone."),
    display_field = "fd_npc_ignore_sounds_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NPC_INVESTIGATE_ONLY",
    name = ccb.content.text("NPC Investigation Area"),
    description = ccb.content.text("Friendly NPCs will investigate unseen sounds only if they come from inside this area."),
    display_field = "fd_npc_investigation_area_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NPC_NO_GO",
    name = ccb.content.text("NPC No-Go Area"),
    description = ccb.content.text("NPCs of this faction will not seek needs-driven targets inside this zone."),
    display_field = "fd_npc_no_go_zone",
    can_be_personal = false,
    hidden = true,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "NPC_RETREAT",
    name = ccb.content.text("NPC Retreat"),
    description = ccb.content.text("When fleeing, friendly NPCs will attempt to retreat toward this zone if it is within 60 tiles."),
    display_field = "fd_npc_retreat_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "ZONE_START_POINT",
    name = ccb.content.text("Start Point"),
    description = ccb.content.text("A prioritized spawn point."),
    display_field = "fd_start_point_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "SOURCE_FIREWOOD",
    name = ccb.content.text("Source: Firewood"),
    description = ccb.content.text("Source for firewood or other flammable materials in this zone may be used to automatically refuel fires.  This will be done to maintain light during long-running tasks such as crafting, reading or waiting."),
    display_field = "fd_firewood_source_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "VEHICLE_DECONSTRUCT",
    name = ccb.content.text("Work: Vehicle Deconstruct"),
    description = ccb.content.text("Any vehicles in this zone are marked for deconstruction."),
    display_field = "fd_vehicle_deconstruct_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "VEHICLE_SERVICE_OUTPUT",
    name = ccb.content.text("Vehicle Service Output"),
    description = ccb.content.text("NPC vehicle services place removed parts and related items in this zone."),
    display_field = "fd_vehicle_service_output_zone",
    can_be_personal = false,
    hidden = true,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "VEHICLE_PATROL",
    name = ccb.content.text("Vehicle Patrol Zone"),
    description = ccb.content.text("Vehicles with an autopilot will patrol in this zone."),
    display_field = "fd_vehicle_patrol_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "VEHICLE_REPAIR",
    name = ccb.content.text("Work: Vehicle Repair"),
    description = ccb.content.text("Any vehicles in this zone are marked for repair work."),
    display_field = "fd_vehicle_repair_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
do
local definition = content.ZoneType {
    id = "STUDY_ZONE",
    name = ccb.content.text("Work: Study"),
    description = ccb.content.text("NPCs will find and read books from this zone until no more books can be learned from."),
    display_field = "fd_study_zone",
    can_be_personal = false,
    hidden = false,
}
content.add(definition)
end
