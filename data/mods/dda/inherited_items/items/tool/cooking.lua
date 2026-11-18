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

do
    -- each charcoal is 5mL so it is 900ml total of charcoal (187g charcoal, enough to purify one gallon)
    -- https://blackblum.com/pages/charcoal-water-filter
    -- 50g of charcoal for 1 liter of water = 12.5g of charcoal per u of water.  1u charcoal weighs 1.04g, so making it 12:1
    local item = content.Item {
        id = "char_purifier",
        name = ccb.content.plural_text("charcoal water purifier", "charcoal water purifiers"),
        description = ccb.content.text("Using this item on a container full of water will purify the water using layered charcoal.  Once the charcoal has purified enough water, it will become unusable and can be disassembled and recycled.  Water taken from uncertain sources like a river may be dirty."),
        mass_milligrams = 1820000,
        volume_ml = 3750,
        longest_side_mm = 300,
        price_cents = 4000,
        price_postapoc_cents = 2000,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WATER_PURIFIER")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 12 }
    item:magazine_pocket { ammo_capacities = { charcoal = 180 } }
    content.add(item)
end

do
    -- each charcoal is 5mL so it is 3600mL total of charcoal (750g charcoal, enough to purify 4 gallons)
    -- https://blackblum.com/pages/charcoal-water-filter
    -- 50g of charcoal for 1 liter of water = 12.5g of charcoal per u of water.  1u charcoal weighs 1.04g, so making it 12:1
    local item = content.Item {
        id = "char_purifier_clay",
        name = ccb.content.plural_text("large charcoal water purifier", "large charcoal water purifiers"),
        looks_like = "clay_hydria",
        description = ccb.content.text("Using this item on a container full of water will purify the water using layered charcoal.  Once the charcoal has purified enough water, it will become unusable and can be disassembled and recycled.  Water taken from uncertain sources like a river may be dirty."),
        mass_milligrams = 2300000,
        volume_ml = 15004,
        longest_side_mm = 450,
        price_cents = 4000,
        price_postapoc_cents = 2000,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("clay", 1)
    item:clear_use_actions()
    item:native_use("WATER_PURIFIER")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 12 }
    item:magazine_pocket { ammo_capacities = { charcoal = 720 } }
    content.add(item)
end

do
    -- contains up to 2 liters of charcoal. Or the same amount of coal by weight, 1u coal weighs about as much as 1u of charcoal and has the same energy although it is 5x smaller.
    local item = content.Item {
        id = "charcoal_cooker",
        name = ccb.content.plural_text("coal/charcoal cooker", "coal/charcoal cookers"),
        description = ccb.content.text("A little metal tank for holding coal or charcoal, with a pilot light attached and a pipe to vent toxic coal fumes.  You could use it for cooking food."),
        mass_milligrams = 450000,
        volume_ml = 2000,
        longest_side_mm = 300,
        price_cents = 5000,
        price_postapoc_cents = 250,
        melee_to_hit = -5,
        symbol = ";",
        color = "green",
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
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 5, ammo_types = { "charcoal", "coal" } }
    item:magazine_pocket { ammo_capacities = { charcoal = 400, coal = 2000 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "esbit_stove",
        name = ccb.content.plural_text("hexamine stove", "hexamine stoves"),
        description = ccb.content.text("A lightweight, folding stove designed to use small hexamine tablets for cooking.  Also known as an Esbit stove."),
        mass_milligrams = 92000,
        volume_ml = 147,
        price_cents = 2000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:tool { charges_per_use = 2, ammo_types = { "esbit" } }
    item:magazine_pocket { ammo_capacities = { esbit = 100 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasoline_cooker",
        name = ccb.content.plural_text("gasoline cooker", "gasoline cookers"),
        description = ccb.content.text("A simple heater powered by gasoline.  It is designed for cooking food."),
        mass_milligrams = 800000,
        volume_ml = 1250,
        price_cents = 5000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
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
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 2, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 500 }, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "oil_cooker",
        name = ccb.content.plural_text("kerosene cooker", "kerosene cookers"),
        description = ccb.content.text("A simple heater powered by kerosene.  It is designed for cooking food."),
        mass_milligrams = 2264000,
        volume_ml = 1250,
        price_cents = 5000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_use_actions()
    item:native_use("HOTPLATE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 2, ammo_types = { "lamp_oil" } }
    item:magazine_pocket { ammo_capacities = { lamp_oil = 800 }, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "oil_press_primitive",
        name = ccb.content.plural_text("oil-powered manual oil press", "oil-powered manual oil presses"),
        description = ccb.content.text("A barrel with a large screw press for creating vegetable oil.  A kerosene cooker heats the raw material to increase extraction efficiency."),
        mass_milligrams = 12000000,
        volume_ml = 20000,
        looks_like = "oil_press_manual",
        price_cents = 12000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool { ammo_types = { "lamp_oil" } }
    item:magazine_pocket { ammo_capacities = { lamp_oil = 800 }, watertight = true, rigid = true }
    content.add(item)
end

do
    -- Should be 20 but currently recipes do not utilize this value
    local item = content.Item {
        id = "popcan_stove",
        name = ccb.content.plural_text("soda can stove kit", "soda can stove kits"),
        description = ccb.content.text("An ultra-light alcohol-burning stove with a simmer ring, crafted by hand from a couple of aluminum soda cans.  It comes with a 500 mL plastic bottle to hold concentrated alcohol fuel."),
        mass_milligrams = 45000,
        volume_ml = 750,
        price_cents = 250,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_use_actions()
    item:native_use("HOTPLATE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 3, ammo_types = { "conc_alcohol" } }
    item:magazine_pocket { ammo_capacities = { conc_alcohol = 500 }, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "coffeemaker",
        name = ccb.content.plural_text("coffeemaker", "coffeemakers"),
        description = ccb.content.text("A heating element with a pot and a frame for holding coffee or other powders.  You can use it to make coffee, or other drinks if you so choose."),
        mass_milligrams = 1000000,
        volume_ml = 7000,
        longest_side_mm = 250,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -5,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ALLOWS_REMOTE_USE")
    item:quality("BOIL", 1)
    item:quality("HOTPLATE", 1)
    item:container_pocket { max_volume_ml = 2000, max_weight_milligrams = 2400000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:link_cable { cable_length = 2, charge_milliwatts = 1000000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 25, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "dehydrator",
        name = ccb.content.plural_text("food dehydrator", "food dehydrators"),
        description = ccb.content.text("An electric food dehydrator, invaluable in preserving food.  Can be connected to the electric grid using cord."),
        mass_milligrams = 2500000,
        volume_ml = 13000,
        price_cents = 6000,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "blue",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 600000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:fault_group("electronic_general", {  })
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "food_processor",
        category = "tools",
        name = ccb.content.plural_text("food processor", "food processors"),
        description = ccb.content.text("A kitchen appliance capable of slicing, chopping, shredding, grinding, pureeing, and mixing."),
        mass_milligrams = 3500000,
        volume_ml = 20000,
        longest_side_mm = 400,
        price_cents = 12000,
        price_postapoc_cents = 700,
        melee_to_hit = -4,
        symbol = "%",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 450000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:fault_group("electronic_general", {  })
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hotplate",
        name = ccb.content.plural_text("hotplate", "hotplates"),
        description = ccb.content.text("A small heating element on a stand, powered by your electric grid.  It is indispensable for cooking and chemistry.  Try not to burn yourself."),
        mass_milligrams = 795000,
        volume_ml = 2000,
        longest_side_mm = 350,
        price_cents = 2500,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ALLOWS_REMOTE_USE")
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:link_cable { cable_length = 3, charge_milliwatts = 1000000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 35, ammo_types = { "battery" } }
    content.add(item)
end

do
    -- technically this should only work with iron/steel ferromagnetic cookware, as most copper/aluminum and ceramic stuff wouldn't work.  No way to do that easily though.
    local item = content.Item {
        id = "hotplate_induction",
        name = ccb.content.plural_text("induction hotplate", "induction hotplates"),
        description = ccb.content.text("A high end hotplate that utilizes magnetic induction coils to heat ferrous cookware directly.  It is far more efficient than a standard hotplate."),
        mass_milligrams = 862000,
        volume_ml = 2000,
        longest_side_mm = 350,
        price_cents = 60000,
        price_postapoc_cents = 1000,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("NO_SALVAGE")
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:link_cable { cable_length = 3, charge_milliwatts = 1500000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 25, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_sealer",
        name = ccb.content.plural_text("makeshift vacuum sealer", "makeshift vacuum sealers"),
        description = ccb.content.text("A homemade heat sealer unit with an air pump.  It's used for vacuum packing food to preserve it."),
        mass_milligrams = 2000000,
        volume_ml = 5000,
        longest_side_mm = 350,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "white",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:link_cable { cable_length = 4, charge_milliwatts = 55000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "oil_press_manual",
        name = ccb.content.plural_text("manual oil press", "manual oil presses"),
        description = ccb.content.text("A hand-cranked press for creating vegetable oil.  A hotplate heats the raw material to increase extraction efficiency."),
        mass_milligrams = 2300000,
        volume_ml = 1560,
        longest_side_mm = 200,
        price_cents = 12000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 1000000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    -- size, weight, pricing, power, etc. was based on https://www.amazon.com/dp/B004UBMRKG
    local item = content.Item {
        id = "snow_machine_home",
        name = ccb.content.plural_text("home snow machine", "home snow machines"),
        description = ccb.content.text("A snow machine, which freezes water and shreds it into \"snow\", designed to be used from the comfort of your own home!  Useful for making snow cones."),
        mass_milligrams = 1360000,
        volume_ml = 12585,
        longest_side_mm = 300,
        price_cents = 5000,
        price_postapoc_cents = 150,
        melee_to_hit = -5,
        symbol = ";",
        color = "white",
        charged_qualities = { { id = "SNOW_MAKING", level = 1 } },
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:link_cable {
        cable_length = 3,
        ammo_scale = 0,
        charge_milliwatts = 55000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 8, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "vac_sealer",
        name = ccb.content.plural_text("vacuum sealer", "vacuum sealers"),
        description = ccb.content.text("A portable heat sealer unit with an air pump.  It's used for vacuum packing food to preserve it."),
        mass_milligrams = 1770000,
        volume_ml = 4100,
        longest_side_mm = 350,
        price_cents = 2500,
        price_postapoc_cents = 2000,
        melee_to_hit = -4,
        symbol = ";",
        color = "white",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 110000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    -- based off RO filter. https://www.netsolwater.com/how-much-energy-does-an-ro-system-use.php claims RO uses 0.03KWH for 2 liters of water/day giving ~14kJ per 0.25L unit of water
    local item = content.Item {
        id = "water_purifier",
        name = ccb.content.plural_text("water purifier", "water purifiers"),
        description = ccb.content.text("A battery-powered device designed to purify drinking water.  Using this item on a container full of water will purify the contents.  It could be useful for water taken from uncertain sources like a river, as it may be non-potable."),
        mass_milligrams = 1360000,
        volume_ml = 3000,
        price_cents = 10000,
        price_postapoc_cents = 1500,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_blue",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("WATER_PURIFIER")
    item:link_cable { cable_length = 2, charge_milliwatts = 30000 }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 14, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "microwave",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("microwave", "microwaves"),
        description = ccb.content.text("A home microwave, has probably seen its share of baked beans."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 11339000,
        volume_ml = 9000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:link_cable { cable_length = 2, charge_milliwatts = 1800000 }
    item:quality("COOK", 1)
    item:quality("OVEN", 1)
    item:quality("HOTPLATE", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("ALLOWS_REMOTE_USE")
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 25, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "toaster",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("toaster", "toasters"),
        description = ccb.content.text("A small two-slice toaster, can be used to toast toast and few other things."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 725000,
        volume_ml = 750,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 1400000 }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ALLOWS_REMOTE_USE")
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end
