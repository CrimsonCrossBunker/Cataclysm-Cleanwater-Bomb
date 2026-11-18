local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "reinforced_solar_panel",
        name = ccb.content.plural_text("vehicle reinforced solar panel", "vehicle reinforced solar panels"),
        description = ccb.content.text("A solar panel that has been covered with a pane of reinforced glass to protect the delicate solar cells from zombies or errant baseballs.  The glass causes this panel to produce slightly less power than a normal panel."),
        mass_milligrams = 24153000,
        color = "light_blue",
        volume_ml = 6500,
        price_cents = 120000,
        price_postapoc_cents = 1500,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
    }
    item:material("glass", 1)
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "reinforced_solar_panel_v2",
        name = ccb.content.plural_text("vehicle advanced reinforced solar panel", "vehicle advanced reinforced solar panels"),
        description = ccb.content.text("An advanced solar panel that has been covered with a pane of reinforced glass to protect the delicate solar cells from zombies or errant baseballs.  The glass causes this panel to produce slightly less power than a normal advanced panel."),
        price_cents = 240000,
        price_postapoc_cents = 3500,
        copy_from = "reinforced_solar_panel",
        looks_like = "reinforced_solar_panel",
    }
    content.add(item)
end

do
    -- Standard polycrystalline wafers are ~156 mm square; 15 cm x 15 cm x ~1.1 cm is ~250 ml
    local item = content.Item {
        id = "solar_cell",
        name = ccb.content.plural_text("solar cell", "solar cells"),
        description = ccb.content.text("A small electronic device that can convert solar radiation into electric power.  This one is a common, inexpensive type made of polycrystalline silicon."),
        mass_milligrams = 500000,
        symbol = ";",
        volume_ml = 250,
        longest_side_mm = 150,
        category = "spare_parts",
        price_cents = 5000,
        price_postapoc_cents = 100,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "solar_cell_v2",
        name = ccb.content.plural_text("advanced solar cell", "advanced solar cells"),
        description = ccb.content.text("A small electronic device that can convert solar radiation into electric power.  This one is a high-performance type made of monocrystalline silicon."),
        price_cents = 15000,
        price_postapoc_cents = 300,
        copy_from = "solar_cell",
        looks_like = "solar_cell",
        stackable = true,
    }
    content.add(item)
end
