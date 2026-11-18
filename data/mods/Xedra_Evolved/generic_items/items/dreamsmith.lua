local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dreamforged_bed_of_restful_repose",
        name = ccb.content.plural_text("dreamforged bed of restful repose, folded for travel", "dreamforged beds of restful repose, folded for travel"),
        description = ccb.content.text("A large object folded up into a box for itself, the size of a keyboard."),
        symbol = "H",
        color = "cyan",
        price_cents = 25000,
        price_postapoc_cents = 1500,
        longest_side_mm = 2130,
        volume_ml = 570000,
        mass_milligrams = 57000000,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:material("dreamstuff", 75)
    item:material("wood", 25)
    content.add(item)
end
