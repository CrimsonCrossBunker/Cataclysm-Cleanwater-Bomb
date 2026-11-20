local ccb = require("ccb")
local content = ccb.content

-- Native item categories
do
local definition = content.ItemCategory {
    id = "e_files",
    header = ccb.content.text("Files"),
    noun = ccb.content.text("file", "item_category"),
    sort_rank = -25,
    spawn_rate = 1.0,
    zone = "LOOT_OTHER",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "software",
    header = ccb.content.text("Software"),
    noun = ccb.content.text("software", "item_category"),
    sort_rank = -24,
    spawn_rate = 1.0,
    zone = "LOOT_OTHER",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "guns",
    header = ccb.content.text("Guns"),
    noun = ccb.content.text("gun", "item_category"),
    sort_rank = -23,
    spawn_rate = 1.0,
    zone = "LOOT_GUNS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "magazines",
    header = ccb.content.text("Magazines"),
    noun = ccb.content.text("magazine", "item_category"),
    sort_rank = -22,
    spawn_rate = 1.0,
    zone = "LOOT_MAGAZINES",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "ammo",
    header = ccb.content.text("Ammo"),
    noun = ccb.content.text("ammo", "item_category"),
    sort_rank = -21,
    spawn_rate = 1.0,
    zone = "LOOT_AMMO",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "weapons",
    header = ccb.content.text("Weapons"),
    noun = ccb.content.text("weapon", "item_category"),
    sort_rank = -20,
    spawn_rate = 1.0,
    zone = "LOOT_WEAPONS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "tools",
    header = ccb.content.text("Tools"),
    noun = ccb.content.text("tool", "item_category"),
    sort_rank = -19,
    spawn_rate = 1.0,
    zone = "LOOT_TOOLS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "clothing",
    header = ccb.content.text("Clothing"),
    noun = ccb.content.text("clothing", "item_category"),
    sort_rank = 19,
    spawn_rate = 1.0,
    zone = "LOOT_CLOTHING",
}
definition:priority_zone("LOOT_FCLOTHING", {  }, true)
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "food",
    header = ccb.content.text("Food"),
    noun = ccb.content.text("food", "item_category"),
    sort_rank = -18,
    spawn_rate = 1.0,
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "drugs",
    header = ccb.content.text("Drugs"),
    noun = ccb.content.text("drug", "item_category"),
    sort_rank = -17,
    spawn_rate = 1.0,
    zone = "LOOT_DRUGS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "manuals",
    header = ccb.content.text("Manuals"),
    noun = ccb.content.text("manual", "item_category"),
    sort_rank = -16,
    spawn_rate = 1.0,
    zone = "LOOT_MANUALS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "books",
    header = ccb.content.text("Books"),
    noun = ccb.content.text("book", "item_category"),
    sort_rank = -15,
    spawn_rate = 1.0,
    zone = "LOOT_BOOKS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "maps",
    header = ccb.content.text("Maps"),
    noun = ccb.content.text("map", "item_category"),
    sort_rank = -14,
    spawn_rate = 1.0,
    zone = "LOOT_MAPS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "mods",
    header = ccb.content.text("Mods"),
    noun = ccb.content.text("mod", "item_category"),
    sort_rank = -13,
    spawn_rate = 1.0,
    zone = "LOOT_MODS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "mutagen",
    header = ccb.content.text("Mutagens"),
    noun = ccb.content.text("mutagen", "item_category"),
    sort_rank = -12,
    spawn_rate = 1.0,
    zone = "LOOT_MUTAGENS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "bionics",
    header = ccb.content.text("Bionics"),
    noun = ccb.content.text("bionic", "item_category"),
    sort_rank = -12,
    spawn_rate = 1.0,
    zone = "LOOT_BIONICS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "currency",
    header = ccb.content.text("Currency"),
    noun = ccb.content.text("currency", "item_category"),
    sort_rank = -11,
    spawn_rate = 1.0,
    zone = "LOOT_CURRENCY",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "veh_parts",
    header = ccb.content.text("Vehicle parts"),
    noun = ccb.content.text("vehicle part", "item_category"),
    sort_rank = -10,
    spawn_rate = 1.0,
    zone = "LOOT_VEHICLE_PARTS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "other",
    header = ccb.content.text("Other"),
    noun = ccb.content.text("other", "item_category"),
    sort_rank = -9,
    spawn_rate = 1.0,
    zone = "LOOT_OTHER",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "fuel",
    header = ccb.content.text("Fuel"),
    noun = ccb.content.text("fuel", "item_category"),
    sort_rank = -8,
    spawn_rate = 1.0,
    zone = "LOOT_FUEL",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "seeds",
    header = ccb.content.text("Seeds"),
    noun = ccb.content.text("seed", "item_category"),
    sort_rank = -7,
    spawn_rate = 1.0,
    zone = "LOOT_SEEDS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "ma_manuals",
    header = ccb.content.text("Martial arts manuals"),
    noun = ccb.content.text("martial arts manual", "item_category"),
    sort_rank = -6,
    spawn_rate = 1.0,
    zone = "LOOT_MA_MANUALS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "traps",
    header = ccb.content.text("Traps"),
    noun = ccb.content.text("trap", "item_category"),
    sort_rank = -5,
    spawn_rate = 1.0,
    zone = "LOOT_TRAPS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "chems",
    header = ccb.content.text("Chemical stuff"),
    noun = ccb.content.text("chemical", "item_category"),
    sort_rank = 5,
    spawn_rate = 1.0,
    zone = "LOOT_CHEMICAL",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "spare_parts",
    header = ccb.content.text("Spare parts"),
    noun = ccb.content.text("spare part", "item_category"),
    sort_rank = 8,
    spawn_rate = 1.0,
    zone = "LOOT_SPARE_PARTS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "container",
    header = ccb.content.text("Containers"),
    noun = ccb.content.text("container", "item_category"),
    sort_rank = 9,
    spawn_rate = 1.0,
    zone = "LOOT_CONTAINERS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "artifacts",
    header = ccb.content.text("Artifacts"),
    noun = ccb.content.text("artifact", "item_category"),
    sort_rank = 10,
    spawn_rate = 1.0,
    zone = "LOOT_ARTIFACTS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "keys",
    header = ccb.content.text("Keys"),
    noun = ccb.content.text("key", "item_category"),
    sort_rank = 11,
    spawn_rate = 1.0,
    zone = "LOOT_KEYS",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "corpses",
    header = ccb.content.text("Corpses"),
    noun = ccb.content.text("corpse", "item_category"),
    sort_rank = 12,
    spawn_rate = 1.0,
    zone = "LOOT_CORPSES",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "tool_magazine",
    header = ccb.content.text("Tool magazines"),
    noun = ccb.content.text("tool magazine", "item_category"),
    sort_rank = -15,
    spawn_rate = 1.0,
    zone = "LOOT_TOOL_MAGAZINE",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "armor",
    header = ccb.content.text("Armor"),
    noun = ccb.content.text("armor", "item_category"),
    sort_rank = 20,
    spawn_rate = 1.0,
    zone = "LOOT_ARMOR",
}
definition:priority_zone("LOOT_FARMOR", {  }, true)
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "exosuit",
    header = ccb.content.text("Exosuit"),
    noun = ccb.content.text("exosuit", "item_category"),
    sort_rank = 20,
    spawn_rate = 1.0,
    zone = "LOOT_EXOSUIT",
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "ITEMS_WORN",
    header = ccb.content.text("Items worn"),
    noun = ccb.content.text("item worn", "item_category"),
    sort_rank = -100,
    spawn_rate = 1.0,
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "INTEGRATED",
    header = ccb.content.text("Integrated"),
    noun = ccb.content.text("integrated", "item_category"),
    sort_rank = -99,
    spawn_rate = 1.0,
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "BIONIC_FUEL_SOURCE",
    header = ccb.content.text("Bionic fuel source"),
    noun = ccb.content.text("bionic fuel source", "item_category"),
    sort_rank = -98,
    spawn_rate = 1.0,
}
content.add(definition)
end
do
local definition = content.ItemCategory {
    id = "WEAPON_HELD",
    header = ccb.content.text("Weapon held"),
    noun = ccb.content.text("weapon held", "item_category"),
    sort_rank = -200,
    spawn_rate = 1.0,
}
content.add(definition)
end
