local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "glassblowing_book",
        category = "manuals",
        name = ccb.content.plural_text("The Art of Glassblowing", "copies of The Art of Glassblowing"),
        description = ccb.content.text("A textbook that illustrates the science and technique of the ancient art of glassblowing."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 4500,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_glassblowing", time_factor = 0.7, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "plastics_book",
        category = "manuals",
        looks_like = "glassblowing_book",
        name = ccb.content.plural_text("Plastics & Polymers: Projects for the Classroom", "copies of Plastics & Polymers: Projects for the Classroom"),
        description = ccb.content.text("A textbook that goes through types and material properties of various common plastics, and how to use them in several common projects."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 4500,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_plasticworking", time_factor = 0.6, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "metal_casting_book",
        category = "manuals",
        name = ccb.content.plural_text("metal casting reference manual", "metal casting reference manuals"),
        description = ccb.content.text("A textbook with information about casting various types of metals."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 4500,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_metalworking", time_factor = 0.7, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alloy_book",
        category = "manuals",
        name = ccb.content.plural_text("alloying reference manual", "alloying reference manuals"),
        description = ccb.content.text("A textbook with information about alloying various types of metals."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 4500,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_metalworking", time_factor = 0.7, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "bronze_book",
        category = "manuals",
        name = ccb.content.plural_text("The Bronze Age Encyclopedia", "copies of The Bronze Age Encyclopedia"),
        description = ccb.content.text("A huge textbook with information about the historic use of bronze around the world, with well illustrated instructions of the manufacturing process of armor, weapons and bronze tools."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 7,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_metalworking", time_factor = 0.5, fail_factor = 0.3 },
            { id = "prof_redsmithing", time_factor = 0.7, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "bronze_mag",
        category = "manuals",
        name = ccb.content.plural_text("Historic Warfare: The Bronze Age", "copies of Historic Warfare: The Bronze Age"),
        description = ccb.content.text("An in-depth magazine about the use of bronze weapons in warfare.  There are some images about their fabrication process."),
        mass_milligrams = 200000,
        volume_ml = 250,
        price_cents = 1500,
        price_postapoc_cents = 200,
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_redsmithing", time_factor = 0.15, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "theater_props",
        category = "manuals",
        looks_like = "glassblowing_book",
        name = ccb.content.plural_text("The Prop Builder's Molding and Casting Handbook", "copies of The Prop Builder's Molding and Casting Handbook"),
        description = ccb.content.text("The first book to contain, in one comprehensive volume, every molding and casting procedure of use to the theater props builder of any skill level.  The author demonstrates the techniques involved in over thirty materials from papier-mâché to breakaway glass."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 4500,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "brown_yellow",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_plasticworking", time_factor = 0.3, fail_factor = 0.4 },
            { id = "prof_carpentry_basic", time_factor = 0.2, fail_factor = 0.2 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "jewelry_book",
        category = "manuals",
        name = ccb.content.plural_text("Antique Adornments", "copies of Antique Adornments"),
        description = ccb.content.text("A comprehensive and illustrated history of the techniques used to make crowns, bracelets, necklaces, and other types of jewelry."),
        mass_milligrams = 600000,
        volume_ml = 1250,
        price_cents = 2000,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_fine_metalsmithing", time_factor = 0.2, fail_factor = 0.3, include_prereqs = false },
            { id = "prof_gem_setting", time_factor = 0.2, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_fabrication",
        category = "manuals",
        name = ccb.content.plural_text("Crafty Crafter's Quarterly", "Crafty Crafter's Quarterlies"),
        description = ccb.content.text("A fun quarterly magazine all about macaroni art and things you can make by supergluing found objects together."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 50,
        symbol = "?",
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
        skill = "fabrication",
        proficiencies = {
            { id = "prof_pottery", time_factor = 0.15, fail_factor = 0.15 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_fabrication",
        category = "manuals",
        name = ccb.content.plural_text("101 Crafts for Beginners", "copies of 101 Crafts for Beginners"),
        description = ccb.content.text("A large, paperback book detailing a hundred and one beginner's projects in fabrication."),
        mass_milligrams = 510000,
        volume_ml = 750,
        price_cents = 2200,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 960,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_arrows",
        category = "manuals",
        name = ccb.content.plural_text("The Fletcher's Friend", "copies of The Fletcher's Friend"),
        description = ccb.content.text("This hefty book is devoted to folks looking to handcraft their own arrows.  It starts with a hip and snappy disclaimer about the risks, both physical and legal, of using explosives and flammable materials.  Look for its companion, \"The Bowyer's Buddy\"!"),
        mass_milligrams = 1454000,
        volume_ml = 1250,
        price_cents = 4800,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_fletching", time_factor = 0.15, fail_factor = 0.35 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_bows",
        category = "manuals",
        name = ccb.content.plural_text("The Bowyer's Buddy", "copies of The Bowyer's Buddy"),
        description = ccb.content.text("This hefty book is dedicated to craftsfolk and outdoors-y types looking to make their own bows.  It recommends its companion volume \"The Fletcher's Friend\" for instructions on producing their ammunition."),
        mass_milligrams = 1454000,
        volume_ml = 1250,
        price_cents = 4800,
        price_postapoc_cents = 1500,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_bowyery", time_factor = 0.15, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_bullets",
        category = "manuals",
        name = ccb.content.plural_text("The Handloader's Helper", "copies of The Handloader's Helper"),
        description = ccb.content.text("Everything you could ever want to know about handloading ammunition, sealed with a… childproof cover.  Apparently a liability thing, because the chapter on explosive rounds covers them in excellent detail too."),
        mass_milligrams = 1454000,
        volume_ml = 1500,
        price_cents = 12000,
        price_postapoc_cents = 1750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_handloading", time_factor = 0.8, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_caseless",
        category = "manuals",
        name = ccb.content.plural_text("Rivtech design binder", "Rivtech design binders"),
        description = ccb.content.text("This Rivtech binder warns that \"Unauthorized readers are our best test subjects.\" With good reason: it contains complete design specs and technical drawings for their entire line of products."),
        mass_milligrams = 1409000,
        volume_ml = 1700,
        price_cents = 84000,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 12,
        read_time_turns = 2700,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_melee",
        category = "manuals",
        name = ccb.content.plural_text("The Streetfighter's Sidekick", "copies of The Streetfighter's Sidekick"),
        description = ccb.content.text("A sizable how-to guide for making hand-to-hand combat weapons.  Though the processes are thoroughly detailed and several illustrations are provided, they rely heavily on technical jargon.  More for machinists-turned-weaponsmiths than streetfighters, really."),
        mass_milligrams = 954000,
        volume_ml = 1500,
        price_cents = 8300,
        price_postapoc_cents = 1750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 5,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_armeast",
        category = "manuals",
        name = ccb.content.plural_text("The Art of Japanese Armormaking", "copies of The Art of Japanese Armormaking"),
        description = ccb.content.text("This in-depth and technical text details various forms of ancient Japanese armor crafting, and is well illustrated with lots of photos."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 2250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3600,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_armorsmithing", time_factor = 0.2, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_armschina",
        category = "manuals",
        name = ccb.content.plural_text("Arms and Armor of Imperial China", "copies of Arms and Armor of Imperial China"),
        description = ccb.content.text("This textbook details the military history of ancient China, with a particular focus on the nature of historical arms and armor.  It also details some of the equipment used by other cultures that came into conflict with the empire over various dynasties."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 2750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_redsmithing", time_factor = 0.15, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_weparabic",
        category = "manuals",
        name = ccb.content.plural_text("Tools of Warfare in the Arabic World", "copies of Tools of Warfare in the Arabic World"),
        description = ccb.content.text("This exhaustive book details various forms of medieval period Middle Eastern and South Asian weapons and armor.  It is incredibly detailed with diagrams and pictures, but quite dry."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 2750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_redsmithing", time_factor = 0.15, fail_factor = 0.3, include_prereqs = false },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_armwest",
        category = "manuals",
        name = ccb.content.plural_text("Studies in Historic Armorsmithing", "copies of Studies in Historic Armorsmithing"),
        description = ccb.content.text("This in-depth and technical text details various forms of ancient European armor crafting, and is well illustrated with lots of photos."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 3000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3600,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_armorsmithing", time_factor = 0.2, fail_factor = 0.25 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_mesoam",
        category = "manuals",
        name = ccb.content.plural_text("The Art of Warfare in Precolumbian Mesoamericas", "copies of The Art of Warfare in Precolumbian Mesoamericas"),
        description = ccb.content.text("This intricate history book details the history of Mesoamerican warfare from the sources of the native codices, Spanish records and contemporary historians.  It contains descriptive diagrams and information on few of the weapons and armor used, mainly of the Nahuatl speaking peoples.  You reckon you could craft a few of these weapons with steel instead of obsidian."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 3000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 9,
        read_time_turns = 3600,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_fabrication",
        category = "manuals",
        name = ccb.content.plural_text("DIY Compendium", "copies of DIY Compendium"),
        description = ccb.content.text("A thick, hardbound book detailing countless projects for inventions that claim to improve all aspects of life."),
        mass_milligrams = 2100000,
        volume_ml = 1750,
        price_cents = 4500,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_fireman",
        category = "manuals",
        name = ccb.content.plural_text("A History of Firefighting", "copies of A History of Firefighting"),
        description = ccb.content.text("This in-depth and technical text details the history of firefighting from ancient times into the modern era, with a focus on the technology used to save lives."),
        mass_milligrams = 528000,
        volume_ml = 1000,
        price_cents = 6500,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 7,
        maximum_level = 9,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_weapeast",
        category = "manuals",
        name = ccb.content.plural_text("The Swords of the Samurai", "copies of The Swords of the Samurai"),
        description = ccb.content.text("This in-depth and technical text details various forms of ancient Japanese sword smithing, and is well illustrated with step by step photo instructions."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_bladesmith", time_factor = 0.2, fail_factor = 0.3, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_weapwest",
        category = "manuals",
        name = ccb.content.plural_text("The Historic Weaponsmith", "copies of The Historic Weaponsmith"),
        description = ccb.content.text("This in-depth and technical text details various forms of ancient European weapon smithing, and is well illustrated with step by step photo instructions."),
        mass_milligrams = 654000,
        volume_ml = 1250,
        price_cents = 6400,
        price_postapoc_cents = 3000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_bladesmith", time_factor = 0.15, fail_factor = 0.25, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "welding_book",
        category = "manuals",
        name = ccb.content.plural_text("Welding and Metallurgy", "copies of Welding and Metallurgy"),
        description = ccb.content.text("A rather technical textbook that illustrates the science and technique of becoming a better welder."),
        mass_milligrams = 2100000,
        volume_ml = 1750,
        price_cents = 6500,
        price_postapoc_cents = 1500,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_welding", time_factor = 0.25, fail_factor = 0.3, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "101_carpentry",
        category = "manuals",
        name = ccb.content.plural_text("101 Home Repairs", "copies of 101 Home Repairs"),
        description = ccb.content.text("A paperback book detailing 101 home repair projects for the novice carpenter."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 1800,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 5,
        read_time_turns = 960,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_carpentry_basic", time_factor = 0.2, fail_factor = 0.3, include_prereqs = true },
            { id = "prof_plumbing", time_factor = 0.2, fail_factor = 0.2, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "carpentry_book",
        category = "manuals",
        name = ccb.content.plural_text("The Complete Home Repair Guide", "copies of The Complete Home Repair Guide"),
        description = ccb.content.text("A massive book that details virtually every aspect of remodeling and repairing a home, with concise terminology aimed at experienced carpenters."),
        mass_milligrams = 2490000,
        volume_ml = 2000,
        price_cents = 8200,
        price_postapoc_cents = 1000,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 9,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_carpentry_basic", time_factor = 0.3, fail_factor = 0.3, include_prereqs = true },
            { id = "prof_plumbing", time_factor = 0.2, fail_factor = 0.3, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_carpentry",
        category = "manuals",
        name = ccb.content.plural_text("Birdhouse Monthly", "Birdhouse Monthlies"),
        description = ccb.content.text("A riveting periodical all about birdhouses and their construction."),
        mass_milligrams = 60000,
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
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_carpentry_basic", time_factor = 0.2, fail_factor = 0.1, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_carpentry",
        category = "manuals",
        name = ccb.content.plural_text("Building for Beginners", "copies of Building for Beginners"),
        description = ccb.content.text("A large, paperback book detailing several beginner's projects in construction."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 2200,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 960,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
        proficiencies = {
            { id = "prof_carpentry_basic", time_factor = 0.1, fail_factor = 0.4, include_prereqs = true },
            { id = "prof_plumbing", time_factor = 0.1, fail_factor = 0.2, include_prereqs = true },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_carpentry",
        category = "manuals",
        name = ccb.content.plural_text("Engineering 301", "copies of Engineering 301"),
        description = ccb.content.text("A textbook on civil engineering and construction."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 6500,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "reference_fabrication1",
        category = "manuals",
        name = ccb.content.plural_text("Machinery's Handbook", "copies of Machinery's Handbook"),
        description = ccb.content.text("This classic reference work contains extensive, dense chapters and tables on materials, metrology, toolmaking, gears, threading and more.  This recent edition includes extensive data on the latest techniques in additive manufacturing.  If you need to know how best complete a certain machining operation, the answer lies somewhere in these pages."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 8000,
        price_postapoc_cents = 1500,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1800,
        fun = -2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "concrete_book",
        category = "manuals",
        name = ccb.content.plural_text("Concrete Constructions", "copies of Concrete Constructions"),
        description = ccb.content.text("A collection of notable uses of concrete.  Contains detailed directions on how to mix and use cement to form useful aggregates."),
        mass_milligrams = 600000,
        volume_ml = 1250,
        price_cents = 4000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "ballista_book",
        category = "manuals",
        name = ccb.content.plural_text("Artillery of the Ancients", "copies of Artillery of the Ancients"),
        description = ccb.content.text("This is a history book detailing the siege machines and field artillery of some ancient civilizations.  It contains detailed diagrams that explain how such devices were assembled and maintained."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        price_cents = 4000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "blue",
        looks_like = "recipe_lab_elec",
    }
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1500,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_dave_manual",
        category = "manuals",
        name = ccb.content.plural_text("Dino Dave's cardboard notebook", "copies of Dino Dave's cardboard notebook"),
        description = ccb.content.text("This school notebook contains an astounding amount of \"recipes\" of various cardboard utilities, ranging from the wholly impractical to completely impossible.  Despite that, they're illustrated in a surprisingly thorough manner, to the point where you could possibly learn something from studying the chicken scratch and schematics in detail.  The last page thanks a number of names, some of which you recognize from the refugee center.  Your name covers half the page.  At the bottom, it warns you not to let \"the sandman\" read it."),
        mass_milligrams = 600000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "?",
        looks_like = "mag_glam",
        color = "brown_yellow",
    }
    book:material("paper", 1)
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 14,
        read_time_turns = 1200,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "improvised_munition_handbook",
        category = "manuals",
        name = ccb.content.plural_text("TM 31-210 Improvised Munitions Handbook", "copies of TM 31-210 Improvised Munitions Handbook"),
        description = ccb.content.text("Army manual, written for situations when military supplies are inaccessible, and describes a variety of ways an army man can produce simple munition out of materials at hand.  Opposite to more popular books of this type, this one is keen to preserve your body integrity in the process, although caution is advised nonetheless."),
        mass_milligrams = 130000,
        volume_ml = 550,
        price_cents = 1195,
        price_postapoc_cents = 2800,
        symbol = "?",
        looks_like = "textbook_anarch",
        color = "yellow",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 6,
        read_time_turns = 2700,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_lab_cvd",
        category = "manuals",
        name = ccb.content.plural_text("lab journal-Gustav", "lab journals-Gustav"),
        description = ccb.content.text("This paper notebook is mostly full of boring logs, experimental observations and notes.  Mixed in, however, are musings on how to use the lab's vapor deposition machine to deposit amorphous carbon in a diamond-like form onto common metals.  The author's intended goal was a better non-stick frying pan, but you can think of a couple of better uses for it."),
        mass_milligrams = 600000,
        volume_ml = 500,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        looks_like = "recipe_lab_elec",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 9,
        maximum_level = 10,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_migo_plate",
        category = "manuals",
        name = ccb.content.plural_text("WX010 Living Armor Observations", "copies of WX010 Living Armor Observations"),
        description = ccb.content.text("This sheaf of papers seems to describe maintenance on a new form of ballistic armor.  \"the regenerative plates though promising for field use do require maintenance or combat to stop from becoming overgrown\"."),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 10,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end
