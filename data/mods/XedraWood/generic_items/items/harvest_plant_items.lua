local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "witchwood_bark",
        copy_from = "alder_bark",
        looks_like = "alder_bark",
        name = ccb.content.plural_text("witchwood bark", "witchwood barks"),
        mass_milligrams = 234000,
        description = ccb.content.text("A thin strip of silvery-blue bark harvested from a witchwood tree.  Touching it makes your fingers tingle slightly."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "starsbreath_harvested",
        name = ccb.content.plural_text("stars' breath flower", "stars' breath flowers"),
        mass_milligrams = 20000,
        description = ccb.content.text("A delicate, silvery-blue flower from the stars' breath plant."),
        color = "light_gray",
        symbol = ",",
        volume_ml = 150,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tanglevine_root",
        name = ccb.content.plural_text("tanglevine root", "tanglevine roots"),
        mass_milligrams = 210000,
        color = "green",
        symbol = "%",
        description = ccb.content.text("A thick, woody root from a tanglevine.  The end glistens as though sap were still flowing through it."),
        price_cents = 1000,
        price_postapoc_cents = 310,
        volume_ml = 350,
    }
    item:material("veggy", 1)
    content.add(item)
end
