local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "2x4",
        name = ccb.content.plural_text("plank", "planks"),
        description = ccb.content.text("A flat, thick plank of wood, like a 2 by 4 or similar piece of dimensional lumber.  Makes a decent melee weapon if you're desperate, and can be used for all kinds of construction projects."),
        category = "spare_parts",
        mass_milligrams = 2440000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 4130,
        longest_side_mm = 1220,
        melee_to_hit = -1,
        price_cents = 1000,
        price_postapoc_cents = 10,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    content.add(item)
end

do
    local item = content.Item {
        id = "plank_short",
        name = ccb.content.plural_text("short plank", "short planks"),
        description = ccb.content.text("A short 2 by 4 plank of wood.  While less common and smaller than its 4 foot cousin it can still be very useful in carpentry."),
        category = "spare_parts",
        mass_milligrams = 1220000,
        color = "brown",
        symbol = "/",
        volume_ml = 2066,
        longest_side_mm = 610,
        melee_to_hit = -1,
        price_cents = 500,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "stick_common",
        copy_from = "stick",
        looks_like = "stick",
        name = ccb.content.plural_text("stick (bent)", "sticks (bent)"),
        description = ccb.content.text("A respectable length of wood, just big enough to wrap your hand around.  It's a little bent, and that makes it useless for most things you'd want to make with it.  Also makes it a little harder to hit things with it."),
    }
    item:adjust_melee_damage { bonuses = { bash = -1 } }
    content.add(item)
end
