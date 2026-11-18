local ccb = require("ccb")
local content = ccb.content

do
    -- Medium weight cotton fabric with a GSM of 203
    local item = content.Item {
        id = "sheet_cotton",
        category = "spare_parts",
        name = ccb.content.plural_text("cotton sheet", "cotton sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of cotton fabric, suitable for making clothing.  You can use it to stop bleeding, but it is very wasteful."),
        mass_milligrams = 23000,
        volume_ml = 47,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 2, bleed = 10, move_cost = 6000 }
    item:material("cotton", 1)
    content.add(item)
end
