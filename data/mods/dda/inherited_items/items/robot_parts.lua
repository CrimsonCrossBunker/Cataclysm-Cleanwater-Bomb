local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "spidery_legs_big",
        name = ccb.content.plural_text("set of spidery legs", "sets of spidery legs"),
        description = ccb.content.text("A set of big pointy legs, like the ones found under a tripod."),
        symbol = "W",
        color = "light_gray",
        mass_milligrams = 40000000,
        volume_ml = 20000,
        price_cents = 200000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end
