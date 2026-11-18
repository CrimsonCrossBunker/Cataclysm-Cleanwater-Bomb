local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "advanced_electronics",
        category = "manuals",
        name = ccb.content.plural_text("Advanced Electronics", "copies of Advanced Electronics"),
        description = ccb.content.text("A college textbook on circuit design."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 8200,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "arduino_experiments",
        category = "manuals",
        name = ccb.content.plural_text("Arduino Experiments", "copies of Arduino Experiments"),
        description = ccb.content.text("A textbook-sized book of electronics and robotics experiments."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 8200,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_electronics",
        category = "manuals",
        name = ccb.content.plural_text("Ham Radio Illustrated", "issues of Ham Radio Illustrated"),
        description = ccb.content.text("An amusing magazine about ham radio, with lots of diagrams and illustrations for making your own electronic devices."),
        mass_milligrams = 45000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "?",
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
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_electronics",
        category = "manuals",
        name = ccb.content.plural_text("What's a Transistor?", "copies of What's a Transistor?"),
        description = ccb.content.text("A basic manual of electronics and circuit design."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 2200,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "ic_reference_electronics",
        category = "manuals",
        name = ccb.content.plural_text("101 Important Integrated Circuits", "copies of 101 Important Integrated Circuits"),
        description = ccb.content.text("This reference manual contains datasheets and pinout diagrams for 101 of the most popular IC chips, including the 555 timer, LM358 op-amp, and LM317 voltage regulator, along with logic chips from the 74xx family, and even the 6502 8-bit processor.  If you want to do anything useful with integrated circuits, a reference like this would be indispensable."),
        mass_milligrams = 900000,
        volume_ml = 800,
        price_cents = 2200,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "radio_book",
        category = "manuals",
        name = ccb.content.plural_text("Amateur Home Radio for Enthusiasts", "copies of Amateur Home Radio for Enthusiasts"),
        description = ccb.content.text("A book about ham radio and citizen's band radio.  It contains numerous diagrams and illustrations explaining the science behind the electronics."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 3300,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_mil_augs",
        category = "manuals",
        name = ccb.content.plural_text("2XI design binder-CLASSIFIED", "2XI design binders-CLASSIFIED"),
        description = ccb.content.text("This DoubleTech Industries binder has several intimidating security warnings on the cover.  Probably because it contains complete design specs, technical drawings, and test results for their military-grade bionic implants."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 74000,
        price_postapoc_cents = 2500,
        symbol = "?",
        looks_like = "recipe_lab_elec",
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
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_electronics",
        category = "manuals",
        name = ccb.content.plural_text("Electronic Circuit Theory", "copies of Electronic Circuit Theory"),
        description = ccb.content.text("An advanced college textbook on circuit theory, design, and organization."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 9300,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_robots",
        category = "manuals",
        name = ccb.content.plural_text("Robots for Fun & Profit", "copies of Robots for Fun & Profit"),
        description = ccb.content.text("A rare book on the design of robots, with lots of helpful step-by-step guides."),
        mass_milligrams = 2063000,
        volume_ml = 2000,
        price_cents = 9200,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 10,
        intelligence = 12,
        read_time_turns = 3300,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "robofac_yrax_trifacet_deactivation_manual",
        category = "manuals",
        name = ccb.content.plural_text("trifacet handling procedures", "trifacet handling procedures"),
        description = ccb.content.text("A heavy and disparate binder detailing the deactivation, storage and transport procedures for a so called \"Trifacet\" UGV.  The pages and schematics within have been compiled from the internal reports of a vast array of governmental agencies, many of which you had never heard of before."),
        mass_milligrams = 550000,
        volume_ml = 500,
        price_cents = 84000,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 2700,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "exodii_wiring_kit_reference",
        category = "manuals",
        name = ccb.content.plural_text("CBM interface wiring reference", "CBM interface wiring reference"),
        description = ccb.content.text("A printed technical reference for the Exodii's CBM interface wire kit using numerous alien symbols along with Anglic terminology.  Thankfully someone's hand-written a legend for those symbols and terms along the margins, but it'll still take significant electronics knowledge to decipher this document."),
        mass_milligrams = 30000,
        volume_ml = 400,
        price_postapoc_cents = 5000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_nursebot",
        name = ccb.content.plural_text("nurse bot schematics", "nurse bot schematics"),
        description = ccb.content.text("Bearing the logo of Uncanny, these are assembly plans, design specs, and technical drawings for the nurse bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_grocerybot",
        name = ccb.content.plural_text("grocery bot schematics", "grocery bot schematics"),
        description = ccb.content.text("Bearing the logo of Uncanny, these are assembly plans, design specs, and technical drawings for the grocery bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_secubot",
        name = ccb.content.plural_text("security bot schematics", "security bot schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the security bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_skitterbot",
        name = ccb.content.plural_text("skitterbot schematics", "skitterbot schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the skitterbot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_hazmatbot",
        name = ccb.content.plural_text("cleaner bot schematics", "cleaner bot schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the cleaner bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_sciencebot",
        name = ccb.content.plural_text("lab defense bot schematics", "lab defense bot schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the lab defense bot.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_dispatch",
        name = ccb.content.plural_text("dispatch schematics", "dispatch schematics"),
        description = ccb.content.text("Bearing the logo of Northrop, these are assembly plans, design specs, and technical drawings for the dispatch.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_dispatch_military",
        name = ccb.content.plural_text("military dispatch schematics", "military dispatch schematics"),
        description = ccb.content.text("Bearing the logo of Northrop, these are assembly plans, design specs, and technical drawings for the military dispatch.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_antimateriel",
        name = ccb.content.plural_text("anti-materiel turret schematics", "anti-materiel turret schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the anti-materiel turret.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_searchlight",
        name = ccb.content.plural_text("milspec searchlight schematics", "milspec searchlight schematics"),
        description = ccb.content.text("Assembly plans, design specs, and technical drawings for the milspec searchlight.  Most of this is useless to you, but you could use the assembly plans to re-assemble the robot from salvaged parts."),
        copy_from = "schematics_generic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_atomic_battery",
        category = "manuals",
        name = ccb.content.plural_text("computer printout", "computer printouts"),
        description = ccb.content.text("One side of this sheet is printed with a meaningless jumble of characters, but the other side shows a complicated, hand-drawn circuit diagram."),
        mass_milligrams = 10000,
        volume_ml = 12,
        price_cents = 40000,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 0,
        intelligence = 12,
        read_time_turns = 3600,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_augs",
        category = "manuals",
        name = ccb.content.plural_text("The Role of Robotics in Modern Day Manufacturing", "copies of The Role of Robotics in Modern Day Manufacturing"),
        description = ccb.content.text("A hefty book containing a whole bunch of technical info on industrial robotics.  While constructing these robots are no doubt outside any realm of feasibility, the information provided still has a fair bit to teach about complex electronics."),
        mass_milligrams = 1500000,
        volume_ml = 1250,
        price_cents = 3000,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "recipe_lab_elec",
        category = "manuals",
        name = ccb.content.plural_text("lab journal-Herrera", "lab journals-Herrera"),
        description = ccb.content.text("This hefty binder contains a multitude of diagrams and technical specifications for various electronic materials.  Some of the diagrams use symbols you've not seen before…"),
        mass_milligrams = 2000000,
        volume_ml = 2400,
        price_cents = 56000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "repeater_mod_guide",
        category = "manuals",
        name = ccb.content.plural_text("plans for a radio repeater mod", "plans for a radio repeater mod"),
        description = ccb.content.text("Instructions on how to create a mod for a radio station terminal which converts the entire system into a repeater."),
        mass_milligrams = 5000,
        volume_ml = 250,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 1)
    book:book {
        required_level = 2,
        maximum_level = 0,
        intelligence = 10,
        read_time_turns = 1200,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end
