local ccb = require("ccb")
local content = ccb.content

do
    -- stats from m8 hex bolt 35 mm (+5 mm for head), 17.11 g the weight of bolt, and 3 g for nut.
    local item = content.Item {
        id = "nuts_bolts",
        category = "spare_parts",
        name = ccb.content.plural_text("nut and bolt", "nuts and bolts"),
        description = ccb.content.text("A matching nut and bolt.  Useful for securing objects together."),
        ascii_picture = "nuts_bolts",
        mass_milligrams = 20000,
        volume_ml = 3,
        longest_side_mm = 40,
        price_cents = 274,
        price_postapoc_cents = 2,
        symbol = "=",
        color = "cyan",
        stackable = true,
    }
    item:material("mc_steel", 1)
    content.add(item)
end
