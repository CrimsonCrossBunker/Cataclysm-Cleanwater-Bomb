local ccb = require("ccb")
local content = ccb.content

do
    -- Intended density 7.60g/cm³; was rounded to 8.0g/cm³ due to unitless stats; but fragments stacks poorly so weight is only 25% of this
    local item = content.Item {
        id = "scrap",
        category = "spare_parts",
        name = ccb.content.plural_text("scrap metal", "scrap metal"),
        description = ccb.content.text("A bulky assortment of small bits of scrap steel useful in all kinds of crafting."),
        mass_milligrams = 50000,
        volume_ml = 31,
        price_cents = 100,
        price_postapoc_cents = 1,
        symbol = ",",
        color = "light_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    content.add(item)
end

do
    local item = content.Item {
        id = "cu_pipe",
        name = ccb.content.plural_text("copper tubing", "copper tubings"),
        description = ccb.content.text("A copper tube; too thin to be much use as a melee weapon, but will do if nothing else is available.  Useful in a few crafting recipes."),
        category = "spare_parts",
        mass_milligrams = 345000,
        longest_side_mm = 600,
        melee_to_hit = 0,
        color = "light_red",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "BATONS" },
        volume_ml = 370,
        price_cents = 7500,
        price_postapoc_cents = 10,
        stackable = true,
    }
    item:material("copper", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_aluminium_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("chunk of aluminum", "chunks of aluminum"),
        description = ccb.content.text("A small chunk of aluminum; light but durable, this could be cast into various shapes for construction or ground down to a powder, for more… high-profile applications."),
        mass_milligrams = 250000,
        volume_ml = 100,
        price_cents = 7,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:quality("HAMMER", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bismuth",
        category = "spare_parts",
        name = ccb.content.plural_text("bismuth", "bismuth"),
        description = ccb.content.text("A dense but brittle metal often used as an alternative to lead."),
        mass_milligrams = 10000,
        volume_ml = 1,
        price_cents = 300,
        price_postapoc_cents = 0,
        symbol = "=",
        color = "dark_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    -- With no industry to use it, worthless.
    local item = content.Item {
        id = "platinum_small",
        category = "spare_parts",
        name = ccb.content.plural_text("platinum", "platinum"),
        description = ccb.content.text("A soft, shiny metal.  Before the apocalypse this would've been worth a small fortune, but now its value is greatly diminished."),
        mass_milligrams = 21000,
        volume_ml = 1,
        price_cents = 15905,
        price_postapoc_cents = 1,
        symbol = "/",
        color = "light_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("platinum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "zinc_metal",
        category = "spare_parts",
        name = ccb.content.plural_text("zinc", "zinc"),
        description = ccb.content.text("A slightly brittle metal.  Apart from being an essential mineral that the body needs, it reacts readily with acids, alkalis, and other non-metals.  It can be crushed to make zinc powder and used in the production of batteries, among other things."),
        mass_milligrams = 7140,
        volume_ml = 1,
        price_cents = 3000,
        price_postapoc_cents = 1,
        symbol = "/",
        color = "blue",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("zinc", 1)
    content.add(item)
end

do
    -- 300g / 8.73g/cm3 = ~34.4ml. Add 10% like bronze = 37.8ml rounded upwards to 38ml.
    -- appears to be about 20% cheaper than bronze
    local item = content.Item {
        id = "scrap_brass",
        category = "spare_parts",
        name = ccb.content.plural_text("chunk of brass", "chunks of brass"),
        description = ccb.content.text("Some decent-sized chunks of scrap brass."),
        mass_milligrams = 300000,
        volume_ml = 38,
        price_cents = 140,
        price_postapoc_cents = 80,
        symbol = ",",
        color = "yellow",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("brass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lead",
        category = "spare_parts",
        name = ccb.content.plural_text("lead", "lead"),
        description = ccb.content.text("A soft, dull metal used since ancient times.  Due to its malleability, it has a wide variety of uses including the manufacture of ammunition."),
        mass_milligrams = 5000,
        volume_ml = 1,
        price_cents = 200,
        price_postapoc_cents = 2,
        symbol = "=",
        color = "dark_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "magnesium",
        category = "spare_parts",
        name = ccb.content.plural_text("magnesium powder", "magnesium powder"),
        description = ccb.content.text("A handful of powdered magnesium, a highly flammable alkaline earth metal.  Useful for constructing flares and similar items."),
        mass_milligrams = 1120,
        volume_ml = 2,
        price_cents = 5000,
        price_postapoc_cents = 1,
        symbol = "=",
        color = "dark_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- 200*5g / 10.49g/ml = ~95.33ml. Add 10% to take an uneven chunk into account = 104.86ml rounded upwards to 105ml.
    local item = content.Item {
        id = "silver_small",
        category = "spare_parts",
        name = ccb.content.plural_text("silver", "silver"),
        description = ccb.content.text("A soft, shiny metal.  Before the Cataclysm it was worth quite a bit, but its value is now greatly diminished."),
        mass_milligrams = 5000,
        volume_ml = 1,
        price_cents = 75000,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "light_gray",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("silver", 1)
    content.add(item)
end

do
    -- Roughly in the 15cm×15cm to 20cm×20cm range. Compact and stacks well, so equally dense as a solid block.
    local item = content.Item {
        id = "sheet_metal_small",
        category = "spare_parts",
        name = ccb.content.plural_text("small mild steel sheet", "small mild steel sheets"),
        description = ccb.content.text("A small sheet of mild steel."),
        looks_like = "sheet_metal",
        mass_milligrams = 250000,
        volume_ml = 32,
        longest_side_mm = 200,
        price_cents = 2000,
        price_postapoc_cents = 1,
        melee_to_hit = -5,
        symbol = "]",
        color = "light_cyan",
        stackable = true,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_sheet_metal_small",
        copy_from = "sheet_metal_small",
        looks_like = "sheet_metal_small",
        name = ccb.content.plural_text("small medium steel sheet", "small medium steel sheets"),
        description = ccb.content.text("A small sheet of medium steel."),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_sheet_metal_small",
        copy_from = "sheet_metal_small",
        looks_like = "sheet_metal_small",
        name = ccb.content.plural_text("small high steel sheet", "small high steel sheets"),
        description = ccb.content.text("A small sheet of high steel."),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_sheet_metal_small",
        copy_from = "sheet_metal_small",
        looks_like = "sheet_metal_small",
        name = ccb.content.plural_text("small hardened steel sheet", "small hardened steel sheets"),
        description = ccb.content.text("A small sheet of hardened steel."),
    }
    item:material("ch_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_sheet_metal_small",
        copy_from = "sheet_metal_small",
        looks_like = "sheet_metal_small",
        name = ccb.content.plural_text("small tempered steel sheet", "small tempered steel sheets"),
        description = ccb.content.text("A small sheet of tempered steel."),
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    -- Intended density 7.60g/cm³; was rounded to 8.0g/cm³ due to unitless stats
    -- 62 × 8.0 = 500g/unit; but mishapen so weight is only 50% of this
    local item = content.Item {
        id = "steel_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("chunk of steel", "chunks of steel"),
        description = ccb.content.text("A misshapen chunk of steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
        mass_milligrams = 250000,
        volume_ml = 62,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- Intended density 7.60g/cm³; was rounded to 8.0g/cm³ due to unitless stats
    -- 125 × 8.0 = 1000g/unit; formed as a solid ingot so weight is 100% of this
    local item = content.Item {
        id = "steel_lump",
        category = "spare_parts",
        name = ccb.content.plural_text("lump of steel", "lumps of steel"),
        description = ccb.content.text("A heavy, formed piece of steel.  Useful for some crafting recipes."),
        mass_milligrams = 1000000,
        volume_ml = 125,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -5,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of mild steel", "lumps of mild steel"),
        description = ccb.content.text("A heavy, formed piece of mild steel.  Useful for some crafting recipes."),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of medium steel", "lumps of medium steel"),
        description = ccb.content.text("A heavy, formed piece of medium steel.  Useful for some crafting recipes."),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of high steel", "lumps of high steel"),
        description = ccb.content.text("A heavy, formed piece of high steel.  Useful for some crafting recipes."),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of hardened steel", "lumps of hardened steel"),
        description = ccb.content.text("A heavy, formed piece of hardened steel.  Useful for some crafting recipes."),
    }
    item:material("ch_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of tempered steel", "lumps of tempered steel"),
        description = ccb.content.text("A heavy, formed piece of tempered steel.  Useful for some crafting recipes."),
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07GF54KV8
    local item = content.Item {
        id = "hinge",
        category = "spare_parts",
        name = ccb.content.plural_text("hinge", "hinges"),
        description = ccb.content.text("A small metal hinge with two metal plates with screw holes.  Useful for making doors or chests."),
        mass_milligrams = 267000,
        volume_ml = 151,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = "%",
        color = "light_cyan",
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_copper",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("chunk of copper", "chunks of copper"),
        category = "spare_parts",
        description = ccb.content.text("A small chunk of copper, usable for crafting or repairs."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        volume_ml = 30,
        mass_milligrams = 250000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("copper", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Density of 7.265g/cm³ => 50g/7.265g/cm³ ~ 7ml
    local item = content.Item {
        id = "scrap_tin",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("scrap tin", "scrap tin"),
        category = "spare_parts",
        description = ccb.content.text("Some small pieces of scrap tin, usable for crafting or repairs."),
        price_cents = 129,
        price_postapoc_cents = 2,
        volume_ml = 8,
        mass_milligrams = 50000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("tin", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    content.add(item)
end

do
    local item = content.Item {
        id = "tin",
        category = "spare_parts",
        price_cents = 4,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("tin powder", "tin powder"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A handful of fine gray tin powder, usable for making solder and lining containers to prevent corrosion."),
        volume_ml = 1,
        mass_milligrams = 2000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("tin", 1)
    content.add(item)
end

do
    -- Density ~ 8g/cm³ ~ 2000kg/250ml @ stack 1000 = 2g/unit
    local item = content.Item {
        id = "solder_wire",
        category = "spare_parts",
        price_cents = 20,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("solder", "solder"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A small spool of solder, useful for electronics crafting."),
        display_type = "BY_WEIGHT",
        volume_ml = 1,
        mass_milligrams = 2000,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 9mm in diameter and 1.572m long.
    local item = content.Item {
        id = "copper_rod",
        category = "spare_parts",
        price_cents = 2000,
        price_postapoc_cents = 20,
        name = ccb.content.plural_text("copper rod", "copper rods"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A thin copper rod, ready to be made into copper wire."),
        volume_ml = 100,
        mass_milligrams = 863000,
        longest_side_mm = 1572,
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fanblade_metal",
        category = "spare_parts",
        name = ccb.content.plural_text("metal fan blade assembly", "metal fan blade assemblies"),
        description = ccb.content.text("A multi-bladed metal fan, like you'd find on a larger desk fan or inside a convection oven."),
        mass_milligrams = 150000,
        volume_ml = 2000,
        longest_side_mm = 300,
        price_cents = 50,
        price_postapoc_cents = 10,
        symbol = "*",
        color = "light_gray",
        stackable = true,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "heavy_wire_rack",
        category = "spare_parts",
        name = ccb.content.plural_text("heavy wire rack", "heavy wire racks"),
        description = ccb.content.text("A durable steel rack, the sort you might find in an oven or on a barbecue."),
        mass_milligrams = 600000,
        volume_ml = 5000,
        longest_side_mm = 600,
        price_cents = 50,
        price_postapoc_cents = 10,
        symbol = "#",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of mild steel", "chunks of mild steel"),
        description = ccb.content.text("A misshapen chunk of mild steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of medium steel", "chunks of medium steel"),
        description = ccb.content.text("A misshapen chunk of medium steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of high steel", "chunks of high steel"),
        description = ccb.content.text("A misshapen chunk of high steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of hardened steel", "chunks of hardened steel"),
        description = ccb.content.text("A misshapen chunk of hardened steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("ch_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of tempered steel", "chunks of tempered steel"),
        description = ccb.content.text("A misshapen chunk of tempered steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_aluminum",
        category = "spare_parts",
        name = ccb.content.plural_text("1L aluminum ingot", "1L aluminum ingots"),
        description = ccb.content.text("A one-liter ingot of solid aluminum."),
        mass_milligrams = 2700000,
        volume_ml = 1000,
        price_cents = 74,
        price_postapoc_cents = 15,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_aluminum",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L aluminum ingot", "5 L aluminum ingots"),
        description = ccb.content.text("A five-liter ingot of solid aluminum."),
        mass_milligrams = 13500000,
        volume_ml = 5000,
        price_cents = 370,
        price_postapoc_cents = 75,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_aluminum",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L aluminum ingot", "10 L aluminum ingots"),
        description = ccb.content.text("A ten-liter ingot of solid aluminum."),
        mass_milligrams = 27000000,
        volume_ml = 10000,
        price_cents = 7400,
        price_postapoc_cents = 200,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_brass",
        category = "spare_parts",
        name = ccb.content.plural_text("1L brass ingot", "1L brass ingots"),
        description = ccb.content.text("A one-liter ingot of solid brass."),
        mass_milligrams = 8730000,
        volume_ml = 1000,
        price_cents = 114548,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_brass",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L brass ingot", "5 L brass ingots"),
        description = ccb.content.text("A five-liter ingot of solid brass."),
        mass_milligrams = 43650000,
        volume_ml = 5000,
        price_cents = 572740,
        price_postapoc_cents = 25,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_brass",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L brass ingot", "10 L brass ingots"),
        description = ccb.content.text("A ten-liter ingot of solid brass."),
        mass_milligrams = 87300000,
        volume_ml = 10000,
        price_cents = 1145475,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("1L bronze ingot", "1L bronze ingots"),
        description = ccb.content.text("A one-liter ingot of solid bronze."),
        mass_milligrams = 7690000,
        volume_ml = 1000,
        price_cents = 130039,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("bronze", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L bronze ingot", "5 L bronze ingots"),
        description = ccb.content.text("A five-liter ingot of solid bronze."),
        mass_milligrams = 38450000,
        volume_ml = 5000,
        price_cents = 650195,
        price_postapoc_cents = 25,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("bronze", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L bronze ingot", "10 L bronze ingots"),
        description = ccb.content.text("A ten-liter ingot of solid bronze."),
        mass_milligrams = 88000000,
        volume_ml = 10000,
        price_cents = 1300400,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("bronze", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_copper",
        category = "spare_parts",
        name = ccb.content.plural_text("1L copper ingot", "1L copper ingots"),
        description = ccb.content.text("A one-liter ingot of solid copper."),
        mass_milligrams = 8960000,
        volume_ml = 1000,
        price_cents = 2315,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "brown",
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_copper",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L copper ingot", "5 L copper ingots"),
        description = ccb.content.text("A five-liter ingot of solid copper."),
        mass_milligrams = 44800000,
        volume_ml = 5000,
        price_cents = 11575,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "brown",
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_copper",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L copper ingot", "10 L copper ingots"),
        description = ccb.content.text("A ten-liter ingot of solid copper."),
        mass_milligrams = 89600000,
        volume_ml = 10000,
        price_cents = 23150,
        price_postapoc_cents = 200,
        symbol = "=",
        color = "brown",
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_tin",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L tin ingot", "10 L tin ingots"),
        description = ccb.content.text("A ten-liter ingot of solid tin."),
        mass_milligrams = 72650000,
        volume_ml = 10000,
        price_cents = 187910,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("tin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_tin",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L tin ingot", "5 L tin ingots"),
        description = ccb.content.text("A five-liter ingot of solid tin."),
        mass_milligrams = 36325000,
        volume_ml = 5000,
        price_cents = 93955,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("tin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_tin",
        category = "spare_parts",
        name = ccb.content.plural_text("1 L tin ingot", "1 L tin ingots"),
        description = ccb.content.text("A one-liter ingot of solid tin."),
        mass_milligrams = 7265000,
        volume_ml = 1000,
        price_cents = 18791,
        price_postapoc_cents = 2,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("tin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_zinc",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L zinc ingot", "10 L zinc ingots"),
        description = ccb.content.text("A ten-liter ingot of solid zinc."),
        mass_milligrams = 71000000,
        volume_ml = 10000,
        price_cents = 23150,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "white",
        stackable = true,
    }
    item:material("zinc", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_zinc",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L zinc ingot", "5 L zinc ingots"),
        description = ccb.content.text("A five-liter ingot of solid zinc."),
        mass_milligrams = 35500000,
        volume_ml = 5000,
        price_cents = 11575,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "white",
        stackable = true,
    }
    item:material("zinc", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_zinc",
        category = "spare_parts",
        name = ccb.content.plural_text("1L zinc ingot", "1L zinc ingots"),
        description = ccb.content.text("A one-liter ingot of solid zinc."),
        mass_milligrams = 7100000,
        volume_ml = 1000,
        price_cents = 2315,
        price_postapoc_cents = 2,
        symbol = "=",
        color = "white",
        stackable = true,
    }
    item:material("zinc", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "1l_gold",
        category = "spare_parts",
        name = ccb.content.plural_text("1 L gold ingot", "1 L gold ingots"),
        description = ccb.content.text("A one-liter ingot of solid gold."),
        mass_milligrams = 19320000,
        volume_ml = 1000,
        price_cents = 123705960,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_gold",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L gold ingot", "5 L gold ingots"),
        description = ccb.content.text("A five-liter ingot of solid gold."),
        mass_milligrams = 96600000,
        volume_ml = 5000,
        price_cents = 618529800,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_gold",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L gold ingot", "10 L gold ingots"),
        description = ccb.content.text("A ten-liter ingot of solid gold."),
        mass_milligrams = 193200000,
        volume_ml = 10000,
        price_cents = 1237059600,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "yellow",
        stackable = true,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_iron",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L cast iron ingot", "5 L cast iron ingots"),
        description = ccb.content.text("A five-liter ingot of solid cast iron."),
        mass_milligrams = 36500000,
        volume_ml = 5000,
        price_cents = 10000,
        price_postapoc_cents = 200,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_iron",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L cast iron ingot", "10 L cast iron ingots"),
        description = ccb.content.text("A ten-liter ingot of solid cast iron."),
        mass_milligrams = 73000000,
        volume_ml = 10000,
        price_cents = 20000,
        price_postapoc_cents = 400,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "1l_lead",
        category = "spare_parts",
        name = ccb.content.plural_text("1 L lead ingot", "1 L lead ingots"),
        description = ccb.content.text("A one-liter ingot of solid lead."),
        mass_milligrams = 11342000,
        volume_ml = 1000,
        price_cents = 2269,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_lead",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L lead ingot", "5 L lead ingots"),
        description = ccb.content.text("A five-liter ingot of solid lead."),
        mass_milligrams = 56710000,
        volume_ml = 5000,
        price_cents = 11345,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_lead",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L lead ingot", "10 L lead ingots"),
        description = ccb.content.text("A ten-liter ingot of solid lead."),
        mass_milligrams = 113400000,
        volume_ml = 10000,
        price_cents = 22690,
        price_postapoc_cents = 200,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "1l_platinum",
        category = "spare_parts",
        name = ccb.content.plural_text("1 L platinum ingot", "1 L platinum ingots"),
        description = ccb.content.text("A one-liter ingot of solid platinum."),
        mass_milligrams = 21450000,
        volume_ml = 1000,
        price_cents = 68232450,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("platinum", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "5l_platinum",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L platinum ingot", "5 L platinum ingots"),
        description = ccb.content.text("A five-liter ingot of solid platinum."),
        mass_milligrams = 107250000,
        volume_ml = 5000,
        price_cents = 341162250,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("platinum", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "10l_platinum",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L platinum ingot", "10 L platinum ingots"),
        description = ccb.content.text("A ten-liter ingot of solid platinum."),
        mass_milligrams = 214500000,
        volume_ml = 10000,
        price_cents = 682324500,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("platinum", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "1l_silver",
        category = "spare_parts",
        name = ccb.content.plural_text("1 L silver ingot", "1 L silver ingots"),
        description = ccb.content.text("A one-liter ingot of solid silver."),
        mass_milligrams = 10490000,
        volume_ml = 1000,
        price_cents = 786750,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("silver", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "5l_silver",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L silver ingot", "5 L silver ingots"),
        description = ccb.content.text("A five-liter ingot of solid silver."),
        mass_milligrams = 52450000,
        volume_ml = 5000,
        price_cents = 3933750,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("silver", 1)
    content.add(item)
end

do
    -- Novelty item, absolutely useless. Same amount of novelty for a 1L gold bar or 10L gold bar, so same price.
    local item = content.Item {
        id = "10l_silver",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L silver ingot", "10 L silver ingots"),
        description = ccb.content.text("A ten-liter ingot of solid silver."),
        mass_milligrams = 104900000,
        volume_ml = 10000,
        price_cents = 7867500,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("silver", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L steel ingot", "5 L steel ingots"),
        description = ccb.content.text("A five-liter ingot of solid steel."),
        mass_milligrams = 39295000,
        volume_ml = 5000,
        price_cents = 20000,
        price_postapoc_cents = 200,
        replace_qualities = true,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    item:quality("ANVIL", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L steel ingot", "10 L steel ingots"),
        description = ccb.content.text("A ten-liter ingot of solid steel."),
        mass_milligrams = 78590000,
        volume_ml = 10000,
        price_cents = 40000,
        price_postapoc_cents = 400,
        replace_qualities = true,
        symbol = "=",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    item:quality("ANVIL", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_budget_steel",
        copy_from = "5l_steel",
        looks_like = "5l_steel",
        name = ccb.content.plural_text("5 L budget steel ingot", "5 L budget steel ingots"),
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_budget_steel",
        copy_from = "10l_steel",
        looks_like = "10l_steel",
        name = ccb.content.plural_text("10 L budget steel ingot", "10 L budget steel ingots"),
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_lc_steel",
        copy_from = "5l_steel",
        looks_like = "5l_steel",
        name = ccb.content.plural_text("5 L mild steel ingot", "5 L mild steel ingots"),
        price_cents = 22000,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_lc_steel",
        copy_from = "10l_steel",
        looks_like = "10l_steel",
        name = ccb.content.plural_text("10 L mild steel ingot", "10 L mild steel ingots"),
        price_cents = 44000,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_mc_steel",
        copy_from = "5l_steel",
        looks_like = "5l_steel",
        name = ccb.content.plural_text("5 L medium steel ingot", "5 L medium steel ingots"),
        price_cents = 24000,
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_mc_steel",
        copy_from = "10l_steel",
        looks_like = "10l_steel",
        name = ccb.content.plural_text("10 L medium steel ingot", "10 L medium steel ingots"),
        price_cents = 48000,
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_hc_steel",
        copy_from = "5l_steel",
        looks_like = "5l_steel",
        name = ccb.content.plural_text("5 L high steel ingot", "5 L high steel ingots"),
        price_cents = 26000,
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "10l_hc_steel",
        copy_from = "10l_steel",
        looks_like = "10l_steel",
        name = ccb.content.plural_text("10 L high steel ingot", "10 L high steel ingots"),
        price_cents = 52000,
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "budget_steel_chunk",
        copy_from = "steel_chunk",
        looks_like = "steel_chunk",
        name = ccb.content.plural_text("chunk of budget steel", "chunks of budget steel"),
        description = ccb.content.text("A misshapen chunk of budget steel.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "budget_steel_lump",
        copy_from = "steel_lump",
        looks_like = "steel_lump",
        name = ccb.content.plural_text("lump of budget steel", "lumps of budget steel"),
        description = ccb.content.text("A heavy, formed piece of budget steel.  Useful for some crafting recipes."),
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "slag",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("slag", "slag"),
        symbol = ".",
        color = "dark_gray",
        description = ccb.content.text("A chunk of slag, leftover from smelting ore."),
        volume_ml = 3,
        mass_milligrams = 10000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("slag", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- 60E1, 76.7 cm2 of surface area
    local item = content.Item {
        id = "railroad_track_item",
        category = "spare_parts",
        name = ccb.content.plural_text("length of railroad track", "lengths of railroad track"),
        description = ccb.content.text("A heavy one-meter length of railroad track with a smooth top, liberated from a now-defunct rail line.  Far too heavy to be useful for much as-is, but perhaps could be shaped into something with some metalworking skill, or cut down into an anvil if sawed in half first."),
        mass_milligrams = 59826000,
        volume_ml = 7670,
        longest_side_mm = 1000,
        price_cents = 10000,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        replace_qualities = true,
        display_type = "BY_LENGTH",
        stackable = true,
    }
    item:material("mc_steel", 1)
    item:quality("ANVIL", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "railroad_track_item_half",
        category = "spare_parts",
        name = ccb.content.plural_text("half-meter length of railroad track", "half-meter lengths of railroad track"),
        description = ccb.content.text("A heavy half-meter length of railroad track with a smooth top, liberated from a now-defunct rail line.  Could be used as a makeshift anvil, especially with some modifications, or as spare steel."),
        mass_milligrams = 29913000,
        volume_ml = 3835,
        longest_side_mm = 500,
        price_cents = 5000,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "light_gray",
        replace_qualities = true,
        display_type = "BY_LENGTH",
        stackable = true,
    }
    item:material("mc_steel", 1)
    item:quality("ANVIL", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_aluminum",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("scrap aluminum", "scrap aluminum"),
        category = "spare_parts",
        description = ccb.content.text("A handful of small pieces of aluminum, usable for crafting or repairs."),
        price_cents = 2,
        price_postapoc_cents = 2,
        volume_ml = 20,
        mass_milligrams = 50000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Roughly in the 15cm x 15cm to 20cm x 20cm range.
    local item = content.Item {
        id = "sheet_aluminum_small",
        category = "spare_parts",
        name = ccb.content.plural_text("small aluminum sheet", "small aluminum sheets"),
        description = ccb.content.text("A small sheet of aluminum."),
        looks_like = "sheet_metal",
        mass_milligrams = 85000,
        volume_ml = 32,
        longest_side_mm = 200,
        price_cents = 3000,
        price_postapoc_cents = 10,
        melee_to_hit = -5,
        symbol = "]",
        color = "light_cyan",
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    -- Roughly in the 70 cm x 70 cm x 1.5 mm to 1 m x 1 m x 0.75 mm range.
    local item = content.Item {
        id = "sheet_aluminum",
        name = ccb.content.plural_text("aluminum sheet", "aluminum sheet"),
        description = ccb.content.text("A large sheet of aluminum."),
        mass_milligrams = 1984000,
        longest_side_mm = 1000,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 735,
        category = "spare_parts",
        price_postapoc_cents = 100,
        replace_qualities = true,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_cast_iron",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("scrap cast iron", "scrap cast iron"),
        category = "spare_parts",
        description = ccb.content.text("A handful of small pieces of scrap cast iron, usable for crafting or repairs."),
        price_cents = 75,
        price_postapoc_cents = 2,
        volume_ml = 8,
        mass_milligrams = 50000,
        melee_to_hit = -5,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    content.add(item)
end

do
    local item = content.Item {
        id = "chunk_cast_iron",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("cast iron chunk", "cast iron chunk"),
        category = "spare_parts",
        description = ccb.content.text("A misshapen chunk of cast iron.  Makes a decent weapon in a pinch, and is also useful for some crafting recipes."),
        price_cents = 375,
        price_postapoc_cents = 10,
        volume_ml = 40,
        mass_milligrams = 250000,
        melee_to_hit = -5,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "lump_cast_iron",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("cast iron lump", "cast iron lump"),
        category = "spare_parts",
        description = ccb.content.text("A heavy piece of cast iron.  Useful for some crafting recipes."),
        price_cents = 1500,
        price_postapoc_cents = 40,
        volume_ml = 158,
        mass_milligrams = 1000000,
        melee_to_hit = -5,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- Bar is 5cm in diameter.
    local item = content.Item {
        id = "aluminum_bar_round",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum bar stock", "aluminum bar stock"),
        description = ccb.content.text("A round bar of aluminum.  Ready to be turned on the lathe."),
        mass_milligrams = 253800,
        volume_ml = 94,
        longest_side_mm = 50,
        price_cents = 200,
        price_postapoc_cents = 10,
        symbol = "-",
        color = "light_cyan",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Bar is 3cm in diameter.
    local item = content.Item {
        id = "small_aluminum_bar_round",
        category = "spare_parts",
        name = ccb.content.plural_text("small aluminum bar stock", "small aluminum bar stock"),
        description = ccb.content.text("A small round bar of aluminum.  Ready to be turned on the lathe."),
        mass_milligrams = 94500,
        volume_ml = 35,
        longest_side_mm = 50,
        price_cents = 100,
        price_postapoc_cents = 5,
        symbol = "-",
        color = "light_cyan",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- Bar is 10cm in diameter.
    -- source is https://www.mcmaster.com/products/steel-bar-stock/steel-2~/shape~rod-1/high-strength-1045-carbon-steel-rods~~/?s=steel-bar-stock.
    local item = content.Item {
        id = "steel_bar_round",
        category = "spare_parts",
        name = ccb.content.plural_text("steel bar stock", "steel bar stock"),
        description = ccb.content.text("A round bar of steel.  Ready to be turned on the lathe."),
        mass_milligrams = 19760000,
        volume_ml = 2470,
        longest_side_mm = 300,
        price_cents = 12000,
        price_postapoc_cents = 500,
        symbol = "-",
        color = "light_gray",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 38)
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_steel_bar_round",
        copy_from = "steel_bar_round",
        looks_like = "steel_bar_round",
        name = ccb.content.plural_text("low steel bar stock", "low steel bar stock"),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_steel_bar_round",
        copy_from = "steel_bar_round",
        looks_like = "steel_bar_round",
        name = ccb.content.plural_text("medium steel bar stock", "medium steel bar stock"),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_steel_bar_round",
        copy_from = "steel_bar_round",
        looks_like = "steel_bar_round",
        name = ccb.content.plural_text("high steel bar stock", "high steel bar stock"),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    -- Bar is 3cm in diameter.
    local item = content.Item {
        id = "small_steel_bar_round",
        category = "spare_parts",
        name = ccb.content.plural_text("small steel bar stock", "small steel bar stock"),
        description = ccb.content.text("A small round bar of steel.  Ready to be turned on the lathe."),
        mass_milligrams = 1696000,
        volume_ml = 212,
        longest_side_mm = 300,
        price_cents = 500,
        price_postapoc_cents = 10,
        symbol = "-",
        color = "light_gray",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_lc_steel_bar_round",
        copy_from = "small_steel_bar_round",
        looks_like = "small_steel_bar_round",
        name = ccb.content.plural_text("small low steel bar stock", "small low steel bar stock"),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_mc_steel_bar_round",
        copy_from = "small_steel_bar_round",
        looks_like = "small_steel_bar_round",
        name = ccb.content.plural_text("small medium steel bar stock", "small medium steel bar stock"),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_hc_steel_bar_round",
        copy_from = "small_steel_bar_round",
        looks_like = "small_steel_bar_round",
        name = ccb.content.plural_text("small high steel bar stock", "small high steel bar stock"),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    -- Bar is 10x5x5 centimeters.
    local item = content.Item {
        id = "aluminum_bar_flat",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum flat bar stock", "aluminum flat bar stock"),
        description = ccb.content.text("A rectangular bar of aluminum.  Ready to be milled on a milling machine."),
        mass_milligrams = 675000,
        volume_ml = 250,
        longest_side_mm = 100,
        price_cents = 25,
        price_postapoc_cents = 25,
        symbol = "-",
        color = "light_cyan",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Bar is 5x3x3 centimeters.
    local item = content.Item {
        id = "small_aluminum_bar_flat",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum flat bar stock", "aluminum flat bar stock"),
        description = ccb.content.text("A rectangular bar of aluminum.  Ready to be milled on a milling machine."),
        mass_milligrams = 121500,
        volume_ml = 122,
        longest_side_mm = 50,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "-",
        color = "light_cyan",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Bar is 10x5x5 centimeters.
    local item = content.Item {
        id = "steel_bar_flat",
        category = "spare_parts",
        name = ccb.content.plural_text("steel flat bar stock", "steel flat bar stock"),
        description = ccb.content.text("A rectangular bar of steel.  Ready to be milled on a milling machine."),
        mass_milligrams = 2000000,
        volume_ml = 250,
        longest_side_mm = 100,
        price_cents = 50,
        price_postapoc_cents = 25,
        symbol = "-",
        color = "light_gray",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Bar is 5x3x3 centimeters.
    local item = content.Item {
        id = "small_steel_bar_flat",
        category = "spare_parts",
        name = ccb.content.plural_text("steel flat bar stock", "steel flat bar stock"),
        description = ccb.content.text("A small rectangular bar of steel.  Ready to be milled on a milling machine."),
        mass_milligrams = 360000,
        volume_ml = 45,
        longest_side_mm = 50,
        price_cents = 50,
        price_postapoc_cents = 25,
        symbol = "-",
        color = "light_gray",
        melee_to_hit = -5,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_steel_bar_flat",
        copy_from = "steel_bar_flat",
        looks_like = "steel_bar_flat",
        name = ccb.content.plural_text("high steel flat bar stock", "high steel flat bar stock"),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_steel_bar_flat",
        copy_from = "steel_bar_flat",
        looks_like = "steel_bar_flat",
        name = ccb.content.plural_text("medium steel flat bar stock", "medium steel flat bar stock"),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_steel_bar_flat",
        copy_from = "steel_bar_flat",
        looks_like = "steel_bar_flat",
        name = ccb.content.plural_text("low steel flat bar stock", "low steel flat bar stock"),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_hc_steel_bar_flat",
        copy_from = "small_steel_bar_flat",
        looks_like = "small_steel_bar_flat",
        name = ccb.content.plural_text("small high steel flat bar stock", "small high steel flat bar stock"),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_mc_steel_bar_flat",
        copy_from = "small_steel_bar_flat",
        looks_like = "small_steel_bar_flat",
        name = ccb.content.plural_text("small medium steel flat bar stock", "small medium steel flat bar stock"),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_lc_steel_bar_flat",
        copy_from = "small_steel_bar_flat",
        looks_like = "small_steel_bar_flat",
        name = ccb.content.plural_text("small low steel flat bar stock", "small low steel flat bar stock"),
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- Based on https://www.constructionknowledge.net/metal/images_metal/hss%20rect%20Steel%20section%20tables%20080307.pdf HSS4X4X1/2
    local item = content.Item {
        id = "steel_section_long",
        name = ccb.content.plural_text("long structural steel section", "long structural steel sections"),
        description = ccb.content.text("A long section of carbon structural steel.  Maybe if you shorten it, you could use it to craft your own steel vehicle frames."),
        category = "spare_parts",
        mass_milligrams = 31000000,
        longest_side_mm = 1000,
        melee_to_hit = -3,
        color = "dark_gray",
        symbol = "/",
        volume_ml = 10000,
        price_cents = 1000,
        price_postapoc_cents = 5,
        stackable = true,
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end

do
    -- Based on https://www.constructionknowledge.net/metal/images_metal/hss%20rect%20Steel%20section%20tables%20080307.pdf HSS4X4X1/2
    local item = content.Item {
        id = "steel_section_short",
        name = ccb.content.plural_text("structural steel section", "structural steel sections"),
        description = ccb.content.text("A section of carbon structural steel.  Maybe you could weld a few of these together to make your own steel frame."),
        category = "spare_parts",
        mass_milligrams = 15000000,
        longest_side_mm = 500,
        melee_to_hit = -4,
        color = "dark_gray",
        symbol = "/",
        volume_ml = 5000,
        price_cents = 500,
        price_postapoc_cents = 2,
        stackable = true,
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end
