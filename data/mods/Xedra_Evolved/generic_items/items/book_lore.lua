local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "spy_map",
        copy_from = "abstractmap",
        category = "maps",
        name = ccb.content.plural_text("strategic points of interest tourist map", "strategic points of interest tourist maps"),
        description = ccb.content.text("A tourist brochure that has markings on it in places that clearly aren't the advertised tourist 'zebras?'."),
        color = "brown_green",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 185,
        message = ccb.content.text("You add the locations to your map."),
        terrains = { { id = "field_office" }, { id = "lab_surface_brick_blockC3" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "spy_note",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("left behind note", "left behind notes"),
        snippet_category = "spy_note",
        description = ccb.content.text("A scrap of paper.  Something's written on it, scrawled in bad handwriting."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- The notes are intended to be basic but telling some info, as they are the closest to a consensus reached on creatures defined by being nigh-impossible to find.
    local item = content.Item {
        id = "deathworm_note",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("notes about the cryptid", "notes about the cryptids"),
        description = ccb.content.text("The notes you have taken about the cryptid you're hunting.\nAlso known as the mongolian death worm, the Olgoi-khorkhoi is a massive acid-spewing burrowing worm.  Finding acid-resistant gear will prove useful to survive the encounter.  According to most of the credible stories you've read, the lethal poison covering its skin is nothing but exaggerations."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 10,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "sevenoclock_note",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("notes about the cryptid", "notes about the cryptids"),
        description = ccb.content.text("The notes you have taken about the cryptid you're hunting.\nThe man of the Nineteenth Hour is peaceful for most of the day but becomes incredibly violent against those who are still awake when he enters his active phase.  Some stories tell that his presence shields those who are sleeping against everything that could disturb their sleep."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 10,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "note_snippet_bloodthorne_druid",
        name = ccb.content.plural_text("druidic notes", "copies of druidic notes"),
        category = "books",
        description = ccb.content.text("Some notes taken on paper with pen or pencil.  Some parts of them catch your eye."),
        snippet_category = "note_bloodthorne_druid",
        mass_milligrams = 15000,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
