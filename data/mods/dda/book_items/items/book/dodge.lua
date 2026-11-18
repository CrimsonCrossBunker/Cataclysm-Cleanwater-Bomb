local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_dodge",
        category = "manuals",
        name = ccb.content.plural_text("Dance Dance Dance!", "issues of Dance Dance Dance!"),
        description = ccb.content.text("Learn the moves of the trendiest dances right now."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 490,
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
        intelligence = 2,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "dodge",
    }
    book:variants {
        -- inherit name from item
        {
            id = "mag_dodge",
        },
        -- 9781013330865
        {
            id = "mag_dodge_1",
            name = ccb.content.plural_text("How Animals Move", "copies of How Animals Move"),
            description = ccb.content.text("In this book, zoologist Sir James Gray explores the development of different kinds of animal movement, from swimming to crawling to jumping, and then examines the mechanics of the variety of possible movements made by different creatures, illustrated with both sketches and photographs."),
        },
        -- 978-0275934194
        {
            id = "mag_dodge_2",
            name = ccb.content.plural_text("The Art of Movement", "copies of The Art of Movement"),
            description = ccb.content.text("A collection of photos of different dance movements of the world.  The images are inspiring, and the movements of the dancers are deep."),
        },
        -- 978-1583948682
        {
            id = "mag_dodge_3",
            name = ccb.content.plural_text("Self-Defense for Gentlemen and Ladies", "copies of Self-Defense for Gentlemen and Ladies"),
            description = ccb.content.text("An old treatise about self defense, with style."),
        },
        -- 978-1533113221
        {
            id = "mag_dodge_4",
            name = ccb.content.plural_text("Self-Defence for Non-Experts: A Book for People Who Can't Fight", "copies of Self-Defence for Non-Experts: A Book for People Who Can't Fight"),
            description = ccb.content.text("A small guide on self defense for an untrained person - mostly simple tricks and advice like having a knife and how to threaten an enemy into backing down, but contains some more advanced and detailed descriptions of movement techniques."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_dodge",
        category = "manuals",
        name = ccb.content.plural_text("The Book of Dances", "copies of The Book of Dances"),
        description = ccb.content.text("This massive antique book documents dances from all around the world in great detail.  A perceptive reader could learn a lot about defensive footwork from some of the war dances."),
        mass_milligrams = 2330000,
        volume_ml = 1250,
        price_cents = 7200,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "dodge",
    }
    book:variants {
        -- inherit name from item
        {
            id = "manual_dodge",
        },
        -- 978-1420875485
        {
            id = "manual_dodge_1",
            name = ccb.content.plural_text("The Complete Book about Dodgeball", "copies of The Complete Book about Dodgeball"),
            description = ccb.content.text("A small book from a Physical Education and Health teacher about the simple game of dodgeball, its rules and variations, tricks, and what it can teach students.  Sadly, the book contains surprisingly poor grammar, and the informal conversational tone makes it difficult to follow at times."),
        },
        -- 978-0989038270
        {
            id = "manual_dodge_2",
            name = ccb.content.plural_text("When Seconds Count", "copies of When Seconds Count"),
            description = ccb.content.text("A comprehensive guide on what to do in dangerous situations on the street and beyond - ways to improve your awareness skills, de-escalate the situation or, if it is not possible, defend yourself and your family in every possible manner, violent or not."),
        },
        -- 978-1623174439
        {
            id = "manual_dodge_3",
            name = ccb.content.plural_text("Born to Walk", "copies of Born to Walk"),
            description = ccb.content.text("This book explores the mechanics, mysteries, and methods of upright walking - why, how, and when.  Includes a big chapter on how different martial arts exploit this mode of movement."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_dodge_kid",
        category = "manuals",
        name = ccb.content.plural_text("Break a Leg!", "copies of Break a Leg!"),
        description = ccb.content.text("\"The Kids' Guide to Acting and Stagecraft\".  This book is packed with engaging outdoor games, complete with rules, strategies, and tips for mastering each activity, along with some simple drills to train skills in an easy way."),
        looks_like = "manual_gun",
        copy_from = "book_nonf_hard_dodge_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 3,
        read_time_turns = 600,
        fun = -1,
        chapters = 18,
        scannable = true,
        skill = "dodge",
    }
    book:variants {
        -- inherit name from item
        {
            id = "manual_dodge_kid",
        },
        -- 978-0874070248
        {
            id = "manual_dodge_kid_1",
            name = ccb.content.plural_text("Self-defense for Your Child", "copies of Self-defense for Your Child"),
            description = ccb.content.text("A fully-illustrated practical course of simple techniques to defend your child from bullies or predators.  You doubt it will help much for a real child, but you found some interesting info here."),
        },
        {
            id = "manual_dodge_kid_2",
            name = ccb.content.plural_text("Protective Measures: A Graphic Novel", "copies of Protective Measures: A Graphic Novel"),
            description = ccb.content.text("Modern comics about an unnamed Hero that protects people without any superpowers, using only his body and different martial arts.  The artwork is well-illustrated and shows the movement and strategy of each character, but the plot is fairly simple."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_dodge_tlwd",
        category = "manuals",
        name = ccb.content.plural_text("Treasury of Legends about Western Dancing", "copies of Treasury of Legends about Western Dancing"),
        description = ccb.content.text("Written by Emanuel Nogueira, a constabulario and historian of Nuevo Laredo, this massive book details the movements and cultural legacies of a variety of North American folk dances."),
        looks_like = "radio_book",
        mass_milligrams = 2330000,
        volume_ml = 1250,
        color = "blue",
        price_postapoc_cents = 2200,
        copy_from = "book_nonf_hard_dodge_tpl",
    }
    book:book {
        required_level = 4,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 1200,
        fun = -1,
        chapters = 18,
        scannable = true,
        skill = "dodge",
    }
    book:variants {
        -- inherit name from item
        {
            id = "book_nonf_hard_dodge_tlwd",
        },
        -- 979-8620742561
        {
            id = "book_nonf_hard_dodge_tlwd_1",
            name = ccb.content.plural_text("A Guide To Making Yourself A Hard Target", "copies of A Guide To Making Yourself A Hard Target"),
            description = ccb.content.text("Written by self-defense instructor Neal Martin, this book describes techniques and movesets you need to train to avoid being a victim, as well as avoid trouble with the law in the aftermath."),
        },
        -- 978-1497530201
        {
            id = "book_nonf_hard_dodge_tlwd_2",
            name = ccb.content.plural_text("The Ultimate Guide to Unarmed Self Defense", "copies of The Ultimate Guide to Unarmed Self Defense"),
            description = ccb.content.text("This book contains a lot of info about awareness, prevention, and defense in unarmed fights."),
        },
        -- 978-0897500227
        {
            id = "book_nonf_hard_dodge_tlwd_3",
            name = ccb.content.plural_text("Knife Self-Defense for Combat", "copies of Knife Self-Defense for Combat"),
            description = ccb.content.text("A small manual about skills you need to defend yourself in armed street fights."),
        },
        -- 978-1941845134
        {
            id = "book_nonf_hard_dodge_tlwd_4",
            name = ccb.content.plural_text("Invincible", "copies of Invincible"),
            description = ccb.content.text("A dark book with a barbarian on the cover, this guide talks about how to obtain skills for the streets, battlefields and… playing fields?"),
        },
        -- 978-0981872100
        {
            id = "book_nonf_hard_dodge_tlwd_5",
            name = ccb.content.plural_text("War Machine", "copies of War Machine"),
            description = ccb.content.text("\"How to Transform Yourself Into A Vicious And Deadly Street Fighter\".  This book, despite having a gladiator on the cover, describes pretty practical ways to obtain the psychology, physiology, and combat potential of a real warrior, ancient or modern."),
        },
        -- 978-1623176570
        {
            id = "book_nonf_hard_dodge_tlwd_6",
            name = ccb.content.plural_text("Understanding the Human Foot", "copies of Understanding the Human Foot"),
            description = ccb.content.text("A full color, updated overview of the structure of the feet, with essential info about its functions, demonstrating how the foot relates to and interacts with the rest of the body during movement."),
        },
    }
    content.add(book)
end
