local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_utilibot",
        symbol = ",",
        color = "light_gray",
        looks_like = "broken_cleanerbot",
        name = ccb.content.plural_text("broken Seneschal", "broken Seneschals"),
        category = "other",
        description = ccb.content.text("A broken Seneschal, now limp and unmoving.  Could be gutted for parts or crafted into a salvaged robot."),
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "broken_utilibot_beehive",
        name = ccb.content.plural_text("broken beehive robot", "broken beehive robots"),
        copy_from = "broken_utilibot",
        looks_like = "broken_utilibot",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_hazmatbot",
        name = ccb.content.plural_text("broken Likvidator", "broken Likvidators"),
        description = ccb.content.text("A broken Likvidator, now limp and unmoving.  Could be gutted for parts or crafted into a salvaged robot."),
        copy_from = "broken_utilibot",
        looks_like = "broken_utilibot",
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_utilibot_butler",
        copy_from = "broken_utilibot",
        looks_like = "broken_utilibot",
        color = "dark_gray",
        name = ccb.content.plural_text("broken Famulus", "broken Famuli"),
        description = ccb.content.text("A broken Famulus, now silent and mangled.  If it wasn't for the obvious rivets and welding, it would look completely human.  Could be stripped down for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_utilibot_const",
        copy_from = "broken_utilibot",
        looks_like = "broken_utilibot",
        color = "dark_gray",
        name = ccb.content.plural_text("broken Udarnik", "broken Udarniks"),
        volume_ml = 680388,
        mass_milligrams = 680388000,
        description = ccb.content.text("A broken Udarnik, now wrecked and immobile.  Could be stripped down for parts."),
    }
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "broken_utilibot_hostile",
        copy_from = "broken_utilibot_const",
        looks_like = "broken_utilibot_const",
        color = "dark_gray",
        name = ccb.content.plural_text("broken Udarnik", "broken Udarniks"),
        description = ccb.content.text("A broken Udarnik, now wrecked and immobile.  Could be stripped down for parts."),
    }
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "broken_utilibot_fire",
        copy_from = "broken_utilibot",
        looks_like = "broken_utilibot",
        color = "yellow",
        name = ccb.content.plural_text("broken Brandspojt", "broken Brandspojts"),
        description = ccb.content.text("A broken Brandspojt, now cold and inert.  Could be stripped down for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_skitterbot_rat",
        copy_from = "broken_skitterbot",
        looks_like = "broken_skitterbot",
        color = "light_gray",
        name = ccb.content.plural_text("broken rat snatcher", "broken rat snatchers"),
        description = ccb.content.text("A broken rat snatcher, now harmless and inert.  Could be stripped down or re-crafted."),
    }
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "broken_tripod",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken tripod", "broken tripods"),
        category = "other",
        description = ccb.content.text("A broken tripod.  Now that its legs lie broken and immobile, the world seems a little less threatening.  Could be gutted for parts."),
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
        name = ccb.content.plural_text("broken Regulator", "broken Regulators"),
        category = "other",
        description = ccb.content.text("A broken Regulator.  Still looks intimidating despite being permanently inoperative, possibly due to the sheer size and mass.  Could be gutted for parts."),
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
        id = "broken_medibot",
        symbol = ",",
        color = "white",
        looks_like = "broken_tripod",
        name = ccb.content.plural_text("broken surgical droid", "broken surgical droids"),
        category = "other",
        description = ccb.content.text("A broken surgical robot, now crumpled and inert.  Could be stripped down for parts."),
        price_cents = 30000,
        price_postapoc_cents = 1000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.upsert_item(item)
end
