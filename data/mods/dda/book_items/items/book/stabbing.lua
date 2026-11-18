local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_stabbing",
        category = "manuals",
        name = content.plural_text("Duelist's Annual", "Duelist's Annuals"),
        description = content.text("An annual publication about fencing and dueling.  There are many good illustrations which describe proper technique and form."),
        mass_milligrams = 80000,
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
        skill = "stabbing",
    }
    book:variants {
        {
            id = "mag_stabbing",
            name = content.plural_text("Duelist's Annual", "issues of Duelist's Annual"),
            description = content.text("An annual publication about fencing and dueling.  There are many good illustrations which describe proper technique and form."),
        },
        -- 978-1884654770
        {
            id = "mag_stabbing_1",
            name = content.plural_text("Fencer's Start-Up", "copies of Fencer's Start-Up"),
            description = content.text("A beginner's guide to traditional and sport fencing - rules, proper defense and offense, movement, etc."),
        },
        -- 978-1782551133
        {
            id = "mag_stabbing_2",
            name = content.plural_text("Learning Fencing", "copies of Learning Fencing"),
            description = content.text("A childish book about fencing, where the mascot Foily guides the reader through the different nuances of fencing with lots of photos and images."),
        },
        -- 978-1782551119
        {
            id = "mag_stabbing_3",
            name = content.plural_text("The Complete Guide to Fencing", "copies of The Complete Guide to Fencing"),
            description = content.text("A thick book, written by professional fencers, that covers every possible aspect of modern sport fencing."),
        },
        -- 978-1847973054
        {
            id = "mag_stabbing_4",
            name = content.plural_text("Fencing: Skills, Tactics, Training", "copies of Fencing: Skills, Tactics, Training"),
            description = content.text("A textbook for fence instructors that fulfills every aspect a fencer must know, from the very basics to a master level, from theory to drill training exercises."),
        },
        -- 978-0978902230
        {
            id = "mag_stabbing_5",
            name = content.plural_text("Modern Saber Fencing", "copies of Modern Saber Fencing"),
            description = content.text("This book highlights the modern technologies used in fencing, with new possible techniques and scientific research that underlies the latest training methods."),
        },
        -- 978-1599101293
        {
            id = "mag_stabbing_6",
            name = content.plural_text("Fencing: A Renaissance Treatise", "copies of Fencing: A Renaissance Treatise"),
            description = content.text("An ancient treatise explaining the fundamental ideas of fencing that are still used today - distance, time, line, blade opposition, counterattacks, countertime, etc."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_stabbing",
        category = "manuals",
        name = content.plural_text("FM 23-25 Army bayonet manual", "FM 23-25 Army bayonet manuals"),
        description = content.text("A hefty military field manual about bayonet usage and combat theory."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "stabbing",
    }
    book:variants {
        {
            id = "manual_stabbing",
            name = content.plural_text("FM 23-25 Army bayonet manual", "copies of FM 23-25 Army bayonet manual"),
            description = content.text("A hefty military field manual about bayonet usage and combat theory."),
        },
        -- 9780919316386
        {
            id = "manual_stabbing_1",
            name = content.plural_text("The Halberd and Other European Pole Arms, 1300-1650", "copies of The Halberd and Other European Pole Arms, 1300-1650"),
            description = content.text("Small, but comprehensive introduction to the pole arms of medieval Europe: from the simple pike, through the halberd in its many forms, to the roncone, bardiche, and many others."),
        },
        -- 978-0917218507
        {
            id = "manual_stabbing_2",
            name = content.plural_text("Boarders Away: With Steel-Edged Weapons and Polearms", "copies of Boarders Away: With Steel-Edged Weapons and Polearms"),
            description = content.text("An all-encompassing study of naval armament under fighting sail.  This volume covers pikes and fighting blades in use between 1626 and 1826."),
        },
        -- 978-1648371059
        {
            id = "manual_stabbing_3",
            name = content.plural_text("Polearms of Paulus Hector Mair", "copies of Polearms of Paulus Hector Mair"),
            description = content.text("The summarized and preserved experience of Paulus Hector Mair, an ancient German fencing master, using spears, lances, halberds, poleaxes, and similar weapons."),
        },
        -- 978-9004144095
        {
            id = "manual_stabbing_4",
            name = content.plural_text("Hafted Weapons in Medieval and Renaissance Europe", "copies of Hafted Weapons in Medieval and Renaissance Europe"),
            description = content.text("Research about the long history of a huge variety of weapons in medieval times, with lots of illustrations."),
        },
        -- 978-1901903560
        {
            id = "manual_stabbing_5",
            name = content.plural_text("Japanese Spears", "copies of Japanese Spears"),
            description = content.text("A fully illustrated guide to the use of polearms, ranging from the earliest halberds and spears reaching Japan from the Asian mainland to the sophisticated naginata, nagamaki, and various forms of yari used by the Japanese samurai through the medieval period."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_knives",
        category = "manuals",
        name = content.plural_text("Spetsnaz Knife Techniques", "copies of Spetsnaz Knife Techniques"),
        description = content.text("A classic Soviet text on the art of attacking with a blade."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 5200,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 1,
        maximum_level = 4,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "stabbing",
    }
    book:variants {
        {
            id = "manual_knives",
            name = content.plural_text("Spetsnaz Knife Techniques", "copies of Spetsnaz Knife Techniques"),
            description = content.text("A classic Soviet text on the art of attacking with a blade."),
        },
        -- 978-1941845646
        {
            id = "manual_knives_1",
            name = content.plural_text("Knife Fighting Targets", "copies of Knife Fighting Targets"),
            description = content.text("Simple, practical and useful martial art techniques to use in a fight.  On the first page the author says they will not be held responsible for any harm caused by using advice from this book."),
        },
        -- 978-1451637557
        {
            id = "manual_knives_2",
            name = content.plural_text("Book of Knives", "copies of Book of Knives"),
            description = content.text("Authored by a state trooper and policeman from Michigan, it contains a lot of experience on real fights with a knife and against a knife."),
        },
        -- 978-1678011840
        {
            id = "manual_knives_3",
            name = content.plural_text("The Ka-Bar Knife Combat Manual", "copies of The Ka-Bar Knife Combat Manual"),
            description = content.text("This manual teaches the reader to use the Ka-Bar, an iconic knife of the U.S. Army that carries the energy and spirit of soldiers."),
        },
        -- 978-0873644846
        {
            id = "manual_knives_4",
            name = content.plural_text("Put 'Em Down, Take 'Em Out!", "copies of Put 'Em Down, Take 'Em Out!"),
            description = content.text("\"Knife Fighting Techniques From Folsom Prison\".  This book describe fighting with a shiv in the tight walls of a jail."),
        },
        {
            id = "manual_knives_5",
            name = content.plural_text("Queen of Knives", "copies of Queen of Knives"),
            description = content.text("A small, femme-oriented manual about self-defense with knife."),
        },
        -- 978-1530527953
        {
            id = "manual_knives_6",
            name = content.plural_text("Secrets of the Karambit", "copies of Secrets of the Karambit"),
            description = content.text("This book aspires to describe and explain the history, design, materials, and demonstrate deployment and drills with the unusual Indonesian weapon known as the karambit knife.  The final impression is disappointing."),
        },
        -- 978-0764348341
        {
            id = "manual_knives_7",
            name = content.plural_text("Combat Knives and Knife Combat", "copies of Combat Knives and Knife Combat"),
            description = content.text("A comprehensive compendium about different types of knives and their usage in various martial arts."),
        },
        -- 979-8667992141
        {
            id = "manual_knives_8",
            name = content.plural_text("The Silent Bodyguard", "copies of The Silent Bodyguard"),
            description = content.text("\"The Art of Knife Fencing & the Chronicles of the Modern Fighting Knife and their Wielders\".  This book teaches the reader how to defend against an aggressor with various weapons."),
        },
    }
    content.add(book)
end
