local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "magical_grimoire_apprentice_wise",
        category = "manuals",
        copy_from = "magical_grimoire_apprentice",
        looks_like = "magical_grimoire_apprentice",
        name = ccb.content.plural_text("apprentice's grimoire", "copies of apprentice's grimoire"),
        description = ccb.content.text("Written using the runes of the wise, this contains the rituals and supplications necessary to unlock the secrets of the lesser mysteries."),
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "magical_grimoire_apprentice",
        category = "manuals",
        name = ccb.content.plural_text("apprentice's grimoire", "copies of apprentice's grimoire"),
        description = ccb.content.text("A compilation of your elementary magical observations, a series of diagrams, maps, drawings of leaves and the sky and the moon, and ticks to mark times and numbers you've counted.  This would be extremely useful as a reference material."),
        mass_milligrams = 920000,
        volume_ml = 750,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:quality("MAGICAL_RESEARCH", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 11,
        read_time_turns = 3600,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end
