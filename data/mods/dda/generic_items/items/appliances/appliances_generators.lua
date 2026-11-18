local ccb = require("ccb")
local content = ccb.content

do
    -- https://www.amazon.com/dp/B0D6PM5XN1
    -- 17.9'' x 11.7'' x 19.7''
    -- Prevent loading items into the generator while it's not in appliance form.
    local item = content.Item {
        id = "portable_generator",
        category = "other",
        name = ccb.content.plural_text("portable gasoline generator", "portable gasoline generators"),
        looks_like = "f_active_backup_generator",
        description = ccb.content.text("Small, portable generator, one that people buy for a camp.  It just needs to be plugged in, fueled up, and then turned on."),
        mass_milligrams = 21817000,
        melee_to_hit = -3,
        volume_ml = 67609,
        longest_side_mm = 454,
        price_cents = 59900,
        price_postapoc_cents = 2500,
        replace_pockets = true,
        symbol = "O",
        color = "green_white",
    }
    item:clear_use_actions()
    item:deploy_appliance("portable_generator")
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 5829,
        max_weight_milligrams = 25000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
        allowed_items = { "gasoline" },
    }
    item:clear_flags()
    item:flag("NO_RELOAD")
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    -- 'Könner & Söhnen' KS 9300DE-1/3 ATSR
    -- 920 x 580 x 860 mm
    local item = content.Item {
        id = "diesel_generator",
        copy_from = "portable_generator",
        name = ccb.content.plural_text("diesel generator", "diesel generators"),
        looks_like = "f_active_backup_generator",
        description = ccb.content.text("Big and powerful generator, used for street works.  It just needs to be plugged in, fueled up, and then turned on.  Has little wheels to make it easier to move."),
        mass_milligrams = 168000000,
        melee_to_hit = -3,
        volume_ml = 459000,
        longest_side_mm = 920,
        price_cents = 196300,
        price_postapoc_cents = 4000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("diesel_generator")
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 15000,
        max_weight_milligrams = 100000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
        allowed_items = { "diesel", "biodiesel", "jp8", "lamp_oil", "motor_oil" },
    }
    content.add(item)
end

do
    -- MEP803A
    -- 32 x 37 x 62 inch, should be 1202 L
    local item = content.Item {
        id = "military_generator",
        copy_from = "portable_generator",
        name = ccb.content.plural_text("military diesel generator", "military diesel generators"),
        looks_like = "f_active_backup_generator",
        description = ccb.content.text("Big and powerful generator, painted in camo.  It just needs to be plugged in, fueled up, and then turned on."),
        mass_milligrams = 536000000,
        melee_to_hit = -3,
        volume_ml = 1000000,
        longest_side_mm = 1575,
        price_cents = 429500,
        price_postapoc_cents = 5000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("military_generator")
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 34000,
        max_weight_milligrams = 100000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
        allowed_items = { "diesel", "biodiesel", "jp8", "lamp_oil", "motor_oil" },
    }
    content.add(item)
end

do
    -- Champion 201160
    -- 83.9 x 67.55 x 73.5 cm + 4L small cart wheels separately
    local item = content.Item {
        id = "12000_gasoline_generator",
        copy_from = "portable_generator",
        name = ccb.content.plural_text("powerful gasoline generator", "powerful gasoline generators"),
        looks_like = "f_active_backup_generator",
        description = ccb.content.text("Still reasonably portable, this 12000 W gasoline generator can power up an entire house.  It just needs to be plugged in, fueled up, and then turned on."),
        mass_milligrams = 150000000,
        melee_to_hit = -3,
        volume_ml = 420000,
        longest_side_mm = 1575,
        price_cents = 283000,
        price_postapoc_cents = 5000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("12000_gasoline_generator")
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 41000,
        max_weight_milligrams = 100000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
        allowed_items = { "gasoline" },
    }
    content.add(item)
end
