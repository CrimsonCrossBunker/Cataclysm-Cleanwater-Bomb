local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "emergency_book",
        category = "manuals",
        name = ccb.content.plural_text("Guide to Advanced Emergency Care", "copies of Guide to Advanced Emergency Care"),
        description = ccb.content.text("A thick textbook for paramedics describing advanced lifesaving procedures and field-expedient care methods."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 9200,
        price_postapoc_cents = 1500,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_wound_care_expert", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_firstaid",
        category = "manuals",
        name = ccb.content.plural_text("Paramedics", "issues of Paramedics"),
        description = ccb.content.text("An educational magazine for EMTs."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 6,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_wound_care", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "pocket_firstaid",
        category = "manuals",
        name = ccb.content.plural_text("Pocket Guide to First Aid", "copies of Pocket Guide to First Aid"),
        description = ccb.content.text("This pocket-sized leather-bound guide to first aid combines a wealth of concise information with simple to follow instructions and easy to read illustrations."),
        mass_milligrams = 192000,
        volume_ml = 250,
        price_cents = 4000,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_wound_care", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    -- College-level textbooks are Cheap at $60.  Med book is likely more expensive.
    local book = content.Item {
        id = "textbook_firstaid",
        category = "manuals",
        name = ccb.content.plural_text("First Responder Handbook", "copies of First Responder Handbook"),
        description = ccb.content.text("A hardbound book detailing advanced first aid techniques and field-expedient medical care."),
        mass_milligrams = 1360000,
        volume_ml = 2000,
        price_cents = 8500,
        price_postapoc_cents = 1250,
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
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_wound_care_expert", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "booklet_firstaid",
        category = "manuals",
        name = ccb.content.plural_text("First Aid Kit Instruction Booklet", "copies of First Aid Kit Instruction Booklet"),
        description = ccb.content.text("Illustrated how-to guide for your first aid kit."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "pocket_firstaid",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 0,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "reference_firstaid1",
        category = "manuals",
        name = ccb.content.plural_text("Physicians' Desk Reference", "copies of Physicians' Desk Reference"),
        description = ccb.content.text("This hefty volume contains all the legally mandated information relevant to physicians for writing prescriptions, generously supported by the efforts and contributions of major pharmaceutical companies.  For the most part, it provides information identical to what is available on that of medication packaging inserts, and cannot match the completeness of digital pharmaceutical references like MediSoft.  At least it doesn't need power to be used."),
        mass_milligrams = 2268000,
        volume_ml = 2500,
        price_cents = 10000,
        price_postapoc_cents = 2250,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
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
        id = "reference_firstaid2",
        category = "manuals",
        name = ccb.content.plural_text("Merck Veterinary Manual", "copies of Merck Veterinary Manual"),
        description = ccb.content.text("This expansive text covers 'all domestic species and diseases in veterinary medicine worldwide'.  Should you need information regarding zoonotic diseases, off-label use of medication for animals, common dysfunctions and diseases of animals, or any other veterinary reference info, this is your book.  There are some interesting new chapters on animal cloning in this edition."),
        mass_milligrams = 1634000,
        volume_ml = 2160,
        price_cents = 8000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_toxicology",
        category = "manuals",
        name = ccb.content.plural_text("Textbook of Advanced Toxicology", "copies of Textbook of Advanced Toxicology"),
        description = ccb.content.text("This unassuming volume details the broad spectrum of chemical and biological toxins known to modern medicine.  While the obvious focus of the book is the therapy of such poisonings, there are lengthy sections describing the structure and synthesis of some compounds of interest."),
        mass_milligrams = 3000000,
        volume_ml = 3000,
        price_cents = 30000,
        price_postapoc_cents = 5000,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 5,
        maximum_level = 6,
        intelligence = 11,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_forensic_reports",
        category = "manuals",
        name = ccb.content.plural_text("Forensic Autopsy Reports", "copies of Forensic Autopsy Reports"),
        description = ccb.content.text("A thick stack of binders holding police autopsy and casework records.  It is packed with specialized jargon, extremely long Latin words, and photographs of human dissection procedures that are horrifying or outright nauseating.  To a layperson it might as well be text from hell; even to a professional it is boring."),
        mass_milligrams = 2300000,
        volume_ml = 3000,
        price_cents = 12000,
        price_postapoc_cents = 2500,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 6)
    book:book {
        required_level = 6,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 2700,
        fun = -4,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_dissect_humans", time_factor = 0.75, fail_factor = 0.5, cap = 0.5 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_first_aid",
        category = "manuals",
        name = ccb.content.plural_text("The Big Book of First Aid", "copies of The Big Book of First Aid"),
        description = ccb.content.text("It's big and heavy, but full of great information about first aid."),
        mass_milligrams = 454000,
        volume_ml = 1250,
        price_cents = 2500,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "green",
        variant_kind = "generic",
        ascii_picture = "manual_first_aid",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "firstaid",
        proficiencies = {
            { id = "prof_wound_care", time_factor = 0.75, fail_factor = 0.5 },
            { id = "prof_wound_care_expert", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    content.add(book)
end
