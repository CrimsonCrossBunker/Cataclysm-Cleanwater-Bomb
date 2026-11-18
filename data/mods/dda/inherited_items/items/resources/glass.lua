local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tempered_glass_sheet",
        symbol = "]",
        color = "light_cyan",
        name = ccb.content.plural_text("sheet of tempered glass", "sheets of tempered glass"),
        description = ccb.content.text("A large, durable sheet of tempered glass, approximately six millimeters thick.  A common type of safety glass with the curious property of breaking into small, non-lethal pieces upon shattering."),
        category = "spare_parts",
        price_cents = 10000,
        price_postapoc_cents = 100,
        mass_milligrams = 17514000,
        volume_ml = 7070,
        longest_side_mm = 1220,
        melee_to_hit = -3,
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:fault("fault_broken_window", 100)
    content.add(item)
end
