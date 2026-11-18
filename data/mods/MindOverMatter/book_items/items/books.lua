local content = require("ccb").content

do
    local book = content.Item {
        id = "manual_psionics_advan",
        category = "manuals",
        name = content.plural_text("Lab Journal-Otomo", "copies of Lab Journal-Otomo"),
        description = content.text("This notebook is mostly a series of fanciful speculations about something the author alternately calls \"Matrix Mechanics,\", \"Dimensional Metaphysics,\" or \"Netherium Mathematics,\" sometimes using more than one in the same sentence.  Most of it is incoherent, but there is some experimental data about \"Conscious redirection of nether energy\" that catches your eye."),
        copy_from = "recipe_lab_cvd",
        looks_like = "recipe_lab_cvd",
    }
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 12,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_report_psionic_drain",
        category = "manuals",
        name = content.plural_text("Report: Channeling Protocol PGS38", "copies of Report: Channeling Protocol PGS38"),
        description = content.text("A formal report on a process to reduce the unpredictable effects of long-term psionic use.  It describes a special meditation technique, performed with the aid of a matrix crystal, though it does warn that the process: \"puts extreme stress on the focus object.  Further refinement is required.\""),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_psionic_ritual",
        category = "manuals",
        name = content.plural_text("Training Manual: Method of Loci and Dimensional Metaphysics", "copies of Training Manual: Method of Loci and Dimensional Metaphysics"),
        description = content.text("A formal report on a series of training procedures to allow the practitioner to hold images and ideas in their head for long periods of time without being distracted or losing their train of thought.  The report concludes, \"While the human mind is not adept at holding static images or scenes in place, some minor variation can be allowed for without suffering any adverse effects from the flow of Netherum energy.  Method of Loci allows the mathematician to maintain their thoughts within this area of variation while still exerting effective control over the mathematics.\""),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 4,
        maximum_level = 4,
        intelligence = 12,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_psionic_martial_power_book",
        category = "manuals",
        name = content.plural_text("Training Manual: VERDANT HAND Combat Protocols", "copies of Training Manual: VERDANT HAND Combat Protocols"),
        description = content.text("A formal report with a mostly-blank cover page, stamped with the Project PHAVIAN logo at the top and a red \"VERDANT HAND - EYES ONLY\" centered underneath.  Contrary to your initial assumption, it is not a martial arts training manual.  Instead, it describes a series of meditations and visualization exercises designed to \"increase the subject's unarmed combat prowess fivefold\".  There are several charts showing the results of a VERDANT HAND combatant against training opponents armed with weapons or firearms at various engagement distances.  It's clearly still not as good as just having a rifle, but the data look pretty promising if you can get these exercises down."),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 8,
        read_time_turns = 720,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "unarmed",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_psionic_control_mutations_book",
        category = "manuals",
        name = content.plural_text("Progress Report: EMERALD VANGUARD", "copies of Progress Report: EMERALD VANGUARD"),
        description = content.text("A formal report with a mostly-blank cover page, stamped with the Project PHAVIAN logo at the top and a red \"EMERALD VANGUARD - EYES ONLY\" centered underneath.  Skimming through it, it seems to be a report of a series of tests involving mixing \"PE050\" and \"BURNT NOVEMBER\" together.  Near the end of the report is a series of \"noetic exercises\" designed to allow the \"mathematician\" to exert conscious control over \"the progressive changes made by exposure to XE037\". There's a lot of jargon in here but the instructions seem like you might be able to puzzle them out."),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 12,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_psionic_teleportation_combat_book",
        category = "manuals",
        name = content.plural_text("Proposal: TURQUOISE KEYSTONE", "copies of Proposal: TURQUOISE KEYSTONE"),
        description = content.text("A formal report with a mostly-blank cover page, stamped with the Project PHAVIAN logo at the top and a red \"TURQUOISE KEYSTONE - EYES ONLY\" centered underneath.  Skimming through it, you see a lot of very worrying phrases in light of recent events, like \"…the sudden but so-far unexplained increase in our mathematicians' prowess…\" or \"…E71 is now capable of passing through two meters of solid matter.\"  The main topic of the document seems to be using teleportation (\"LOST RAIN\", as the report calls it) in combat.  By lengthening the space between the teleporter and their target to build up momentum on their strikes, warping space to make near-misses turn into hits, or teleporting fractions of a meter to avoid incoming attacks or put themselves in a better position to make strikes, the TURQUOISE KEYSTONE practitioner can vastly increase their prowess in close-quarters combat.  Written at the bottom of the last page is, \"We had better test this soon--I think we're going to need it.\""),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 12,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phavian_psionic_telepathic_mental_engineering_book",
        category = "manuals",
        name = content.plural_text("Lab Report: PATIENT MOSAIC process", "copies of Lab Report: PATIENT MOSAIC process"),
        description = content.text("A thick lab report with a mostly-blank cover page, stamped with the Project PHAVIAN logo at the top and a red \"PATIENT MOSAIC - EYES ONLY\" centered underneath.  According to the summary, the report details how a powerful GRAY DAWN participant may use a specifically attuned focusing tool to allow themselves to induce permanent changes in their personality and other segments of their brain.  The report details little success in GRAY DAWN participant applying this process to others."),
        copy_from = "recipe_lab_elec",
        looks_like = "recipe_lab_elec",
    }
    book:book {
        required_level = 8,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 720,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_meditation",
        category = "manuals",
        name = content.plural_text("Meditation and You", "copies of Meditation and You"),
        description = content.text("A description of simple meditation and breathing techniques, intended for a beginner."),
        mass_milligrams = 1454000,
        volume_ml = 1250,
        price_cents = 2500,
        price_postapoc_cents = 150,
        symbol = "?",
        looks_like = "book_nonf_hard_psych_moodalm",
        color = "white",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 3)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    book:variants {
        {
            id = "manual_meditation_1",
            name = content.plural_text("Zen Mind, Beginner's Mind", "copies of Zen Mind, Beginner's Mind"),
            description = content.text("This is a transcription of lectures given by Suzuki Shunryū, a Buddhist monk who founded the first Zen Buddhist monastery in the United States, containing discussion about Zen meditation and practice."),
            weight = 1,
        },
        {
            id = "manual_meditation_2",
            name = content.plural_text("How to Meditate: A Practical Guide to Making Friends with Your Mind", "copies of How to Meditate: A Practical Guide to Making Friends with Your Mind"),
            description = content.text("A book on meditation written for a general audience, containing simple techniques on breathing and mindfulness."),
            weight = 1,
        },
        {
            id = "manual_meditation_3",
            name = content.plural_text("The Wandering Mind: What Medieval Monks Tell Us about Distraction", "copies of The Wandering Mind: What Medieval Monks Tell Us about Distraction"),
            description = content.text("A history of monastic attempts at finding calm and peace in the midst of a profane world.  There are far fewer daily distractions now than pre-Cataclysm but there's still some useful techniques you could gain here."),
            weight = 1,
        },
        {
            id = "manual_meditation_4",
            name = content.plural_text("The Miracle of Mindfulness: An Introduction to the Practice of Meditation", "copies of The Miracle of Mindfulness: An Introduction to the Practice of Meditation"),
            description = content.text("A translation of a letter written by Thich Nhat Hanh to colleagues in Viet Nam, this book focuses on mindfulness and breathwork."),
            weight = 1,
        },
    }
    content.add(book)
end

do
    -- Advanced meditation is controversial but I have to make the distinction somewhere.
    local book = content.Item {
        id = "manual_meditation_int",
        category = "manuals",
        name = content.plural_text("Secrets of the Zen Masters", "copies of Secrets of the Zen Masters"),
        description = content.text("This book purports to contain hidden tips that will make you serene and calm in the face of the most grievous calamities.  Cataclysms, one might say."),
        copy_from = "manual_meditation",
        looks_like = "manual_meditation",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 9,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "metaphysics",
    }
    book:variants {
        {
            id = "manual_meditation_int_1",
            name = content.plural_text("The Mind Illuminated: A Complete Meditation Guide Integrating Buddhist Wisdom and Brain Science for Greater Mindfulness", "copies of The Mind Illuminated: A Complete Meditation Guide Integrating Buddhist Wisdom and Brain Science for Greater Mindfulness"),
            description = content.text("Written by a neuroscientist and meditator practitioner, this book offers a ten-step meditation program that combines science with traditional meditation techniques."),
            weight = 1,
        },
        {
            id = "manual_meditation_int_2",
            name = content.plural_text("Mastering the Core Teachings of the Buddha: An Unusually Hardcore Dharma Book", "copies of Mastering the Core Teachings of the Buddha: An Unusually Hardcore Dharma Book"),
            description = content.text("This book argues that meditation is not an eternal progression but can be mastered just like any other skill, and it will tell you how to do it."),
            weight = 1,
        },
        {
            id = "manual_meditation_int_3",
            name = content.plural_text("Not Always So: Practicing the True Spirit of Zen", "copies of Not Always So: Practicing the True Spirit of Zen"),
            description = content.text("A continuation of the lessons expounded on in \"Zen Mind, Beginner's Mind\", this book contains a myriad of parables and koans to help the student grasp the nature of meditation."),
            weight = 1,
        },
    }
    content.add(book)
end
