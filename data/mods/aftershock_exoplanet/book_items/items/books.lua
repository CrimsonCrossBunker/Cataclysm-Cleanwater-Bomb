local content = require("ccb").content

do
    local book = content.Item {
        id = "afs_librarian_book",
        name = content.plural_text("original copy of Housefly", "original copies of Housefly"),
        description = content.text("The only copy of Housefly in existence - a long book about three individuals drawn together by fate in the early 1800s to save their English town of Victoria from a mysterious threat.  You never got to publish it, but reading it lets you forget the horrors of the Cataclysm, if only for a moment."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        looks_like = "ZSG",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 6,
        chapters = 30,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "afs_welcome2_book",
        name = content.plural_text("Unofficial History of Salus IV Vol. 2", "copies of Unofficial History of Salus IV Vol. 2"),
        description = content.text("Even during the Discontinuity Salus IV's population continued to drop as there were easier places to live even in the Salus system - from honeycombed asteroid habitats to domed cities with gorgeous views.  Mercurial Genomics was an early member of the nascent post-Discontinuity government efforts.  As a result of this membership, they have successfully reclaimed Salus IV in the court system set up by ESCA.  The Whately family, which runs Mercurial Genomics, began leasing development and exploitation permits and allows the establishment of minor UICA outposts within Salus IV.  There is an official citizen count of less than twenty thousand sentient beings, albeit mostly in orbit.  It is believed, however, that there are at least that many non-citizen sentients spread amongst squatter, smuggler, pirate, and feral uplift communities."),
        copy_from = "afs_welcome1_book",
        looks_like = "afs_welcome1_book",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "afs_welcome3_book",
        name = content.plural_text("Unofficial History of Salus IV Vol. 3", "copies of Unofficial History of Salus IV Vol. 3"),
        description = content.text("The Salus system is what is called a hinge system for the new FTL travels.  This system contains a number of easy exit points to star systems that have no other easy way to travel to each other than through a series of systems with low to zero civilization in them.  Salus has several interstellar refueling points.  These stations are often blind to each other as the planets and other objects rotate around the sun.  Mercurial seems to have no interest in managing or protecting the traffic that flows through the Salus system or in neighboring systems beyond the bare minimum effort required by UICA.  As a result of this neglect; victims of pirate attacks, engine failure and other critical issues regularly limp to whatever safety they can find in the Salus system.  Unfortunately for many of them they will crash land on Salus IV where there are few regular shuttles between its scattered ports and the outside universe.  As the locals are fond of saying 'Getting to Salus IV is hard, getting off may be impossible'."),
        copy_from = "afs_welcome1_book",
        looks_like = "afs_welcome1_book",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "afs_bugbrew_book",
        category = "manuals",
        name = content.plural_text("mealworm farm logbook", "mealworm farm logbooks"),
        description = content.text("A binder containing detailed production logs from an industrial mealworm farm.  You could use its recordings to start your own farming operations."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        looks_like = "file",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 12,
        read_time_turns = 3000,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_diamond_press",
        name = content.plural_text("diamond press schematics", "diamond press schematics"),
        description = content.text("Bearing the logo of Matrioshka Fabritechnics, those are assembly plans, design specs, and technical drawings for the diamond press.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_nano_forge",
        name = content.plural_text("nano forge schematics", "nano forge schematics"),
        description = content.text("Bearing the logo of Matrioshka Fabritechnics, those are assembly plans, design specs, and technical drawings for the nano forge.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_eyebot",
        name = content.plural_text("eyebot schematics", "eyebot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the eyebot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_copbot",
        name = content.plural_text("police bot schematics", "police bot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the police bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_riotbot",
        name = content.plural_text("riot control bot schematics", "riot control bot schematics"),
        description = content.text("Assembly plans, design specs, and technical drawings for the riot control bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "afs_landfall_kit_2_instructions",
        category = "manuals",
        name = content.plural_text("landfall survival manual", "landfall survival manuals"),
        description = content.text("A small folio indicating how to best utilize the equipment of your landfall survival kit during an emergency.  Its first page urges you to remain calm, and to consult your escape pod's control console for further instructions."),
        mass_milligrams = 120000,
        volume_ml = 500,
        price_cents = 0,
        symbol = "?",
        looks_like = "file",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 9,
        read_time_turns = 1200,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "survival",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cyrus'_notes",
        category = "manuals",
        name = content.plural_text("Cyrus Whateley's Notes on Repurposing mi-go victims", "copies of Cyrus Whateley's Notes"),
        description = content.text("A folio of notes written by a madman.  They seem to suggest ways to re-animate the dead and create various affronts to the natural order."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 929200,
        symbol = "?",
        looks_like = "adv_chemistry",
        color = "light_green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 8,
        maximum_level = 9,
        intelligence = 13,
        read_time_turns = 3000,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_uplift",
        name = content.plural_text("Dr. Moreau and You", "copies of Dr. Moreau and You"),
        description = content.text("In what many considered a stunning example of poor taste and others considered overt speciesism this text on the creation of Uplifted Animals references a story about sapient animals killing their creator.  Otherwise a dry text about genetic modification."),
        copy_from = "textbook_atomic",
        looks_like = "textbook_atomic",
    }
    book:book {
        required_level = 9,
        maximum_level = 10,
        intelligence = 13,
        read_time_turns = 3000,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "millyficents_diary",
        category = "manuals",
        name = content.plural_text("Millyficent's Diary", "copies of Millyficent's Diary"),
        description = content.text("A pocket-sized book filled to the margins with cramped handwriting and notes on the biology of Mi-Go and other musings.  It's hard to understand and quite gruesome in some places and written in a shorthand or cipher in others."),
        mass_milligrams = 600000,
        volume_ml = 250,
        price_cents = 300000,
        symbol = "?",
        looks_like = "ZSG",
        color = "cyan",
    }
    book:material("paper", 1)
    book:book {
        required_level = 10,
        maximum_level = 10,
        intelligence = 16,
        read_time_turns = 2100,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipes_resistance",
        category = "manuals",
        name = content.plural_text("useful recipes for resistance", "copies of useful recipes for resistance"),
        description = content.text("Recipes for Resistance is a collection of tales, strategies and recipes for working against corporate rule.  Very simple language is used in the recipes but it drags out the explanations."),
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 64000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
        looks_like = "adv_chemistry",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 9,
        read_time_turns = 3000,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipes_cryolab",
        category = "manuals",
        name = content.plural_text("Working in Boreal Conditions and Beyond", "copies of Working in Boreal Conditions and Beyond"),
        description = content.text("A corporate manual for conditions of inhospitable cold.  It includes instructions for building devices and substances that will aid in survival in extreme weather or even the lack thereof."),
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 64000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_cyan",
        looks_like = "recipe_lab_elec",
    }
    book:material("paper", 1)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 14,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_unusual_ammos",
        category = "manuals",
        name = content.plural_text("Unusual Ammunitions of the Corporations", "copies of Unusual Ammunitions of the Corporations"),
        description = content.text("A lab book dedicated to reverse engineering various ammunitions found throughout the solar system.  Written in a format to allow barely trained technicians to *safely* replicate these rounds."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 9200,
        symbol = "?",
        looks_like = "adv_chemistry",
        color = "light_green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 9,
        read_time_turns = 3000,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_lichenlog",
        category = "manuals",
        name = content.plural_text("Applications of Salus IV Lichen", "copies of Applications of Salus IV Lichen"),
        description = content.text("A sheaf of notes detailing some species of lichen.  Most of the information is useless to you except for the fact that the majority of Salus IV lifeform's metabolism rely on a macronutrient that acts like a neurotoxin for humans.  One useful note is a detailed procedure to neutralize said neurotoxin."),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 5000,
        symbol = "?",
        looks_like = "recipe_medicalmut",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 9,
        read_time_turns = 3000,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "exosuit_maintenance",
        name = content.plural_text("TsKBEM Exoskeleton user manual", "copies of TsKBEM Exoskeleton user manuals"),
        description = content.text("A somewhat hefty manual in Russian with accompanying English text which goes in-depth into the proper usage and maintenance of TsKBEM brand Exoskeletons.\n\nWhile it mainly pertains to the old TsKBEM exoskeletons, the knowledge within could still help out with modular exoskeletons in general."),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 5000,
        symbol = "?",
        looks_like = "adv_chemistry",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 9,
        read_time_turns = 3000,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "afs_welcome1_book",
        name = content.plural_text("Unofficial History of Salus IV Vol. 1", "copies of Unofficial History of Salus IV Vol. 1"),
        description = content.text("Welcome to Frozen Hell, an unofficial history of Salus IV by Bette Lapin.  Salus IV was founded in the early days of the Hyperspace Era as a joint venture between Mercurial Genomics and a Soviet Design Bureau.  At its height several hundred years ago Salus IV had just over 110 million citizens (including both uplifts and humans). However, that population had begun to decline even before the Discontinuity as people migrated to planets that, while more hostile to life during the earliest colonization phases than Salus IV, were much simpler to terraform into a place more enjoyable by human and uplift citizens."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        looks_like = "ZSG",
        symbol = "?",
        color = "light_blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 2,
        chapters = 3,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_atomic",
        category = "manuals",
        name = content.plural_text("Nuclear Physics Made Easy", "copies of Nuclear Physics Made Easy"),
        description = content.text("A book detailing the workings of state of the art atomic technology, and the physics behind it."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 9200,
        symbol = "?",
        looks_like = "adv_chemistry",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 3000,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_chickenbot",
        name = content.plural_text("Pathfinder schematics", "Pathfinder schematics"),
        description = content.text("Bearing the logo of Wraitheon, those are assembly plans, design specs, and technical drawings for the Pathfinder.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "schematics_tankbot",
        name = content.plural_text("Regulator schematics", "Regulator schematics"),
        description = content.text("Bearing the logo of Wraitheon, those are assembly plans, design specs, and technical drawings for the Regulator.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "schematics_tripod",
        name = content.plural_text("tripod schematics", "tripod schematics"),
        description = content.text("Bearing the logo of Honda, those are assembly plans, design specs, and technical drawings for the tripod.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "recipe_augs",
        name = content.plural_text("Augmentative Tech Review", "issues of Augmentative Tech Review"),
        description = content.text("This annual publication covers the various ways in which people use technology to improve their bodies.  There are a few in-depth and thoroughly illustrated articles on prosthetics, though they tend to use too much jargon."),
        mass_milligrams = 400000,
        volume_ml = 500,
        symbol = "?",
        color = "pink",
        copy_from = "recipe_augs",
        looks_like = "recipe_augs",
    }
    content.replace(book)
end
