local content = require("ccb").content

do
    local book = content.Item {
        id = "fcl_schematics_eyebot",
        name = content.plural_text("eyebot schematics", "eyebot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the eyebot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "fcl_schematics_copbot",
        name = content.plural_text("police bot schematics", "police bot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the police bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "fcl_schematics_molebot",
        name = content.plural_text("miner bot schematics", "miner bot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the miner bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "fcl_schematics_riotbot",
        name = content.plural_text("riot control bot schematics", "riot control bot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the riot control bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_tripod",
        name = content.plural_text("tripod schematics", "tripod schematics"),
        description = content.text("Bearing the logo of Honda, those are assembly plans, design specs, and technical drawings for the tripod.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end
