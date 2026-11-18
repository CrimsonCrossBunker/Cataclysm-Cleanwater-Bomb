local ccb = require("ccb")
local content = ccb.content

do
    -- Match type options in iuse_actor.cpp
    -- Add maps/brochures/pamphlets as appropriate to itemgroups/books.json 's groups
    local item = content.Item {
        id = "abstractmap",
        abstract = true,
        category = "maps",
        name = ccb.content.plural_text("abstract map", "abstract maps"),
        description = ccb.content.text("seeing this is a bug."),
        mass_milligrams = 30000,
        volume_ml = 250,
        price_cents = 1000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "light_gray",
    }
    item:clear_flags()
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:flag("PAPER_SHAPED")
    item:material("paper", 1)
    content.add(item)
end
