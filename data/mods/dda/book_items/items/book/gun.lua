local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "pocket_firearms",
        category = "manuals",
        name = ccb.content.plural_text("Pocket Guide to Firearm Safety", "copies of Pocket Guide to Firearm Safety"),
        description = ccb.content.text("This pocket-sized leather-bound guide to firearm safety combines a wealth of concise information with simple to follow instructions and easy to read illustrations."),
        mass_milligrams = 226000,
        volume_ml = 250,
        price_cents = 4000,
        price_postapoc_cents = 500,
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
        skill = "gun",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_guns",
        category = "manuals",
        name = ccb.content.plural_text("Guns n Ammo", "issues of Guns n Ammo"),
        description = ccb.content.text("Reviews of firearms, and various useful tips about their use."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 2,
        read_time_turns = 420,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "gun",
    }
    book:variants {
        {
            id = "mag_guns",
            name = ccb.content.plural_text("Guns n Ammo", "issues of Guns n Ammo"),
            description = ccb.content.text("Reviews of firearms, and various useful tips about their use."),
        },
        {
            id = "mag_guns_1",
            name = ccb.content.plural_text("Gun Digest", "issues of Gun Digest"),
            description = ccb.content.text("Annual magazine about firearms, weapon collections, self-defense, same as some practical and legal advices."),
        },
        {
            id = "mag_guns_2",
            name = ccb.content.plural_text("Recoil", "issues of Recoil"),
            description = ccb.content.text("A modern magazine about handguns, tactical weapons, knives, and shooting activities.  It says there is a fold-out target, but someone took it off."),
        },
        {
            id = "mag_guns_3",
            name = ccb.content.plural_text("SWAT", "issues of SWAT"),
            description = ccb.content.text("\"Special Weapons And Tactics for the prepared American\", this magazine contains info about firearms, law enforcement, and related interests, with a focus on SWAT police officers."),
        },
        {
            id = "mag_guns_4",
            name = ccb.content.plural_text("Bullet Point", "issues of Bullet Point"),
            description = ccb.content.text("Small magazine about ammo and firearms, and how to choose, use, and maintain them properly."),
        },
        {
            id = "mag_guns_5",
            name = ccb.content.plural_text("Trigger Happy", "issues of Trigger Happy"),
            description = ccb.content.text("Modern magazine for young people about firearms, self-defense, different competitions, and reviews."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_gun",
        category = "manuals",
        name = ccb.content.plural_text("The Gun Owner's Handbook", "copies of The Gun Owner's Handbook"),
        description = ccb.content.text("A thick soft-cover book that claims to be a complete guide to safely operating, maintaining, and repairing firearms."),
        mass_milligrams = 462000,
        volume_ml = 500,
        price_cents = 3800,
        price_postapoc_cents = 1250,
        symbol = "?",
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
        skill = "gun",
    }
    book:variants {
        {
            id = "manual_gun",
            name = ccb.content.plural_text("The Gun Owner's Handbook", "copies of The Gun Owner's Handbook"),
            description = ccb.content.text("A thick soft-cover book that claims to be a complete guide to safely operating, maintaining, and repairing firearms."),
        },
        {
            id = "manual_gun_1",
            name = ccb.content.plural_text("FM 3-90-1: Offense And Defense", "copies of FM 3-90-1: Offense And Defense"),
            description = ccb.content.text("Official U.S. Army manual about basics and tactics of moving and attacking a target - how to shoot, how to hide, how to retreat, and how to defend."),
        },
        -- 978-1736672723
        {
            id = "manual_gun_2",
            name = ccb.content.plural_text("Surplus Military", "issues of Surplus Military"),
            description = ccb.content.text("A journal about modern and old firearms, their style, manufacturing, and usage."),
        },
        -- 979-8519992862
        {
            id = "manual_gun_3",
            name = ccb.content.plural_text("Owning a Modern Firearm", "copies of Owning a Modern Firearm"),
            description = ccb.content.text("Essential handbook detailing how to own, use, and properly maintain a modern-day firearm."),
        },
        -- 979-8593500014
        {
            id = "manual_gun_4",
            name = ccb.content.plural_text("Practical Shooting Training", "copies of Practical Shooting Training"),
            description = ccb.content.text("Step-by-step instructions on how to use a gun, with lot of drills for each level."),
        },
        -- 978-1951115142
        {
            id = "manual_gun_5",
            name = ccb.content.plural_text("The Illustrated History of Firearms", "copies of The Illustrated History of Firearms"),
            description = ccb.content.text("A reference book that contains hundreds of images of firearms inside, with lot of comments from professionals and information about each model."),
        },
        -- 978-1518654725
        {
            id = "manual_gun_6",
            name = ccb.content.plural_text("Long Range Shooting Handbook", "copies of Long Range Shooting Handbook"),
            description = ccb.content.text("\"The Complete Beginner's Guide to Precision Rifle Shooting\", this book contains information about shooting equipment, terminology, principles, and covers the theory of long-range shooting.  It has a lot of practical advice about marksmanship."),
        },
        -- 978-1480115736
        {
            id = "manual_gun_7",
            name = ccb.content.plural_text("The Rifle-Musket", "copies of The Rifle-Musket"),
            description = ccb.content.text("\"A Practical Treatise on the Enfield-Pritchett Rifle, Recently Adopted in the British Service\".  This is a practical guide to using the newly adopted P-1853 Enfield Rifle-Musket.  Despite being written in 1854, it still has lot of useful information about shooting, as well as information about how to maintain this antique rifle."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "text_gunsmith",
        name = ccb.content.plural_text("Ballistics: Theory, Design, and Application", "copies of Ballistics: Theory, Design, and Application"),
        description = ccb.content.text("This hefty, hardbound textbook is written in obtuse, complex language.  If you already knew a bit about engineering and fabrication, it might be a useful reference on gunsmithing and design, but without that knowledge it'd be better used to prop up a table."),
        mass_milligrams = 350000,
        volume_ml = 450,
        longest_side_mm = 250,
        symbol = "?",
        copy_from = "manual_gun",
        looks_like = "manual_gun",
    }
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2100,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "gun",
        proficiencies = {
            { id = "prof_gunsmithing_basic", time_factor = 0.75, fail_factor = 0.5 },
        },
    }
    book:variants {
        {
            id = "text_gunsmith",
            name = ccb.content.plural_text("Ballistics: Theory, Design, and Application", "copies of Ballistics: Theory, Design, and Application"),
            description = ccb.content.text("This hefty, hardbound textbook is written in obtuse, complex language.  If you already knew a bit about engineering and fabrication, it might be a useful reference on gunsmithing and design, but without that knowledge it'd be better used to prop up a table."),
        },
        -- 978-1632202697
        {
            id = "text_gunsmith_1",
            name = ccb.content.plural_text("The Complete Guide to Gunsmithing", "copies of The Complete Guide to Gunsmithing"),
            description = ccb.content.text("This fairly old book is a highly detailed and essential reference for any gun enthusiast, and covers everything from the use of proper tools to how to get a gunsmithing job."),
        },
        -- 978-1163156063
        {
            id = "text_gunsmith_2",
            name = ccb.content.plural_text("Professional Gunsmithing", "copies of Professional Gunsmithing"),
            description = ccb.content.text("A guide for gun shop owners, this book contains lots of information about weapons and weapon maintenance."),
        },
        -- 978-1946267467
        {
            id = "text_gunsmith_3",
            name = ccb.content.plural_text("Gunsmithing - Rifles", "copies of Gunsmithing - Rifles"),
            description = ccb.content.text("The book contains step-by-step instructions to repair and maintain all major rifle types, from the AR-15 and AK-47 to the M1 Garand.  It also details many different projects and enhancements for gun owners."),
        },
        -- 978-1614272373
        {
            id = "text_gunsmith_4",
            name = ccb.content.plural_text("Gunsmithing: A Manual of Firearm Design, Construction, Alteration and Remodeling", "copies of Gunsmithing: A Manual of Firearm Design, Construction, Alteration and Remodeling"),
            description = ccb.content.text("This book contains extremely precise instructions for fixing different issues with your gun.  Having lots of modern photos is a huge advantage, though the fact that it's a reprint of a book from the 1950s is not."),
        },
        -- 978-1982129224
        {
            id = "text_gunsmith_5",
            name = ccb.content.plural_text("The Guns of John Moses Browning", "copies of The Guns of John Moses Browning"),
            description = ccb.content.text("A major biography of John Moses Browning, \"the Thomas Edison of guns\", this book describes his story, and the inventions he made, as well as decisions behind their development, processes, manufacturing, and usage."),
        },
        -- 978-1732132764
        {
            id = "text_gunsmith_6",
            name = ccb.content.plural_text("DIY Guns: Easy DIY Gunsmithing Projects", "issues of DIY Guns: Easy DIY Gunsmithing Projects"),
            description = ccb.content.text("A big magazine about different gunsmithing projects, from tuning your gun to making a brand new one using common techniques."),
        },
        -- 978-0486287201
        {
            id = "text_gunsmith_7",
            name = ccb.content.plural_text("The Book of the Crossbow", "copies of The Book of the Crossbow"),
            description = ccb.content.text("This book details the long story of crossbows - a devastating weapon which improved medieval distance warfare drastically - with lot of illustrations and information about additional weapons, like ballistae and catapults."),
        },
    }
    content.add(book)
end
