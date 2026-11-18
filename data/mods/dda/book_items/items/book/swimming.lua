local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_swimming",
        category = "manuals",
        name = ccb.content.plural_text("Swim Planet", "issues of Swim Planet"),
        description = ccb.content.text("The world's leading resource about aquatic sports."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 460,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 1,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "swimming",
    }
    book:variants {
        {
            id = "mag_swimming",
            name = ccb.content.plural_text("Swim Planet", "issues of Swim Planet"),
            description = ccb.content.text("The world's leading resource about aquatic sports."),
        },
        {
            id = "mag_swimming_1",
            name = ccb.content.plural_text("Men's Fitness", "issues of Men's Fitness"),
            description = ccb.content.text("A shiny magazine about fitness, nutrition, and sports, mostly oriented towards men."),
        },
        {
            id = "mag_swimming_2",
            name = ccb.content.plural_text("Iron Man", "issues of Iron Man"),
            description = ccb.content.text("A quarterly issue about natural bodybuilding, weightlifting, and powerlifting."),
        },
        {
            id = "mag_swimming_3",
            name = ccb.content.plural_text("Muscle & Fitness", "issues of Muscle & Fitness"),
            description = ccb.content.text("A magazine about mainstream fitness and simple bodybuilding, containing articles about different training techniques, nutrition tips, and doctor recommendations."),
        },
        {
            id = "mag_swimming_4",
            name = ccb.content.plural_text("Muscular Development", "issues of Muscular Development"),
            description = ccb.content.text("A monthly issue which covers mostly fitness and bodybuilding themes.  Lots of muscular men aggressively poke at you from the cover."),
        },
        {
            id = "mag_swimming_5",
            name = ccb.content.plural_text("Bicycling", "issues of Bicycling"),
            description = ccb.content.text("A small magazine about the bicycle scene, tips about the buying and maintenance of bikes, and different types of training you can do with them."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_swimming",
        category = "manuals",
        name = ccb.content.plural_text("Water Survival Training Field Manual", "copies of Water Survival Training Field Manual"),
        description = ccb.content.text("A commercially produced survival guide that details swimming and deep water survival techniques tailored to emergency scenarios."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 2200,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "manual_smg",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 8,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "swimming",
    }
    book:variants {
        {
            id = "manual_swimming",
            name = ccb.content.plural_text("Water Survival Training Field Manual", "copies of Water Survival Training Field Manual"),
            description = ccb.content.text("A commercially produced survival guide that details swimming and deep water survival techniques tailored to emergency scenarios."),
        },
        -- 978-1735728506
        {
            id = "manual_swimming_1",
            name = ccb.content.plural_text("Built from Broken", "copies of Built from Broken"),
            description = ccb.content.text("\"A Science-Based Guide to Healing Painful Joints, Preventing Injuries, and Rebuilding Your Body\".  This book details a way to build your body without painful and exhausting training, with a proper training program and step-by-step instructions."),
        },
        -- 978-0241394519
        {
            id = "manual_swimming_2",
            name = ccb.content.plural_text("Science of Running", "copies of Science of Running"),
            description = ccb.content.text("This book contains comprehensive information about how anatomy and physiology function in running, training plans, and many new exercises for new runners."),
        },
        -- 978-0990873853
        {
            id = "manual_swimming_3",
            name = ccb.content.plural_text("Overcoming Gravity", "copies of Overcoming Gravity"),
            description = ccb.content.text("\"A Systematic Approach to Gymnastics and Bodyweight Strength\", this thick book is a gold mine of information about strength-oriented bodyweight workout, including scientific principles, different routines, methods, detail about progression, and a huge variety of exercises and their modifications."),
        },
        -- 978-1646111688
        {
            id = "manual_swimming_4",
            name = ccb.content.plural_text("Calisthenics for Beginners", "copies of Calisthenics for Beginners"),
            description = ccb.content.text("A step-by-step guide about fitness and working out using only your body, with a huge variety of difficulties in exercises."),
        },
        -- 978-1540395429
        {
            id = "manual_swimming_5",
            name = ccb.content.plural_text("The Squat Bible", "copies of The Squat Bible"),
            description = ccb.content.text("200 pages of different squat trainings, with comprehensive info on what each of them is designed to train."),
        },
        -- 978-1642505030
        {
            id = "manual_swimming_6",
            name = ccb.content.plural_text("Functional Training and Beyond", "copies of Functional Training and Beyond"),
            description = ccb.content.text("The best book for someone who wants to build a better body - from the start to an advanced level."),
        },
        -- 978-1492530619
        {
            id = "manual_swimming_7",
            name = ccb.content.plural_text("New Functional Training for Sports", "copies of New Functional Training for Sports"),
            description = ccb.content.text("Concepts, methods, exercises and programs for athletes of different sports, with demonstrations, commentary, and analysis of key exercises."),
        },
        -- 978-0751572544
        {
            id = "manual_swimming_8",
            name = ccb.content.plural_text("The World's Fittest Book", "copies of The World's Fittest Book"),
            description = ccb.content.text("\"How to Train for Anything and Everything, Anywhere and Everywhere\", this book contains different types of trainings for everyone."),
        },
        -- 978-0008487034
        {
            id = "manual_swimming_9",
            name = ccb.content.plural_text("Blueprint", "copies of Blueprint"),
            description = ccb.content.text("The cutting-edge training program to make you stronger than ever, from zero to superhuman, in a year."),
        },
        -- 978-0593233757
        {
            id = "manual_swimming_10",
            name = ccb.content.plural_text("Hard Work Pays Off", "copies of Hard Work Pays Off"),
            description = ccb.content.text("A training manual for someone ready to spend lot of time and energy on training, with detailed instructions and comments."),
        },
    }
    content.add(book)
end
