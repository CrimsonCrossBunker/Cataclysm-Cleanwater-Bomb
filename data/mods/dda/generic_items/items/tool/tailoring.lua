local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "awl_bone",
        category = "tools",
        name = ccb.content.plural_text("bone sewing awl", "bone sewing awls"),
        description = ccb.content.text("A crude, sharpened bone awl, used for leatherworking before metal was discovered.  It can also serve as an improvised stabbing weapon, but will break quickly."),
        mass_milligrams = 140000,
        volume_ml = 100,
        price_cents = 300,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("bone", 1)
    item:quality("LEATHER_AWL", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "awl_steel",
        copy_from = "awl_bone",
        looks_like = "awl_bone",
        name = ccb.content.plural_text("steel sewing awl", "steel sewing awls"),
        description = ccb.content.text("A steel awl with a wooden grip, usually used for leatherworking.  It can also serve as an improvised stabbing weapon, but will break quickly."),
        mass_milligrams = 50000,
        volume_ml = 42,
        longest_side_mm = 130,
        price_cents = 800,
        price_postapoc_cents = 100,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("LEATHER_AWL", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 10)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0BCQML8GQ
    local item = content.Item {
        id = "knitting_needles",
        category = "tools",
        name = ccb.content.plural_text("knitting needles (pair)", "knitting needles (pair)"),
        description = ccb.content.text("A pair of stout wooden needles with round ends, used to turn thread and yarn into cloth."),
        mass_milligrams = 18000,
        volume_ml = 40,
        longest_side_mm = 360,
        price_cents = 700,
        price_postapoc_cents = 15,
        symbol = ",",
        color = "brown",
        replace_qualities = true,
        melee_to_hit = -2,
    }
    item:material("wood", 1)
    item:quality("KNIT", 1)
    item:clear_melee_damage()
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "loom_frame",
        category = "tools",
        name = ccb.content.plural_text("frame loom", "frame looms"),
        description = ccb.content.text("A rather bulky and primitive wooden frame which can be used to weave cloth sheets.  The process is very slow, though."),
        mass_milligrams = 3804000,
        volume_ml = 6000,
        price_cents = 4000,
        price_postapoc_cents = 750,
        symbol = ";",
        color = "yellow",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "shed_stick",
        category = "tools",
        name = ccb.content.plural_text("wooden shed stick", "wooden shed sticks"),
        description = ccb.content.text("A short, thin, flat wooden stick, used as a tool while weaving cloth with a frame loom."),
        mass_milligrams = 300000,
        volume_ml = 250,
        price_cents = 100,
        price_postapoc_cents = 15,
        symbol = ";",
        color = "yellow",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "tailoring_pattern_set",
        category = "tools",
        name = ccb.content.plural_text("tailoring pattern set", "tailoring pattern sets"),
        description = ccb.content.text("A large set of tailoring patterns made from paper.  They're useful for making any kind of cloth or leather items from scratch, but are necessary for more advanced projects."),
        mass_milligrams = 1000000,
        volume_ml = 833,
        price_cents = 4000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "yellow",
    }
    item:material("paper", 1)
    content.add(item)
end
