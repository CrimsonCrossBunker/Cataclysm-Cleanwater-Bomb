local ccb = require("ccb")
local content = ccb.content

do
    -- 8 g of some unknown to me explosive material, let's assume comp b for simplicity
    local item = content.Item {
        id = "60mm_propellant",
        name = ccb.content.plural_text("60 mm mortar propellant charge", "60 mm mortar propellant charges"),
        description = ccb.content.text("Small explosive in a form of donut without a piece, this thing is designed to be attached on the mortar shell tail, to increase the projectile velocity and, therefore, its range.  Since the projectile it was connected to was already shot, you can only cut it for its content."),
        mass_milligrams = 50000,
        volume_ml = 70,
        longest_side_mm = 45,
        price_cents = 1400,
        price_postapoc_cents = 200,
        symbol = "=",
        color = "dark_gray",
    }
    item:clear_flags()
    item:flag("IRREPLACEABLE_CONSUMABLE")
    item:material("plastic", 80)
    item:material("powder", 20)
    content.add(item)
end
