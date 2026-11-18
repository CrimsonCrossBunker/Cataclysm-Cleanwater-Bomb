local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "grinder_cutoff_disc",
        symbol = "o",
        color = "dark_gray",
        name = ccb.content.plural_text("cutoff disc", "cutoff discs"),
        description = ccb.content.text("A manufactured disc for an angle grinder, with a thin, abrasive edge designed for cutting metal."),
        category = "spare_parts",
        price_cents = 20,
        price_postapoc_cents = 500,
        mass_milligrams = 349000,
        volume_ml = 250,
        melee_to_hit = -4,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "grinder_metal_grinding_disc",
        symbol = "o",
        color = "dark_gray",
        name = ccb.content.plural_text("metal grinding disc", "metal grinding discs"),
        description = ccb.content.text("A manufactured disc for an angle grinder, with a thick, abrasive surface designed for grinding and shaping metal."),
        category = "spare_parts",
        price_cents = 20,
        price_postapoc_cents = 500,
        mass_milligrams = 349000,
        volume_ml = 250,
        melee_to_hit = -4,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "carding_paddles",
        category = "tools",
        name = ccb.content.plural_text("carding paddles (pair)", "carding paddles (pair)"),
        description = ccb.content.text("A pair of toothy wooden paddles used to clean fibers for use in textile production."),
        mass_milligrams = 360000,
        volume_ml = 500,
        longest_side_mm = 265,
        price_cents = 3000,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "distaff_spindle",
        category = "tools",
        name = ccb.content.plural_text("distaff and spindle", "distaves and spindles"),
        description = ccb.content.text("A pair of specialized wooden rods used to spin fibers into thread and yarn."),
        mass_milligrams = 612000,
        volume_ml = 1500,
        longest_side_mm = 610,
        price_cents = 7000,
        price_postapoc_cents = 15,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1" },
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "toolbox_empty",
        category = "container",
        name = ccb.content.plural_text("toolbox", "toolboxes"),
        description = ccb.content.text("A stout metal box for holding tools.  It has a handle on the top and a latch on the front."),
        mass_milligrams = 4377000,
        volume_ml = 8000,
        longest_side_mm = 420,
        price_cents = 1700,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "red",
        replace_pockets = true,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 7800, max_weight_milligrams = 15000000, max_item_length_mm = 400, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "toolbox_workshop_empty",
        category = "container",
        name = ccb.content.plural_text("workshop toolbox", "workshop toolboxes"),
        description = ccb.content.text("A stout metal box for holding tools.  It is much bigger than a regular toolbox, and can be used to store more tools as a result."),
        looks_like = "toolbox_empty",
        mass_milligrams = 8618000,
        volume_ml = 34400,
        longest_side_mm = 660,
        price_cents = 14099,
        price_postapoc_cents = 450,
        symbol = ";",
        color = "red",
        replace_pockets = true,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 34000, max_weight_milligrams = 34000000, max_item_length_mm = 650, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end
