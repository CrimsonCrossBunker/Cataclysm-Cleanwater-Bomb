local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "log",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("log", "logs"),
        description = ccb.content.text("A large log of wood, cut from a tree.  (a)ctivate a wood axe or wood saw to cut it into planks."),
        category = "other",
        price_cents = 10000,
        price_postapoc_cents = 10,
        mass_milligrams = 30000000,
        volume_ml = 50000,
        longest_side_mm = 1400,
        melee_to_hit = -2,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "splinter",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("splintered wood", "splintered wood"),
        description = ccb.content.text("A splintered piece of wood, could be used as a skewer or for kindling."),
        category = "other",
        mass_milligrams = 150000,
        volume_ml = 250,
        longest_side_mm = 300,
        melee_to_hit = -3,
        replace_qualities = true,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "stick_long",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("long stick", "long sticks"),
        description = ccb.content.text("A straight section of wood, about eight feet long and a couple of inches in diameter.  Makes a decent melee weapon, and can be broken into shorter pieces for crafting."),
        techniques = { "WBLOCK_1" },
        mass_milligrams = 3000000,
        volume_ml = 5000,
        longest_side_mm = 2600,
        looks_like = "stick",
        melee_to_hit = 0,
        category = "spare_parts",
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:flag("REACH_ATTACK")
    item:clear_use_actions()
    item:native_use("BREAK_STICK")
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    content.add(item)
end

do
    local item = content.Item {
        id = "bamboo_stalk",
        symbol = "/",
        color = "green",
        name = ccb.content.plural_text("green bamboo stalk", "green bamboo stalks"),
        description = ccb.content.text("A freshly cut bamboo stalk.  It is useful for making poles and other simple wooden items, but should be dried before use as a stick."),
        mass_milligrams = 3000000,
        volume_ml = 5000,
        longest_side_mm = 1900,
        stackable = true,
    }
    item:material("wood", 1)
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    content.add(item)
end

do
    local item = content.Item {
        id = "bamboo_stalk_dry",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("dried bamboo stalk", "dried bamboo stalks"),
        description = ccb.content.text("A dried bamboo stalk.  It can be used anywhere a bamboo-compatible stick requirement is specified and can be split into two sticks."),
        mass_milligrams = 2700000,
        volume_ml = 5000,
        longest_side_mm = 1900,
        stackable = true,
    }
    item:material("wood", 1)
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    content.add(item)
end

do
    -- a long pole is a single piece of wood, and the heavy stick just isn't large enough.
    local item = content.Item {
        id = "long_pole",
        name = ccb.content.plural_text("long pole", "long poles"),
        description = ccb.content.text("A stout, ten-foot pole.  Could be used similarly to a spear.  The Cataclysm gives fresh meaning to walking softly and carrying a big stick."),
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        mass_milligrams = 2250000,
        volume_ml = 3750,
        longest_side_mm = 3050,
        weapon_categories = { "POLEARMS" },
        price_cents = 4000,
        price_postapoc_cents = 50,
        melee_to_hit = 1,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("POLEARM")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 19)
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_shaft",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("spear shaft", "spear shafts"),
        looks_like = "q_staff",
        description = ccb.content.text("A long stick, sanded and treated with oil for integrity and carved into a smooth staff with a slight taper, for use in making spears.  It can also be used as a makeshift quarterstaff as-is, but is too thin to be very effective for just hitting people."),
        price_cents = 4000,
        techniques = { "WBLOCK_2", "RAPID" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1000000,
        volume_ml = 1250,
        longest_side_mm = 1800,
        category = "weapons",
        melee_to_hit = 3,
        price_postapoc_cents = 1000,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "firewood",
        name = ccb.content.plural_text("piece of firewood", "pieces of firewood"),
        description = ccb.content.text("A part of a log rough-chopped into firewood, burned for heat for longer than recorded history."),
        category = "spare_parts",
        mass_milligrams = 2847000,
        color = "brown",
        symbol = "/",
        volume_ml = 4821,
        longest_side_mm = 610,
        melee_to_hit = -1,
        price_cents = 500,
        price_postapoc_cents = 5,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 13)
    content.add(item)
end

do
    local item = content.Item {
        id = "tonewood",
        name = ccb.content.plural_text("tonewood", "blocks of tonewood"),
        description = ccb.content.text("A block of tonally appropriate wood that has been air dried for a year in preparation for being turned into a musical instrument."),
        category = "spare_parts",
        mass_milligrams = 1830000,
        color = "brown",
        symbol = "/",
        volume_ml = 3099,
        longest_side_mm = 610,
        melee_to_hit = -1,
        price_cents = 5000,
        price_postapoc_cents = 100,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "tuning_pegs",
        name = ccb.content.plural_text("tuning peg", "tuning pegs"),
        description = ccb.content.text("Tuning pegs go on stringed instruments to both provide an anchor for the strings and to control the tightness of the wire which in turn controls the tune of the notes produced."),
        category = "spare_parts",
        mass_milligrams = 50,
        color = "brown",
        symbol = "/",
        volume_ml = 1,
        longest_side_mm = 10,
        melee_to_hit = -2,
        price_cents = 50,
        price_postapoc_cents = 1,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    content.add(item)
end

do
    local item = content.Item {
        id = "plank_long",
        name = ccb.content.plural_text("long plank", "long planks"),
        description = ccb.content.text("A long 2 by 4 plank of wood.  While not as common as the 4 foot variant, still makes a decent melee weapon, and can be used for all kinds construction."),
        category = "spare_parts",
        mass_milligrams = 4880000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 8264,
        longest_side_mm = 2440,
        melee_to_hit = -1,
        price_cents = 1500,
        price_postapoc_cents = 15,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 26)
    content.add(item)
end

do
    local item = content.Item {
        id = "wood_beam",
        name = ccb.content.plural_text("heavy wooden beam", "heavy wooden beams"),
        description = ccb.content.text("An enormous beam of solid wood, very heavy and hard to lug around, but also very sturdy for construction.  You could saw or chop it into smaller pieces, like planks or panels."),
        category = "spare_parts",
        mass_milligrams = 48861000,
        volume_ml = 82743,
        longest_side_mm = 2440,
        color = "brown",
        symbol = "/",
        price_cents = 40000,
        price_postapoc_cents = 50,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_post",
        name = ccb.content.plural_text("wooden post", "wooden posts"),
        description = ccb.content.text("A wooden post with a 4 by 4 square base.  Posts with a length similar to this are commonly used in mailboxes or as table legs."),
        category = "spare_parts",
        mass_milligrams = 5694000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 9642,
        longest_side_mm = 1220,
        melee_to_hit = -1,
        price_cents = 1000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 26)
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_post_short",
        name = ccb.content.plural_text("short wooden post", "short wooden posts"),
        description = ccb.content.text("A wooden post with a 4 by 4 square base.  Posts with a length similar to this are commonly used as chair legs."),
        category = "spare_parts",
        mass_milligrams = 2847000,
        color = "brown",
        symbol = "/",
        volume_ml = 4821,
        longest_side_mm = 610,
        melee_to_hit = -1,
        price_cents = 500,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_post_long",
        name = ccb.content.plural_text("long wooden post", "long wooden posts"),
        description = ccb.content.text("A wooden post with a 4 by 4 square base.  Posts with a length similar to this are commonly used in the construction of walls and floors."),
        category = "spare_parts",
        mass_milligrams = 11387000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 19248,
        longest_side_mm = 2440,
        melee_to_hit = -1,
        price_cents = 1000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 26)
    content.add(item)
end

do
    local item = content.Item {
        id = "wood_block",
        name = ccb.content.plural_text("small wood block", "small wood blocks"),
        description = ccb.content.text("A small 2x2x5 inches block of wood, primarily used for carving out small wooden objects."),
        category = "spare_parts",
        mass_milligrams = 194000,
        color = "brown",
        symbol = "/",
        volume_ml = 328,
        longest_side_mm = 130,
        price_cents = 1000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Weight and volume assumes 16 square feet of 1/2 inch plywood.  The actual size of the panel likely varies wildly and the item entry may represent several smaller pieces.
    local item = content.Item {
        id = "wood_panel",
        name = ccb.content.plural_text("wooden panel", "wooden panels"),
        description = ccb.content.text("A wide, thin wooden board - plywood, OSB, MDF, tongue-in-groove boards, or similar, already cut to shape.  Good for all kinds of construction, but for really big projects you'd need a proper sheet of uncut plywood or the like."),
        category = "spare_parts",
        mass_milligrams = 12000000,
        longest_side_mm = 1220,
        melee_to_hit = -2,
        color = "brown",
        looks_like = "2x4",
        symbol = "H",
        techniques = { "WBLOCK_1" },
        volume_ml = 19000,
        price_cents = 8000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- Weight and volume assumes 32 square feet of 1/2 inch plywood.  Due to its enormously bulky shape, volume is higher than actual displacement volume
    local item = content.Item {
        id = "wood_sheet",
        name = ccb.content.plural_text("large wooden sheet", "large wooden sheets"),
        description = ccb.content.text("A standard 4 by 8 sheet of flat wood - usually plywood, OSB, or MDF.  Heavy and bulky, it is extremely useful for all manner of construction, but you might have to cut it to size before doing smaller projects."),
        category = "spare_parts",
        mass_milligrams = 24000000,
        melee_to_hit = -2,
        color = "brown",
        symbol = "H",
        techniques = { "WBLOCK_1" },
        volume_ml = 38000,
        longest_side_mm = 2440,
        price_cents = 20000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- weight for a bit less than 3x3x4 wooden beam at 0.60 g/cm3 density, substracted from wood beam stats above
    local item = content.Item {
        id = "giant_wood_screw",
        name = ccb.content.plural_text("giant wooden screw", "giant wooden screws"),
        description = ccb.content.text("A giant screw carved out of solid wood, a simple component used to convert rotational energy into a downward movement of greater force."),
        category = "spare_parts",
        mass_milligrams = 15000000,
        volume_ml = 25000,
        longest_side_mm = 1200,
        color = "brown",
        symbol = "§",
        price_cents = 30000,
        price_postapoc_cents = 20,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end
