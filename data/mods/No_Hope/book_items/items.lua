local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "necropolis_freq",
        name = ccb.content.plural_text("frequency list", "frequency lists"),
        description = ccb.content.text("A notepad with a number of frequencies scribbled on it."),
        mass_milligrams = 200000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "pocket_firstaid",
        color = "light_cyan",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 2,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_chickenbot",
        name = ccb.content.plural_text("chicken walker schematics", "chicken walker schematics"),
        description = ccb.content.text("Bearing the logo of Northrop, those are assembly plans, design specs, and technical drawings for the chicken walker.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "schematics_tankbot",
        name = ccb.content.plural_text("tank drone schematics", "tank drone schematics"),
        description = ccb.content.text("Bearing the logo of Northrop, those are assembly plans, design specs, and technical drawings for the tank drone.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "schematics_tripod",
        name = ccb.content.plural_text("tripod schematics", "tripod schematics"),
        description = ccb.content.text("Bearing the logo of Honda, those are assembly plans, design specs, and technical drawings for the tripod.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end
