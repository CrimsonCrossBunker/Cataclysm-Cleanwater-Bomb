local content = require("ccb").content

do
    local book = content.Item {
        id = "recipe_alpha",
        category = "manuals",
        name = content.plural_text("PE050 \"Alpha\": Preliminary Report", "copies of PE050 \"Alpha\": Preliminary Report"),
        description = content.text("This sheaf of papers--dated two weeks before all this started--describes some new chemical formula, and its effects on human subjects.  It's stamped \"APPROVED\"…"),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_animal",
        category = "manuals",
        name = content.plural_text("lab journal-Dionne", "lab journals-Dionne"),
        description = content.text("This team logbook details several varieties of mutagenic experiments, focusing on those derived from various Earth fauna.  The team seems quite enthusiastic--if not eager--about their results."),
        mass_milligrams = 500000,
        volume_ml = 600,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_chimera",
        category = "manuals",
        name = content.plural_text("PE065 \"Chimera\": Best Practices", "copies of PE065 \"Chimera\": Best Practices"),
        description = content.text("This sheaf of papers describes a new chemical formula in detail and supplies instructions for its use as some sort of… crowd-control catalyst?  That can't be right…"),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_creepy",
        category = "manuals",
        name = content.plural_text("lab journal-Smythe", "lab journals-Smythe"),
        description = content.text("This team logbook details several varieties of mutagenic experiments, focusing on those derived from flesh contaminated with XE037.  The results look promising but the procurement methods seem awfully vague…"),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -4,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_labchem",
        category = "manuals",
        name = content.plural_text("chemical reference-CLASSIFIED", "chemical references-CLASSIFIED"),
        description = content.text("This somewhat technical binder has several intimidating security warnings on the cover, yet guarantees unauthorized readers \"permanent employment, for life\".  It contains useful information on \"basic\" chemical projects like methamphetamine and heroin, along with briefing on things called \"XE037\" and \"PE012\"."),
        mass_milligrams = 2000000,
        volume_ml = 2000,
        price_cents = 64000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 12,
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
        id = "recipe_maiar",
        category = "manuals",
        name = content.plural_text("lab journal-x-|xp", "lab journals-x-|xp"),
        description = content.text("This damaged team logbook lacks (deliberately?) any identifying information, but still contains useful information on several types of mutagen and their development."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_medicalmut",
        category = "manuals",
        name = content.plural_text("PE023 \"Medical\": Application and Findings", "copies of PE023 \"Medical\": Application and Findings"),
        description = content.text("This binder of highly technical papers describes some new chemical formula, and its effects on human subjects.  It's stamped \"APPROVED\"…"),
        mass_milligrams = 1450000,
        volume_ml = 1750,
        price_cents = 62000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 6,
        maximum_level = 7,
        intelligence = 13,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_serum",
        category = "manuals",
        name = content.plural_text("Best Practices for Compound Delivery", "copies of Best Practices for Compound Delivery"),
        description = content.text("This internal manual details several varieties of mutagenic experiments, as well as describing the protocols used to concentrate mutagens for quicker results.  The authors recommend that researchers ensure that their subjects are well-fed and in good health, as the concentrated serums draw heavily on subjects' bodies."),
        mass_milligrams = 500000,
        volume_ml = 600,
        price_cents = 50000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 6,
        maximum_level = 8,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -4,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "reference_cooking",
        category = "manuals",
        name = content.plural_text("CRC-Merck Handbook, 4th edition", "copies of CRC-Merck Handbook, 4th edition"),
        description = content.text("This huge hardbound book is a collection of reference data and formulae pertinent to many technical disciplines.  If poring over tables of chemical and physical data is your thing, this is the book for you."),
        mass_milligrams = 5790000,
        volume_ml = 1750,
        price_cents = 9000,
        price_postapoc_cents = 2000,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "light_green",
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
        id = "textbook_gaswarfare",
        category = "manuals",
        name = content.plural_text("Art and Science of Chemical Warfare", "copies of Art and Science of Chemical Warfare"),
        description = content.text("This in-depth and technical text covers the design, development, dissemination of, and defenses against various chemical weapons throughout the centuries.  The photographs the author chose make it a difficult read at times, though the information is top-notch."),
        mass_milligrams = 854000,
        volume_ml = 1500,
        price_cents = 400,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 9,
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
        id = "adv_chemistry",
        category = "manuals",
        name = content.plural_text("Advanced Physical Chemistry", "copies of Advanced Physical Chemistry"),
        description = content.text("A university-level textbook on advanced principles of physical chemistry and all its branches: thermochemistry, electrochemistry, solid-state chemistry, photochemistry, quantum chemistry et cetera."),
        mass_milligrams = 1712000,
        volume_ml = 2000,
        price_cents = 7950,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 5,
        maximum_level = 7,
        intelligence = 12,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
        proficiencies = {
            { id = "prof_intro_chemistry", time_factor = 0.6, fail_factor = 0.25 },
        },
    }
    book:variants {
        {
            id = "adv_chemistry",
            name = content.plural_text("Advanced Physical Chemistry", "copies of Advanced Physical Chemistry"),
            description = content.text("A university-level textbook on advanced principles of physical chemistry and all its branches: thermochemistry, electrochemistry, solid-state chemistry, photochemistry, quantum chemistry et cetera."),
        },
        -- 978-0136056065
        {
            id = "adv_chemistry_1",
            name = content.plural_text("Physical Chemistry: Principles and Applications", "copies of Physical Chemistry: Principles and Applications"),
            description = content.text("Fifth Edition of a best-selling book about using physical chemistry in various branches, with real examples."),
        },
        -- 978-8184959888
        {
            id = "adv_chemistry_2",
            name = content.plural_text("Physical Chemistry: A Molecular Approach", "copies of Physical Chemistry: A Molecular Approach"),
            description = content.text("A textbook that covers more specialized topics in physical chemistry, including quantum chemistry, statistical mechanics, and surface science."),
        },
        {
            id = "adv_chemistry_3",
            name = content.plural_text("Physical Chemistry: From Quantum Mechanics to Statistical Thermodynamics", "copies of Physical Chemistry: From Quantum Mechanics to Statistical Thermodynamics"),
            description = content.text("This book provides a comprehensive introduction to the principles of physical chemistry, covering topics such as quantum mechanics, thermodynamics, and statistical mechanics."),
        },
        {
            id = "adv_chemistry_4",
            name = content.plural_text("Physical Chemistry for Scientists and Engineers", "copies of Physical Chemistry for Scientists and Engineers"),
            description = content.text("This book is designed for students in engineering and the physical sciences who are interested in applying physical chemistry concepts to real-world problems.  It covers topics such as thermodynamics, statistical mechanics, and transport phenomena, and includes examples and problems drawn from engineering and scientific applications."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "modern_tanner",
        category = "manuals",
        name = content.plural_text("The Modern Tanner", "copies of The Modern Tanner"),
        description = content.text("An in-depth and easy to read guide that details a very modern take on the ancient art of leather tanning."),
        mass_milligrams = 568000,
        volume_ml = 750,
        price_cents = 2000,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "brown",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
        proficiencies = {
            { id = "prof_leatherworking_basic", time_factor = 0.6, fail_factor = 0.25 },
        },
    }
    book:variants {
        {
            id = "modern_tanner",
            name = content.plural_text("The Modern Tanner", "copies of The Modern Tanner"),
            description = content.text("An in-depth and easy to read guide that details a very modern take on the ancient art of leather tanning."),
        },
        -- 978-0764360398
        {
            id = "modern_tanner_1",
            name = content.plural_text("Leathercraft: Traditional Handcrafted Leatherwork Skills and Projects", "copies of Leathercraft: Traditional Handcrafted Leatherwork Skills and Projects"),
            description = content.text("A guide by Nigel Armitage offering traditional leatherworking techniques with modern applications, creating durable goods able to last generations."),
        },
        -- 978-1844034741
        {
            id = "modern_tanner_2",
            name = content.plural_text("Leatherworking Handbook", "copies of Leatherworking Handbook"),
            description = content.text("A leatherworking book for amateurs by a top professional, with some key techniques and various projects."),
        },
        -- 978-3337106478
        {
            id = "modern_tanner_3",
            name = content.plural_text("The Leather Manufacture in the United States", "copies of The Leather Manufacture in the United States"),
            description = content.text("This vintage book contains a detailed treatise on the leather industry in late-nineteenth century America, being a dissertation on the methods employed in and the economics of tanning."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_elfa",
        category = "manuals",
        name = content.plural_text("standpipe maintenance log", "standpipe maintenance logs"),
        description = content.text("This binder details the scheduled maintenance for several plumbing systems throughout the facility.  However, some of the log sheets seem to be filled with… a chemical formula?"),
        mass_milligrams = 400000,
        volume_ml = 750,
        price_cents = 400,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 7,
        maximum_level = 0,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "recipe_raptor",
        category = "manuals",
        name = content.plural_text("PE070 \"Raptor\": Proposal", "copies of PE070 \"Raptor\": Proposal"),
        description = content.text("This sheaf of papers is a highly speculative proposal for focusing \"PE065\".  Scribbled notes throughout seem to think that it might work, but that there's no time."),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 125000,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 8,
        maximum_level = 0,
        intelligence = 13,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_chemistry",
        category = "manuals",
        name = content.plural_text("chemistry textbook", "copies of chemistry textbook"),
        description = content.text("A college textbook on chemistry."),
        mass_milligrams = 1587000,
        volume_ml = 2000,
        price_cents = 7950,
        price_postapoc_cents = 1000,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
        variant_kind = "generic",
        ascii_picture = "textbook_chemistry",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    book:variants {
        {
            id = "textbook_chemistry",
            name = content.plural_text("chemistry textbook", "copies of chemistry textbook"),
            description = content.text("A college textbook on chemistry."),
        },
        -- 978-1119591146
        {
            id = "textbook_chemistry_1",
            name = content.plural_text("Chemistry Essentials For Dummies", "copies of Chemistry Essentials For Dummies"),
            description = content.text("Invaluable quick reference guide to the fundamentals of chemistry for students."),
        },
        -- 978-0486656229
        {
            id = "textbook_chemistry_2",
            name = content.plural_text("General Chemistry", "copies of General Chemistry"),
            description = content.text("The revised third edition of a classic first-year text by Nobel laureate.  Covers atomic and molecular structure, quantum mechanics, statistical mechanics, and thermodynamics correlated with descriptive chemistry problems."),
        },
        -- 978-0554023557
        {
            id = "textbook_chemistry_3",
            name = content.plural_text("Modern Chemistry: Student Edition", "copies of Modern Chemistry: Student Edition"),
            description = content.text("A giant, almost 1000 page book that covers anything a student may want (and may not want) to know about chemistry, from foundations to an intermediate level."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_extraction",
        category = "manuals",
        name = content.plural_text("The Essential Oil Enthusiasts Handbook", "copies of The Essential Oil Enthusiasts Handbook"),
        description = content.text("A heavy hardback book explaining the process of essential oil making, with schematics for the equipment to do it.  Good luck, and don't blow yourself up!"),
        looks_like = "textbook_chemistry",
        mass_milligrams = 1420000,
        volume_ml = 1000,
        price_cents = 6000,
        price_postapoc_cents = 1000,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 3600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    book:variants {
        {
            id = "textbook_extraction",
            name = content.plural_text("The Essential Oil Enthusiasts Handbook", "copies of The Essential Oil Enthusiasts Handbook"),
            description = content.text("A heavy hardback book explaining the process of essential oil making, with schematics for the equipment to do it.  Good luck, and don't blow yourself up!"),
        },
        -- 978-0815370963
        {
            id = "textbook_extraction_1",
            name = content.plural_text("Handbook of Essential Oils: Science, Technology, and Applications", "copies of Handbook of Essential Oils: Science, Technology, and Applications"),
            description = content.text("This book presents the development, use and marketing of essential oils, with a wide range of topics, sources, as well as production and analysis techniques."),
        },
        {
            id = "textbook_extraction_2",
            name = content.plural_text("Essential Oil Distillation", "copies of Essential Oil Distillation"),
            description = content.text("This book provides a detailed guide to the process of distilling essential oils, including information on equipment and processes for extracting them from plant materials.  It also includes tips for selecting and storing essential oils, as well as using the byproducts of manufacturing."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "basic_chemistry",
        category = "manuals",
        name = content.plural_text("Chemistry for Kids: Awesome Science Experiments that Really Work", "copies of Chemistry for Kids: Awesome Science Experiments that Really Work"),
        description = content.text("A book with comprehensive and accurate step-by-step illustrated instructions for many scientific experiments, for young researchers and anyone else who wants to delve into the amazing world of chemistry."),
        mass_milligrams = 362000,
        volume_ml = 500,
        price_cents = 550,
        price_postapoc_cents = 1900,
        symbol = "?",
        looks_like = "recipe_alpha",
        color = "light_cyan",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
        proficiencies = {
            { id = "prof_intro_chemistry", time_factor = 0.6, fail_factor = 0.25 },
        },
    }
    book:variants {
        {
            id = "basic_chemistry",
            name = content.plural_text("Chemistry for Kids: Awesome Science Experiments that Really Work", "copies of Chemistry for Kids: Awesome Science Experiments that Really Work"),
            description = content.text("A book with comprehensive and accurate step-by-step illustrated instructions for many scientific experiments, for young researchers and anyone else who wants to delve into the amazing world of chemistry."),
        },
        -- 978-0241515549
        {
            id = "basic_chemistry_1",
            name = content.plural_text("The Chemistry Book: Big Ideas Simply Explained", "copies of The Chemistry Book: Big Ideas Simply Explained"),
            description = content.text("Short, pithy explanations of some of the most historic moments in science, from the birth of alchemy to modern chemistry state.  Simple graphics, such as flowcharts and mind maps, support the text and make the explanation of key concepts easy to follow."),
        },
        -- 978-0134138046
        {
            id = "basic_chemistry_2",
            name = content.plural_text("Basic Chemistry", "copies of Basic Chemistry"),
            description = content.text("The fifth edition of a textbook to help students master math and problem solving they will use in their future chemistry classes."),
        },
        -- 978-1439813379
        {
            id = "basic_chemistry_3",
            name = content.plural_text("Basic Chemistry Concepts and Exercises", "copies of Basic Chemistry Concepts and Exercises"),
            description = content.text("This book communicates the fundamentals of chemistry in a practical, down-to-earth manner, with simple language and detailed images."),
        },
        -- 978-1523504251
        {
            id = "basic_chemistry_4",
            name = content.plural_text("Everything You Need to Ace Chemistry in One Big Fat Notebook", "copies of Everything You Need to Ace Chemistry in One Big Fat Notebook"),
            description = content.text("This book provides plenty of info about high school-level chemistry, with lot of additional tables and formulas, though lacking many additional pictures."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "catalytic_cracking_handbook",
        category = "manuals",
        name = content.plural_text("Catalytic Cracking at Home for Solarpunks", "copies of Catalytic Cracking at Home for Solarpunks"),
        description = content.text("A colorful textbook that proclaims to teach one how to bootstrap kerosene and diesel production from waste products.  Despite the hip title, the information contained within is highly advanced and technical."),
        mass_milligrams = 1200000,
        volume_ml = 2000,
        price_cents = 1500,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "light_cyan",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 4)
    book:book {
        required_level = 5,
        maximum_level = 7,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    book:variants {
        {
            id = "catalytic_cracking_handbook",
            name = content.plural_text("Catalytic Cracking at Home for Solarpunks", "copies of Catalytic Cracking at Home for Solarpunks"),
            description = content.text("A colorful textbook that proclaims to teach one how to bootstrap kerosene and diesel production from waste products.  Despite the hip title, the information contained within is highly advanced and technical."),
        },
        -- 978-3659713538
        {
            id = "catalytic_cracking_handbook_1",
            name = content.plural_text("Modeling and Simulation of Fluid Catalytic Cracking Riser", "copies of Modeling and Simulation of Fluid Catalytic Cracking Riser"),
            description = content.text("Describing the problems that may occur while refining oil, this book is an excellent reference and teaching material for students and researchers in chemical engineering and chemistry."),
        },
        {
            id = "catalytic_cracking_handbook_2",
            name = content.plural_text("Fluid Catalytic Cracking Handbook", "copies of Fluid Catalytic Cracking Handbook"),
            description = content.text("This handbook provides practical information and tools that engineers can use to maximize the profitability and reliability of their fluid catalytic cracking operations."),
        },
        -- 978-1523389322
        {
            id = "catalytic_cracking_handbook_3",
            name = content.plural_text("A Literature Review on Cold Cracking of Petroleum Crude Oil", "copies of A Literature Review on Cold Cracking of Petroleum Crude Oil"),
            description = content.text("This book describes cold petroleum cracking - a type of process that occurs below the freezing point, compared the common process that occurs at nearly 400 centigrade.  You can't really use this type of process without a lot of additional equipment, but the book provides plenty of information about common methods that you can do by hand."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_biodiesel",
        category = "manuals",
        name = content.plural_text("Biodiesel: Renewable Fuel Resource", "copies of Biodiesel: Renewable Fuel Resource"),
        description = content.text("A large textbook for college students about biodiesel."),
        mass_milligrams = 1200000,
        volume_ml = 2000,
        price_cents = 1500,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    book:variants {
        {
            id = "textbook_biodiesel",
            name = content.plural_text("Biodiesel: Renewable Fuel Resource", "copies of Biodiesel: Renewable Fuel Resource"),
            description = content.text("A large textbook for college students about biodiesel."),
        },
        -- 978-0784415344
        {
            id = "textbook_biodiesel_1",
            name = content.plural_text("Biodiesel Production: Technologies, Challenges, and Future Prospects", "copies of Biodiesel Production: Technologies, Challenges, and Future Prospects"),
            description = content.text("Sponsored by the American Society of Civil Engineers, this book presents approaches, technologies, and source materials for biodiesel production, as well as socioeconomic and political impacts of its applications.  You surely don't need the second part anymore."),
        },
        -- 978-1893997622
        {
            id = "textbook_biodiesel_2",
            name = content.plural_text("The Biodiesel Handbook", "copies of The Biodiesel Handbook"),
            description = content.text("A big, 500-page book that provides plenty of info about the history of different fuels, methods to apply them, and properties required for each.  It's mainly centered on biodiesel and another biofuels."),
        },
        -- 978-1846289941
        {
            id = "textbook_biodiesel_3",
            name = content.plural_text("Biodiesel: a Realistic Fuel Alternative for Diesel Engines", "copies of Biodiesel: a Realistic Fuel Alternative for Diesel Engines"),
            description = content.text("A small book offering insights into plant-based fuels, with detailed analyses of biodiesel types, and possible scenarios for their implementation.  Sadly most of the book just repeats itself, writing the same text over and over again, which makes you feel you stuck in a constant loop."),
        },
        -- 978-1845695910
        {
            id = "textbook_biodiesel_4",
            name = content.plural_text("Biodiesel Science and Technology: From Soil to Oil", "copies of Biodiesel Science and Technology: From Soil to Oil"),
            description = content.text("This book contains different techniques for producing biofuels in different scales - from home-made work in your backyard to large manufacturing - with different issues you may meet in the process, and ways to resolve them."),
        },
        -- 978-1505404630
        {
            id = "textbook_biodiesel_5",
            name = content.plural_text("Biodiesel Basics and Beyond: A Comprehensive Guide to Production and Use for the Home and Farm", "copies of Biodiesel Basics and Beyond: A Comprehensive Guide to Production and Use for the Home and Farm"),
            description = content.text("A comprehensive guide by William Kemp to produce biodiesel at small scale while avoiding common failures of fuel quality and byproduct waste management, with accuracies of data and process backed by government or university verification."),
        },
        -- 978-0323911931
        {
            id = "textbook_biodiesel_6",
            name = content.plural_text("Handbook of Biofuels Production: Process and Technologies", "copies of Handbook of Biofuels Production: Process and Technologies"),
            description = content.text("A book about different types of biofuels, issues in their production and application, and different processes and technologies that are used in their manufacturing."),
        },
        {
            id = "textbook_biodiesel_7",
            name = content.plural_text("Bean Diesel", "copies of Bean Diesel"),
            description = content.text("The original cover of this book was replaced with a white sheet of paper with a hand-made \"Bean Diesel\" label and simplified image of Vin Diesel, drawn in pen.  Excluding this, it is a pretty mundane handbook about biofuel production."),
        },
    }
    content.add(book)
end
