local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "manual_aikido",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Spirit of Aikido", "copies of The Spirit of Aikido"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Aikido."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_aikido",
    }
    content.add(book)
end

do
    -- Don't translate name, this book is in archaic Spanish with translations in the margins.
    -- Spanish description should change to say that this is archaic text and should mention explanations of archaic words instead of translations.
    local book = content.Item {
        id = "manual_barbaran",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Las Nueve Reglas de la Montante", "copies of Las Nueve Reglas de la Montante"),
        price_cents = 11000,
        price_postapoc_cents = 3000,
        description = ccb.content.text("Thankfully, someone has scrawled translations in the margins of this guide to Barbaran Montante.  Judging by the notation, this greatsword and war hammer training manual is also a form of poem."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_barbaran",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_boxing",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Practical Pugilism", "copies of Practical Pugilism"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to boxing.  Let's get ready to rough-up some ruffians!"),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_boxing",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_capoeira",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Capoeira 100", "copies of Capoeira 100"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Capoeira."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_capoeira",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_crane",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Red Crane", "copies of The Red Crane"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Crane Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_crane",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_dragon",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Jade Dragon", "copies of The Jade Dragon"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Dragon Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_dragon",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_eskrima",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Practical Eskrima", "copies of Practical Eskrima"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to Eskrima."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_eskrima",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_fencing",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Modern Swordsman", "copies of The Modern Swordsman"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to Fencing."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_fencing",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_judo",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Kodokan Judo", "copies of Kodokan Judo"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Judo."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_judo",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_karate",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Shōtōkan Karate Handbook", "copies of The Shōtōkan Karate Handbook"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Shōtōkan Karate."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_karate",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_bojutsu",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Bōjutsu The Matsumoto System", "copies of Bōjutsu The Matsumoto System"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Bōjutsu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_bojutsu",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_kickboxing",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Ultimate Guide to Kickboxing", "copies of Ultimate Guide to Kickboxing"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("The ultimate guide to learning and mastering kickboxing, from beginner to black belt."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_kickboxing",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_krav_maga",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Complete Krav Maga", "copies of Complete Krav Maga"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Krav Maga."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_krav_maga",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_leopard",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Deaf Leopard", "copies of The Deaf Leopard"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Leopard Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_leopard",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_muay_thai",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Ultimate Muay Thai", "copies of Ultimate Muay Thai"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Muay Thai."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_muay_thai",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_ninjutsu",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Essence of Ninjutsu", "copies of Essence of Ninjutsu"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to Ninjutsu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_ninjutsu",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_niten",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Book of Five Rings", "copies of The Book of Five Rings"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A primer on Miyamoto Musashi's style of combat and philosophy, Niten Ichi-Ryu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_niten",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_pankration",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Modern Pankratiast", "copies of The Modern Pankratiast"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Pankration."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_pankration",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_silat",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Indonesian Warrior", "copies of The Indonesian Warrior"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to Pencak Silat."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_silat",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_snake",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Black Snake", "copies of The Black Snake"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Snake Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_snake",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_taekwondo",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Official Taekwondo Training Manual", "copies of Official Taekwondo Training Manual"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Taekwondo."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_taekwondo",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_tai_chi",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Becoming One with the Tao", "copies of Becoming One with the Tao"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Tai Chi Chuan."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_tai_chi",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_tiger",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The White Tiger", "copies of The White Tiger"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Tiger Kung Fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_tiger",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_zui_quan",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Zui Quan and You", "copies of Zui Quan and You"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Zui Quan."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_zui_quan",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_sojutsu",
        copy_from = "book_martial",
        name = ccb.content.plural_text("The Way of the Spear", "copies of The Way of the Spear"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to Sōjutsu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_sojutsu",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_wingchun",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Wing Chun Compendium", "copies of Wing Chun Compendium"),
        price_postapoc_cents = 2000,
        description = ccb.content.text("A complete guide to Wing Chun Kung-fu."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_wingchun",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_medievalpole",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Fior Di Battaglia", "copies of Fior Di Battaglia", "book"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A completely translated medieval guide teaching various techniques with polearms.  There is a chapter about the many variations of common polearms… there are even pictures!"),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_medievalpole",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_swordsmanship",
        copy_from = "book_martial",
        name = ccb.content.plural_text("Historic European Swordfighting", "copies of Historic European Swordfighting"),
        price_postapoc_cents = 3000,
        description = ccb.content.text("A complete guide to medieval swordsmanship.  Compares the German and Italian traditions for a multitude of swords, in and out of armor, with and without shield."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "style_swordsmanship",
    }
    content.add(book)
end
