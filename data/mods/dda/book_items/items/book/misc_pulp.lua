local content = require("ccb").content

do
    local book = content.Item {
        id = "book_fict_soft_pulp_venus",
        name = content.plural_text("Black Valkyries From Venus", "copies of Black Valkyries From Venus"),
        description = content.text("You hold in your hands a weather-beaten novel written by someone named \"Lee Racket.\""),
        mass_milligrams = 191000,
        volume_ml = 243,
        longest_side_mm = 230,
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_wtmrw",
        name = content.plural_text("The Wrong Tomorrow", "copies of Wrong Tomorrow"),
        description = content.text("You hold in your hands a cheap drugstore paperback written by someone named \"Lee Racket.\""),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    -- 'Hard-boiled enough to break a spoon' means melodramatic, exaggerated, emotional but simple, and possessing a general lack of literary pretense.  Weatherworn means damaged by age.  Skirt means woman.
    local book = content.Item {
        id = "book_fict_soft_pulp_nogod",
        name = content.plural_text("No God From a Corpse", "copies of No God From a Corpse"),
        description = content.text("A weatherworn paperback written by some skirt named \"Lee Racket.\"  It tells how rage and jealousy can turn a man, or a woman, into a monster.  This story is hard-boiled enough to break a spoon."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_squids",
        name = content.plural_text("Planet of the Murderous Squids that Time Forgot!", "copies of Planet of the Murderous Squids that Time Forgot!"),
        description = content.text("In this psychedelic adventure novel of cosmic exploration, an elderly assassin discovers a planet too good to be true.  Only once it is too late does she discover the harrowing truth at the center of \"The Planet of the Murderous Squids that Time Forgot!\""),
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_gcapes",
        name = content.plural_text("The Great Capes of Metropolis", "copies of The Great Capes of Metropolis"),
        description = content.text("In this classic pulp paperback of superheroic exploits, a group of masked vigilantes with diverse superpowers learn to work together to defeat the ultimate villain."),
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_yesmurd",
        name = content.plural_text("Yesterday's Murdered", "copies of Yesterday's Murdered"),
        description = content.text("In this fast paced pulp noir, a hard-drinking detective with nerves of steel has one last shot at vengeance."),
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_flashcc",
        name = content.plural_text("Flashgun Condor and the Crimson Criminal", "copies of Flashgun Condor and the Crimson Criminal"),
        description = content.text("A hot-blooded photographer who fights crime with film, footage, and fists, Condor is more than a mere shutterbug on the crime beat.  But will she be able to unravel a devious deception and bring the \"Crimson Criminal\" to justice?"),
        copy_from = "book_fict_soft_pulp_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_pulp",
        name = content.plural_text("pulp novel", "pulp novels"),
        description = content.text("A hardboiled detective tale filled with hard hitting action and intrigue."),
        copy_from = "book_fict_soft_pulp_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1080,
        fun = 2,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781612420530
    -- this is also scifi
    -- Broad is a dismissive and outdated term that simply means "woman."  The term is used because it evokes the (decidedly misogynistic) era in which the pulp genre gained popularity within the United States.
    local book = content.Item {
        id = "book_fict_soft_pulp_ddive",
        name = content.plural_text("The Deep Dive", "copies of The Deep Dive"),
        description = content.text("This dimestore short story about space travel is written by a broad named \"Lee Racket.\""),
        mass_milligrams = 154000,
        volume_ml = 206,
        longest_side_mm = 190,
        copy_from = "book_fict_soft_pulp_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 12,
        scannable = true,
    }
    content.add(book)
end
