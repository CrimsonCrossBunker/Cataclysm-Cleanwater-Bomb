local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "hatchet",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("hatchet", "hatchets"),
        description = ccb.content.text("A one-handed hatchet.  Makes a great melee weapon, and is useful both for chopping things and hammering them."),
        category = "tools",
        price_cents = 2500,
        price_postapoc_cents = 500,
        techniques = { "WBLOCK_1" },
        mass_milligrams = 907000,
        volume_ml = 1000,
        longest_side_mm = 380,
        melee_to_hit = 0,
        weapon_categories = { "HAND_AXES" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:quality("CUT", 1)
    item:quality("AXE", 2, 1.5)
    item:quality("BUTCHER", 16)
    item:quality("HAMMER", 2)
    item:quality("HAMMER_FINE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 20)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general_no_tip", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bow_saw",
        name = ccb.content.plural_text("bow saw", "bow saws"),
        description = ccb.content.text("A saw that is more at home outdoors than inside.  It's used for trimming trees, pruning, and cutting firewood, but may be used for other rough cuts as well."),
        mass_milligrams = 750000,
        volume_ml = 3500,
        longest_side_mm = 880,
        price_cents = 3000,
        price_postapoc_cents = 100,
        symbol = "(",
        color = "red",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("AXE", 2)
    item:quality("SAW_W", 2)
    item:quality("BUTCHER", -90)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "copper_ax",
        name = ccb.content.plural_text("copper hatchet", "copper hatchets"),
        description = ccb.content.text("A primitive axe made from a small wedge of copper affixed to a short haft."),
        mass_milligrams = 379000,
        volume_ml = 1000,
        longest_side_mm = 350,
        price_cents = 500,
        price_postapoc_cents = 50,
        melee_to_hit = 0,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
        weapon_categories = { "HAND_AXES" },
    }
    item:material("wood", 1)
    item:material("copper", 1)
    item:quality("CUT", 1)
    item:quality("AXE", 1, 2.2)
    item:quality("BUTCHER", -44)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("cut", 14)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general_no_tip", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_axe",
        name = ccb.content.plural_text("bronze axe", "bronze axes"),
        description = ccb.content.text("A socketed bronze axe with a work-hardened edge, tightly bound to the shaft with cords."),
        mass_milligrams = 1489000,
        volume_ml = 2000,
        longest_side_mm = 560,
        price_cents = 5500,
        price_postapoc_cents = 250,
        melee_to_hit = 0,
        symbol = "/",
        color = "yellow",
        looks_like = "ax",
        replace_qualities = true,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:quality("CUT", 1)
    item:quality("AXE", 2, 1.5)
    item:quality("BUTCHER", -30)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 24)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general_no_tip", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "luthier_toolset",
        name = ccb.content.plural_text("luthier toolset", "luthier toolsets"),
        description = ccb.content.text("A set of luthier tools in several sizes and types.  Guaranteed to have the right tools for creating musical instruments from wood."),
        looks_like = "screwdriver_set",
        mass_milligrams = 1600000,
        volume_ml = 1500,
        longest_side_mm = 280,
        price_cents = 20000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("LUTHIER", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_axe",
        name = ccb.content.plural_text("stone axe head", "stone axe heads"),
        description = ccb.content.text("A broad piece of stone with an edge narrow enough to roughly chop wood."),
        mass_milligrams = 453000,
        volume_ml = 230,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("CUT", 1)
    item:quality("AXE", 1, 12)
    item:quality("BUTCHER", -50)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 11)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_axe",
        copy_from = "hand_axe",
        looks_like = "hand_axe",
        name = ccb.content.plural_text("metal axe head", "metal axe heads"),
        description = ccb.content.text("A chunk of steel with one edge hammered down to something resembling a cutting edge.  It works passably well, but really can't compare to a proper axe."),
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_AXE")
    item:quality("CUT", 1)
    item:quality("AXE", 1, 7)
    item:quality("BUTCHER", -50)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "primitive_adze",
        name = ccb.content.plural_text("stone adze", "stone adzes"),
        description = ccb.content.text("A stone adze, a primitive tool for smoothing or scraping wood objects."),
        mass_milligrams = 950000,
        volume_ml = 1000,
        longest_side_mm = 560,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:material("wood", 1)
    item:quality("SAW_W", 1)
    item:quality("BUTCHER", -56)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "primitive_axe",
        name = ccb.content.plural_text("stone axe", "stone axes"),
        description = ccb.content.text("A stone with a narrow edge affixed to a stick.  It can chop wood, but requires much more effort than a modern axe."),
        mass_milligrams = 822000,
        volume_ml = 1000,
        longest_side_mm = 560,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = "/",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:quality("CUT", 1)
    item:quality("AXE", 1, 3)
    item:quality("BUTCHER", -70)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "saw",
        name = ccb.content.plural_text("wood saw", "wood saws"),
        description = ccb.content.text("A thin saw, useful for cutting through wood objects.  Activate it to turn pre-cut logs into planks."),
        mass_milligrams = 283000,
        volume_ml = 1000,
        longest_side_mm = 460,
        price_cents = 3000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("AXE", 1)
    item:quality("SAW_W", 2)
    item:quality("BUTCHER", -90)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "stone_chisel",
        name = ccb.content.plural_text("stone chisel", "stone chisels"),
        looks_like = "chisel",
        description = ccb.content.text("A short, primitive chisel made from hard stone, usually used for primitive woodworking."),
        mass_milligrams = 600000,
        volume_ml = 250,
        longest_side_mm = 200,
        price_cents = 200,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("CHISEL", 1)
    item:quality("CHISEL_WOOD", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end
