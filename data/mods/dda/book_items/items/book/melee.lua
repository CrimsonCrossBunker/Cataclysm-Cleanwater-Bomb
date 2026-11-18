local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_melee",
        category = "manuals",
        name = content.plural_text("CQB Monthly", "issues of CQB Monthly"),
        description = content.text("An in-depth look at various styles of close quarters fighting.  There's an amusing essay about dirty tricks in the front section."),
        mass_milligrams = 70000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "melee",
    }
    book:variants {
        {
            id = "mag_melee",
            name = content.plural_text("CQB Monthly", "issues of CQB Monthly"),
            description = content.text("An in-depth look at various styles of close quarters fighting.  There's an amusing essay about dirty tricks in the front section."),
        },
        -- 978-1941845073
        {
            id = "mag_melee_1",
            name = content.plural_text("Savage Street Fighting", "copies of Savage Street Fighting"),
            description = content.text("A barbaric guide detailing how to win a fight in the worst possible scenarios - mostly about how to retreat from such a fight, but it still has some information in case you have no another way."),
        },
        -- 978-1941845011
        {
            id = "mag_melee_2",
            name = content.plural_text("Maximum Damage", "copies of Maximum Damage"),
            description = content.text("This book teaches how to predict enemy attacks, with a nice explanation of how to react to each of them - both defense and counterattacks."),
        },
        -- 978-0989038201
        {
            id = "mag_melee_3",
            name = content.plural_text("Out of the Cage", "copies of Out of the Cage"),
            description = content.text("This book shows lot of techniques to defeat an experienced martial artist - brutal and dirty."),
        },
        -- 978-1941845677
        {
            id = "mag_melee_4",
            name = content.plural_text("Combat Pressure Points", "copies of Combat Pressure Points"),
            description = content.text("An illustrated handbook about the human body, how it works, and how to destroy it with fairly easy steps."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_melee",
        category = "manuals",
        name = content.plural_text("Close Quarter Fighting Manual", "copies of Close Quarter Fighting Manual"),
        description = content.text("A well-thumbed hardbound book which illustrates simple strategies and techniques for close quarters combat encounters."),
        mass_milligrams = 564000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "melee",
    }
    book:variants {
        {
            id = "manual_melee",
            name = content.plural_text("Close Quarter Fighting Manual", "copies of Close Quarter Fighting Manual"),
            description = content.text("A well-thumbed hardbound book which illustrates simple strategies and techniques for close quarters combat encounters."),
        },
        -- 978-1941845417
        {
            id = "manual_melee_1",
            name = content.plural_text("Survival Weapons", "copies of Survival Weapons"),
            description = content.text("\"Will You Be The Last One Standing?\", asks the author on the first page.  You don't know the answer, but this book contains plenty of info to reach this target."),
        },
        -- 978-1594392139
        {
            id = "manual_melee_2",
            name = content.plural_text("Facing Violence", "copies of Facing Violence"),
            description = content.text("Different techniques to end the fight fast, easy, and without going to prison.  Luckily no one can imprison you anymore!"),
        },
        -- 978-1594392139
        {
            id = "manual_melee_3",
            name = content.plural_text("Training for Sudden Violence", "copies of Training for Sudden Violence"),
            description = content.text("This book contains professional instructions to prepare and prevail in dangerous situations, both physically and psychologically."),
        },
    }
    content.add(book)
end
