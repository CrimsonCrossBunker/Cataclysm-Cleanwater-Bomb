local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_bashing",
        category = "manuals",
        name = content.plural_text("Batter Up!", "issues of Batter Up!"),
        description = content.text("A baseball magazine that focuses on batting tips.  There are lots of colorful, full-page photos of skilled athletes demonstrating proper form and technique."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 450,
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
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "bashing",
    }
    book:variants {
        {
            id = "mag_bashing",
            name = content.plural_text("Batter Up!", "issues of Batter Up!"),
            description = content.text("A baseball magazine that focuses on batting tips.  There are lots of colorful, full-page photos of skilled athletes demonstrating proper form and technique."),
        },
        {
            id = "mag_bashing_1",
            name = content.plural_text("Bludgeons and Broken Bones: A Reference Guide", "copies of Bludgeons and Broken Bones: A Reference Guide"),
            description = content.text("Written with hard prison slang, this book says a lot about how to use maximum power from your muscles and weight of your weapon."),
        },
        {
            id = "mag_bashing_2",
            name = content.plural_text("Bash Weapons for Self-Defense: A Practical Guide", "copies of Bash Weapons for Self-Defense: A Practical Guide"),
            description = content.text("A small brochure from an unknown self-defense shop, focused on using bash weapons for self-defense in real-world situations.  It covers topics like assessing threats, using verbal commands and body language to de-escalate situations, and legal considerations for using force in self-defense.  It also includes techniques for using bash weapons to defend against attackers armed with knives, guns, and other weapons."),
        },
        {
            id = "mag_bashing_3",
            name = content.plural_text("Ultra Tactics: The Ways of the Modern Warrior", "copies of Ultra Tactics: the Ways of the Modern Warrior"),
            description = content.text("This book researches the long, international story of ultras - fanatical football fans ready to defend the prestige of their football team in any possible way, including with brutal violence and heavy bats."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_bashing",
        category = "manuals",
        name = content.plural_text("tactical baton defense manual", "copies of tactical baton defense manual"),
        description = content.text("An informative guide to self-defense using clubs and batons.  Aimed at the law enforcement and military market, it is packed with time tested, no-nonsense information and written to be understandable for beginners."),
        mass_milligrams = 454000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 3,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "bashing",
    }
    book:variants {
        {
            id = "manual_bashing",
            name = content.plural_text("tactical baton defense manual", "copies of tactical baton defense manual"),
            description = content.text("An informative guide to self-defense using clubs and batons.  Aimed at the law enforcement and military market, it is packed with time tested, no-nonsense information and written to be understandable for beginners."),
        },
        -- 978-1594397332
        {
            id = "manual_bashing_1",
            name = content.plural_text("The Art and Science of Stick Fighting", "copies of The Art and Science of Stick Fighting"),
            description = content.text("A non-style specific guide to fighting with the short stick, with a few levels of instructions from easy to master, and a lot of photos showing movements with motion arrows."),
        },
        {
            id = "manual_bashing_2",
            name = content.plural_text("Demolition Man", "copies of Demolition Man"),
            description = content.text("A comprehensive guide on how to do demolition on your own piece of land - from replacing the pavement to total house deconstruction - using only common instruments.  Surprisingly not so hard, as you just need to know how and when hit the thing."),
        },
        -- 978-1941845738
        {
            id = "manual_bashing_3",
            name = content.plural_text("Cane Fighting", "copies of Cane Fighting"),
            description = content.text("\"The Authoritative Guide to Using the Cane or Walking Stick for Self-Defense\", this book provides plenty of ways to use an everyday tool as a sturdy weapon."),
        },
    }
    content.add(book)
end
