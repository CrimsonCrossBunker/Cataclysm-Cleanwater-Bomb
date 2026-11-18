local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_shotgun",
        category = "manuals",
        name = content.plural_text("Trap and Field", "issues of Trap and Field"),
        description = content.text("An in-depth magazine all about shotguns and shooting.  There is an informative article about proper shooting stance in the back pages."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "mag_guns",
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
        skill = "shotgun",
    }
    book:variants {
        {
            id = "mag_shotgun",
            name = content.plural_text("Trap and Field", "issues of Trap and Field"),
            description = content.text("An in-depth magazine all about shotguns and shooting.  There is an informative article about proper shooting stance in the back pages."),
        },
        -- 978-1440240683
        {
            id = "mag_shotgun_1",
            name = content.plural_text("Gun Digest Shooter's Guide to Shotguns", "copies of Gun Digest Shooter's Guide to Shotguns"),
            description = content.text("A training guide for anyone who never used a shotgun, with simple explanations and drills."),
        },
        {
            id = "mag_shotgun_2",
            name = content.plural_text("Man Magnum", "issues of Man Magnum"),
            description = content.text("A modern magazine, published in South Africa, it contains various information about hunting and shooting.  This particular issue has a lot of information about shotguns and drills with them."),
        },
        {
            id = "mag_shotgun_3",
            name = content.plural_text("Texas Parks and Wildlife", "issues of Texas Parks and Wildlife"),
            description = content.text("Published by Texas Parks and Wildlife Department, this book contains lots of information and photos about nature and recreation in Texas's fields.  This exact issue is about hunting and gun safety."),
        },
        {
            id = "mag_shotgun_4",
            name = content.plural_text("The Wingshooter's Diary", "issues of The Wingshooter's Diary"),
            description = content.text("An annual magazine about bird hunting, including species identification, hunting techniques, and equipment recommendations."),
        },
        {
            id = "mag_shotgun_5",
            name = content.plural_text("The Skeet Shooter's Logbook", "copies of The Skeet Shooter's Logbook"),
            description = content.text("A small guide to skeet shooting, including rules, equipment, tips, and techniques for improving accuracy and performance."),
        },
        -- 978-0976020400
        {
            id = "mag_shotgun_6",
            name = content.plural_text("If It Ain't Broke, Fix It!", "copies of If It Ain't Broke, Fix It!"),
            description = content.text("The beginner's guide to clay shooting, with lots of advice, instructions, and drills."),
        },
        -- 978-0976020417
        {
            id = "mag_shotgun_7",
            name = content.plural_text("Sporting Clays Consistency", "copies of Sporting Clays Consistency"),
            description = content.text("A bird and clay shooting manual, this book contains lots of information about proper shotgun shooting like stances, aim, and ballistics."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_shotgun",
        category = "manuals",
        name = content.plural_text("Shotguns: The Art and Science", "copies of Shotguns: The Art and Science"),
        description = content.text("This book claims to address every problem the shotgunner is likely to face, and offers solutions to ensure that shooters can make every shot count."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 2100,
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
        intelligence = 3,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "shotgun",
    }
    book:variants {
        {
            id = "manual_shotgun",
            name = content.plural_text("Shotguns: The Art and Science", "copies of Shotguns: The Art and Science"),
            description = content.text("This book claims to address every problem the shotgunner is likely to face, and offers solutions to ensure that shooters can make every shot count."),
        },
        -- 978-1616080891
        {
            id = "manual_shotgun_1",
            name = content.plural_text("Fine Shotguns", "copies of Fine Shotguns"),
            description = content.text("This book shows the history, science and art of the most beautiful shotguns in the world - single and double barrel, combination, hammer shotguns, paired shotguns, special-use guns, and small-bore shotguns from around the world, with detailed information about each of them, and their usage."),
        },
        -- 978-1939473219
        {
            id = "manual_shotgun_2",
            name = content.plural_text("Shotguns: A Comprehensive Guide", "copies of Shotguns: A Comprehensive Guide"),
            description = content.text("Detailed manual about buying, owning, and shooting a shotgun, with additional information like cleaning, safety, and training."),
        },
        -- 9781510709249
        {
            id = "manual_shotgun_3",
            name = content.plural_text("Winchester Shotguns", "copies of Winchester Shotguns"),
            description = content.text("An illustrated chronicle of every model designed and produced under the Winchester name, with a wealth of facts, figures, and historically relevant information."),
        },
        -- 978-1940453712
        {
            id = "manual_shotgun_4",
            name = content.plural_text("Ordnance Maintenance Shotguns, All Types", "copies of Ordnance Maintenance Shotguns, All Types"),
            description = content.text("Part of a 1942 army manual, this book contains lots of information about the proper usage and maintenance of all shotguns that were adopted by the U.S. military, including the Winchester M97 and M12, Stevens M620, M620A and M520, the Ithaca M37, the Remington M31, M11, and Browning Automatic 5."),
        },
        -- 978-1581604368
        {
            id = "manual_shotgun_5",
            name = content.plural_text("Streetsweepers", "copies of Streetsweepers"),
            description = content.text("A comprehensive book about combat shotguns, covering single- and double-barreled, slide-action, semi-auto and rotary-cylinder shotguns, their usage, service, and tactics."),
        },
        -- 978-0924357480
        {
            id = "manual_shotgun_6",
            name = content.plural_text("Shotguns and Shooting", "copies of Shotguns and Shooting"),
            description = content.text("This book has lot of fundamental information about shotguns, their workmanship, engineering, and art, along with lot of practical trainings for them."),
        },
        -- 978-1905124862
        {
            id = "manual_shotgun_7",
            name = content.plural_text("Shotguns - Their History and Development", "copies of Shotguns - Their History and Development"),
            description = content.text("An old magazine about shotguns: their history, models, cartridges, ballistics, accessories, and shooting, along with an appendix on shotgun data and tables."),
        },
        -- 978-0892727742
        {
            id = "manual_shotgun_8",
            name = content.plural_text("Vintage British Shotguns", "copies of Vintage British Shotguns"),
            description = content.text("A good guide for both sportsmen and gun collectors, this book contains information about classic shotguns and their usage."),
        },
        {
            id = "manual_shotgun_9",
            name = content.plural_text("USMC M1014 technical manual", "USMC M1014 technical manuals"),
            description = content.text("A pocket-sized book printed in 2000 by the United States Marine Corps for official use.  It describes the operation, repair, and cleaning of the Benelli M1014 shotgun.  Though specific to the M4, it can provide a wealth of information to the trained eye."),
        },
    }
    content.add(book)
end
