local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_animecon",
        copy_from = "mag_tailor",
        looks_like = "mag_tailor",
        name = ccb.content.plural_text("Boston AnimeCon magazine", "Boston AnimeCon magazines"),
        description = ccb.content.text("A short magazine printed as an advertisement for the now canceled Boston AnimeCon.  A few costume ideas are intermixed with miscellaneous information about the event."),
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_leatherworking_basic", time_factor = 0.1, fail_factor = 0.1 },
            { id = "prof_elastics", time_factor = 0.1, fail_factor = 0.1 },
            { id = "prof_plasticworking", time_factor = 0.1, fail_factor = 0.1 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_beauty",
        category = "manuals",
        name = ccb.content.plural_text("Beauty Magazine", "Beauty Magazines"),
        description = ccb.content.text("A full-size glossy women's magazine.  There are a few simple patterns and basic sewing tips somewhere in between the fashion photos and the makeup advertisements."),
        mass_milligrams = 180000,
        volume_ml = 500,
        price_cents = 450,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 1440,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_tailor",
        category = "manuals",
        name = ccb.content.plural_text("Sew What? Clothing!", "copies of Sew What? Clothing!"),
        description = ccb.content.text("A colorful book about tailoring."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 1900,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "manual_driving",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_closures", time_factor = 0.2, fail_factor = 0.25 },
            { id = "prof_elastics", time_factor = 0.2, fail_factor = 0.15 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "tailor_portfolio",
        category = "manuals",
        name = ccb.content.plural_text("clothing designer's portfolio", "clothing designer's portfolios"),
        description = ccb.content.text("A leather bound portfolio that once belonged to a clothing designer.  Filled with sketches and notes, a skilled tailor could learn a lot from this volume."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 9200,
        price_postapoc_cents = 1000,
        symbol = "?",
        looks_like = "isherwood_herbal_remedies",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "tailor_japanese",
        category = "manuals",
        name = ccb.content.plural_text("Traditional Japanese Kimono", "copies of Traditional Japanese Kimono"),
        description = ccb.content.text("An illustrated textbook on the crafting of Japanese traditional garb."),
        mass_milligrams = 2400000,
        volume_ml = 1500,
        price_cents = 8000,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "glassblowing_book",
        color = "red",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 2400,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_fauxfur",
        category = "manuals",
        name = ccb.content.plural_text("Friendly, Humane Fashion", "copies of Friendly, Humane Fashion"),
        description = ccb.content.text("An educational book detailing the uses of fake fur, as well as its benefits and disadvantages.  The prose is rather passionate, and a disclaimer on the cover proudly states that the book is printed and distributed by the Gryphon Animal Rights Organization."),
        mass_milligrams = 1200000,
        volume_ml = 1000,
        price_cents = 5000,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "glassblowing_book",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_furriery", time_factor = 0.2, fail_factor = 0.2, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_tailor",
        category = "manuals",
        name = ccb.content.plural_text("Sewing Techniques for Designers", "copies of Sewing Techniques for Designers"),
        description = ccb.content.text("A massive, hardbound book full of a wealth of information for the professional clothing designer."),
        mass_milligrams = 2600000,
        volume_ml = 2000,
        price_cents = 6000,
        price_postapoc_cents = 1500,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_closures", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_elastics", time_factor = 0.1, fail_factor = 0.25 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "scots_tailor",
        category = "manuals",
        name = ccb.content.plural_text("Ye Scots Beuk o Tailorin'", "copies of Ye Scots Beuk o Tailorin'"),
        description = ccb.content.text("A translated Gaelic book from Scotland.  While boring to read due to its technical tone, it provides insights into Scottish culture and information about tailoring."),
        mass_milligrams = 2600000,
        volume_ml = 2000,
        price_cents = 3000,
        price_postapoc_cents = 550,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "dieselpunk_tailor",
        category = "manuals",
        name = ccb.content.plural_text("Dieselpunk Designs", "copies of Dieselpunk Designs"),
        description = ccb.content.text("A large, leatherbound book containing a number of leather and rubber recipes for the fashionable dieselpunk."),
        mass_milligrams = 2600000,
        volume_ml = 2000,
        price_cents = 6000,
        price_postapoc_cents = 1500,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "dark_gray",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:material("leather", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_closures", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_leatherworking_basic", time_factor = 0.1, fail_factor = 0.25 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_tailor",
        category = "manuals",
        name = ccb.content.plural_text("Sew Awesome Monthly", "Sew Awesome Monthlies"),
        description = ccb.content.text("A well presented monthly magazine all about knitting, crocheting, and needlepoint.  Filled with ideas and project patterns."),
        mass_milligrams = 75000,
        volume_ml = 250,
        price_cents = 400,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_knitting", time_factor = 0.15, fail_factor = 0.1 },
            { id = "prof_closures", time_factor = 0.2, fail_factor = 0.1 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "bp_nomad_cowl",
        name = ccb.content.plural_text("nomad cowl blueprint", "nomad cowl blueprints"),
        description = ccb.content.text("A simple printed pamphlet with clear illustrations and very few words describing how to make what appears to be a well-designed and comfortable cowl offering protection from the elements and physical injury.  The directions do not offer much guidance beyond the plans themselves; this will take a little skill to interpret."),
        color = "dark_gray",
        copy_from = "exodii_blueprint",
    }
    book:book {
        required_level = 4,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        proficiencies = {
            { id = "prof_closures_waterproofing", fail_factor = 0.05 },
            { id = "prof_leatherworking", fail_factor = 0.05 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "bp_nomad_bodyglove",
        name = ccb.content.plural_text("nomad bodyglove blueprint", "nomad bodyglove blueprints"),
        description = ccb.content.text("A simple printed pamphlet with clear illustrations and very few words describing how to make what appears to be a tight-fitting but protective bodysuit, with options to reinforce it with Kevlar threads.  The directions do not offer much guidance beyond the plans themselves; this will take a little skill to interpret."),
        color = "blue",
        copy_from = "exodii_blueprint",
    }
    book:book {
        required_level = 4,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        proficiencies = {
            { id = "prof_closures_waterproofing", fail_factor = 0.05 },
            { id = "prof_leatherworking", fail_factor = 0.05 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "bp_nomad_jumpsuit",
        name = ccb.content.plural_text("nomad jumpsuit blueprint", "nomad jumpsuit blueprints"),
        description = ccb.content.text("A simple printed pamphlet with clear illustrations and very few words describing how to make what appears to be a jumpsuit designed to survive the long-term wear and tear of exploring the apocalyptic wasteland, with a lot of storage capacity.  The directions do not offer much guidance beyond the plans themselves; this will take a little skill to interpret.  There seems to be room within the directions to make a simpler, lighter version, or a leather-reinforced version."),
        color = "green",
        copy_from = "exodii_blueprint",
    }
    book:book {
        required_level = 4,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        proficiencies = {
            { id = "prof_closures_waterproofing", fail_factor = 0.05 },
            { id = "prof_leatherworking", fail_factor = 0.05 },
        },
    }
    content.add(book)
end
