local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_unarmed",
        category = "manuals",
        name = ccb.content.plural_text("Boxing Monthly", "issues of Boxing Monthly"),
        description = ccb.content.text("An exciting monthly magazine about boxing.  There are lots of large, colorful photos of pugilistic exploits."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
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
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "unarmed",
    }
    book:variants {
        {
            id = "mag_unarmed",
            name = ccb.content.plural_text("Boxing Monthly", "issues of Boxing Monthly"),
            description = ccb.content.text("An exciting monthly magazine about boxing.  There are lots of large, colorful photos of pugilistic exploits."),
        },
        -- 978-1941845097
        {
            id = "mag_unarmed_1",
            name = ccb.content.plural_text("Feral Fighting", "copies of Feral Fighting"),
            description = ccb.content.text("A brutal book about using dirty tricks to disrupt your enemies, and using this advantage to knockout or even kill them."),
        },
        -- 978-1941845059
        {
            id = "mag_unarmed_2",
            name = ccb.content.plural_text("Stand And Deliver", "copies of Stand And Deliver"),
            description = ccb.content.text("\"A Street Warrior's Guide To Tactical Combat Stances\", this book provides plenty of information about how stance changes your movement, and how to use each of them with maximum effect."),
        },
        -- 978-0985347284
        {
            id = "mag_unarmed_3",
            name = ccb.content.plural_text("First Strike: End a Fight in Ten Seconds or Less!", "copies of First Strike: End a Fight in Ten Seconds or Less!"),
            description = ccb.content.text("Despite having a pretty odd name, this book provides a lot of information about fighting techniques, and different tactics and skills you need to obtain to use them properly."),
        },
        -- 978-0873645171
        {
            id = "mag_unarmed_4",
            name = ccb.content.plural_text("Street Lethal: Unarmed Urban Combat", "copies of Street Lethal: Unarmed Urban Combat"),
            description = ccb.content.text("This book contains lot of images showing how to use different attacks in close quarters, but someone has hand-written \"lame\" on the cover."),
        },
        {
            id = "mag_unarmed_5",
            name = ccb.content.plural_text("Nuclear Strike!", "copies of Nuclear Strike!"),
            description = ccb.content.text("\"Turn your fist into a weapon of mass destruction!\"  This book details different training programs to train your body overall and to temper your hands and nerves into unstoppable forces."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_brawl",
        category = "manuals",
        name = ccb.content.plural_text("101 Wrestling Moves", "copies of 101 Wrestling Moves"),
        description = ccb.content.text("It seems to be a wrestling manual, poorly photocopied and released on spiral-bound paper.  Still, there are lots of useful tips for unarmed combat."),
        mass_milligrams = 227000,
        volume_ml = 500,
        price_cents = 3800,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 3,
        read_time_turns = 900,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "unarmed",
    }
    book:variants {
        {
            id = "manual_brawl",
            name = ccb.content.plural_text("101 Wrestling Moves", "copies of 101 Wrestling Moves"),
            description = ccb.content.text("It seems to be a wrestling manual, poorly photocopied and released on spiral-bound paper.  Still, there are lots of useful tips for unarmed combat."),
        },
        {
            id = "manual_brawl_1",
            name = ccb.content.plural_text("Turn Your Fists Into Sledgehammers!", "copies of Turn Your Fists Into Sledgehammers!"),
            description = ccb.content.text("A detailed explanation of how to train your hands, arms and fists to crush the heads of your opponents, with lot of photos and instructions."),
        },
        -- 978-1941845110
        {
            id = "manual_brawl_2",
            name = ccb.content.plural_text("Unleash Hell", "copies of Unleash Hell"),
            description = ccb.content.text("A book with a creepy image of death with a scythe on the cover, it guides the user on different attacks that can be combined to overwhelm and destroy your enemy in seconds."),
        },
        -- 978-1941845325
        {
            id = "manual_brawl_3",
            name = ccb.content.plural_text("Knockout: The Ultimate Guide to Sucker Punching", "copies of Knockout: The Ultimate Guide to Sucker Punching"),
            description = ccb.content.text("This book shows how to use sucker punches - fast and unexpected attacks - to take advantage in a street fight.  Not as useful as before, but it still contains solid information about certain skills and trainings."),
        },
        -- 978-1941845455
        {
            id = "manual_brawl_4",
            name = ccb.content.plural_text("Killer Instinct: Unarmed Combat for Street Survival", "copies of Killer Instinct: Unarmed Combat for Street Survival"),
            description = ccb.content.text("A shabby book about possible street dangers the author met in his long life, ways to deal with them, and the skill set that such situations require."),
        },
        -- 978-0985347208
        {
            id = "manual_brawl_5",
            name = ccb.content.plural_text("The Bigger They Are, The Harder They Fall", "copies of The Bigger They Are, The Harder They Fall"),
            description = ccb.content.text("This book explains simple rules that you need to rely on to fight an enemy of different constitution, with techniques and tactics."),
        },
    }
    content.add(book)
end
