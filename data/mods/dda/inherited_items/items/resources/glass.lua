local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tempered_glass_sheet",
        symbol = "]",
        color = "light_cyan",
        name = ccb.content.plural_text("sheet of tempered glass", "sheets of tempered glass"),
        description = ccb.content.text("A large, durable sheet of tempered glass, approximately six millimeters thick.  A common type of safety glass with the curious property of breaking into small, non-lethal pieces upon shattering."),
        category = "spare_parts",
        price_cents = 10000,
        price_postapoc_cents = 100,
        mass_milligrams = 17514000,
        volume_ml = 7070,
        longest_side_mm = 1220,
        melee_to_hit = -3,
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:fault("fault_broken_window", 100)
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_shard",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("glass shard", "glass shards"),
        category = "other",
        description = ccb.content.text("A broken shard of glass covered in sharp edges.  You could use it as a weapon, but you might want to wear gloves."),
        mass_milligrams = 75000,
        volume_ml = 30,
        melee_to_hit = -5,
        weapon_categories = { "SHIVS" },
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_glass",
        moves = 12000,
        practice = 2,
        message = ccb.content.text("You carefully place the shards on the ground, ready to be cracked by something passing by."),
    }
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_sheet",
        symbol = "]",
        color = "light_cyan",
        name = ccb.content.plural_text("sheet of glass", "sheets of glass"),
        description = ccb.content.text("A large sheet of glass, around three by four feet.  Easily shattered.  Useful for repairing windows."),
        category = "spare_parts",
        price_cents = 5000,
        price_postapoc_cents = 100,
        mass_milligrams = 6577000,
        volume_ml = 2655,
        longest_side_mm = 1220,
        melee_to_hit = -3,
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_glass",
        moves = 60000,
        practice = 2,
        message = ccb.content.text("You break the pane and place the shards on the ground, ready to be cracked by something passing by."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:fault("fault_broken_window", 100)
    content.add(item)
end
