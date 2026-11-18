local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "spellcraft_theory_basic",
        category = "manuals",
        copy_from = "spellcraft_theory",
        looks_like = "spellcraft_theory",
        name = ccb.content.plural_text("Basic Spellcraft Theory", "copies of Basic Spellcraft Theory"),
        description = ccb.content.text("A beginner textbook on magical theories."),
        mass_milligrams = 1087000,
        volume_ml = 1450,
        price_cents = 5200,
        price_postapoc_cents = 550,
    }
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 9,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "caster_boosts_info",
        category = "manuals",
        copy_from = "spellcraft_theory",
        looks_like = "spellcraft_theory",
        name = ccb.content.plural_text("The Basics of Caster Levels", "copies of The Basics of Caster Levels"),
        description = ccb.content.text("This book goes into details about different ways to boost one's caster level above what one would normally achieve.  Domination schools can be boosted by various items detailed inside, while harmony schools can be boosted by circumstances.  Regardless, the book cautions that this boost can not exceed 1 + ( your highest caster level in that school / 5 ).  For animist, they get a boost if they stand in blood.  More blood means a higher maximum boost.  Stormshapers gets a boost while being outside during precipitation.  More precipitation means a higher maximum boost.  Earthshapers get a boost by being underground, and by standing on dirt, sand, clay or the like.  Apparently, standing in pits is also very effective.  Druids gets a boost by standing on grass, fern, bushes, and the like.  Hugging a young tree gives among the highest possible boosts for druids."),
        mass_milligrams = 1087000,
        volume_ml = 1450,
        price_cents = 5200,
        price_postapoc_cents = 550,
    }
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 9,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_mithril",
        category = "manuals",
        name = ccb.content.plural_text("ᚲᚨᚲ:ᚲᛟᚹᚨᛏ:ᛗᛁᚠᚱᛁᛚ", "ᚲᚨᚲ:ᚲᛟᚹᚨᛏ:ᛗᛁᚠᚱᛁᛚ"),
        description = ccb.content.text("This book is written in a runic language unfamiliar to you.  Fortunately, there are several very detailed pictures that demonstrate the process of forging a sword from an ingot of silvery metal.  You get the impression that this is some sort of textbook for blacksmiths."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 2250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 7,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3600,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_bladesmith", time_factor = 0.2, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "druid_shapeshifting_learn_book_bear",
        copy_from = "spell_scroll",
        name = ccb.content.plural_text("Scroll of the Forest King", "Scrolls of the Forest King"),
        description = ccb.content.text("A list of the proper procedures and rituals to learn the druidic method of transformation into a bear.  Without the capability to use druidic magic, the formulae in here would be useless."),
        price_postapoc_cents = 3000,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "druid_shapeshifting_learn_book_cougar",
        copy_from = "spell_scroll",
        name = ccb.content.plural_text("Scroll of the Stalking Hunter", "Scrolls of the Stalking Hunter"),
        description = ccb.content.text("A list of the proper procedures and rituals to learn the druidic method of transformation into a cougar.  Without the capability to use druidic magic, the formulae in here would be useless."),
        price_postapoc_cents = 3000,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "druid_shapeshifting_learn_book_deer",
        copy_from = "spell_scroll",
        name = ccb.content.plural_text("Scroll of the Swift Runner", "Scrolls of the Swift Runner"),
        description = ccb.content.text("A list of the proper procedures and rituals to learn the druidic method of transformation into a deer.  Without the capability to use druidic magic, the formulae in here would be useless."),
        price_postapoc_cents = 3000,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "druid_shapeshifting_learn_book_raven",
        copy_from = "spell_scroll",
        name = ccb.content.plural_text("Scroll of the Soaring Wings", "Scrolls of the Soaring Wings"),
        description = ccb.content.text("A list of the proper procedures and rituals to learn the druidic method of transformation into a raven.  Without the capability to use druidic magic, the formulae in here would be useless."),
        price_postapoc_cents = 3000,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "spellcraft_theory",
        category = "manuals",
        name = ccb.content.plural_text("Spellcraft Theory", "copies of Spellcraft Theory"),
        description = ccb.content.text("A intermediate textbook on magical theories."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        longest_side_mm = 220,
        price_cents = 8200,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end
