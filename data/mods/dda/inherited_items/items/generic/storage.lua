local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "clothes_hanger",
        name = ccb.content.plural_text("clothes hanger", "clothes hangers"),
        description = ccb.content.text("A plastic clothes hanger with a metal hook to hang something on a rail."),
        mass_milligrams = 100000,
        volume_ml = 150,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "brown",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "storage_line",
        category = "container",
        name = ccb.content.plural_text("storage line", "storage lines"),
        description = ccb.content.text("A four foot long collection of carabiners for hanging items while camping."),
        mass_milligrams = 127000,
        volume_ml = 500,
        longest_side_mm = 450,
        price_cents = 4000,
        price_postapoc_cents = 200,
        symbol = "[",
        looks_like = "rope_6",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("nylon", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 2000000,
        holster = true,
        max_item_length_mm = 300,
        min_item_length_mm = 100,
        moves = 150,
        description = ccb.content.text("Small carabiner."),
    }
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 2000000,
        holster = true,
        max_item_length_mm = 300,
        min_item_length_mm = 100,
        moves = 150,
        description = ccb.content.text("Small carabiner."),
    }
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 2000000,
        holster = true,
        max_item_length_mm = 300,
        min_item_length_mm = 100,
        moves = 150,
        description = ccb.content.text("Small carabiner."),
    }
    item:container_pocket {
        max_volume_ml = 4000,
        max_weight_milligrams = 4000000,
        holster = true,
        max_item_length_mm = 400,
        min_item_length_mm = 100,
        moves = 150,
        description = ccb.content.text("Large carabiner."),
    }
    item:container_pocket {
        max_volume_ml = 4000,
        max_weight_milligrams = 4000000,
        holster = true,
        max_item_length_mm = 400,
        min_item_length_mm = 100,
        moves = 150,
        description = ccb.content.text("Large carabiner."),
    }
    item:clear_flags()
    item:flag("WATER_FRIENDLY")
    item:flag("HARD")
    content.add(item)
end
