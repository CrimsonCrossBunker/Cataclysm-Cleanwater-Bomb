local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "field_stone",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("field stone", "field stones"),
        description = ccb.content.text("A medium, flattish, heavy rock, big enough and flat enough to be used as a block in field stone walls."),
        category = "spare_parts",
        mass_milligrams = 2628000,
        volume_ml = 1000,
        longest_side_mm = 350,
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "rock_large",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("large rock", "large rocks"),
        description = ccb.content.text("A large, heavy rock, big enough to be used as a primitive anvil or shaped into larger stone items."),
        category = "spare_parts",
        mass_milligrams = 15768000,
        volume_ml = 6000,
        longest_side_mm = 300,
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("ANVIL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    content.add(item)
end

do
    -- I am assuming this is made of rock wool, but it could also be fiberglass.  There is almost no practical difference for our purposes.
    local item = content.Item {
        id = "rock_wool_bat",
        symbol = "#",
        color = "brown",
        name = ccb.content.plural_text("fiber insulation batt", "fiber insulation batts"),
        description = ccb.content.text("A foil-wrapped batt of fibrous insulation; fire- and moisture-resistant, it's used for hot appliances like dishwashers and ovens."),
        category = "spare_parts",
        mass_milligrams = 150000,
        volume_ml = 3000,
        stackable = true,
    }
    item:material("epoxy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bone_plaster",
        category = "spare_parts",
        name = ccb.content.plural_text("bone replica", "bone replicas"),
        mass_milligrams = 500000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A plaster replica of a bone."),
        price_cents = 0,
        price_postapoc_cents = 10,
        volume_ml = 250,
        longest_side_mm = 400,
        melee_to_hit = -2,
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_bone_plaster",
        category = "spare_parts",
        name = ccb.content.plural_text("large bone replica", "large bone replicas"),
        mass_milligrams = 70000000,
        color = "white",
        symbol = "I",
        description = ccb.content.text("A plaster replica of a huge bone."),
        price_cents = 0,
        price_postapoc_cents = 20,
        volume_ml = 36000,
        longest_side_mm = 2000,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    content.add(item)
end

do
    local item = content.Item {
        id = "bone_fossil",
        category = "spare_parts",
        name = ccb.content.plural_text("bone fossil", "bone fossils"),
        mass_milligrams = 500000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A fossilized bone.  Not good to eat."),
        price_cents = 0,
        price_postapoc_cents = 10,
        volume_ml = 250,
        longest_side_mm = 400,
        melee_to_hit = -2,
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_bone_fossil",
        category = "spare_parts",
        name = ccb.content.plural_text("large bone replica", "large bone replicas"),
        mass_milligrams = 70000000,
        color = "white",
        symbol = "I",
        description = ccb.content.text("A huge fossilized bone.  Not good to eat."),
        price_cents = 0,
        price_postapoc_cents = 20,
        volume_ml = 36000,
        longest_side_mm = 2000,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    content.add(item)
end
