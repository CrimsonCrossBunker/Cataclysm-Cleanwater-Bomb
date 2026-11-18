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
    }
    item:material("steel", 1)
    content.upsert_item(item)
end

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
        id = "chickenbot_chassis",
        name = ccb.content.plural_text("Pathfinder chassis", "Pathfinder chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Pathfinder."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 60000000,
        volume_ml = 80000,
        price_cents = 300000,
        category = "spare_parts",
    }
    item:material("steel", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "tankbot_chassis",
        name = ccb.content.plural_text("Regulator chassis", "Regulator chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Regulator tank."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 150000000,
        volume_ml = 575000,
        price_cents = 1000000,
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
        id = "hazmatbot_chassis",
        name = ccb.content.plural_text("Likvidator chassis", "Likvidator chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Likvidator."),
        copy_from = "utilibot_chassis",
        looks_like = "utilibot_chassis",
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "butlerbot_chassis",
        name = ccb.content.plural_text("Famulus chassis", "Famulus chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  Looking at it fills you with uneasiness as the Famulus stares at you with empty eyes."),
        copy_from = "utilibot_chassis",
        looks_like = "utilibot_chassis",
        color = "dark_gray",
    }
    content.add(item)
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
        id = "utilibot_fire_chassis",
        name = ccb.content.plural_text("Brandspojt chassis", "Brandspojt chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Brandspojt."),
        copy_from = "utilibot_chassis",
        looks_like = "utilibot_chassis",
        color = "yellow",
    }
    content.add(item)
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

do
    local item = content.Item {
        id = "reverse_jointed_legs",
        name = ccb.content.plural_text("set of reverse-jointed legs", "sets of reverse-jointed legs"),
        description = ccb.content.text("A set of reverse-jointed legs, like the ones found under a chicken walker."),
        symbol = "k",
        color = "light_gray",
        mass_milligrams = 60000000,
        volume_ml = 20000,
        price_cents = 500000,
        price_postapoc_cents = 250,
        category = "spare_parts",
    }
    item:material("steel", 1)
    content.upsert_item(item)
end
