local content = require("ccb").content

do
    local book = content.Item {
        id = "decoy_anarch",
        category = "manuals",
        name = content.plural_text("AAA Guide", "copies of AAA Guide"),
        description = content.text("A tourist-centric guide to points of interest throughout the country.  Though it focuses on the north-central US, the driving sections contain some practical tips on proper driving techniques."),
        mass_milligrams = 220000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "textbook_anarch",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 6,
        read_time_turns = 1800,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "driving",
    }
    book:variants {
        {
            id = "decoy_anarch",
            name = content.plural_text("AAA Guide", "copies of AAA Guide"),
            description = content.text("A tourist-centric guide to points of interest throughout the country.  Though it focuses on the north-central US, the driving sections contain some practical tips on proper driving techniques."),
        },
        -- 978-1638607175
        {
            id = "decoy_anarch_1",
            name = content.plural_text("Driving Around", "copies of Driving Around"),
            description = content.text("A travelogue about a group of teenagers in the late nineties."),
        },
        -- 978-3899555943
        {
            id = "decoy_anarch_2",
            name = content.plural_text("Off The Road", "copies of Off The Road"),
            description = content.text("A notebook about living off-the-grid, with a wide collection of stories, examples, tips, and advice."),
        },
        -- 978-0307277190
        {
            id = "decoy_anarch_3",
            name = content.plural_text("Traffic: Why We Drive the Way We Do", "copies of Traffic: Why We Drive the Way We Do"),
            description = content.text("A big research book that talks about how roads are built, why they're built in such a manner, and what we can do to improve it."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_cars",
        category = "manuals",
        name = content.plural_text("Top Gear magazine", "Top Gear magazines"),
        description = content.text("Lots of articles about cars and driving techniques."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 450,
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
        skill = "driving",
    }
    book:variants {
        {
            id = "mag_cars",
            name = content.plural_text("Top Gear", "issues of Top Gear"),
            description = content.text("Lots of articles about cars and driving techniques."),
        },
        {
            id = "mag_cars_1",
            name = content.plural_text("Automobile", "issues of Automobile"),
            description = content.text("A nice-looking magazine about the automobile industry, with shiny images and long articles.  Dated 2019."),
        },
        {
            id = "mag_cars_2",
            name = content.plural_text("Automotive Industries", "issues of Automotive Industries"),
            description = content.text("A monthly report about recent changes in the transport industry."),
        },
        {
            id = "mag_cars_3",
            name = content.plural_text("Autoweek", "issues of Autoweek"),
            description = content.text("A shabby magazine about new and old cars, automobile reviews, general motorsports, and DIY."),
        },
        {
            id = "mag_cars_4",
            name = content.plural_text("Car and Driver", "issues of Car and Driver"),
            description = content.text("An absolutely generic monthly magazine about the automotive industry."),
        },
        {
            id = "mag_cars_5",
            name = content.plural_text("Car Craft", "issues of Car Craft"),
            description = content.text("Flashy journal about cars, racing, and mechanics."),
        },
        {
            id = "mag_cars_6",
            name = content.plural_text("Diesel Power", "issues of Diesel Power"),
            description = content.text("An automotive magazine, focused on heavily modifying trucks, SUVs, and cars powered by diesel."),
        },
        {
            id = "mag_cars_7",
            name = content.plural_text("Cruisin' Style Magazine", "issues of Cruisin' Style Magazine"),
            description = content.text("A really old issue about classic car maintenance and restoration."),
        },
        {
            id = "mag_cars_8",
            name = content.plural_text("Hot Rod", "issues of Hot Rod"),
            description = content.text("Monthly magazine about hot rodding, drag racing, and muscle cars."),
        },
        {
            id = "mag_cars_9",
            name = content.plural_text("Motor Trend", "issues of Motor Trend"),
            description = content.text("Boring automobile magazine with a big shiny label."),
        },
        {
            id = "mag_cars_10",
            name = content.plural_text("Quatro Rodas", "issues of Quatro Rodas"),
            description = content.text("It seems to be a car magazine, but you can only understand the images, as the text is written in another language."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_driving",
        category = "manuals",
        name = content.plural_text("The Rules of the Road", "copies of The Rules of the Road"),
        description = content.text("A thick textbook for beginning drivers.  It contains chapters on laws, safe vehicle operation, and defensive driving concepts."),
        mass_milligrams = 404000,
        volume_ml = 500,
        price_cents = 2200,
        price_postapoc_cents = 250,
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
        intelligence = 5,
        read_time_turns = 960,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "driving",
    }
    book:variants {
        {
            id = "manual_driving",
            name = content.plural_text("The Rules of the Road", "copies of The Rules of the Road"),
            description = content.text("A thick textbook for beginning drivers.  It contains chapters on laws, safe vehicle operation, and defensive driving concepts."),
        },
        -- 978-1789630473
        {
            id = "manual_driving_1",
            name = content.plural_text("Guide to Passing the Driving Test", "copies of Guide to Passing the Driving Test"),
            description = content.text("A thick, heavy book about every thing you may be asked in your driving exam.  The biggest part of the book contains a 'theory test' with detailed answers, and many how-to's related to driving overall."),
        },
        -- 978-0115537011
        {
            id = "manual_driving_2",
            name = content.plural_text("The official DVSA guide to driving", "copies of The official DVSA guide to driving"),
            description = content.text("This book is packed with comprehensive information about driving, how to do it properly, and take joy in it.  You wonder how this manual made it here, as DVSA is a British organization, and the book contains information about specific British driving rules."),
        },
        -- 978-0367265595
        {
            id = "manual_driving_3",
            name = content.plural_text("Automated Driving and Driver Assistance Systems", "copies of Automated Driving and Driver Assistance Systems"),
            description = content.text("This book explains the technologies and approaches of advanced driving systems, how they are designed, and why it is hard to get a good result.  It is difficult to understand sometimes, but it shows driving from a perspective an average driver wouldn't think about."),
        },
        -- 978-1398602786
        {
            id = "manual_driving_4",
            name = content.plural_text("The Driving Instructor's Handbook", "copies of The Driving Instructor's Handbook"),
            description = content.text("Detailed textbook about how to provide driving lessons, what may be discussed, and how to prevent dangerous situations and collisions."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "textbook_anarch",
        category = "manuals",
        name = content.plural_text("AAA Guide", "copies of AAA Guide"),
        description = content.text("A tourist-centric guide to points of interest throughout the country.  This particular copy is apparently the Anonymous Anarchist's Annual: the cover conceals a wealth of ways to help stick it to The Man, along with plenty of advice for avoiding police."),
        mass_milligrams = 223000,
        volume_ml = 500,
        price_cents = 5000,
        price_postapoc_cents = 2750,
        symbol = "?",
        looks_like = "decoy_anarch",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 4,
        intelligence = 9,
        read_time_turns = 2700,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "driving",
    }
    book:variants {
        {
            id = "textbook_anarch",
            name = content.plural_text("AAA Guide", "copies of AAA Guide"),
            description = content.text("A tourist-centric guide to points of interest throughout the country.  This particular copy is apparently the Anonymous Anarchist's Annual: the cover conceals a wealth of ways to help stick it to The Man, along with plenty of advice for avoiding police."),
        },
        -- really? you don't know how to find the anarchist cookbook?
        {
            id = "textbook_anarch_1",
            name = content.plural_text("The Anarchist Cookbook", "copies of The Anarchist Cookbook"),
            description = content.text("Classic illegal manual about making weapons and explosives.  The first page contains a quote from its author William Powell, that describes it as \"a youthful indiscretion or mistake that can haunt someone during their early years or even longer\"."),
        },
        -- 978-0879472115
        {
            id = "textbook_anarch_2",
            name = content.plural_text("Science of Revolutionary Warfare", "copies of Science of Revolutionary Warfare"),
            description = content.text("A small, shabby book about making explosives, poisons, and weapons with resources you may find in your backyard."),
        },
        -- 978-0879472306
        {
            id = "textbook_anarch_3",
            name = content.plural_text("The Poor Man's James Bond", "copies of The Poor Man's James Bond"),
            description = content.text("A collection of American paramilitary knowledge throughout history, containing a lot of information about how to make dangerous weapons and explosives in pretty dry language."),
        },
    }
    content.add(book)
end
