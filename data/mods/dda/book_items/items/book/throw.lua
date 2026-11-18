local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_throwing",
        category = "manuals",
        name = content.plural_text("Diskobolus", "issues of Diskobolus"),
        description = content.text("A biannual magazine devoted to the art and science of discus-throwing."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 1,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "throw",
    }
    book:variants {
        {
            id = "mag_throwing",
            name = content.plural_text("Diskobolus", "issues of Diskobolus"),
            description = content.text("A biannual magazine devoted to the art and science of discus-throwing."),
        },
        -- 978-0578840550
        {
            id = "mag_throwing_1",
            name = content.plural_text("The Perfect Throw", "copies of The Perfect Throw"),
            description = content.text("This book has pretty good information about ways to throw a hatchet, from a World Axe Throwing Championship champion.  You are surprised there was a championship for axe throwing."),
        },
        -- 978-1478118169
        {
            id = "mag_throwing_2",
            name = content.plural_text("Sergeant Shenk's Comprehensive Book on Knife Throwing", "copies of Sergeant Shenk's Comprehensive Book on Knife Throwing"),
            description = content.text("Illustrated booklet, that covers the basics of knife throwing."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_throw",
        category = "manuals",
        name = content.plural_text("The Complete Guide to Pitching", "copies of The Complete Guide to Pitching"),
        description = content.text("A detailed guide for baseball pitchers that combines time-tested techniques and information mixed with a common sense approach to pitching."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 2800,
        price_postapoc_cents = 750,
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
        skill = "throw",
    }
    book:variants {
        {
            id = "manual_throw",
            name = content.plural_text("The Complete Guide to Pitching", "copies of The Complete Guide to Pitching"),
            description = content.text("A detailed guide for baseball pitchers that combines time-tested techniques and information mixed with a common sense approach to pitching."),
        },
        -- 978-1632205308
        {
            id = "manual_throw_1",
            name = content.plural_text("The Ultimate Guide to Knife Throwing", "copies of The Ultimate Guide to Knife Throwing"),
            description = content.text("A precise handbook for someone who wants to win a throwing tournament."),
        },
        -- 978-0764347795
        {
            id = "manual_throw_2",
            name = content.plural_text("Guide to Knife & Ax Throwing", "copies of Guide to Knife & Ax Throwing"),
            description = content.text("A small, simple guide on how to throw a projectile, with different techniques, guides, and tricks."),
        },
        -- 978-0804815420
        {
            id = "manual_throw_3",
            name = content.plural_text("Knife & Tomahawk Throwing: The Art of the Experts", "copies of Knife & Tomahawk Throwing: The Art of the Experts"),
            description = content.text("A small book on the long history of projectile throwing and the people building the sport.  It serves as a guide for someone who wants to get into it, with useful drills and diagrams."),
        },
        -- 978-1510768970
        {
            id = "manual_throw_4",
            name = content.plural_text("The Science of Baseball", "copies of The Science of Baseball"),
            description = content.text("The author and several experts cover topics like what makes a ball break, bounce, and fly; how material science and physics work together to make the bat function; how hitters use physics, geometry, and force to connect; baseball injuries; and much more."),
        },
        -- 978-1886950023
        {
            id = "manual_throw_5",
            name = content.plural_text("The Complete Knife Throwing Guide", "copies of The Complete Knife Throwing Guide"),
            description = content.text("A tiny, though still comprehensive manual of knife throwing from experienced knifemaker."),
        },
    }
    content.add(book)
end
