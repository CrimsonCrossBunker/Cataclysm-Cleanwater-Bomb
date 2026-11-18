local content = require("ccb").content

do
    local book = content.Item {
        id = "book_pneumatics",
        copy_from = "book_icef",
        looks_like = "book_icef",
        name = content.plural_text("Pneumatic Pnowledge", "copies of Pneumatic Pnowledge"),
        description = content.text("A whimsical guide to the world of building and designing compressed air and pneumatic devices, loaded with puns and dry technical diagrams.  It is unclear who the audience for a book like this would be."),
    }
    book:book {
        required_level = 4,
        maximum_level = 8,
        intelligence = 8,
        read_time_turns = 2400,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
        proficiencies = {
            { id = "prof_pneumatics", time_factor = 0.7, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_fieldrepair",
        copy_from = "book_magazine",
        category = "manuals",
        name = content.plural_text("army improvised field repairs manual", "army improvised field repairs manuals"),
        price_postapoc_cents = 500,
        description = content.text("A compact manual with faded print detailing a number of improvised field repairs that can be made to vehicles."),
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_mechanics",
        category = "manuals",
        name = content.plural_text("Popular Mechanics", "issues of Popular Mechanics"),
        description = content.text("A magazine about mechanical innovations.  Full of entertaining articles and advertisements for esoteric gadgets."),
        mass_milligrams = 70000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "pink",
        looks_like = "mag_gaming",
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
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_makerspace",
        category = "manuals",
        name = content.plural_text("makerspace kit instructions", "copies of makerspace kit instructions"),
        description = content.text("Instructions and blueprints for dozens of projects of increasing complexity for anyone new to the maker community."),
        mass_milligrams = 70000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "^",
        looks_like = "textbook_botany",
        color = "cyan_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_robotics_kit",
        category = "manuals",
        name = content.plural_text("robotics kit instructions", "copies of robotics kit instructions"),
        description = content.text("Instructions and blueprints for dozens of projects of increasing complexity.  An introduction to toy robots."),
        mass_milligrams = 70000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "^",
        looks_like = "textbook_botany",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_engine_kit",
        category = "manuals",
        name = content.plural_text("Stirling engine kit instructions", "copies of Stirling engine instructions"),
        description = content.text("Instructions and blueprints for building toy Stirling engines.  An introduction to engine principles."),
        mass_milligrams = 70000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "^",
        looks_like = "textbook_botany",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mechanics",
        category = "manuals",
        name = content.plural_text("Under the Hood", "copies of Under the Hood"),
        description = content.text("An advanced mechanics manual, covering all sorts of topics."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 5500,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "textbook_botany",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 8,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mechanics_car_owner",
        category = "manuals",
        name = content.plural_text("car owner manual", "car owner manuals"),
        description = content.text("A manual detailing how to do maintenance and light repairs to a car, ranging from changing a tire to changing oil and general checks of engine health."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 3000,
        price_postapoc_cents = 200,
        symbol = "?",
        looks_like = "textbook_botany",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_atomic_lab",
        copy_from = "recipe_lab_cvd",
        looks_like = "recipe_lab_cvd",
        name = content.plural_text("lab journal-Curie", "lab journals-Curie"),
        price_postapoc_cents = 2000,
        description = content.text("This lab notebook is filled with the collective discoveries and refinements of a research team dedicated to nuclear energy.  You don't think you're ready to start a second Cataclysm, but the general information provided might be useful…"),
    }
    book:book {
        required_level = 6,
        maximum_level = 10,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_mechnic_hotrod",
        category = "manuals",
        name = content.plural_text("Hot Rod Chassis & Suspension Handbook", "copies of Hot Rod Handbook"),
        description = content.text("By learning the fundamentals of chassis building and suspension design you will gain the critical knowledge needed to hot rod properly."),
        mass_milligrams = 500000,
        volume_ml = 500,
        price_cents = 3100,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "textbook_mechanics",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 7,
        maximum_level = 8,
        intelligence = 9,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_mechanics",
        category = "manuals",
        name = content.plural_text("Mechanical Mastery", "copies of Mechanical Mastery"),
        description = content.text("An advanced guide on mechanics and welding, covering topics like \"Grinding off rust\" and \"Making cursive E's\"."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 4950,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "textbook_botany",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 6,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end
