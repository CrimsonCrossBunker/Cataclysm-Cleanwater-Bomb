local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "integrated_dreamspark_storage_10",
        name = ccb.content.plural_text("Well of Dreamsparks", "Well of Dreamsparks"),
        description = ccb.content.text("The power of mortal dreams."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "[",
        looks_like = "ragpouch",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_SALVAGE")
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:container_pocket {
        max_volume_ml = 10,
        max_weight_milligrams = 0,
        max_item_length_mm = 100,
        moves = 0,
        weight_multiplier = 0.0,
        volume_multiplier = 0.0,
        volume_encumber_modifier = 0,
        allowed_items = { "changeling_dreamspark" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "integrated_dreamspark_storage_20",
        name = ccb.content.plural_text("Well of Dreamsparks", "Well of Dreamsparks"),
        description = ccb.content.text("The power of mortal dreams."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "[",
        looks_like = "ragpouch",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_SALVAGE")
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:container_pocket {
        max_volume_ml = 20,
        max_weight_milligrams = 0,
        max_item_length_mm = 1000,
        moves = 0,
        weight_multiplier = 0.0,
        volume_multiplier = 0.0,
        volume_encumber_modifier = 0,
        allowed_items = { "changeling_dreamspark" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "integrated_dreamspark_storage_30",
        name = ccb.content.plural_text("Well of Dreamsparks", "Well of Dreamsparks"),
        description = ccb.content.text("The power of mortal dreams."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "[",
        looks_like = "ragpouch",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_SALVAGE")
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:container_pocket {
        max_volume_ml = 30,
        max_weight_milligrams = 0,
        max_item_length_mm = 1000,
        moves = 0,
        weight_multiplier = 0.0,
        volume_multiplier = 0.0,
        volume_encumber_modifier = 0,
        allowed_items = { "changeling_dreamspark" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "integrated_dreamspark_storage_40",
        name = ccb.content.plural_text("Well of Dreamsparks", "Well of Dreamsparks"),
        description = ccb.content.text("The power of mortal dreams."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "[",
        looks_like = "ragpouch",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_SALVAGE")
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:container_pocket {
        max_volume_ml = 40,
        max_weight_milligrams = 0,
        max_item_length_mm = 1000,
        moves = 0,
        weight_multiplier = 0.0,
        volume_multiplier = 0.0,
        volume_encumber_modifier = 0,
        allowed_items = { "changeling_dreamspark" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "integrated_dreamspark_storage_50",
        name = ccb.content.plural_text("Well of Dreamsparks", "Well of Dreamsparks"),
        description = ccb.content.text("The power of mortal dreams."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "[",
        looks_like = "ragpouch",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_SALVAGE")
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:container_pocket {
        max_volume_ml = 50,
        max_weight_milligrams = 0,
        max_item_length_mm = 1000,
        moves = 0,
        weight_multiplier = 0.0,
        volume_multiplier = 0.0,
        volume_encumber_modifier = 0,
        allowed_items = { "changeling_dreamspark" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "data_core_slots",
        mass_milligrams = 100000,
        volume_ml = 75,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "cyan",
        name = ccb.content.plural_text("data core slots", "data core slots"),
        description = ccb.content.text("Slots for data cores to be plugged in."),
    }
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("WATER_FRIENDLY")
    item:flag("SOFT")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_NATURAL_ATTACKS")
    item:flag("TRADER_AVOID")
    item:material("superalloy", 1)
    item:material("copper", 1)
    item:tool()
    content.add(item)
end
