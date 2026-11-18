local ccb = require("ccb")
local content = ccb.content

do
    -- Leverage, not spring energy: Whittaker and Maginniss (2006), https://worldatlatl.org/wp-content/uploads/2017/12/2006-2-THE-ATLATL.pdf
    -- Bebber et al. (2023), https://doi.org/10.1038/s41598-023-40451-8, measured faster darts than hand-thrown javelins using different projectile masses. These multipliers are conservative game-balance values, not measured damage or range ratios. Bounds also admit existing JAVELIN items; heavy rigid javelins are not equivalent to the experimental darts.
    -- Full bonuses at throwing 2 are a balance choice informed by velocity gains after brief novice practice in Bebber et al. (2023), https://doi.org/10.1038/s41598-023-40451-8; the study does not measure a game skill threshold.
    local item = content.Item {
        id = "atlatl",
        category = "weapons",
        name = ccb.content.plural_text("atlatl", "atlatls"),
        description = ccb.content.text("Although spear throwing contraptions were used throughout the entire world, this design in particular hails from Mesoamericas.  It was especially popular among Peruvian natives, despite the Nahuatl origin of the name.  It is a carved wooden spear thrower with a hook that holds the tail of a dart.  Its leverage helps launch atlatl darts and suitably sized javelins.  It'll also do well as a melee weapon in a pinch."),
        mass_milligrams = 1200000,
        volume_ml = 2100,
        symbol = "(",
        color = "brown",
        price_cents = 4500,
        price_postapoc_cents = 750,
        longest_side_mm = 600,
        melee_to_hit = 0,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELTED")
    item:flag("FRAGILE_MELEE")
    item:flag("THROW_KEEP_WIELDED")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:throw_correction {
        full_bonus_skill = 2,
        required_flags = { { "JAVELIN" } },
        allowed_ammo = { "atlatl" },
        min_mass_milligrams = 1000,
        max_mass_milligrams = 1200000,
        max_volume_ml = 1500,
        max_length_mm = 2000,
        damage_multiplier = 1.5,
        range_multiplier = 2.0,
        stamina_multiplier = 1.25,
        dispersion_multiplier = 1.0,
        speed_multiplier = 1.25,
        weight_multiplier = 1.25,
    }
    content.add(item)
end
