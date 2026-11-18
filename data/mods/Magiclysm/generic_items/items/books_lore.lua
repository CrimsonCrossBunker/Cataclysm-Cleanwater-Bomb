local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "retreat_map",
        copy_from = "abstractmap",
        category = "maps",
        name = ccb.content.plural_text("vacation brochure", "vacation brochures"),
        description = ccb.content.text("This is a glossy brochure encouraging students to book vacations at a lake retreat or remote cabin.  The brochure includes lush photographs of a tower on an island and a remote looking cabin in the woods.  It includes a map of the areas."),
        color = "white",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 185,
        message = ccb.content.text("You add the locations to your map."),
        terrains = { { id = "lake_retreat_ground" }, { id = "magic_cabin" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lair_map",
        copy_from = "abstractmap",
        category = "maps",
        name = ccb.content.plural_text("lair map", "lair maps"),
        description = ccb.content.text("This is a well worn map.  It has pictures of fantastical beasts embellishing the carefully drawn map markers."),
        color = "white",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 185,
        message = ccb.content.text("You add the locations to your map."),
        terrains = {
            { id = "demon_spider_lair" },
            { id = "black_dragon_lair_z-0_NW" },
            { id = "black_dragon_lair_z-0_NE" },
            { id = "black_dragon_lair_z-0_SW" },
            { id = "black_dragon_lair_z-0_SE" },
        },
    }
    content.add(item)
end

do
    -- Unique item for magic_basement.
    local item = content.Item {
        id = "wizard_photo",
        category = "other",
        name = ccb.content.plural_text("old photo", "old photos"),
        description = ccb.content.text("A photo of a jovial, old wizard, he seems to be dancing with a coat rack in this basement.  There is a stack of suitcases in the background."),
        mass_milligrams = 1000,
        volume_ml = 10,
        price_cents = 800,
        symbol = "*",
        color = "light_gray",
    }
    item:material("paper", 1)
    content.add(item)
end
