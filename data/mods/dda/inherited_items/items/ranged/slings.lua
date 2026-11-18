local ccb = require("ccb")
local content = ccb.content

do
    -- It's little more than a piece of slightly shaped leather
    -- Full bonuses at throwing 3 are a balance choice informed by precise release timing (Denny 2025, https://doi.org/10.1119/5.0226263) and experienced-slinger experiments (Brown Vega and Craig 2009, https://doi.org/10.1016/j.jas.2009.01.018), not a measured skill threshold.
    local item = content.Item {
        id = "sling",
        looks_like = "slingshot",
        category = "weapons",
        symbol = "(",
        color = "brown",
        name = ccb.content.plural_text("sling", "slings", "weapon"),
        description = ccb.content.text("A leather sling.  When wielded, it greatly enhances the throwing range, damage, and accuracy of compatible stones and sling bullets."),
        price_cents = 150,
        mass_milligrams = 96000,
        volume_ml = 80,
        price_postapoc_cents = 250,
    }
    item:material("leather", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("THROW_KEEP_WIELDED")
    item:throw_correction {
        required_flags = { { "SLING_PROJECTILE" } },
        allowed_ammo = { "pebble" },
        full_bonus_skill = 3,
        min_mass_milligrams = 1000,
        max_mass_milligrams = 700000,
        max_volume_ml = 500,
        max_length_mm = 200,
        damage_multiplier = 1.25,
        range_multiplier = 2.5,
        stamina_multiplier = 2,
        dispersion_multiplier = 0.9,
        speed_multiplier = 3.5,
        weight_multiplier = 1.5,
    }
    content.add(item)
end

do
    -- The staff sling consists of a staff with a short sling at one end.
    -- Full bonuses at throwing 3 conservatively reuse the hand-sling requirement; no controlled staff-sling learning comparison was found. This is a balance choice, not a staff-sling result from Denny (2025), https://doi.org/10.1119/5.0226263.
    local item = content.Item {
        id = "staff_sling",
        looks_like = "quarterstaff",
        category = "weapons",
        symbol = "(",
        color = "brown",
        name = ccb.content.plural_text("staff sling", "staff slings"),
        description = ccb.content.text("A staff with a sling pouch at one end.  When wielded, it enhances the throwing range and damage of compatible sling projectiles, and can also serve as a melee weapon.  Fire it to select and launch sling-ready explosives directly from your inventory.  They are activated only when you fire, fall at the first creature or obstacle in their path, and retain their normal fuse."),
        price_cents = 150,
        weapon_categories = { "QUARTERSTAVES" },
        techniques = { "WBLOCK_2", "RAPID", "SWEEP" },
        mass_milligrams = 1333000,
        volume_ml = 1375,
        longest_side_mm = 1500,
        price_postapoc_cents = 250,
        melee_to_hit = 0,
    }
    item:material("wood", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("BELTED")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("THROW_KEEP_WIELDED")
    item:flag("SLING_LAUNCHER")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:throw_correction {
        required_flags = { { "SLING_PROJECTILE" } },
        allowed_ammo = { "pebble" },
        full_bonus_skill = 3,
        min_mass_milligrams = 1000,
        max_mass_milligrams = 1200000,
        max_volume_ml = 500,
        max_length_mm = 300,
        damage_multiplier = 1.5,
        range_multiplier = 2,
        stamina_multiplier = 1.5,
        dispersion_multiplier = 0.9,
        speed_multiplier = 3.0,
        weight_multiplier = 1.2,
    }
    content.add(item)
end

do
    -- It's little more than a piece of slightly shaped leather
    -- Full bonuses at throwing 4 are a balance choice for this item's larger range bonus, not a measured length-specific learning threshold. General sling release timing: Denny (2025), https://doi.org/10.1119/5.0226263.
    local item = content.Item {
        id = "sling_long",
        looks_like = "slingshot",
        category = "weapons",
        symbol = "(",
        color = "brown",
        name = ccb.content.plural_text("long sling", "long slings", "weapon"),
        description = ccb.content.text("A longer sling that provides even greater leverage.  When wielded, it dramatically enhances the throwing range, damage, and accuracy of compatible stones and sling bullets."),
        price_cents = 150,
        mass_milligrams = 90000,
        volume_ml = 100,
        price_postapoc_cents = 250,
    }
    item:material("leather", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("THROW_KEEP_WIELDED")
    item:throw_correction {
        required_flags = { { "SLING_PROJECTILE" } },
        allowed_ammo = { "pebble" },
        full_bonus_skill = 4,
        min_mass_milligrams = 1000,
        max_mass_milligrams = 900000,
        max_volume_ml = 500,
        max_length_mm = 250,
        damage_multiplier = 1.5,
        range_multiplier = 3,
        stamina_multiplier = 4.5,
        dispersion_multiplier = 0.9,
        speed_multiplier = 4,
        weight_multiplier = 1.8,
    }
    content.add(item)
end
