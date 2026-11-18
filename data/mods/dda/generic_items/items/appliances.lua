local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "stationary_water_purifier",
        looks_like = "f_water_purifier",
        symbol = "W",
        description = ccb.content.text("A device that effectively sterilizes water, but it doesn't take batteries.  You'll need to connect it to a power source."),
        color = "dark_gray_white",
        name = ccb.content.plural_text("disconnected large water purifier", "disconnected large water purifiers"),
        longest_side_mm = 500,
        volume_ml = 50000,
        mass_milligrams = 20000000,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "arcade_machine",
        looks_like = "f_arcade_machine",
        symbol = "6",
        description = ccb.content.text("A bulky upright arcade cabinet, brightly painted and slightly worn with age.  Ready to be plugged in and played."),
        color = "red",
        name = ccb.content.plural_text("disconnected arcade machine", "disconnected arcade machines"),
        longest_side_mm = 2000,
        volume_ml = 290000,
        mass_milligrams = 77000000,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "arc_furnace",
        looks_like = "f_arcfurnace_empty",
        symbol = "U",
        description = ccb.content.text("An arc furnace designed to burn a powdery mix of coke and limestone to create calcium carbide.  Needs to be placed and plugged into a power source."),
        color = "blue",
        name = ccb.content.plural_text("disconnected arc furnace", "disconnected arc furnaces"),
        longest_side_mm = 2000,
        volume_ml = 400000,
        mass_milligrams = 1024000000,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    -- Based off JET J-2500 Drill Press
    local item = content.Item {
        id = "drill_press",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A powerful drill mounted on a slide that lets it drop precisely down.  Useful in all kinds of projects, from industrial fabrication to home woodworking.  Needs to be placed and plugged into a power source."),
        color = "yellow_red",
        name = ccb.content.plural_text("disconnected drill press", "disconnected drill presses"),
        longest_side_mm = 1370,
        volume_ml = 200000,
        mass_milligrams = 114000000,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    -- Based off Big Blu 65 MAX & Anyang ST 25 Power Hammer
    local item = content.Item {
        id = "power_hammer",
        looks_like = "f_drophammer",
        symbol = "7",
        description = ccb.content.text("A self-contained pneumatic power hammer using compressed air from an integrated compressor to strike repeatedly with great force.  Used for efficiently shaping and working metal.  Needs to be placed and plugged into a power source."),
        color = "light_blue",
        name = ccb.content.plural_text("disconnected power hammer", "disconnected power hammers"),
        longest_side_mm = 1700,
        volume_ml = 1000000,
        mass_milligrams = 1100000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off of Evenheat Knife Oven - KF 49.5 Extreme Depth
    local item = content.Item {
        id = "steel_kiln",
        looks_like = "f_kiln",
        name = ccb.content.plural_text("disconnected tempering kiln", "disconnected tempering kilns"),
        description = ccb.content.text("A very long electric kiln made for heat treating metal.  Unlike a forge, it can't get extremely hot, but its temperature is completely programmable.  Needs to be placed and plugged into a power source."),
        symbol = "8",
        color = "light_blue",
        mass_milligrams = 110000000,
        volume_ml = 300000,
        longest_side_mm = 1500,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off Powermatic PM1000 Table Saw
    local item = content.Item {
        id = "tablesaw",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A rotating sawblade set into a large, flat table.  Used for making straight, measured cuts, it's a key tool in any carpenter's arsenal.  Needs to be placed and plugged into a power source."),
        color = "yellow_red",
        name = ccb.content.plural_text("disconnected table saw", "disconnected table saws"),
        longest_side_mm = 1350,
        volume_ml = 500000,
        mass_milligrams = 130000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off JET JWBS-18-3 Woodworking Band Saw
    local item = content.Item {
        id = "bandsaw",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A ribbonlike sawblade runs in a single direction in this tool, allowing precise cuts at almost any angle.  Needs to be placed and plugged into a power source."),
        color = "yellow_cyan",
        name = ccb.content.plural_text("disconnected band saw", "disconnected band saws"),
        longest_side_mm = 2160,
        volume_ml = 500000,
        mass_milligrams = 225000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off Powermatic TS29 Shaper.  TODO: When support for multi-tile appliances is added, this can stretch two tiles
    local item = content.Item {
        id = "router",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("This table has an inset router, a rotating motor with an exchangeable blade head for cutting specific profiles and grooves.  Needs to be placed and plugged into a power source."),
        color = "yellow_green",
        name = ccb.content.plural_text("disconnected router table", "disconnected router tables"),
        longest_side_mm = 1470,
        volume_ml = 500000,
        mass_milligrams = 500000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off JET JWP-15BHH Woodworking Planer
    local item = content.Item {
        id = "planer",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A hefty tool that will take in a board and cut it smooth and flat to a specific width, particularly great if working with raw lumber stock, but also good just for shaving wood down to size.  Needs to be placed and plugged into a power source."),
        color = "yellow_white",
        name = ccb.content.plural_text("disconnected planer", "disconnected planers"),
        longest_side_mm = 1210,
        volume_ml = 500000,
        mass_milligrams = 130000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off Powermatic PJ-882 Jointer.  TODO: When support for multi-tile appliances is added, this can stretch two tiles
    local item = content.Item {
        id = "jointer",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A table-shaped tool with a rotating blade that will cut down, smooth out, and square off a board to make it nice and smooth.  Needs to be placed and plugged into a power source."),
        color = "yellow_magenta",
        name = ccb.content.plural_text("disconnected jointer", "disconnected jointers"),
        longest_side_mm = 2200,
        volume_ml = 260000,
        mass_milligrams = 300000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off Daytona DSP20T Hydraulic Shop Press
    local item = content.Item {
        id = "hydraulic_press",
        looks_like = "f_hydraulic_press",
        symbol = "7",
        description = ccb.content.text("If you really want to squash something a lot, this is exactly the right industrial tool for you.  Needs to be placed and plugged into a power source."),
        color = "black_red",
        name = ccb.content.plural_text("disconnected hydraulic press", "disconnected hydraulic presses"),
        longest_side_mm = 1580,
        volume_ml = 500000,
        mass_milligrams = 76000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Based off Renegade Industrial 2.2HP 210LPM Air Compressor
    local item = content.Item {
        id = "air_compressor",
        looks_like = "f_standing_tank",
        symbol = "7",
        description = ccb.content.text("This durable tank is topped with a motor that will cram as much air into the tank as possible.  Needs to be placed and plugged into a power source."),
        color = "black_yellow",
        name = ccb.content.plural_text("disconnected air compressor", "disconnected air compressors"),
        longest_side_mm = 1100,
        volume_ml = 400000,
        mass_milligrams = 80000000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wall_light",
        name = ccb.content.plural_text("disconnected wall light", "disconnected wall lights"),
        description = ccb.content.text("A wall light that provides illumination when plugged into a grid."),
        mass_milligrams = 500000,
        melee_to_hit = -4,
        volume_ml = 400,
        longest_side_mm = 200,
        price_cents = 9000,
        price_postapoc_cents = 500,
        symbol = "L",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "standing_lamp",
        name = ccb.content.plural_text("disconnected standing lamp", "disconnected standing lamps"),
        description = ccb.content.text("A tall standing lamp that provides illumination when plugged into a power outlet."),
        mass_milligrams = 2500000,
        melee_to_hit = 0,
        volume_ml = 2000,
        longest_side_mm = 1700,
        price_cents = 9000,
        price_postapoc_cents = 500,
        symbol = "L",
        color = "white",
        looks_like = "f_floor_lamp",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_lamp",
        name = ccb.content.plural_text("disconnected scavenged utility light", "disconnected scavenged utility lights"),
        description = ccb.content.text("Some parts of this lamp have a curved appearance as though the metal were grown in a lab, but by and large this isn't a particularly unusual looking area light.  Its bulbs will emit light if connected to power."),
        mass_milligrams = 2500000,
        melee_to_hit = 0,
        volume_ml = 2000,
        longest_side_mm = 1700,
        price_cents = 3000,
        price_postapoc_cents = 300,
        symbol = "T",
        color = "light_gray",
        looks_like = "f_exodii_lamp",
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "standing_floodlight",
        name = ccb.content.plural_text("disconnected standing floodlight", "disconnected standing floodlights"),
        description = ccb.content.text("A large, heavy light designed to illuminate wide areas when plugged into a power outlet."),
        mass_milligrams = 2750000,
        melee_to_hit = -1,
        volume_ml = 2000,
        longest_side_mm = 1700,
        price_cents = 90000,
        price_postapoc_cents = 1500,
        symbol = "F",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "standing_directed_floodlight",
        name = ccb.content.plural_text("disconnected standing directed floodlight", "disconnected standing directed floodlights"),
        description = ccb.content.text("A large, heavy light designed to illuminate a wide semicircle in a chosen direction when plugged into a power outlet."),
        mass_milligrams = 2750000,
        melee_to_hit = -1,
        volume_ml = 2000,
        longest_side_mm = 1700,
        price_cents = 90000,
        price_postapoc_cents = 1500,
        looks_like = "standing_floodlight",
        symbol = "F",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "wall_wiring",
        name = ccb.content.plural_text("wall wiring", "wall wirings"),
        description = ccb.content.text("Electric wires used to run power through walls."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "~",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "foot_locker_recharge_station",
        category = "other",
        name = ccb.content.plural_text("disconnected foot locker recharging station", "disconnected foot locker recharging stations"),
        description = ccb.content.text("A universal recharging station integrated into a steel storage compartment.  When plugged in and powered, it will steadily charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space."),
        mass_milligrams = 30000000,
        color = "cyan",
        symbol = "]",
        volume_ml = 215000,
        price_cents = 105000,
        price_postapoc_cents = 1400,
        looks_like = "recharge_station",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 400000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "box_battery_charger",
        category = "other",
        name = ccb.content.plural_text("disconnected box battery charger", "disconnected box battery chargers"),
        description = ccb.content.text("A small device for recharging batteries integrated into a small wooden storage compartment.  When plugged in and powered, it will slowly charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space."),
        mass_milligrams = 8100000,
        color = "cyan",
        symbol = "]",
        volume_ml = 65000,
        price_cents = 5000,
        price_postapoc_cents = 200,
        looks_like = "battery_charger",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:container_pocket { max_volume_ml = 50000, max_weight_milligrams = 100000000, rigid = true }
    content.add(item)
end

do
    -- the base unit is 39x46x76cm (136 liters) and weighs 32 kg. I am assuming that XEDRA or another org added a lot of armor as a hedge against portal fuckery
    -- being enclosed in a solid box of milcomp plating I'm assuming about another 68 kg (3 armor platings' worth + shocks etc)
    -- I don't know how much these were worth pre-Cataclysm but the pu-238 alone is worth about 5-6 million and hundreds of millions were spent on research.  After the apocalypse these should basically be valuable beyond compare though.
    local item = content.Item {
        id = "compact_ASRG_containment",
        category = "other",
        name = ccb.content.plural_text("disconnected advanced Stirling radioisotope generator", "disconnected advanced Stirling radioisotope generators"),
        looks_like = "t_plut_generator",
        description = ccb.content.text("A rather heavy brick of metal housing an ASRG, formerly designed by NASA and repurposed for terrestrial use.  Will provide about 130 W, basically forever as far as you're concerned.  Even though the alpha radiation these run off of isn't very dangerous in case of a breach, this unit appears to be armored to take a beating and is a good deal heavier owing to its composite plating."),
        mass_milligrams = 100000000,
        melee_to_hit = -3,
        volume_ml = 150000,
        longest_side_mm = 800,
        price_cents = 1000000000,
        price_postapoc_cents = 12000,
        symbol = "O",
        color = "green_white",
    }
    item:material("lead", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "oxygen_concentrator",
        category = "other",
        name = ccb.content.plural_text("oxygen concentrator", "oxygen concentrator"),
        description = ccb.content.text("A machine capable of generating pure oxygen from the air.  Can be placed and plugged into a power source."),
        mass_milligrams = 29000000,
        volume_ml = 110000,
        longest_side_mm = 700,
        price_cents = 200000,
        price_postapoc_cents = 2000,
        symbol = "&",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hd_compressor_unit",
        category = "other",
        name = ccb.content.plural_text("high pressure compressor unit", "high pressure compressor unit"),
        description = ccb.content.text("A machine designed to compress an input gas to a very high pressure.  Can be placed and plugged into a power source."),
        mass_milligrams = 52500000,
        volume_ml = 150000,
        longest_side_mm = 630,
        price_cents = 200000,
        price_postapoc_cents = 2000,
        symbol = "&",
        color = "light_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Loosely based off Jen-Ken Kiln - Crucible 1813, but homemade
    local item = content.Item {
        id = "glassblowers_crucible",
        category = "other",
        name = ccb.content.plural_text("disconnected glassblower's crucible", "disconnected glassblower's crucibles"),
        description = ccb.content.text("An electric crucible, powered by your electric grid.  Designed for melting large quantities of glass for batch crafting and production of large items, it needs to be placed and plugged into a power source."),
        mass_milligrams = 55000000,
        volume_ml = 62500,
        longest_side_mm = 1000,
        price_cents = 217900,
        price_postapoc_cents = 2500,
        symbol = "o",
        color = "brown",
    }
    item:material("steel", 1)
    item:material("clay", 1)
    content.add(item)
end

do
    -- Based off https://www.grizzly.com/products/grizzly-8-x-16-variable-speed-benchtop-metal-lathe/g0768 because its longest side is roughly 1 m long (hence it'd fit in a tile) and it seemed standard enough.
    local item = content.Item {
        id = "lathe",
        name = ccb.content.plural_text("disconnected lathe", "disconnected lathes"),
        description = ccb.content.text("An industrial-grade lathe, for turning chunks of metal and other hard things into round chunks of metal and other hard things.  Needs to be placed and plugged into a power source."),
        looks_like = "f_heavy_lathe",
        symbol = "4",
        color = "cyan_red",
        longest_side_mm = 1150,
        volume_ml = 275000,
        mass_milligrams = 150000000,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    -- Based off https://www.frymaster.com/product/fam_zeozpi/E4-Electric-Fryers-RE14-RE14-2.
    local item = content.Item {
        id = "deep_fryer",
        name = ccb.content.plural_text("disconnected deep fryer", "disconnected deep fryers"),
        description = ccb.content.text("An industrial deep fryer, for frying huge batches of food at once.  Needs to be placed and plugged into a power source."),
        looks_like = "f_oven",
        symbol = "h",
        color = "light_gray",
        longest_side_mm = 1150,
        volume_ml = 368000,
        mass_milligrams = 86000000,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- based on YZS-68 oil press: http://www.oilpressmachine.com/6yl-68-oil-press.html
    local item = content.Item {
        id = "oil_press_electric",
        name = ccb.content.plural_text("disconnected industrial oil press", "disconnected industrial oil presses"),
        description = ccb.content.text("A heavy-duty press used to create vegetable oil from nuts or seeds.  Needs to be placed and plugged into a power source."),
        looks_like = "f_machinery_light",
        symbol = "Y",
        color = "green",
        longest_side_mm = 880,
        volume_ml = 370000,
        mass_milligrams = 140000000,
        price_cents = 100000,
        price_postapoc_cents = 1000,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "electric_cooker",
        name = ccb.content.plural_text("disconnected electric cooker", "disconnected electric cookers"),
        description = ccb.content.text("An electric cooker designed to automatically heat and cook food placed inside.  Needs to be placed and plugged into a power source."),
        looks_like = "f_oven",
        symbol = "#",
        color = "dark_gray",
        longest_side_mm = 600,
        volume_ml = 25000,
        mass_milligrams = 15000000,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bulk_liquid_tank",
        category = "container",
        looks_like = "f_storage_tank",
        name = ccb.content.plural_text("disconnected bulk liquid tank", "disconnected bulk liquid tanks"),
        description = ccb.content.text("A heavy rack of ten interconnected steel tanks providing 600 liters of liquid storage.  It is built for stationary use, includes electric heating to keep its contents from freezing, and can accept plumbing equipment once placed as an appliance."),
        mass_milligrams = 61244000,
        volume_ml = 650000,
        longest_side_mm = 2000,
        symbol = "O",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 600000, max_weight_milligrams = 1200000000, rigid = true, watertight = true }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end
