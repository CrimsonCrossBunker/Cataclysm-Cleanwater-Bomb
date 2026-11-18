local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_cutting",
        category = "manuals",
        name = ccb.content.plural_text("All About Swords", "issues of All About Swords"),
        description = ccb.content.text("An interesting magazine that contains information about swords and sword fighting techniques from all across the world."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
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
        skill = "cutting",
    }
    book:variants {
        -- inherit name from item
        {
            id = "mag_cutting",
        },
        -- 978-9526793481
        {
            id = "mag_cutting_1",
            name = ccb.content.plural_text("Swordfighting, for Writers, Game Designers, and Martial Artists", "copies of Swordfighting, for Writers, Game Designers, and Martial Artists"),
            description = ccb.content.text("Answers for questions you may have if you've never held a sword in your hands."),
        },
        -- 978-0897501781
        {
            id = "mag_cutting_2",
            name = ccb.content.plural_text("The Beginner's Guide to the Long Sword", "copies of The Beginner's Guide to the Long Sword"),
            description = ccb.content.text("Based on different Europeans' martial arts, this book describes the main principles of swordsmanship."),
        },
        -- 978-1612331720
        {
            id = "mag_cutting_3",
            name = ccb.content.plural_text("Basics Of Stage Combat", "copies of Basics Of Stage Combat"),
            description = ccb.content.text("Foundation of using single handed sword on stage and on screen, with different tricks how to make a good show of it."),
        },
        -- 978-1784382858
        {
            id = "mag_cutting_4",
            name = ccb.content.plural_text("Medieval Combat in Colour", "copies of Medieval Combat in Colour"),
            description = ccb.content.text("An ancient fencing manual with updated illustrations of techniques.  Sometimes it just looks silly, describing how to fight if you have sword in one hand and a spear in another."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_cutting",
        category = "manuals",
        name = ccb.content.plural_text("knife fighter's notes", "collections of knife fighter's notes"),
        description = ccb.content.text("It seems to be a guide to edged weapon combat, poorly photocopied and released on spiral-bound paper.  Still, there are lots of useful tips for beginners."),
        mass_milligrams = 454000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "record_patient",
        color = "green",
        variant_kind = "generic",
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
        skill = "cutting",
    }
    book:variants {
        -- inherit name from item
        {
            id = "manual_cutting",
        },
        -- 978-1937439033
        {
            id = "manual_cutting_1",
            name = ccb.content.plural_text("The Medieval Dagger", "copies of The Medieval Dagger"),
            description = ccb.content.text("Principles and guides to Italian dagger combat, with useful drills and advice for novices."),
        },
        -- 978-1941845523
        {
            id = "manual_cutting_2",
            name = ccb.content.plural_text("Knife Fighting Techniques for the Street", "copies of Knife Fighting Techniques for the Street"),
            description = ccb.content.text("A small book that contain pretty simple and easy to follow movements to use against your enemy or enemies."),
        },
        -- 978-1492935391
        {
            id = "manual_cutting_3",
            name = ccb.content.plural_text("Knife Offense", "copies of Knife Offense"),
            description = ccb.content.text("Complete methodology for using knives in a real fight, with tips and tricks."),
        },
        -- 978-1387035885
        {
            id = "manual_cutting_4",
            name = ccb.content.plural_text("Blade Combatives", "copies of Blade Combatives"),
            description = ccb.content.text("This book combines some different blade methodologies from European, Asian, and American martial arts into a unique style."),
        },
        -- 978-1480259638
        {
            id = "manual_cutting_5",
            name = ccb.content.plural_text("Knife Anatomy", "copies of Knife Anatomy"),
            description = ccb.content.text("Lots of knife training methods and techniques for experienced martial artists."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_swords",
        category = "manuals",
        name = ccb.content.plural_text("USMC Sword Manual Procedure", "copies of USMC Sword Manual Procedure"),
        description = ccb.content.text("A text on stationary sword drills in US Marine Corps.  Contains lots of information about how to draw and pose with a sword, but nothing about using it."),
        mass_milligrams = 454000,
        volume_ml = 250,
        price_cents = 5200,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 4,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cutting",
    }
    book:variants {
        -- inherit name from item
        {
            id = "manual_swords",
        },
        -- 978-1838862176
        {
            id = "manual_swords_1",
            name = ccb.content.plural_text("Five Rings Illustrated", "copies of Five Rings Illustrated"),
            description = ccb.content.text("An old Japanese treatise about swordsmanship, translated and polished, with additional illustrations and detailed explanations."),
        },
        -- 978-0851155661
        {
            id = "manual_swords_2",
            name = ccb.content.plural_text("Records of the Medieval Sword", "copies of Records of the Medieval Sword"),
            description = ccb.content.text("Original research about straight two-edged knightly swords of the European middle ages."),
        },
        -- 978-1590309865
        {
            id = "manual_swords_3",
            name = ccb.content.plural_text("The Unfettered Mind", "copies of The Unfettered Mind"),
            description = ccb.content.text("An ancient Japanese book of advice about building the proper skills and mind for sword fighting.  Talks too much about Zen, but the sword techniques are worth noting."),
        },
        -- 978-1526768988
        {
            id = "manual_swords_4",
            name = ccb.content.plural_text("The Art of Longsword Fighting", "copies of The Art of Longsword Fighting"),
            description = ccb.content.text("A grounded work about the history of swordsmanship, ways to teach it, and how to enhance students' experience."),
        },
        -- 978-1473876750
        {
            id = "manual_swords_5",
            name = ccb.content.plural_text("Art of Sword Combat", "copies of Art of Sword Combat"),
            description = ccb.content.text("Translation of an old German treatise about using a few different cutting weapons in a real fight, with modern comments and clarification."),
        },
    }
    content.add(book)
end
