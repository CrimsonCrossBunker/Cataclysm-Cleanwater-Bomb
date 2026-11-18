local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "standing_pyrokinetic_lamp",
        name = ccb.content.plural_text("disconnected standing matrix lamp", "disconnected standing matrix lamps"),
        description = ccb.content.text("A tall floor lamp that provides illumination when plugged into a power outlet.  This lamp is enhanced with matrix technology, making it far more power efficient."),
        mass_milligrams = 2500000,
        melee_to_hit = -1,
        volume_ml = 2000,
        longest_side_mm = 1700,
        price_cents = 9000,
        price_postapoc_cents = 500,
        symbol = "L",
        color = "white",
        looks_like = "f_floor_lamp",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end
