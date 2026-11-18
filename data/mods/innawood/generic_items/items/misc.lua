local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "light_battery_shell",
        category = "spare_parts",
        name = ccb.content.plural_text("light battery shell", "light battery shells"),
        description = ccb.content.text("This is the outer casing of a light battery.  It will need to be refilled to be useful."),
        ascii_picture = "light_battery_cell",
        mass_milligrams = 10000,
        volume_ml = 35,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "light_gray",
        looks_like = "battery",
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "medium_battery_shell",
        category = "spare_parts",
        name = ccb.content.plural_text("medium battery shell", "medium battery shells"),
        description = ccb.content.text("This is the outer casing of a medium battery.  It will need to be refilled to be useful."),
        ascii_picture = "medium_battery_cell",
        mass_milligrams = 175000,
        volume_ml = 525,
        price_postapoc_cents = 250,
        symbol = "=",
        color = "light_gray",
        looks_like = "battery",
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "heavy_battery_shell",
        category = "spare_parts",
        name = ccb.content.plural_text("heavy battery shell", "heavy battery shells"),
        description = ccb.content.text("This is the outer casing of a heavy battery.  It will need to be refilled to be useful."),
        ascii_picture = "heavy_battery_cell",
        mass_milligrams = 450000,
        volume_ml = 1500,
        price_postapoc_cents = 375,
        symbol = "=",
        color = "light_gray",
        looks_like = "battery",
    }
    item:material("iron", 1)
    content.add(item)
end
