local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "chair_wood",
        name = ccb.content.plural_text("wooden chair", "wooden chairs"),
        description = ccb.content.text("A simple wooden chair, with four legs, a seat, and a back.  It's nice to rest your feet for once, and if coupled with a suitable table, you could eat a meal properly and almost pretend that things were normal again."),
        category = "other",
        symbol = "#",
        color = "brown",
        price_cents = 3000,
        price_postapoc_cents = 250,
        longest_side_mm = 950,
        volume_ml = 30000,
        mass_milligrams = 12000000,
        melee_to_hit = -2,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "armchair",
        name = ccb.content.plural_text("armchair", "armchairs"),
        description = ccb.content.text("A simple upholstered chair with armrests.  Soft and fairly warm, it definitely beats the ground for sleeping on, though not by much."),
        category = "other",
        symbol = "H",
        color = "green",
        price_cents = 25000,
        price_postapoc_cents = 1500,
        longest_side_mm = 1100,
        volume_ml = 570000,
        mass_milligrams = 27000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:material("cotton", 3)
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "stool_wood",
        name = ccb.content.plural_text("wooden stool", "wooden stools"),
        description = ccb.content.text("A simple stool, with four legs and a seat.  While it's a touch more maneuverable to sit on, the lack of back support means it's significantly less comfortable than a normal chair."),
        category = "other",
        symbol = "#",
        color = "brown",
        price_cents = 3000,
        price_postapoc_cents = 250,
        longest_side_mm = 450,
        volume_ml = 17000,
        mass_milligrams = 3000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "stool_log",
        name = ccb.content.plural_text("log stool", "log stools"),
        description = ccb.content.text("A short section from a tree trunk with one of the flat ends smoothed down.  Makes for a decent place to sit, but not quite a real chair."),
        category = "other",
        symbol = "#",
        color = "brown",
        price_cents = 0,
        price_postapoc_cents = 1,
        longest_side_mm = 500,
        volume_ml = 20000,
        mass_milligrams = 11000000,
        melee_to_hit = -4,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "barstool",
        name = ccb.content.plural_text("bar stool", "bar stools"),
        description = ccb.content.text("A bar stool with a leather seat on a steel support.  Not practical for sleeping at all, but it does feel nicer than sitting on the ground."),
        category = "other",
        symbol = "p",
        color = "light_gray",
        price_cents = 5000,
        price_postapoc_cents = 500,
        longest_side_mm = 800,
        volume_ml = 30000,
        mass_milligrams = 7500000,
        melee_to_hit = -3,
    }
    item:material("steel", 39)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "chair_plywood",
        name = ccb.content.plural_text("plywood chair", "plywood chairs"),
        description = ccb.content.text("A simple chair made of plywood on a steel frame.  Quite uncomfortable but works for sleeping if it's the only option available."),
        category = "other",
        symbol = "#",
        color = "brown",
        price_cents = 3000,
        price_postapoc_cents = 500,
        longest_side_mm = 800,
        volume_ml = 30000,
        mass_milligrams = 5000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 17)
    item:material("steel", 3)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "chair_wood_black",
        name = ccb.content.plural_text("black wooden chair", "black wooden chairs"),
        description = ccb.content.text("A simple wooden chair, with four legs, a seat, and a back.  It's nice to rest your feet for once, and if coupled with a suitable table, you could eat a meal properly and almost pretend that things were normal again.  This particular chair was painted black."),
        copy_from = "chair_wood",
        looks_like = "chair_wood",
        color = "light_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "chair_wood_white",
        name = ccb.content.plural_text("white wooden chair", "white wooden chairs"),
        description = ccb.content.text("A simple wooden chair, with four legs, a seat, and a back.  It's nice to rest your feet for once, and if coupled with a suitable table, you could eat a meal properly and almost pretend that things were normal again.  This particular chair was painted white."),
        copy_from = "chair_wood",
        looks_like = "chair_wood",
        color = "white",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "beanbag",
        name = ccb.content.plural_text("bean bag", "bean bags"),
        description = ccb.content.text("A large cushion filled with beads often used as a seat."),
        category = "other",
        symbol = "O",
        color = "light_blue",
        price_postapoc_cents = 200,
        longest_side_mm = 1000,
        volume_ml = 250000,
        mass_milligrams = 4000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:material("nylon", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 0)
    content.add(item)
end
