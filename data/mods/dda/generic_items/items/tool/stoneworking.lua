local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "billet_bone",
        symbol = ";",
        color = "white",
        name = ccb.content.plural_text("bone billet", "bone billets"),
        description = ccb.content.text("A thick, short bone, usually used in flintknapping for soft-hammer percussion."),
        category = "tools",
        price_cents = 10,
        mass_milligrams = 150000,
        volume_ml = 100,
        longest_side_mm = 200,
        melee_to_hit = -1,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:quality("HAMMER_SOFT", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "billet_wood",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("wooden billet", "wooden billets"),
        description = ccb.content.text("A thick, short wooden stick, usually used in flintknapping for soft-hammer percussion."),
        category = "tools",
        price_cents = 10,
        mass_milligrams = 150000,
        volume_ml = 100,
        longest_side_mm = 200,
        melee_to_hit = -1,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("HAMMER_SOFT", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "drill_rock_primitive",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("primitive rock drill", "primitive rock drills"),
        description = ccb.content.text("A thick, blunted wooden stick.  Can be used to drill rough holes in rock, if water and sand are available, but the process is lengthy."),
        category = "tools",
        price_cents = 10,
        mass_milligrams = 150000,
        volume_ml = 100,
        longest_side_mm = 200,
        melee_to_hit = -1,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("DRILL_ROCK", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "punch_bone",
        symbol = ";",
        color = "white",
        name = ccb.content.plural_text("bone punch", "bone punches"),
        description = ccb.content.text("A thick, short bone with a small, pointy tip, usually used in flintknapping for indirect percussion and pressure flaking."),
        category = "tools",
        price_cents = 10,
        mass_milligrams = 92000,
        volume_ml = 100,
        longest_side_mm = 150,
        melee_to_hit = -4,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:quality("PUNCH", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "punch_nail",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("nail punch", "nail punches"),
        description = ccb.content.text("Two pieces of wood with a steel nail secured between them with some cordage.  Usually used in flintknapping for indirect percussion and pressure flaking."),
        category = "tools",
        price_cents = 10,
        mass_milligrams = 150000,
        volume_ml = 100,
        longest_side_mm = 150,
        melee_to_hit = -4,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("PUNCH", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 4)
    content.add(item)
end
