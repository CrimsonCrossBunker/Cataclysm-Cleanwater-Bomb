local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_25_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("25mm casing", "25mm casings"),
        description = ccb.content.text("A large casing from a spent 25mm cartridge."),
        mass_milligrams = 50000,
        volume_ml = 45,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("superalloy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_5x50_hull",
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
