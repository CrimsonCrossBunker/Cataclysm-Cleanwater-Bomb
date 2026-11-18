local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_tripod",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken tribot", "broken tribots"),
        category = "other",
        description = ccb.content.text("A broken tribot.  Now that its legs lie broken and immobile, the world seems a little less threatening.  Could be gutted for parts."),
        price_cents = 1000,
        mass_milligrams = 430000000,
        volume_ml = 187500,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 6)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "broken_tankbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken tank drone", "broken tank drones"),
        category = "other",
        description = ccb.content.text("A broken tank drone.  Still looks intimidating despite being permanently inoperative, possibly due to the sheer size and mass.  Could be gutted for parts."),
        price_cents = 1000,
        mass_milligrams = 1223850000,
        volume_ml = 875000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:melee_damage("cut", 15)
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
        name = ccb.content.plural_text("chicken walker chassis", "chicken walker chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the chicken walker."),
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
        name = ccb.content.plural_text("Beagle chassis", "Beagle chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the Beagle tank."),
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
