local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_scrap_1",
        abstract = true,
        category = "spare_parts",
        name = ccb.content.plural_text("ur-scrap", "ur-scraps"),
        description = ccb.content.text("A small techno doodad."),
        looks_like = "e_scrap",
        price_cents = 500,
        price_postapoc_cents = 1000,
        mass_milligrams = 250000,
        volume_ml = 50,
        melee_to_hit = -3,
        symbol = "*",
        color = "light_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_scrap_2",
        abstract = true,
        name = ccb.content.plural_text("ur-scrap", "ur-scraps"),
        copy_from = "afs_scrap_1",
        price_cents = 5000,
        price_postapoc_cents = 10000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_scrap_3",
        abstract = true,
        name = ccb.content.plural_text("ur-scrap", "ur-scraps"),
        copy_from = "afs_scrap_1",
        price_cents = 5000,
        price_postapoc_cents = 50000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_scrap_4",
        abstract = true,
        name = ccb.content.plural_text("ur-scrap", "ur-scraps"),
        copy_from = "afs_scrap_1",
        price_cents = 50000,
        price_postapoc_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_scrap_5",
        abstract = true,
        name = ccb.content.plural_text("ur-scrap", "ur-scraps"),
        copy_from = "afs_scrap_1",
        price_cents = 500000,
        price_postapoc_cents = 1000000,
    }
    content.add(item)
end
