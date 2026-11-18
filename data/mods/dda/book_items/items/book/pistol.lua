local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_pistol",
        category = "manuals",
        name = content.plural_text("Tactical Handgun Digest", "issues of Tactical Handgun Digest"),
        description = content.text("A glossy magazine all about handguns and shooting.  There is a good article about proper sighting near the middle."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
        looks_like = "mag_glam",
        symbol = "?",
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
        skill = "pistol",
    }
    book:variants {
        {
            id = "mag_pistol",
            name = content.plural_text("Tactical Handgun Digest", "issues of Tactical Handgun Digest"),
            description = content.text("A glossy magazine all about handguns and shooting.  There is a good article about proper sighting near the middle."),
        },
        -- 978-0764358371
        {
            id = "mag_pistol_1",
            name = content.plural_text("Shooting Handguns", "copies of Shooting Handguns"),
            description = content.text("Simple beginner's guide to shooting handguns safely and effectively; simple and effective rules with some key information about handguns themselves."),
        },
        -- 978-0996085342
        {
            id = "mag_pistol_2",
            name = content.plural_text("The Practical Guide to Guns and Shooting, Handgun Edition", "copies of The Practical Guide to Guns and Shooting, Handgun Edition"),
            description = content.text("A practical guide for one who want to buy a gun - how they differ, how to choose the right ammo, shooting techniques, and lot of another info."),
        },
        -- 9781438948928
        {
            id = "mag_pistol_3",
            name = content.plural_text("Defensive Handgun for the Armed Citizen", "copies of Defensive Handgun for the Armed Citizen"),
            description = content.text("This book takes carrying handguns seriously, and delivers lots of information a user may need to know, including self defense concepts, using deadly force, analyzing confrontation, as well as handgun tactics and techniques."),
        },
        -- 978-1440218125
        {
            id = "mag_pistol_4",
            name = content.plural_text("The Gun Digest Book of the Revolver", "copies of The Gun Digest Book of the Revolver"),
            description = content.text("This book covers all aspects of the double-action revolver: shooting, handling, carrying, maintaining, and accessorizing - everything you need to know to operate the quintessential American handgun."),
        },
        {
            id = "mag_pistol_5",
            name = content.plural_text("American Handgunner", "issues of American Handgunner"),
            description = content.text("A shiny magazine about handguns and activities around them - handgun hunting, competition shooting, reloading, new brands and gear, ammo, and other similar things."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_pistol",
        category = "manuals",
        name = content.plural_text("The Tao of the Handgun", "copies of The Tao of the Handgun"),
        description = content.text("This introspective volume covers proper usage of handguns, from safety and stance, to maintenance and proper sighting technique."),
        mass_milligrams = 440000,
        volume_ml = 500,
        price_cents = 2200,
        price_postapoc_cents = 1250,
        looks_like = "book_archery",
        symbol = "?",
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
        skill = "pistol",
    }
    book:variants {
        {
            id = "manual_pistol",
            name = content.plural_text("The Tao of the Handgun", "copies of The Tao of the Handgun"),
            description = content.text("This introspective volume covers proper usage of handguns, from safety and stance, to maintenance and proper sighting technique."),
        },
        {
            id = "manual_pistol_1",
            name = content.plural_text("Practical Guide to the Operational Use of the TT-33 Tokarev Pistol", "copies of Practical Guide to the Operational Use of the TT-33 Tokarev Pistol"),
            description = content.text("The most current, up to date, full color manual anywhere on the TT-33 Tokarev pistol, from former Special Forces instructor.  Surprisingly easy to follow."),
        },
        -- 978-0989038232
        {
            id = "manual_pistol_2",
            name = content.plural_text("Gun Safety: For Home Defense And Concealed Carry", "copies of Gun Safety: For Home Defense And Concealed Carry"),
            description = content.text("A book for a responsible gun owner, it highlights using weapons in the civil world, with lot of rules and legal recommendations, alongside how to avoid harm for the gun user and their environment."),
        },
        -- 978-1782741503
        {
            id = "manual_pistol_3",
            name = content.plural_text("Pistols & Revolvers: From 1400 to the Present Day", "copies of Pistols & Revolvers: From 1400 to the Present Day"),
            description = content.text("The book contains a long, detailed history of handguns - from the very first hand cannons to the latest automatics and machine pistols, with photos, technical specifications, and some artwork."),
        },
        -- 9780912412122
        {
            id = "manual_pistol_4",
            name = content.plural_text("Pistol & Revolver Handbook", "copies of Pistol & Revolver Handbook"),
            description = content.text("A complete guide to maintaining handguns - lots of information about components, reloading, bullet types, and ballistics."),
        },
        -- 978-1951115500
        {
            id = "manual_pistol_5",
            name = content.plural_text("Gun Digest Book of Automatic Pistols Assembly/Disassembly", "copies of Gun Digest Book of Automatic Pistols Assembly/Disassembly"),
            description = content.text("A giant, 1000-page manual of with step-by-step instructions for the disassembly of automatic pistols.  Over 100 models are covered, with clear photos and procedure tips."),
        },
        -- 978-1946267498
        {
            id = "manual_pistol_6",
            name = content.plural_text("Book of Revolvers Assembly/Disassembly", "copies of Book of Revolvers Assembly/Disassembly"),
            description = content.text("A 700-page instructional manual of different revolver disassembly processes, with photos, detailed steps, and additional info."),
        },
        {
            id = "manual_pistol_7",
            name = content.plural_text("FM 3-23.35: Combat Training With Pistols, M9 And M11", "copies of FM 3-23.35: Combat Training With Pistols, M9 And M11"),
            description = content.text("Official U.S. Army manual detailing how M9 and M11 handguns work, and how to use them safely and effectively."),
        },
        {
            id = "manual_pistol_8",
            name = content.plural_text("Black Powder to Berettas", "copies of Black Powder to Berettas"),
            description = content.text("This hardcover book, aimed at the gun nut, provides an illustrated, concise history of the handgun throughout history, including technical specifications and use techniques.  It's difficult to follow without a passing knowledge in pistols, but an experienced handgun user could glean much from it."),
        },
    }
    content.add(book)
end
