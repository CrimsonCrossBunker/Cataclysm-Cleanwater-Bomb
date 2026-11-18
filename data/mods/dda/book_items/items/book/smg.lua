local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_smg",
        category = "manuals",
        name = ccb.content.plural_text("Submachine Gun Enthusiast", "issues of Submachine Gun Enthusiast"),
        description = ccb.content.text("An in-depth magazine about submachine guns and shooting.  There is an exhaustive article about close quarter combat techniques in the front."),
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
        skill = "smg",
    }
    book:variants {
        {
            id = "mag_smg",
            name = ccb.content.plural_text("Submachine Gun Enthusiast", "issues of Submachine Gun Enthusiast"),
            description = ccb.content.text("An in-depth magazine about submachine guns and shooting.  There is an exhaustive article about close quarter combat techniques in the front."),
        },
        -- 978-1782009177
        {
            id = "mag_smg_1",
            name = ccb.content.plural_text("The MP5 Submachine Gun", "copies of The MP5 Submachine Gun"),
            description = ccb.content.text("A small, shiny journal about the most famous machine gun in the world, H&K MP5, and how it is used currently."),
        },
        {
            id = "mag_smg_2",
            name = ccb.content.plural_text("Guns & Weapons for Law Enforcement", "issues of Guns & Weapons for Law Enforcement"),
            description = ccb.content.text("A relatively old magazine about modern automatic firearms police may use.  This issue talks about submachine guns and the brand new KRISS Super V .45 ACP specifically."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_smg",
        category = "manuals",
        name = ccb.content.plural_text("The Submachine Gun Handbook", "copies of The Submachine Gun Handbook"),
        description = ccb.content.text("This concise guide details the proper care and operation of most forms of machine pistols and submachine guns currently used by regular armed and reserve forces, as well as several obsolete weapons."),
        mass_milligrams = 362000,
        volume_ml = 500,
        price_cents = 2100,
        price_postapoc_cents = 1250,
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
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "smg",
    }
    book:variants {
        {
            id = "manual_smg",
            name = ccb.content.plural_text("The Submachine Gun Handbook", "copies of The Submachine Gun Handbook"),
            description = ccb.content.text("This concise guide details the proper care and operation of most forms of machine pistols and submachine guns currently used by regular armed and reserve forces, as well as several obsolete weapons."),
        },
        -- 978-0982391815
        {
            id = "manual_smg_1",
            name = ccb.content.plural_text("The Mac Man", "copies of The Mac Man"),
            description = ccb.content.text("The full story of Gordon Ingram and his revolutionary machine gun designs: the Model 6, MAC-10, MAC-11, and SWD."),
        },
        -- 978-1847972934
        {
            id = "manual_smg_2",
            name = ccb.content.plural_text("The Development of Sub-Machine Guns and their Ammunition from World War 1 to the Present Day", "copies of The Development of Sub-Machine Guns and their Ammunition from World War 1 to the Present Day"),
            description = ccb.content.text("A comprehensive study of the development and use of the sub-machine gun since World War I, including a country-by-country survey of equipment used, with lots of illustrations and precise information."),
        },
        -- 978-0764354847
        {
            id = "manual_smg_3",
            name = ccb.content.plural_text("American Submachine Guns 1919–1950", "copies of American Submachine Guns 1919–1950"),
            description = ccb.content.text("A fully illustrated book about famous submachine guns, their design, construction, and testing, as well as their accessories such as magazines, ammunition, webbing, and cleaning kits."),
        },
        -- 978-1493673346
        {
            id = "manual_smg_4",
            name = ccb.content.plural_text("Firearm Anatomy", "copies of Firearm Anatomy"),
            description = ccb.content.text("Part of a big series about weapons and their complexity, this issue describes the long history of the M1A1 Thompson Submachine gun - when it was created, why, and why it is iconic now."),
        },
        -- 979-8730435377
        {
            id = "manual_smg_5",
            name = ccb.content.plural_text("An Amateur's Guide for the Colt's Thompson Submachine Gun", "copies of An Amateur's Guide for the Colt's Thompson Submachine Gun"),
            description = ccb.content.text("A 200-page collector's manual advising how to buy a real, old Tommy Gun, with detailed info on each model, info about maintenance and shooting, and stories about its usage in the St. Louis Police Department."),
        },
        -- 978-1940453118
        {
            id = "manual_smg_6",
            name = ccb.content.plural_text("Submachine Guns Caliber .45", "copies of Submachine Guns Caliber .45"),
            description = ccb.content.text("Part of an old army field manual, this book explains the usage and maintenance of the M3 and M3A1, and how it was adopted into U.S. Army service in 1942."),
        },
        -- 978-1733005333
        {
            id = "manual_smg_7",
            name = ccb.content.plural_text("Maintenance on the MP40, PPSH41, M3A1, and Sten MKII Submachine Guns", "copies of Maintenance on the MP40, PPSH41, M3A1, and Sten MKII Submachine Guns"),
            description = ccb.content.text("A short manual about the disassembly, reassembly, maintenance, operation, and repair of some old machine guns.  Seems it has lack of some info, but better than nothing."),
        },
    }
    content.add(book)
end
