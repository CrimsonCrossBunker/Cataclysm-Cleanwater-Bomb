local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tripod_chassis",
        name = ccb.content.plural_text("tripod chassis", "tripod chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the tripod."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 40000000,
        volume_ml = 70000,
        price_cents = 200000,
        category = "spare_parts",
    }
    item:material("steel", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "utilibot_chassis",
        name = ccb.content.plural_text("Seneschal chassis", "Seneschal chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Seneschal."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 40000000,
        volume_ml = 70000,
        price_cents = 200000,
        category = "spare_parts",
    }
    item:material("steel", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "utilibot_const_chassis",
        name = ccb.content.plural_text("Udarnik chassis", "Udarnik chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Udarnik."),
        copy_from = "utilibot_chassis",
        looks_like = "utilibot_chassis",
        color = "dark_gray",
    }
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "medibot_chassis",
        name = ccb.content.plural_text("surgical droid chassis", "surgical droid chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the surgical droid."),
        copy_from = "utilibot_chassis",
        looks_like = "utilibot_chassis",
        color = "white",
    }
    content.upsert_item(item)
end
