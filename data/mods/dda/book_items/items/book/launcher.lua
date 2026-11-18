local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_launcher",
        category = "manuals",
        name = ccb.content.plural_text("High Explosives Quarterly", "issues of High Explosives Quarterly"),
        description = ccb.content.text("An interesting quarterly report about rocket launchers and recoilless rifles.  There are lots of large, exciting photos of explosions and weaponry."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "pink",
        looks_like = "mag_glam",
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
        skill = "launcher",
    }
    book:variants {
        {
            id = "mag_launcher",
            name = ccb.content.plural_text("High Explosives Quarterly", "issues of High Explosives Quarterly"),
            description = ccb.content.text("An interesting quarterly report about rocket launchers and recoilless rifles.  There are lots of large, exciting photos of explosions and weaponry."),
        },
        -- 978-1631594274
        {
            id = "mag_launcher_1",
            name = ccb.content.plural_text("Launchers, Lobbers and Rockets Engineer", "copies of Launchers, Lobbers and Rockets Engineer"),
            description = ccb.content.text("DIY guide about different ballistic launchers, how they work, and how to build one."),
        },
        -- 978-1472810861
        {
            id = "mag_launcher_2",
            name = ccb.content.plural_text("Katyusha", "copies of Katyusha"),
            description = ccb.content.text("This book shows the history of Soviet Multiple Rocket Launcher systems, developed in a late 1930s, the reasons to use it, problems solved while designing them, and tactics for using them."),
        },
        -- 978-1849081535
        {
            id = "mag_launcher_3",
            name = ccb.content.plural_text("The Rocket Propelled Grenade", "copies of The Rocket Propelled Grenade"),
            description = ccb.content.text("Part of a big series about different small arms, this book details RPGs - how they were created, how they were used, and how they are used now in modern times."),
        },
        {
            id = "mag_launcher_4",
            name = ccb.content.plural_text("Field Artillery", "issues of Field Artillery"),
            description = ccb.content.text("A professional magazine about artillery, published by the US Field Artillery Corps.  Lots of articles analyze using modern artillery in different wars, modern and future technologies, and the most recent discoveries in ballistics and field engineering."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_launcher",
        category = "manuals",
        name = ccb.content.plural_text("Jane's Mortars and Rocket Launchers", "copies of Jane's Mortars and Rocket Launchers"),
        description = ccb.content.text("An incredibly detailed guide to modern rockets, mortars, grenade launchers, and recoilless weaponry.  Lavishly illustrated with color photographs, it contains a wealth of information."),
        mass_milligrams = 650000,
        volume_ml = 919,
        price_cents = 2000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "green",
        looks_like = "mag_guns",
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
        skill = "launcher",
    }
    book:variants {
        {
            id = "manual_launcher",
            name = ccb.content.plural_text("Jane's Mortars and Rocket Launchers", "copies of Jane's Mortars and Rocket Launchers"),
            description = ccb.content.text("An incredibly detailed guide to modern rockets, mortars, grenade launchers, and recoilless weaponry.  Lavishly illustrated with color photographs, it contains a wealth of information."),
        },
        -- 978-1472819529
        {
            id = "manual_launcher_1",
            name = ccb.content.plural_text("U.S. Grenade Launchers", "copies of U.S. Grenade Launchers"),
            description = ccb.content.text("Part of a big series about different small arms, this book tells about the M79.  Created to fill the gap between hand grenade and light mortar, this weapon became an iconic symbol of the Vietnam War, and still serves its role perfectly."),
        },
        -- 978-1940453101
        {
            id = "manual_launcher_2",
            name = ccb.content.plural_text("Catalogue of Standard Ordnance Items: Volume 3 & 4", "copies of Catalogue of Standard Ordnance Items: Volume 3 & 4"),
            description = ccb.content.text("A giant, comprehensive list of every U.S. Army weapon, munition, and piece of equipment that was used during World War II, with small, but detailed information about each of them.  Volume 3 describes light weapons like grenade launchers, recoilless rifles, man-portable anti-tank and air-defense missiles and mortars, and Volume 4 describes different heavy ammunition from 20mm to 16 inch hand and rifle grenades."),
        },
        -- 979-8642959404
        {
            id = "manual_launcher_3",
            name = ccb.content.plural_text("FM 3-09: Fire Support and Field Artillery Operations", "copies of FM 3-09: Fire Support and Field Artillery Operations"),
            description = ccb.content.text("Official U.S. Army manual about principles and functions for fire support elements and field artillery.  Most of it is about the functions and operations of artillery, alongside some ballistic calculations."),
        },
        {
            id = "manual_launcher_4",
            name = ccb.content.plural_text("FM 3-22.3: Stryker Gunnery", "copies of FM 3-22.3: Stryker Gunnery"),
            description = ccb.content.text("Official U.S. Army manual about using different light weapons - M203, ITAS M41, TOW and Javelins."),
        },
        -- 979-8538902606
        {
            id = "manual_launcher_5",
            name = ccb.content.plural_text("FM 23-11: 90mm Recoilless Rifle, M67", "copies of FM 23-11: 90mm Recoilless Rifle, M67"),
            description = ccb.content.text("Official U.S. Army manual for using the M67 anti-tank rifle - theory, practice, and essential information."),
        },
        {
            id = "manual_launcher_5",
            name = ccb.content.plural_text("Jane's Flamethrowers and Firestarters", "copies of Jane's Flamethrowers and Firestarters"),
            description = ccb.content.text("A detailed, full-colored guide to flamethrowers, incendiary weapons, and napalm.  It builds off of information provided in its sister book, Jane's Mortars and Rocket Launchers, and so it's mostly incomprehensible to anyone without prior knowledge."),
        },
    }
    content.add(book)
end
