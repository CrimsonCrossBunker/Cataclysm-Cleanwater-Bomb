local ccb = require("ccb")
local content = ccb.content

do
    -- Four solar panels stuck together to fit in 1 m x 1 m
    local item = content.Item {
        id = "ground_solar_panel",
        name = ccb.content.plural_text("solar panel array", "solar panel arrays"),
        description = ccb.content.text("A collection of four solar panels, ready to get to work converting solar radiation into electric power.  Install them to use them in a static power grid."),
        copy_from = "solar_panel",
        looks_like = "solar_panel",
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
    -- Assumed to be ~0.5 m x 0.5 m to fit in a vehicle tile
    local item = content.Item {
        id = "solar_panel_v2",
        name = ccb.content.plural_text("vehicle advanced solar panel", "vehicle advanced solar panels"),
        description = ccb.content.text("An electronic device that can convert solar radiation into electric power.  This one is a high-performance type made with monocrystalline silicon cells."),
        price_cents = 190000,
        price_postapoc_cents = 3000,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
    }
    content.add(item)
end

do
    -- Four advanced solar panels stuck together for 1 m x 1 m area
    local item = content.Item {
        id = "ground_solar_panel_v2",
        name = ccb.content.plural_text("advanced solar panel array", "advanced solar panel arrays"),
        description = ccb.content.text("A collection of four smaller solar panels, ready to convert solar radiation into electric power.  These panels are high-performance, made with monocrystalline silicon cells."),
        copy_from = "solar_panel_v2",
        looks_like = "solar_panel_v2",
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
