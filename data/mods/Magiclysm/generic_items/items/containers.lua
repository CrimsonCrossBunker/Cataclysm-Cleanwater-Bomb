local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bag_holding_1",
        category = "container",
        name = ccb.content.plural_text("lesser dimensional bag", "lesser dimensional bags"),
        description = ccb.content.text("This is a bag that can contain more than it should.  The bag magically reduces the weight of its contents and expands less than the amount of stuff you put into it.  It takes a few words and hand-waving to take an item out."),
        symbol = "U",
        color = "magenta",
        volume_ml = 4000,
        mass_milligrams = 4000000,
        price_cents = 300000,
        replace_pockets = true,
    }
    item:clear_flags()
    item:flag("TARDIS")
    item:container_pocket {
        max_volume_ml = 40000,
        max_weight_milligrams = 50000000,
        moves = 1800,
        max_item_volume_ml = 7000,
        max_item_length_mm = 3000,
        spoil_multiplier = 1.5,
        weight_multiplier = 0.7,
        volume_multiplier = 0.7,
        rigid = false,
        magazine_well_ml = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_holding_2",
        copy_from = "bag_holding_1",
        looks_like = "bag_holding_1",
        category = "container",
        name = ccb.content.plural_text("dimensional bag", "dimensional bags"),
        mass_milligrams = 6000000,
        price_cents = 750000,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 100000,
        max_weight_milligrams = 110000000,
        moves = 1800,
        max_item_volume_ml = 10000,
        max_item_length_mm = 4000,
        spoil_multiplier = 1.5,
        weight_multiplier = 0.5,
        volume_multiplier = 0.5,
        rigid = false,
        magazine_well_ml = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_holding_3",
        copy_from = "bag_holding_1",
        looks_like = "bag_holding_1",
        category = "container",
        name = ccb.content.plural_text("greater dimensional bag", "greater dimensional bags"),
        description = ccb.content.text("This dimensional bag has reached the limits of human innovation with a combination of manufacturing and magical secrets."),
        mass_milligrams = 10000000,
        price_cents = 8500000,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 165000,
        max_weight_milligrams = 200000000,
        moves = 1800,
        max_item_volume_ml = 15000,
        max_item_length_mm = 6000,
        spoil_multiplier = 1.5,
        weight_multiplier = 0.3,
        volume_multiplier = 0.3,
        rigid = false,
        magazine_well_ml = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fridge_holding_1",
        category = "container",
        name = ccb.content.plural_text("supergravity preservation box", "supergravity preservation boxes"),
        description = ccb.content.text("A box that uses gravity magic to preserve food.  It makes the box much heavier, but anything in it lasts far longer and you can store more."),
        mass_milligrams = 80000000,
        symbol = "E",
        color = "light_red",
        volume_ml = 100000,
        price_cents = 400000,
        replace_pockets = true,
    }
    item:clear_flags()
    item:flag("TARDIS")
    item:container_pocket {
        max_volume_ml = 200000,
        max_weight_milligrams = 500000000,
        moves = 2300,
        max_item_length_mm = 1000,
        spoil_multiplier = 0.2,
        weight_multiplier = 2.5,
        rigid = true,
    }
    content.add(item)
end
