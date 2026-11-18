local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "reinforced_glass_sheet",
        symbol = "]",
        color = "light_blue",
        name = ccb.content.plural_text("sheet of reinforced glass", "sheets of reinforced glass"),
        description = ccb.content.text("A large sheet of bulletproof glass, it looks to a little over two inches thick."),
        category = "spare_parts",
        price_cents = 10000,
        price_postapoc_cents = 250,
        mass_milligrams = 45900000,
        volume_ml = 21200,
        longest_side_mm = 1220,
        melee_to_hit = -3,
    }
    item:material("glass", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "reinforced_glass_pane",
        symbol = "]",
        color = "light_blue",
        name = ccb.content.plural_text("pane of reinforced glass", "panes of reinforced glass"),
        description = ccb.content.text("A small pane of bulletproof glass, it looks to be a little over two inches thick."),
        category = "spare_parts",
        price_cents = 5000,
        price_postapoc_cents = 100,
        mass_milligrams = 11475000,
        volume_ml = 5300,
        longest_side_mm = 305,
        stackable = true,
    }
    item:material("glass", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
