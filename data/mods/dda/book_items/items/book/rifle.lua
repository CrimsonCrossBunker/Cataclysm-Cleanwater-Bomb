local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "retool_instructions",
        category = "manuals",
        name = ccb.content.plural_text("retool instructions", "copies of retool instructions"),
        description = ccb.content.text("This is a small booklet, containing several diagrams and clearly worded instructions for assisting one in assembling, installing, and using their newly purchased weapon conversion kit.  The flyer's rear is covered in neatly printed rows of advertisements, displaying other products by the same manufacturer.  All in all, it, strangely enough, brings to mind nostalgic images of the instructions for assembling Legos—a very angry, explosive Lego construct that goes boom."),
        mass_milligrams = 25000,
        volume_ml = 100,
        price_cents = 150,
        price_postapoc_cents = 350,
        symbol = "?",
        looks_like = "mag_guns",
        color = "pink",
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
        skill = "rifle",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_rifle",
        category = "manuals",
        name = ccb.content.plural_text("Modern Rifleman", "issues of Modern Rifleman"),
        description = ccb.content.text("An informative magazine all about rifles and shooting.  There is an excellent article about proper maintenance in this issue."),
        mass_milligrams = 100000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "mag_guns",
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
        skill = "rifle",
    }
    book:variants {
        {
            id = "mag_rifle",
            name = ccb.content.plural_text("Modern Rifleman", "issues of Modern Rifleman"),
            description = ccb.content.text("An informative magazine all about rifles and shooting.  There is an excellent article about proper maintenance in this issue."),
        },
        {
            id = "mag_rifle_1",
            name = ccb.content.plural_text("American Rifleman", "issues of American Rifleman"),
            description = ccb.content.text("A monthly shooting and firearms publication, with a lot of articles and comments."),
        },
        {
            id = "mag_rifle_2",
            name = ccb.content.plural_text("Shooting Stars", "issues of Shooting Stars"),
            description = ccb.content.text("An annual magazine for marksmen, with lots of articles and papers, as well as reviews of new rifles, optics, and mods."),
        },
        {
            id = "mag_rifle_3",
            name = ccb.content.plural_text("The Precisionist", "issues of The Precisionist"),
            description = ccb.content.text("A dedicated journal about various firearms, their usage, and news about them.  Different articles review new firearm models, old models, new attachments, hunting, maintenance, and a lot of other topics."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_rifle",
        category = "manuals",
        name = ccb.content.plural_text("FM 23-16 Army marksmanship manual", "FM 23-16 Army marksmanship manuals"),
        description = ccb.content.text("A hefty military field manual about automatic rifle usage and techniques which improve marksmanship and proper weapons-handling."),
        mass_milligrams = 454000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "mag_guns",
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
        skill = "rifle",
    }
    book:variants {
        {
            id = "manual_rifle",
            name = ccb.content.plural_text("FM 23-16 Army marksmanship manual", "copies of FM 23-16 Army marksmanship manual"),
            description = ccb.content.text("A hefty military field manual about automatic rifle usage and techniques which improve marksmanship and proper weapons-handling."),
        },
        -- 978-1493036752
        {
            id = "manual_rifle_1",
            name = ccb.content.plural_text("SAS and Elite Forces Guide Sniper", "copies of SAS and Elite Forces Guide Sniper"),
            description = ccb.content.text("An unofficial guide about the work and skills of British and NATO snipers.  There are a lot of photos of weapons and equipment, but it has a huge lack of details - the most important information is just mentioned or described without any value."),
        },
        -- 978-1951115104
        {
            id = "manual_rifle_2",
            name = ccb.content.plural_text("Precision Rifle Marksmanship: The Fundamentals", "copies of Precision Rifle Marksmanship: The Fundamentals"),
            description = ccb.content.text("A small book about the use of a rifle as a marksman's tool.  There is plenty of information, but it is too general, and the author talks more about his experience as a sniper than sniping itself."),
        },
        -- 978-1979598699
        {
            id = "manual_rifle_3",
            name = ccb.content.plural_text("Precision Long Range Shooting And Hunting", "copies of Precision Long Range Shooting And Hunting"),
            description = ccb.content.text("A book about the basics of long-range shooting, written in fairly simple language."),
        },
        -- 978-1792182938
        {
            id = "manual_rifle_4",
            name = ccb.content.plural_text("The Marine Sniping Handbook", "copies of The Marine Sniping Handbook"),
            description = ccb.content.text("The Official (or at least so it says) marksmanship guide for scout snipers.  With lots of essential info, it gives a pretty good foundation to anyone who knows how to use a rifle."),
        },
        -- 978-0267853731
        {
            id = "manual_rifle_5",
            name = ccb.content.plural_text("How to Shoot", "copies of How to Shoot"),
            description = ccb.content.text("A reprint of a 1917 book about rifle shooting and maintenance.  It is surprisingly detailed, and contains lots of information, even if the language is fairly old-fashioned."),
        },
        -- 979-8355590895
        {
            id = "manual_rifle_6",
            name = ccb.content.plural_text("Rifle Shooting for Beginners", "copies of Rifle Shooting for Beginners"),
            description = ccb.content.text("A guide to shooting sports that explains the basics of equipment usage, judging distance, aiming, breathing, movement, and trigger discipline alongside a lot of other essential info."),
        },
        -- 978-1510731691
        {
            id = "manual_rifle_7",
            name = ccb.content.plural_text("Great Hunting Rifles: Victorian to the Present", "copies of Great Hunting Rifles: Victorian to the Present"),
            description = ccb.content.text("A history of some of the most exquisite rifles made in the twentieth century, written with a lot of love and attention to detail."),
        },
        {
            id = "manual_rifle_8",
            name = ccb.content.plural_text("FM 3-22.9: Rifle Marksmanship M16-/M4- Series", "copies of FM 3-22.9: Rifle Marksmanship M16-/M4- Series"),
            description = ccb.content.text("An official U.S. Army manual that provides guidance for the planning and execution of training with the 5.56mm M16-series rifle and M4 carbine."),
        },
        {
            id = "manual_rifle_9",
            name = ccb.content.plural_text("FM 3-22.68: Crew-Served Machine Guns 5.56-mm And 7.62-mm", "copies of FM 3-22.68: Crew-Served Machine Guns 5.56-mm And 7.62-mm"),
            description = ccb.content.text("An official U.S. Army manual which is a comprehensive guide about using the M240 and M249 crew-served machine guns, with excellent examples and a lot of theory."),
        },
        -- 979-8360280453
        {
            id = "manual_gun_10",
            name = ccb.content.plural_text("Adaptive Rifle", "copies of Adaptive Rifle"),
            description = ccb.content.text("A book containing different training methods for carbine users from world champion shooters, aimed toward civilians, law enforcement, and military shooters."),
        },
        -- 978-1581605921
        {
            id = "manual_gun_11",
            name = ccb.content.plural_text("The Art of the Rifle", "copies of The Art of the Rifle"),
            description = ccb.content.text("This book covers the fundamentals of rifle shooting, including stance, grip, sight alignment, and trigger control."),
        },
        -- 978-1510760042
        {
            id = "manual_gun_12",
            name = ccb.content.plural_text("Shooter's Bible Guide to Rifle Ballistics", "copies of Shooter's Bible Guide to Rifle Ballistics"),
            description = ccb.content.text("A comprehensive guide to the principles of rifle ballistics, including information on bullet types, trajectory, and wind drift."),
        },
        -- 978-0743270762
        {
            id = "manual_gun_13",
            name = ccb.content.plural_text("The Gun", "copies of The Gun"),
            description = ccb.content.text("A giant, 500-page history about the AK-47—the most popular firearm in the world—and the information around it: the mechanics of the weapon, its usage, maintenance, modifications, and its impact on global conflicts."),
        },
        -- 978-0743270762
        {
            id = "manual_gun_14",
            name = ccb.content.plural_text("America's Rifle", "copies of America's Rifle"),
            description = ccb.content.text("A history book penned by an anonymous author.  Starting from its design by John Garand and ending with the Vietnam War, it provides a detailed run-down of the M1 Garand rifle's use throughout history as well as its design and quirks with the weapon."),
        },
    }
    content.add(book)
end
