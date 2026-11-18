local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "schematics_matrix_channeling",
        name = ccb.content.plural_text("matrix channeling array schematics", "matrix channeling array schematics"),
        description = ccb.content.text("This is a series of technical design documents for a \"matrix channeling array\" designed to \"allow an attuned mathematician to direct a stronger level of Netherum energy\".  It sounds like nonsense, but the document does have the XEDRA seal stamped on it."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "blue",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_matrix_aligning",
        name = ccb.content.plural_text("crystalline focusing assembly schematics", "crystalline focusing assembly schematics"),
        description = ccb.content.text("This is a series of technical design documents for a focusing assembly designed to \"enhance the precision of Netherum mathematics\"."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "white",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 11,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_telepathic_focusing_tool",
        name = ccb.content.plural_text("telepathic focusing tool schematics", "telepathic focusing tool schematics"),
        description = ccb.content.text("This is a series of technical design documents for a focusing assembly designed to \"enhance the precision of Netherum mathematics\"."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "white",
    }
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_matrix_crystal_ground",
        name = ccb.content.plural_text("refined matrix crystal schematics", "refined matrix crystal schematics"),
        description = ccb.content.text("A series of technical documents for further refining ground matrix crystal, separating out the inert parts from the \"Netherically active\" parts."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "blue",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_anchoring_crown",
        name = ccb.content.plural_text("anchoring crown schematics", "anchoring crown schematics"),
        description = ccb.content.text("This is a series of technical design documents for using matrix crystals to shield the wearer from excess Netherum energies with the drawback of also shutting down any psionic ability they have while worn."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "blue",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_telepathic_dampener",
        name = ccb.content.plural_text("telepathic dampener schematics", "telepathic dampener schematics"),
        description = ccb.content.text("This is a series of technical design documents for using matrix crystals to shield the wearer's mind from telepathic assault and from unfriendly attention from Netherum entities.  The design also mentions that it reduces the wearer's own psionic power, however."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "blue",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_grenade_inferno",
        name = ccb.content.plural_text("inferno grenade schematics", "inferno grenade schematics"),
        description = ccb.content.text("This is a design document to create a grenade using matrix crystal dust that explodes in a sea of pure flame.  In pen below is the note \"EXTREMELY DANGEROUS\".  You're not sure you could replicate the exact process with the tools available to you, but you could definitely come up with your own version."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "red",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_transporters",
        name = ccb.content.plural_text("Netherum transporter schematics", "Netherum transporter schematics"),
        description = ccb.content.text("This is a series of design documents for building a transporter beacon and connected transporter remote, which you can use to teleport yourself through the Nether to the beacon.  It's labeled \"for immersion use only\", but that part has a line through it and \"IT WORKS!\" written next to it in pen.  There's another note in red that states that on very rare occasions, \"entities\" can also use the beacon to exit the Nether, and also that as of two weeks before the Cataclysm, the designers have not solved the energy surge problems that make each remote burn out after use."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "magenta",
    }
    book:book {
        required_level = 7,
        maximum_level = 7,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_everglow_lamp",
        name = ccb.content.plural_text("everglow matrix lamp schematics", "everglow matrix lamp schematics"),
        description = ccb.content.text("This is a series of design documents to use ground matrix crystals to greatly enhance the power efficiency of a lamp."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "blue",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_reactant_liquid_base",
        name = ccb.content.plural_text("psychoreactive catalyst specifications", "psychoreactive catalyst specifications"),
        description = ccb.content.text("A chemical formula for mixing ground matrix crystals with other metals and dissolving them in liquid.  There's a long list of possible applications for the resulting compound, almost all of which would have seemed like pure fantasy if you hadn't lived through the end of the world."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 12,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_instability_remover",
        name = ccb.content.plural_text("morphic reinforcement serum schematics", "morphic reinforcement serum schematics"),
        description = ccb.content.text("This document details a series of steps for making an injectable serum which will \"enhance the subject's resilience against detrimental mutagenic alterations caused by XE037 overexposure, reducing negative outcomes during testing\".  It's stamped with a XEDRA symbol in the corner with \"Project PHAVIAN\" written at the top."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "green",
    }
    book:book {
        required_level = 7,
        maximum_level = 7,
        intelligence = 10,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_psionic_purifier",
        name = ccb.content.plural_text("morphic reversion serum schematics", "morphic reversion serum schematics"),
        description = ccb.content.text("A series of steps to create a serum that will \"Eliminate the undesirable effects of XE037 overexposure\".  It is designed to be injected in the recipient."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "green",
    }
    book:book {
        required_level = 8,
        maximum_level = 8,
        intelligence = 12,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_panaceus",
        name = ccb.content.plural_text("compound XV471 schematics", "compound XV471 schematics"),
        description = ccb.content.text("This document details the chemical process necessary to create what it calls Compound XV471, which it claims is a pharmaceutical treatment for a wide variety of ills.  According to this, it acts as a near-universal antivenin, an antifungal, an antiparasitic, an antibiotic, cures several common diseases such as influenza or the common cold, improves the immune system generally, and even increases strength, agility, and overall bodily function.  You would think it was too good to be true if you hadn't seen so many other bizarre things since the Cataclysm."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "white",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_noetic_resilience",
        name = ccb.content.plural_text("noetic resilience treatment schematics", "noetic resilience treatment schematics"),
        description = ccb.content.text("A technical document outlining a treatment for \"noetic overuse\".  After the outline of the treatment is a note, dated two weeks before the end of the world, that while it showed great promise in initial trials the side effects require further study before it can be recommended for widespread usage."),
        copy_from = "schematics_generic",
        looks_like = "schematics_nursebot",
        symbol = "ç",
        color = "white",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_noetic_resonance_detector_instructions",
        name = ccb.content.plural_text("noetic resonance detector operator instructions", "noetic resonance detector operator instructions"),
        description = ccb.content.text("An extensive series of instructions on the proper calibrations and parameters for using the \"noetic resonance detector\" to determine a target's noetic potential.  There is no way you could have ever figured this out without these directions to follow."),
        copy_from = "schematics_generic",
        looks_like = "basic_chemistry",
        symbol = "ç",
        color = "white",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 12,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    content.add(book)
end
