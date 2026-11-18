local content = require("ccb").content

do
    local book = content.Item {
        id = "atomic_survival",
        category = "manuals",
        name = content.plural_text("Survival Under Atomic Attack", "copies of Survival Under Atomic Attack"),
        description = content.text("A wordy and intricate guide to wilderness and urban survival in a worst-case scenario.  While filled with loads of useful information, the madman who wrote this was a terrible writer, and gleaning knowledge from the rants is a chore."),
        mass_milligrams = 1920000,
        volume_ml = 2000,
        price_cents = 920,
        price_postapoc_cents = 3750,
        symbol = "?",
        looks_like = "manual_gun",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 1,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 3300,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "fun_survival",
        category = "manuals",
        name = content.plural_text("Through the Lens", "copies of Through the Lens"),
        description = content.text("A colorful digest devoted to backpacking and wilderness photography.  The photos are beautiful, though the terminology in the sections on survivalcraft assume some proficiency."),
        mass_milligrams = 440000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "textbook_fireman",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 480,
        fun = 3,
        chapters = 0,
        scannable = true,
        skill = "survival",
        proficiencies = {
            { id = "prof_knapping", time_factor = 0.15, fail_factor = 0.15 },
            { id = "prof_knapping_speed", time_factor = 0.15, fail_factor = 0.15 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_dude",
        category = "manuals",
        name = content.plural_text("Alpha Male Quarterly", "Alpha Male Quarterlies"),
        description = content.text("A full-size glossy men's magazine.  There's a brief article about hiking and a list of simple wilderness survival tips somewhere in between the photos of bikini-clad women and the gadget advertisements."),
        mass_milligrams = 180000,
        volume_ml = 500,
        price_cents = 450,
        price_postapoc_cents = 50,
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
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_survival",
        category = "manuals",
        name = content.plural_text("Outdoor Adventures", "issues of Outdoor Adventures"),
        description = content.text("A glossy magazine about surviving and hunting in the wilderness.  There's an exciting article about a bear attack in the back pages."),
        mass_milligrams = 80000,
        volume_ml = 250,
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
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_survival",
        category = "manuals",
        name = content.plural_text("Pitching a Tent", "copies of Pitching a Tent"),
        description = content.text("A guide detailing the basics of woodsmanship and outdoor survival."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 2900,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "manual_archery",
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
        skill = "survival",
        proficiencies = {
            { id = "prof_knapping", time_factor = 0.15, fail_factor = 0.2 },
            { id = "prof_knapping_speed", time_factor = 0.15, fail_factor = 0.2 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "pocket_survival",
        category = "manuals",
        name = content.plural_text("Pocket Survival Guide", "copies of Pocket Survival Guide"),
        description = content.text("This pocket-sized leather-bound survival guide combines a wealth of concise information with simple to follow instructions and easy to read illustrations."),
        mass_milligrams = 212000,
        volume_ml = 250,
        price_cents = 4000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "mag_gaming",
        color = "green",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "survival",
        proficiencies = {
            { id = "prof_knapping", time_factor = 0.25, fail_factor = 0.3 },
            { id = "prof_knapping_speed", time_factor = 0.25, fail_factor = 0.3 },
        },
    }
    content.add(book)
end

do
    -- Since it's a novel, price point is much more reasonable.
    local book = content.Item {
        id = "survival_book",
        category = "manuals",
        name = content.plural_text("Autobiography of a Mountain Man", "copies of Autobiography of a Mountain Man"),
        description = content.text("An amusing historical novel filled with detailed descriptions of surviving in the wild, potentially containing great insights for an experienced outdoorsman."),
        mass_milligrams = 1920000,
        volume_ml = 2000,
        price_cents = 920,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_dodge",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 3300,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "survival",
        proficiencies = {
            { id = "prof_knapping", time_factor = 0.1, fail_factor = 0.15 },
            { id = "prof_knapping_speed", time_factor = 0.1, fail_factor = 0.15 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_survival",
        category = "manuals",
        name = content.plural_text("Outdoor Survival Guide", "copies of Outdoor Survival Guide"),
        description = content.text("A thick soft-cover book filled with vital information about surviving in the wild, aimed at the experienced backpacker."),
        mass_milligrams = 910000,
        volume_ml = 2000,
        price_cents = 6000,
        price_postapoc_cents = 1750,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_botany",
        category = "manuals",
        name = content.plural_text("Introduction to Plant Biology", "copies of Introduction to Plant Biology"),
        description = content.text("A college-level textbook about plants of all shapes and sizes.  Covers a wide range of subjects, from horticulture to the identification of tropical plants.  As such, it is of limited practical use in your current situation."),
        mass_milligrams = 1200000,
        volume_ml = 2700,
        price_cents = 6000,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 9,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_arthropod",
        category = "manuals",
        name = content.plural_text("The Wonderful World of Arthropodology", "copies of The Wonderful World of Arthropodology"),
        description = content.text("A three-volume doorstopper introducing the whole breadth of modern arthropodology, beginning with a lengthy section on the comparative anatomy of the described taxa.  The authors somehow manage to maintain a gushingly enthusiastic tone, even as they describe the grisly effects of arthropod venoms or the mating habits of horseshoe crabs.  Given the curious lack of man-sized wasps in the illustrations, you have to wonder how much of the content is still applicable."),
        mass_milligrams = 2200000,
        volume_ml = 2680,
        price_cents = 10000,
        price_postapoc_cents = 1250,
        color = "red",
        symbol = "?",
        looks_like = "textbook_firstaid",
    }
    book:material("paper", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 9,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "survival",
        proficiencies = {
            { id = "prof_chitinworking", time_factor = 0.1, fail_factor = 0.15 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "isherwood_herbal_remedies",
        category = "manuals",
        name = content.plural_text("Natural Remedies of New England", "copies of Natural Remedies of New England"),
        description = content.text("A leather-bound manuscript, it features native herbal remedies with hand-colored illustrations of each plant."),
        mass_milligrams = 400000,
        volume_ml = 1250,
        price_cents = 50000,
        price_postapoc_cents = 1500,
        symbol = "?",
        looks_like = "scots_cookbook",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 1,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 4,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end
