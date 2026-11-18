local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "black_dragons",
        category = "manuals",
        name = ccb.content.plural_text("Black Dragons: Swamp Ruins", "copies of Black Dragons: Swamp Ruins"),
        description = ccb.content.text("This book details black dragons: The most evil of dragons, who live in ruins generally in swamps.  Immune to acid and breathe acid.  The book also details how to prepare its hide and craft various armors that make use of some of its acid resistance."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "black_white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 1920,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "black_dragons_historical",
        category = "manuals",
        name = ccb.content.plural_text("A Comprehensive Analysis on Black Dragons", "copies of A Comprehensive Analysis on Black Dragons"),
        description = ccb.content.text("This book painstakingly delves into the history of black dragons, gruesomely detailing their acts, the cults that worship them, and those that oppose them.  In its pages are some alchemical formulae that can be concocted using the remains of dead black dragons."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "black_white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 8,
        maximum_level = 8,
        intelligence = 11,
        read_time_turns = 2220,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_basic",
        category = "manuals",
        name = ccb.content.plural_text("A Beginner's Guide to Alchemy", "copies of A Beginner's Guide to Alchemy"),
        description = ccb.content.text("A paperback tome for the art of liquid magic, alcohol not included."),
        mass_milligrams = 780000,
        volume_ml = 1550,
        price_cents = 7900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 9,
        read_time_turns = 1200,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "necro_basic",
        category = "manuals",
        name = ccb.content.plural_text("A Soulbinder's Guide to Necromancy", "copies of A Soulbinder's Guide to Necromancy"),
        description = ccb.content.text("A paperback tome for the art of binding undead creatures' souls to dolls, along with emulating their healing factor."),
        mass_milligrams = 425000,
        volume_ml = 450,
        price_cents = 7900,
        symbol = "?",
        color = "dark_gray",
        looks_like = "summon_undead_spellbook",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1200,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_illegal",
        category = "manuals",
        name = ccb.content.plural_text("small notebook", "small notebooks"),
        description = ccb.content.text("Small old notebook without cover.  There are some illegal potion recipes, that you can't find in common books"),
        mass_milligrams = 260000,
        volume_ml = 350,
        price_cents = 13900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 3)
    book:book {
        required_level = 5,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_master",
        category = "manuals",
        name = ccb.content.plural_text("Tabula Smaragdina", "copies of Tabula Smaragdina"),
        description = ccb.content.text("Huge, hardcover book, filled with the most detailed information about alchemy history, usage, and future, authored by Trismegistus.  Modern edition, published by Noita Press."),
        mass_milligrams = 870000,
        volume_ml = 750,
        price_cents = 17800,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 6)
    book:book {
        required_level = 6,
        maximum_level = 9,
        intelligence = 12,
        read_time_turns = 1200,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_mana_processing",
        category = "manuals",
        name = ccb.content.plural_text("Quintessential Refinement", "copies of Quintessential Refinement"),
        description = ccb.content.text("A reference manual for the process needed to turn raw mana crystals into useful crystallized mana, for those who prefer to source their mana from nature instead of the time-consuming and extremely fatiguing process of condensing the mana using thaumaturgy."),
        mass_milligrams = 425000,
        volume_ml = 450,
        price_cents = 5000,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 6)
    book:book {
        required_level = 6,
        maximum_level = 9,
        intelligence = 12,
        read_time_turns = 1200,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "techno_basic",
        category = "manuals",
        name = ccb.content.plural_text("Magitek Illustrated", "copies of Magitek Illustrated"),
        description = ccb.content.text("A paperback tome for the art of combining modern technology with magic.  There is a disclaimer on the back: `Cannith Industries bears no responsibility for malfunctions or accidents for any products mentioned herein`."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "dark_gray",
        looks_like = "manual_gun",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 9,
        read_time_turns = 1200,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_mythological",
        category = "manuals",
        name = ccb.content.plural_text("The Weapons of Asgard and Beyond", "copies of The Weapons of Asgard and Beyond"),
        description = ccb.content.text("An ornate book which appears to be written in Norse runes.  Based on the detailed illustrations, it appears to contain information about crafting numerous weapons used by various Gods."),
        mass_milligrams = 654000,
        color = "light_blue",
        symbol = "?",
        volume_ml = 1250,
        price_cents = 30000,
    }
    book:material("paper", 1)
    book:book {
        required_level = 8,
        maximum_level = 10,
        intelligence = 9,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cooking_poison",
        category = "manuals",
        name = ccb.content.plural_text("Cooking with Poison", "copies of Cooking with Poison"),
        description = ccb.content.text("A leatherbound book with an embossed cauldron on the cover.  Inside it describes ways to purify food magically."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1200,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "metal_legends",
        category = "manuals",
        name = ccb.content.plural_text("Metals of Legend", "copies of Metals of Legend"),
        description = ccb.content.text("A book with a brass coverplate.  It professes to teach one how to make magical metals such as Orichalcum.  It is dry reading even for an alchemical tome."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 9,
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
        id = "magic_armormaking",
        category = "manuals",
        name = ccb.content.plural_text("Protection from Magical Beasts", "copies of Protection from Magical Beasts"),
        description = ccb.content.text("A leatherbound book with a picture of a shield holding back dragonfire on the cover.  There are many ways to turn monster skins and hides into protective equipment inside."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 6,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 1500,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "tailor",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "enchantment_basic",
        category = "manuals",
        name = ccb.content.plural_text("The Art of Enchantment", "copies of The Art of Enchantment"),
        description = ccb.content.text("A paperback tome on the art of imbuing items with magic properties."),
        mass_milligrams = 1000000,
        volume_ml = 750,
        price_cents = 7900,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 6,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 1500,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "weapon_enchanting_guide",
        category = "manuals",
        name = ccb.content.plural_text("Guide of Enchanter", "copies of Guide of Enchanter"),
        description = ccb.content.text("A textbook on enchanting weapons."),
        mass_milligrams = 750000,
        volume_ml = 1250,
        price_cents = 9400,
        price_postapoc_cents = 4250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 3600,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "history_botanical_enchantment",
        category = "manuals",
        name = ccb.content.plural_text("A Comprehensive History of Botanical Enchantment", "copies of A Comprehensive History of Botanical Enchantment"),
        description = ccb.content.text("A history of the ancient art of \"botanical enchantment\", infusing fruit with mana to create primitive potions.  While one of the earliest methods of alchemy known, discovered in prehistoric times, advancement in alchemical techniques (to say nothing of modern chemistry) rendered it a curiosity at best in the decades leading up to the Cataclysm.  Still, the book details several methods of botanical enchantment that would probably be useful."),
        mass_milligrams = 750000,
        volume_ml = 1250,
        price_cents = 3000,
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 1500,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "arcane_archer_companion",
        category = "manuals",
        name = ccb.content.plural_text("The Arcane Archer's Companion", "copies of The Arcane Archer's Companion"),
        description = ccb.content.text("A reference book discussing the ancient and now mostly-forgot art of enchanted archery.  With firearms so convenient and taking much less training to use, it has long since fallen out of favor, but this book is so detailed you could revive it for yourself with the recipes it contains."),
        mass_milligrams = 1300000,
        volume_ml = 2500,
        price_cents = 7900,
        symbol = "?",
        color = "dark_gray",
        looks_like = "manual_gun",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 9,
        read_time_turns = 1500,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "journeyman_enchanting",
        category = "manuals",
        name = ccb.content.plural_text("The Journeyman Enchanter's Primer", "copies of The Journeyman Enchanter's Primer"),
        description = ccb.content.text("Despite the title, this seems to be written in Middle English.  A little obtuse, but you can make out most of the words well enough."),
        mass_milligrams = 600000,
        volume_ml = 850,
        price_cents = 8000,
        looks_like = "manual_gun",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 9,
        read_time_turns = 1500,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    -- All recipes related to the wildwood set should inevitably live here.
    local book = content.Item {
        id = "mag_druid_items_master",
        category = "manuals",
        name = ccb.content.plural_text("Taming the Wildwood", "copies of Taming the Wildwood"),
        description = ccb.content.text("A paperback tome on the art of growing wildwood entities."),
        mass_milligrams = 900000,
        volume_ml = 750,
        price_cents = 4200,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 1500,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "harnessing_hellfire",
        category = "manuals",
        name = ccb.content.plural_text("Harnessing Hellfire", "copies of Harnessing Hellfire"),
        description = ccb.content.text("A detailed guide on how one could use otherworldly flames for crafting everlasting light sources.  Long considered outdated, now might be time for these methods to make a comeback."),
        mass_milligrams = 160000,
        volume_ml = 700,
        price_cents = 6000,
        looks_like = "manual_gun",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 9,
        read_time_turns = 1500,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "spellcraft",
    }
    content.add(book)
end
