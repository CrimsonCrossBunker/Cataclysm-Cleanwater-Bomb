local content = require("ccb").content

do
    local book = content.Item {
        id = "SICP",
        category = "manuals",
        name = content.plural_text("SICP", "copies of SICP"),
        description = content.text("A classic text, \"The Structure and Interpretation of Computer Programs.\" Written with examples in LISP, but applicable to any language."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 7800,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 6)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 12,
        read_time_turns = 3000,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "SICP",
            name = content.plural_text("SICP", "copies of SICP"),
            description = content.text("A classic text, \"The Structure and Interpretation of Computer Programs.\" Written with examples in LISP, but applicable to any language."),
        },
        -- 978-0262046305
        {
            id = "SICP_1",
            name = content.plural_text("Introduction to Algorithms", "copies of Introduction to Algorithms"),
            description = content.text("Also known as CLRS - a letter for the last names of each author - this book contains deep explanations for a range of algorithms divided across several self-contained chapters, with pseudocode presentation."),
        },
        -- 978-0137935109
        {
            id = "SICP_2",
            name = content.plural_text("The Art of Computer Programming, Vol. 1", "copies of The Art of Computer Programming, Vol. 1"),
            description = content.text("A huge reference manual about fundamental algorithms, with a lot of examples and math."),
        },
        -- 978-0137935109
        {
            id = "SICP_3",
            name = content.plural_text("The Art of Computer Programming, Vol. 3", "copies of The Art of Computer Programming, Vol. 3"),
            description = content.text("A huge reference manual about sorting and searching algorithms, with a lot of examples and math."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "computer_science",
        category = "manuals",
        name = content.plural_text("Computer Science 301", "copies of Computer Science 301"),
        description = content.text("A college textbook on computer science."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 7900,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "computer_science",
            name = content.plural_text("Computer Science 301", "copies of Computer Science 301"),
            description = content.text("A college textbook on computer science."),
        },
        -- 978-1292263427
        {
            id = "computer_science_1",
            name = content.plural_text("Computer Science: An Overview", "copies of Computer Science: An Overview"),
            description = content.text("The 13th edition, this book gives a bottom-up, concrete-to-abstract foundation in the subject, and encourages a practical and realistic understanding of computer science."),
        },
        -- 978-0761196761
        {
            id = "computer_science_2",
            name = content.plural_text("Everything You Need to Ace Computer Science and Coding in One Big Fat Notebook", "copies of Everything You Need to Ace Computer Science and Coding in One Big Fat Notebook"),
            description = content.text("Not as big as the back cover suggests, this book still contains lots of information for the reader about key concepts, definitions, diagrams, and doodles about computer science."),
        },
        -- 978-1119724414
        {
            id = "computer_science_3",
            name = content.plural_text("The Self-Taught Computer Scientist", "copies of The Self-Taught Computer Scientist"),
            description = content.text("A nice workbook that contains information about computer science beyond the common college program, with lots of practical examples and additional tools."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "howto_computer",
        category = "manuals",
        name = content.plural_text("How to Browse the Web", "copies of How to Browse the Web"),
        description = content.text("Very beginner-level information about computers."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 1700,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 5,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "howto_computer",
            name = content.plural_text("How to Browse the Web", "copies of How to Browse the Web"),
            description = content.text("Very beginner-level information about computers."),
        },
        -- 978-0273729174
        {
            id = "howto_computer_1",
            name = content.plural_text("Computer Basics For The Over 50s", "copies of Computer Basics For The Over 50s"),
            description = content.text("A colorful book with lots of images detailing how to perform simple tasks in a computer system."),
        },
        -- 978-3844333176
        {
            id = "howto_computer_2",
            name = content.plural_text("Hand Book On Computer Basics", "copies of Hand Book On Computer Basics"),
            description = content.text("A small book that describes the very foundations of how computers and the internet work, with relevant examples."),
        },
        -- 978-1119849605
        {
            id = "howto_computer_3",
            name = content.plural_text("Computers For Seniors For Dummies", "copies of Computers For Seniors For Dummies"),
            description = content.text("A simple guide to computers that'll show you what all the fuss is about."),
        },
        -- 978-0713679175
        {
            id = "howto_computer_4",
            name = content.plural_text("Check Your English Vocabulary for Computers and Information Technology", "copies of Check Your English Vocabulary for Computers and Information Technology"),
            description = content.text("This workbook is designed to help non-native English speakers improve their knowledge and understanding of core computing and IT terminology, with definitions and some examples."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_computer",
        category = "manuals",
        name = content.plural_text("Computer World", "issues of Computer World"),
        description = content.text("An informative magazine all about computers, both hardware and software."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "mag_computer",
            name = content.plural_text("Computer World", "issues of Computer World"),
            description = content.text("An informative magazine all about computers, both hardware and software."),
        },
        {
            id = "mag_computer_1",
            name = content.plural_text("PCMag", "issues of PCMag"),
            description = content.text("An old, shabby magazine about hardware and software.  The last page says this is the last printed issue, as they are going all digital."),
        },
        {
            id = "mag_computer_2",
            name = content.plural_text("ACM Computing Reviews", "issues of ACM Computing Reviews"),
            description = content.text("A shiny scientific journal that reviews fresh literature in the computer science field."),
        },
        {
            id = "mag_computer_3",
            name = content.plural_text("IEEE Software", "issues of IEEE Software"),
            description = content.text("Journal that cover lot of aspects of software engineering, processes, and practices."),
        },
        {
            id = "mag_computer_4",
            name = content.plural_text("\"Computer\"", "issues of \"Computer\""),
            description = content.text("A practitioner-oriented magazine issued to all members of the society, containing articles and columns about different computing-related issues."),
        },
    }
    content.add(book)
end

do
    -- College-level textbooks are Cheap at $60.
    local book = content.Item {
        id = "manual_computer",
        category = "manuals",
        name = content.plural_text("Computer Science 101", "copies of Computer Science 101"),
        description = content.text("An entry-level textbook about computers."),
        mass_milligrams = 462000,
        volume_ml = 750,
        price_cents = 5500,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "manual_computer",
            name = content.plural_text("Computer Science 101", "copies of Computer Science 101"),
            description = content.text("An entry-level textbook about computers."),
        },
        -- 978-1590282755
        {
            id = "manual_computer_1",
            name = content.plural_text("An Introduction to Computer Science", "copies of An Introduction to Computer Science"),
            description = content.text("An introduction into computer world, based on simple computer language.  It guides the reader toward deep computer world."),
        },
        {
            id = "manual_computer_2",
            name = content.plural_text("Multimedia Computing", "copies of Multimedia Computing"),
            description = content.text("Printouts, held together by a staple, that explain work in different applications, multimedia, the web, and basic work with hardware."),
        },
        -- 978-1138238060
        {
            id = "manual_computer_3",
            name = content.plural_text("Teaching Computing in Secondary Schools", "copies of Teaching Computing in Secondary Schools"),
            description = content.text("A practical book for teachers about how to plan lessons and what they need to teach scholars about computer science."),
        },
        -- 978-0262539807
        {
            id = "manual_computer_4",
            name = content.plural_text("The Elements of Computing Systems", "copies of The Elements of Computing Systems"),
            description = content.text("A book that describes how computers works, how they break big tasks into smaller and simpler tasks, and teaches how you can do the same."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_computer",
        category = "manuals",
        name = content.plural_text("Principles of Advanced Programming", "copies of Principles of Advanced Programming"),
        description = content.text("A heavy textbook dedicated to advanced-level software design, written for several different programming languages."),
        mass_milligrams = 2206000,
        volume_ml = 1750,
        price_cents = 8500,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 4,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 2100,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "textbook_computer",
            name = content.plural_text("Principles of Advanced Programming", "copies of Principles of Advanced Programming"),
            description = content.text("A heavy textbook dedicated to advanced-level software design, written for several different programming languages."),
        },
        -- 978-0137314911
        {
            id = "textbook_computer_1",
            name = content.plural_text("Modern Software Engineering", "copies of Modern Software Engineering"),
            description = content.text("This book illuminates durable principles at the heart of effective software development, with historic examples and personal experience."),
        },
        -- 978-1492043454
        {
            id = "textbook_computer_2",
            name = content.plural_text("Fundamentals of Software Architecture", "copies of Fundamentals of Software Architecture"),
            description = content.text("This book examines different architecture patterns and components of good application."),
        },
        -- 978-0134667607
        {
            id = "textbook_computer_3",
            name = content.plural_text("Advanced Game Design: A Systems Approach", "copies of Advanced Game Design: A Systems Approach"),
            description = content.text("Author researches how computer games work, how they are built, and how to make proper gameplay parts and prototypes, with examples of real code."),
        },
        -- 978-0132350884
        {
            id = "textbook_computer_4",
            name = content.plural_text("Clean Code", "copies of Clean Code"),
            description = content.text("This book describes the key features of popular computer languages with features you can use to enhance your working environment and experience, as well as your code."),
        },
        -- 978-1800200920
        {
            id = "textbook_computer_5",
            name = content.plural_text("Mastering Apex Programming", "copies of Mastering Apex Programming"),
            description = content.text("This book shows the most common pitfalls inexperienced programmers may meet in their work, and different solutions one can use to resolve or avoid them."),
        },
        -- 978-1009098489
        {
            id = "textbook_computer_6",
            name = content.plural_text("Data-Driven Science and Engineering", "copies of Data-Driven Science and Engineering"),
            description = content.text("A guide for scientists and engineers describing how to use modern computer systems and methods in their work."),
        },
    }
    content.add(book)
end

do
    -- An entry-level book for younger coders that includes real coding practice.
    local book = content.Item {
        id = "webbasics_computer",
        category = "manuals",
        name = content.plural_text("Web Design Basics", "copies of Web Design Basics"),
        description = content.text("A thick glossy paperback instructional manual for aspiring web designers that includes a teaching guide for young students."),
        mass_milligrams = 907000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 1200,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "webbasics_computer",
            name = content.plural_text("Web Design Basics", "copies of Web Design Basics"),
            description = content.text("A thick glossy paperback instructional manual for aspiring web designers that includes a teaching guide for young students."),
        },
        -- 978-0763692766
        {
            id = "webbasics_computer_1",
            name = content.plural_text("Get Coding!", "copies of Get Coding!"),
            description = content.text("A comics-like manual explaining how to perform simple code tasks, targeted at kids."),
        },
        -- 979-8490556817
        {
            id = "webbasics_computer_2",
            name = content.plural_text("Computer Programming: Fundamentals for Absolute Beginners", "copies of Computer Programming: Fundamentals for Absolute Beginners"),
            description = content.text("A book that tries to teach the reader the most common programming activities - planning the work, making comfortable workarounds, designing the code schemes, and writing them in the right way."),
        },
        -- 978-0596802370
        {
            id = "webbasics_computer_3",
            name = content.plural_text("Head First Programming", "copies of Head First Programming"),
            description = content.text("This handbook describes the very basics of coding - creating and using variables, loops, decisions, objects - and examples of how and where to use them."),
        },
        -- 978-1719439558
        {
            id = "webbasics_computer_4",
            name = content.plural_text("Computer Programming for Beginners: Fundamentals", "copies of Computer Programming for Beginners: Fundamentals"),
            description = content.text("A small book that explains different skills a programmer needs to be able to code, in simple terms and with samples."),
        },
        -- 978-0794539504
        {
            id = "webbasics_computer_5",
            name = content.plural_text("Coding for Beginners", "copies of Coding for Beginners"),
            description = content.text("A beginner's guide to coding, with step-by-step instructions how to get started and write a simple program."),
        },
    }
    content.add(book)
end

do
    -- A pristine, almost untouched book about coding targeted at teenagers.
    local book = content.Item {
        id = "hackerman_computer",
        category = "manuals",
        name = content.plural_text("Pro Hacker Secrets", "copies of Pro Hacker Secrets"),
        description = content.text("A thinly veiled attempt at teaching kids coding skills.  Not nearly as exciting as the authors might have hoped, but there's some real knowledge in here."),
        mass_milligrams = 1320000,
        volume_ml = 750,
        price_cents = 4000,
        price_postapoc_cents = 100,
        symbol = "?",
        looks_like = "textbook_traps",
        color = "red",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "computer",
    }
    book:variants {
        {
            id = "hackerman_computer",
            name = content.plural_text("Pro Hacker Secrets", "copies of Pro Hacker Secrets"),
            description = content.text("A thinly veiled attempt at teaching kids coding skills.  Not nearly as exciting as the authors might have hoped, but there's some real knowledge in here."),
        },
        -- 978-1526315779
        {
            id = "hackerman_computer_1",
            name = content.plural_text("First Steps in Coding: What's Decomposition?", "copies of First Steps in Coding: What's Decomposition?"),
            description = content.text("A tiny book with childish images of a robot, that explains what functional decomposition is, and how to use it properly."),
        },
        -- 978-1913565541
        {
            id = "hackerman_computer_2",
            name = content.plural_text("Let's Get Coding", "copies of Let's Get Coding"),
            description = content.text("A shiny book with lot of useful information about using code for different tasks inside the computer.  Sadly some big chunks of information are hidden behind QR code links, which you can't open."),
        },
        -- 978-1617292231
        {
            id = "hackerman_computer_3",
            name = content.plural_text("Grokking Algorithms", "copies of Grokking Algorithms"),
            description = content.text("A fully illustrated, friendly guide describing how different algorithms are used to solve practical problems - both in real life and in programming."),
        },
        -- 978-1536205411
        {
            id = "hackerman_computer_4",
            name = content.plural_text("Get Coding 2!", "copies of Get Coding 2!"),
            description = content.text("A tiny book that describe how games are created, alongside simple projects to make your own simple games, with lot of illustrations and funny facts."),
        },
    }
    content.add(book)
end
