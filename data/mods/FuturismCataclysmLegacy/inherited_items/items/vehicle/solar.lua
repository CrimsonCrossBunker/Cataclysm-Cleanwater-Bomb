local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "solar_panel_v3",
        name = ccb.content.plural_text("quantum solar panel", "quantum solar panels"),
        description = ccb.content.text("This solar panel is obviously cutting-edge technology and given where you found it, it should probably provide a LOT of power.  It's covered in strange-looking material, and the covering looks rather fragile; reinforcing or modifying it would require unusually careful, advanced work."),
        melee_to_hit = -5,
        volume_ml = 4500,
        price_cents = 900000,
        price_postapoc_cents = 9000,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
    }
    item:material("glass", 1)
    item:material("steel", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "reinforced_solar_panel_v3",
        name = ccb.content.plural_text("vehicle reinforced quantum solar panel", "vehicle reinforced quantum solar panels"),
        description = ccb.content.text("A quantum solar panel covered with a pane of reinforced glass to protect the delicate exotic photovoltaic layer.  The glass causes this panel to produce slightly less power than a normal quantum panel."),
        mass_milligrams = 24153000,
        color = "light_blue",
        volume_ml = 6500,
        price_cents = 1020000,
        price_postapoc_cents = 10500,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
    }
    item:material("glass", 1)
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- Four quantum solar panels stuck together for 1 m x 1 m area
    local item = content.Item {
        id = "ground_solar_panel_v3",
        name = ccb.content.plural_text("quantum solar panel array", "quantum solar panel arrays"),
        description = ccb.content.text("A collection of four quantum solar panels, ready to convert solar radiation into electric power with exotic photovoltaic materials."),
        copy_from = "solar_panel_v3",
        looks_like = "solar_panel_v3",
    }
    item:adjust_measurements {
        longest_side_mm = { factor = 2 },
        price_cents = { factor = 4 },
        price_postapoc_cents = { factor = 4 },
        volume_ml = { factor = 4 },
        mass_milligrams = { factor = 4 },
    }
    content.add(item)
end

do
    -- Four reinforced quantum solar panels stuck together for 1 m x 1 m area
    local item = content.Item {
        id = "reinforced_ground_solar_panel_v3",
        name = ccb.content.plural_text("reinforced quantum solar panel array", "reinforced quantum solar panel arrays"),
        description = ccb.content.text("A collection of four reinforced quantum solar panels, ready to provide static-grid power while better protected from impact damage."),
        copy_from = "reinforced_solar_panel_v3",
        looks_like = "reinforced_solar_panel_v3",
    }
    item:adjust_measurements {
        longest_side_mm = { factor = 2 },
        price_cents = { factor = 4 },
        price_postapoc_cents = { factor = 4 },
        volume_ml = { factor = 4 },
        mass_milligrams = { factor = 4 },
    }
    content.add(item)
end
