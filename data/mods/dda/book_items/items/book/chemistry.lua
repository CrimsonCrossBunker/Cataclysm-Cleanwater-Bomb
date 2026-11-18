local content = require("ccb").content

do
    local book = content.Item {
        id = "recipe_alpha",
        category = "manuals",
        name = content.plural_text("PE050 \"Alpha\": Preliminary Report", "copies of PE050 \"Alpha\": Preliminary Report"),
        description = content.text("This sheaf of papers--dated two weeks before all this started--describes some new chemical formula, and its effects on human subjects.  It's stamped \"APPROVED\"…"),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_animal",
        category = "manuals",
        name = content.plural_text("lab journal-Dionne", "lab journals-Dionne"),
        description = content.text("This team logbook details several varieties of mutagenic experiments, focusing on those derived from various Earth fauna.  The team seems quite enthusiastic--if not eager--about their results."),
        mass_milligrams = 500000,
        volume_ml = 600,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_chimera",
        category = "manuals",
        name = content.plural_text("PE065 \"Chimera\": Best Practices", "copies of PE065 \"Chimera\": Best Practices"),
        description = content.text("This sheaf of papers describes a new chemical formula in detail and supplies instructions for its use as some sort of… crowd-control catalyst?  That can't be right…"),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_creepy",
        category = "manuals",
        name = content.plural_text("lab journal-Smythe", "lab journals-Smythe"),
        description = content.text("This team logbook details several varieties of mutagenic experiments, focusing on those derived from flesh contaminated with XE037.  The results look promising but the procurement methods seem awfully vague…"),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -4,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_labchem",
        category = "manuals",
        name = content.plural_text("chemical reference-CLASSIFIED", "chemical references-CLASSIFIED"),
        description = content.text("This somewhat technical binder has several intimidating security warnings on the cover, yet guarantees unauthorized readers \"permanent employment, for life\".  It contains useful information on \"basic\" chemical projects like methamphetamine and heroin, along with briefing on things called \"XE037\" and \"PE012\"."),
        mass_milligrams = 2000000,
        volume_ml = 2000,
        price_cents = 64000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 12,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_maiar",
        category = "manuals",
        name = content.plural_text("lab journal-x-|xp", "lab journals-x-|xp"),
        description = content.text("This damaged team logbook lacks (deliberately?) any identifying information, but still contains useful information on several types of mutagen and their development."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_medicalmut",
        category = "manuals",
        name = content.plural_text("PE023 \"Medical\": Application and Findings", "copies of PE023 \"Medical\": Application and Findings"),
        description = content.text("This binder of highly technical papers describes some new chemical formula, and its effects on human subjects.  It's stamped \"APPROVED\"…"),
        mass_milligrams = 1450000,
        volume_ml = 1750,
        price_cents = 62000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_serum",
        category = "manuals",
        name = content.plural_text("Best Practices for Compound Delivery", "copies of Best Practices for Compound Delivery"),
        description = content.text("This internal manual details several varieties of mutagenic experiments, as well as describing the protocols used to concentrate mutagens for quicker results.  The authors recommend that researchers ensure that their subjects are well-fed and in good health, as the concentrated serums draw heavily on subjects' bodies."),
        mass_milligrams = 500000,
        volume_ml = 600,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 8,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -4,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "reference_cooking",
        category = "manuals",
        name = content.plural_text("CRC-Merck Handbook, 4th edition", "copies of CRC-Merck Handbook, 4th edition"),
        description = content.text("This huge hardbound book is a collection of reference data and formulae pertinent to many technical disciplines.  If poring over tables of chemical and physical data is your thing, this is the book for you."),
        mass_milligrams = 5790000,
        volume_ml = 1750,
        price_cents = 9000,
        price_postapoc_cents = 2000,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1800,
        fun = -2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_gaswarfare",
        category = "manuals",
        name = content.plural_text("Art and Science of Chemical Warfare", "copies of Art and Science of Chemical Warfare"),
        description = content.text("This in-depth and technical text covers the design, development, dissemination of, and defenses against various chemical weapons throughout the centuries.  The photographs the author chose make it a difficult read at times, though the information is top-notch."),
        mass_milligrams = 854000,
        volume_ml = 1500,
        price_cents = 400,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1200,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end
