local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_tv",
        category = "manuals",
        name = content.plural_text("US Weekly", "US Weeklies"),
        description = content.text("Weekly news about a bunch of famous people who're all (un)dead now."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 400,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 3,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_speech",
        category = "manuals",
        name = content.plural_text("Self-Esteem for Dummies", "copies of Self-Esteem for Dummies"),
        description = content.text("Full of useful tips for showing confidence in your speech."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 1600,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_speech",
        category = "manuals",
        name = content.plural_text("Principles of Effective Communication", "copies of Principles of Effective Communication"),
        description = content.text("A hardbound book devoted to being an effective and persuasive speaker."),
        mass_milligrams = 1120000,
        volume_ml = 2000,
        price_cents = 4000,
        price_postapoc_cents = 250,
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
        skill = "speech",
    }
    content.add(book)
end

do
    -- Have you held one of these things? Bastards have some real weight behind 'em
    local book = content.Item {
        id = "dnd_handbook",
        category = "manuals",
        name = content.plural_text("Dungeon Master's Guide: 6th Edition", "copies of Dungeon Master's Guide: 6th Edition"),
        description = content.text("A thick, hardcover volume with everything needed to weave legendary stories.  It's full of information, but finding the things you're looking for can be a chore."),
        mass_milligrams = 2267000,
        volume_ml = 2500,
        price_cents = 3000,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 0,
        maximum_level = 5,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_speech_naillaw",
        category = "manuals",
        name = content.plural_text("Nail Your Law Firm Interview", "copies of Nail Your Law Firm Interview"),
        description = content.text("This lightweight book proclaims itself to be \"the ONLY gold star interview guide for lawyers interviewing in any type of job interview.\"  It was supposed to help new lawyers find work."),
        mass_milligrams = 360000,
        volume_ml = 528,
        price_cents = 2000,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 7,
        read_time_turns = 1440,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end
