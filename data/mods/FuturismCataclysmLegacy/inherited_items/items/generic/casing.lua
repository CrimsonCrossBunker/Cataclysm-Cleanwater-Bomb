local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fcl_5x50_hull",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("5x50mm hull", "5x50mm hulls"),
        description = ccb.content.text("An empty plastic hull from a 5x50mm flechette round."),
        mass_milligrams = 1000,
        volume_ml = 5,
        color = "light_green",
    }
    item:material("plastic", 1)
    content.add(item)
end
