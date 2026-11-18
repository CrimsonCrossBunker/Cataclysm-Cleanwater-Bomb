local ccb = require("ccb")
local content = ccb.content

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
