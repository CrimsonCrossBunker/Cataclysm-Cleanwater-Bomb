local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "swimming_kickboard",
        name = ccb.content.plural_text("swimming kickboard", "swimming kickboards"),
        description = ccb.content.text("A swimming kickboard, would be a great training aid for the beach or the pool, if only they weren't full of zombies and mutant fish."),
        volume_ml = 3450,
        mass_milligrams = 200000,
        longest_side_mm = 370,
        price_cents = 1200,
        price_postapoc_cents = 5,
        color = "blue",
        symbol = "/",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FLOTATION")
    content.add(item)
end

do
    local item = content.Item {
        id = "shuttlecock",
        category = "other",
        name = ccb.content.plural_text("badminton shuttlecock", "shuttlecocks"),
        description = ccb.content.text("A high-drag projectile used in the sport of badminton."),
        mass_milligrams = 5000,
        volume_ml = 600,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "white",
    }
    item:material("rubber", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "golf_tee",
        category = "other",
        name = ccb.content.plural_text("golf tee", "golf tees"),
        description = ccb.content.text("A pin-shaped piece of wood meant for holding a golf ball slightly off the ground."),
        mass_milligrams = 3000,
        volume_ml = 250,
        longest_side_mm = 70,
        price_cents = 1000,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "white",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "golf_ball",
        category = "other",
        name = ccb.content.plural_text("golf ball", "golf balls"),
        description = ccb.content.text("A small, hard plastic ball with round indentations on it."),
        mass_milligrams = 46000,
        longest_side_mm = 43,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "white",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("SLING_PROJECTILE")
    content.add(item)
end

do
    local item = content.Item {
        id = "bowling_ball",
        symbol = "*",
        color = "blue",
        name = ccb.content.plural_text("bowling ball", "bowling balls"),
        description = ccb.content.text("A large, heavy ball with finger holes for better grip.  Before the apocalypse, its main purpose was to be rolled along waxed floors."),
        category = "other",
        price_cents = 3000,
        price_postapoc_cents = 10,
        mass_milligrams = 7257000,
        volume_ml = 5277,
        longest_side_mm = 216,
    }
    item:material("ceramic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    content.add(item)
end

do
    local item = content.Item {
        id = "basketball",
        symbol = "*",
        color = "brown",
        name = ccb.content.plural_text("basketball", "basketballs"),
        category = "other",
        description = ccb.content.text("A high-quality, size 7 indoor basketball."),
        price_cents = 1200,
        price_postapoc_cents = 10,
        mass_milligrams = 800000,
        volume_ml = 1000,
        longest_side_mm = 239,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "indoor_volleyball",
        symbol = "*",
        color = "white",
        name = ccb.content.plural_text("volleyball", "volleyballs"),
        category = "other",
        description = ccb.content.text("A standard regulation volleyball."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 260000,
        volume_ml = 1000,
        longest_side_mm = 260,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mannequin",
        symbol = "@",
        color = "dark_gray",
        name = ccb.content.plural_text("mannequin", "mannequins"),
        category = "other",
        description = ccb.content.text("A figure of an adult human, as seen in the display case at the mall."),
        price_cents = 15000,
        price_postapoc_cents = 500,
        mass_milligrams = 81500000,
        volume_ml = 62500,
        longest_side_mm = 1800,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:clear_use_actions()
    item:deploy_furniture("f_mannequin")
    content.add(item)
end
