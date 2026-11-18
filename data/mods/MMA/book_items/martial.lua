local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "manual_mma_desert_wind",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Scorching Sirocco", "copies of Scorching Sirocco"),
        description = ccb.content.text("This book contains the teaching of the Desert Wind discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_desert_wind",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_diamond_mind",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Perfect Clarity of Mind and Body", "copies of Perfect Clarity of Mind and Body"),
        description = ccb.content.text("This book contains the teaching of the Diamond Mind discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_diamond_mind",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_hylian",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("The Book of Mudora", "copies of The Book of Mudora"),
        description = ccb.content.text("A collection of ancient Hylian lore and stories.  A section on historic battles is bookmarked."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_hylian",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_iron_heart",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Stormguard Warrior", "copies of Stormguard Warrior"),
        description = ccb.content.text("This book contains the teaching of the Iron Heart discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_iron_heart",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_panzer",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("The Life and Work of Tiger Sauer", "copies of The Life and Work of Tiger Sauer"),
        description = ccb.content.text("A biography of a combat cyborg agent detailing his philosophy and martial art."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_panzer",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_pokken",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Pocket Monster Encyclopedia", "copies of Pocket Monster Encyclopedia"),
        description = ccb.content.text("This encyclopedia contains a detailed listing of the strengths and techniques of various fictional monsters and how to apply them in a real fight."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_pokken",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_setting_sun",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Distant Horizon", "copies of Distant Horizon"),
        description = ccb.content.text("This book contains the teaching of the Setting Sun discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_setting_sun",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_shii_cho",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Jedi Holocrons: Form I", "copies of Jedi Holocrons: Form I"),
        description = ccb.content.text("This device contains the teachings of the first form of Jedi lightsaber combat: Shii-Cho."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_shii_cho",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_stone_dragon",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Shards of Granite", "copies of Shards of Granite"),
        description = ccb.content.text("This book contains the teaching of the Stone Dragon discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_stone_dragon",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_mma_tiger_claw",
        copy_from = "book_martial",
        looks_like = "manual_karate",
        name = ccb.content.plural_text("Reaping Talons", "copies of Reaping Talons"),
        description = ccb.content.text("This book contains the teaching of the Tiger Claw discipline."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_mma_tiger_claw",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_centipede",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Centipede Lu Feng", "copies of The Centipede Lu Feng"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Centipede Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_centipede",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_lizard",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Lizard Kuo Chui", "copies of The Lizard Kuo Chui"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Lizard Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_lizard",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_scorpion",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Scorpion Sun Chien", "copies of The Scorpion Sun Chien"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Scorpion Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_scorpion",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_toad",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Toad Lo Mang", "copies of The Toad Lo Mang"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Toad Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_toad",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_venom_snake",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Viper Wei Pai", "copies of The Viper Wei Pai"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Viper Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_venom_snake",
    }
    content.add(book)
end
