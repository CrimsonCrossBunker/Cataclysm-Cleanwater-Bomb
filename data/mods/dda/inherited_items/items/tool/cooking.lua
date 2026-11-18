local ccb = require("ccb")
local content = ccb.content

do
    -- butcher knives and carving knives are between 30-40cm.
    local item = content.Item {
        id = "butchering_kit",
        name = ccb.content.plural_text("butchering kit", "butchering kits"),
        category = "tools",
        description = ccb.content.text("A kit containing all the specialized knives you need to debone, skin, and prepare cuts of meat from an animal."),
        copy_from = "base_kitchen_knife",
        looks_like = "knife_huge",
        mass_milligrams = 1170000,
        volume_ml = 800,
        longest_side_mm = 400,
        price_cents = 8000,
        price_postapoc_cents = 150,
        replace_qualities = true,
    }
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 37)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "screw_press",
        name = ccb.content.plural_text("screw press", "screw presses"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 70000000,
        volume_ml = 100000,
        price_cents = 20000,
        price_postapoc_cents = 100,
        symbol = "T",
        color = "red",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    -- contains up to 10 liters of charcoal. Or the same amount of coal by weight, 1u coal weighs about as much as 1u of charcoal and has the same energy although it is 5x smaller.
    local item = content.Item {
        id = "char_smoker",
        name = ccb.content.plural_text("charcoal smoker", "charcoal smokers"),
        description = ccb.content.text("A portable charcoal smoker.  Good for weekend barbecuing and preserving meat with smoke.  Cannot be used with coal; the toxic fumes would ruin the meat."),
        mass_milligrams = 4000000,
        volume_ml = 20000,
        longest_side_mm = 600,
        price_cents = 10000,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:ammo_pocket("charcoal", 2000)
    item:tool { charges_per_use = 5, ammo_types = { "charcoal" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "heatpack",
        name = ccb.content.plural_text("heat pack", "heat packs"),
        description = ccb.content.text("A chemical heat pack, used to treat sports injuries and heat food.  It is usable only once."),
        mass_milligrams = 36000,
        volume_ml = 128,
        price_cents = 100,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("HEATPACK")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "heatpack_used",
        category = "other",
        name = ccb.content.plural_text("used heat pack", "used heat packs"),
        description = ccb.content.text("A chemical heat pack, used to treat sports injuries and heat food.  This one has been used up and is chemically inert, rendering it useless."),
        mass_milligrams = 36000,
        volume_ml = 128,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B01743BX1A
    local item = content.Item {
        id = "mess_kit",
        name = ccb.content.plural_text("mess kit", "mess kits"),
        description = ccb.content.text("A self-contained camping mess kit, containing everything you might need for wilderness cooking."),
        mass_milligrams = 520000,
        volume_ml = 2100,
        longest_side_mm = 150,
        price_cents = 3000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("CHEM", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:container_pocket { max_volume_ml = 1000, max_weight_milligrams = 2000000, watertight = true, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mortar_pestle",
        ascii_picture = "mortar_pestle",
        name = ccb.content.plural_text("mortar and pestle", "mortars and pestles"),
        description = ccb.content.text("A simple combination of a small grindstone and a bowl-shaped stone.  Used for grinding grain, but time-consuming compared to more complex methods."),
        mass_milligrams = 1632000,
        volume_ml = 1000,
        longest_side_mm = 120,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ":",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("FINE_GRIND", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rock_quern",
        name = ccb.content.plural_text("stone quern", "stone querns"),
        description = ccb.content.text("A simple hand-powered stone quern with a wooden handle, for grinding grain."),
        mass_milligrams = 31536000,
        volume_ml = 12000,
        longest_side_mm = 300,
        price_cents = 100,
        melee_to_hit = -5,
        symbol = ":",
        color = "light_gray",
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "still",
        name = ccb.content.plural_text("still", "stills"),
        description = ccb.content.text("A large still, useful for creating distillations of alcohol and other, more curious substances.  Features a slot for a thermometer."),
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 30000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = "L",
        color = "white",
        replace_qualities = true,
    }
    item:material("copper", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("DISTILL", 2)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    -- Slow sand biofilter: https://wwwnc.cdc.gov/travel/yellowbook/2024/preparing/water-disinfection#:~:text=Figure%202%2D02.%20Emergency%20gravel%20and%20sand%20filter
    -- Weight = 8 kg gravel + 20 kg sand + 815 g bucket + a bit extra for mesh and any residual water
    local item = content.Item {
        id = "water_filter_sand",
        name = ccb.content.plural_text("slow-sand water filter", "slow-sand water filters"),
        description = ccb.content.text("An improvised water filter made from a plastic bucket filled with a layer of sand and a layer of gravel.  It can be used to remove particulates and some pathogens from water, but it is not 100% effective."),
        mass_milligrams = 29800000,
        volume_ml = 21000,
        price_cents = 1000,
        price_postapoc_cents = 150,
        symbol = ";",
        color = "light_blue",
    }
    item:material("sand", 29)
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_pressure_cooker",
        name = ccb.content.plural_text("makeshift pressure cooker", "makeshift pressure cookers"),
        description = ccb.content.text("A large pot with 20 gauge walls and a thick aluminum bottom, modified to serve as a bulky but passable pressure cooker."),
        copy_from = "stock_pot",
        looks_like = "stock_pot",
        color = "light_gray",
        mass_milligrams = 2590000,
        volume_ml = 12800,
        longest_side_mm = 300,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 12000,
        max_weight_milligrams = 12000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crystallizing_sugar_active",
        symbol = "*",
        color = "white",
        category = "food",
        name = ccb.content.plural_text("crystallizing sugar", "crystallizing sugars"),
        description = ccb.content.text("Sweet, sweet sugar in the process of crystallizing.  It needs two weeks to form solid crystals."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 10000,
        volume_ml = 10,
        countdown_turns = 1209600,
    }
    item:material("sugar", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("WATER_DISSOLVE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "sugar" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_honing_rod",
        ascii_picture = "honing_rod",
        name = ccb.content.plural_text("honing rod", "honing rods"),
        description = ccb.content.text("A steel rod with fine grit used to hone the edge of knives."),
        mass_milligrams = 76000,
        volume_ml = 250,
        longest_side_mm = 300,
        price_cents = 1500,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("GRIND", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_sharpener_handheld",
        ascii_picture = "knife_sharpener_handheld",
        name = ccb.content.plural_text("handheld knife sharpener", "handheld knife sharpeners"),
        description = ccb.content.text("A tool with slots of grits for sharpening knives."),
        mass_milligrams = 180000,
        volume_ml = 150,
        longest_side_mm = 200,
        price_cents = 1800,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("GRIND", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
