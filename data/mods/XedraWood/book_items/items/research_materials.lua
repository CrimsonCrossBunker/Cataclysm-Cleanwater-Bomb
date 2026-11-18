local content = require("ccb").content

do
    local book = content.Item {
        id = "occult_research_intro",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("rudimentary occult research results", "sets of rudimentary occult research results"),
        description = content.text("Jotted down thoughts about the hidden things of the world.  Nothing here is particularly profound, and you'll probably not need to consult this again."),
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "occult_research_minor",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("apprentice occult research results", "sets of apprentice occult research results"),
        description = content.text("Musings and tangents mixed with a few real insights.  You know there's power to be grasped out there, if you can just find out how to do it."),
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "used_occult_notes",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("old occult research notes", "sets of old occult research notes"),
        description = content.text("A set of your notes about the occult.  You've already gotten most of the value you can out of these, but you never know when it might be useful in the future."),
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "forest_research_materials",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("forest magic research materials", "sets of forest magic research materials"),
        description = content.text("A set of documents, scribbed notes, musings, bits of pressed leaves and flowers, and other esoterica for research into magic.  Using this, you might be able to discover a magical formula related to the natural world."),
    }
    book:material("paper", 1)
    book:material("wood", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "earth_research_materials",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("earth magic research materials", "sets of earth magic research materials"),
        description = content.text("A set of documents, scribbed notes, musings, polished rocks and samples of soil, and other esoterica for research into magic.  Using this, you might be able to discover a magical formula related to the earth."),
    }
    book:material("paper", 1)
    book:material("stone", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "moon_research_materials",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("moon magic research materials", "sets of moon magic research materials"),
        description = content.text("A set of documents, scribbed notes, musings, lunar observations, star charts, and other esoterica for research into magic.  Using this, you might be able to discover a magical formula related to the moon."),
    }
    book:material("paper", 1)
    book:material("wood", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "sky_research_materials",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("sky magic research materials", "sets of sky magic research materials"),
        description = content.text("A set of documents, scribbed notes, musings, weather observations, and other esoterica for research into magic.  Using this, you might be able to discover a magical formula related to the sky."),
    }
    book:material("paper", 1)
    book:material("wood", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "sea_research_materials",
        copy_from = "research_notes_abstract",
        looks_like = "research_notes_abstract",
        name = content.plural_text("sea magic research materials", "sets of sea magic research materials"),
        description = content.text("A set of documents, scribbed notes, musings, tidal records, and other esoterica for research into magic.  Using this, you might be able to discover a magical formula related to the sea."),
    }
    book:material("paper", 1)
    book:material("wood", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "research_notes_abstract",
        name = content.plural_text("research notes abstract", "research notes abstracts"),
        description = content.text("A bunch of loose notes for researching bugs, which you're probably doing if you can see this."),
        mass_milligrams = 50000,
        volume_ml = 15,
        longest_side_mm = 220,
        color = "white",
        symbol = ",",
        variant_kind = "generic",
        melee_to_hit = -3,
    }
    book:material("paper", 1)
    book:clear_flags()
    book:flag("TRADER_AVOID")
    book:flag("TINDER")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
