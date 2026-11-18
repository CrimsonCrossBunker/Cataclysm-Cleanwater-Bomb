local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "parabolan_felt_patch",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("parabolan felt patch", "parabolan felt patches"),
        description = ccb.content.text("A smallish patch of iridescent felt; could be disassembled for parabolan wool fiber."),
        price_cents = 2000,
        price_postapoc_cents = 200,
        mass_milligrams = 3000,
        volume_ml = 6,
        category = "spare_parts",
        melee_to_hit = -1,
    }
    item:material("parabolan_wool", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end
