local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "22_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".22 LR casing", ".22 LR casings"),
        description = ccb.content.text("An empty casing from a .22 LR round.  These can't be hand-reloaded."),
        mass_milligrams = 2000,
        volume_ml = 3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "22_casing_new",
        looks_like = "9mm_casing",
        category = "spare_parts",
        price_cents = 100,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("unused .22 casing", "unused .22 casings"),
        symbol = "=",
        color = "yellow",
        description = ccb.content.text("An unfired, like-new .22 round casing, with the primer still intact."),
        stackable = true,
        volume_ml = 3,
        mass_milligrams = 1000,
    }
    item:material("powder", 1)
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "22_casing_new_short",
        looks_like = "22_casing_new",
        category = "spare_parts",
        price_cents = 90,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("unused .22 short casing", "unused .22 short casings"),
        symbol = "=",
        color = "yellow",
        description = ccb.content.text("An unfired, like-new .22 short casing, with the priming compound still intact."),
        stackable = true,
        volume_ml = 2,
        mass_milligrams = 1000,
    }
    item:material("powder", 1)
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "33_naval_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("3.3 naval casing", "3.3 naval casings"),
        description = ccb.content.text("An empty casing from a 3.3 naval round.  If it wasn't for burns and soot, it could be used as a cup."),
        mass_milligrams = 80000,
        volume_ml = 100,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "atgm_spent",
        copy_from = "casing",
        name = ccb.content.plural_text("152mm ATGM tube", "152mm ATGM tubes"),
        color = "dark_gray",
        description = ccb.content.text("An empty steel tube which once contained a 152mm ATGM.  Now it's essentially just a huge pipe."),
        mass_milligrams = 9500000,
        volume_ml = 7500,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "20shot_hull",
        copy_from = "shot_hull",
        looks_like = "shot_hull",
        name = ccb.content.plural_text("20 gauge hull", "20 gauge hulls"),
        description = ccb.content.text("An empty hull from a 20 gauge shotgun shell."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_20shot_hull",
        copy_from = "unprimed_shot_hull",
        looks_like = "unprimed_shot_hull",
        name = ccb.content.plural_text("primerless 20 gauge hull", "primerless 20 gauge hulls"),
        description = ccb.content.text("An empty hull from a 20 gauge shotgun shell, with its primer removed."),
    }
    content.add(item)
end
