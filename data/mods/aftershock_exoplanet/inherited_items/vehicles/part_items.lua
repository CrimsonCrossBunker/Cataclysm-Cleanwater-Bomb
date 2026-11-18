local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "solar_panel_v3",
        name = ccb.content.plural_text("quantum solar panel", "quantum solar panels"),
        description = ccb.content.text("This solar panel is obviously cutting-edge technology and given where you found it, it should probably provide a LOT of power.  It's covered in strange-looking material, but the covering looks rather fragile; it doesn't look like it could support a reinforcing sheet, either."),
        melee_to_hit = -5,
        volume_ml = 4500,
        price_cents = 900000,
        copy_from = "solar_panel",
        looks_like = "solar_panel",
    }
    item:material("glass", 1)
    item:material("steel", 1)
    content.upsert_item(item)
end
