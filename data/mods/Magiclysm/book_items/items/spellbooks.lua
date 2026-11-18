local content = require("ccb").content

do
    local book = content.Item {
        id = "DEBUG_spellbook",
        name = content.plural_text("A Technomancer's Guide to Debugging C:DDA", "copies of A Technomancer's Guide to Debugging C:DDA"),
        description = content.text("static std::string description( spell sp ) const;"),
        mass_milligrams = 1000,
        volume_ml = 1,
        looks_like = "cookbook",
        symbol = "?",
        color = "magenta",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "debug_hp", "debug_stamina", "debug_teleport_to", "example_template", "debug_bionic", "pain_split", "fireball", "gravity_well", "cone_cold", "megablast", "test_area_push", "test_area_pull_field", "test_area_pull_all" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 classless spell
    local book = content.Item {
        id = "wizard_beginner",
        category = "manuals",
        name = content.plural_text("A Beginner's Guide to Magic", "copies of A Beginner's Guide to Magic"),
        description = content.text("You would describe this as more like a pamphlet than a spellbook, but it seems to have at least a few interesting spells you can use."),
        mass_milligrams = 585000,
        volume_ml = 250,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "create_atomic_light", "sound_bomb", "classless_watch_spell", "protection_aura" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Magus, 3 classless spell
    local book = content.Item {
        id = "wizard_beginner_old",
        category = "manuals",
        name = content.plural_text("Magica Beginning", "copies of Magica Beginning"),
        description = content.text("An English translation of the original Latin work, this book was written by a magus for her apprentices.  In current days the majority of the theory is outdated, therefore this work is of mostly historical significance, but it is still possible to learn several spells from it."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "magic_missile", "phase_door", "create_atomic_light", "sound_bomb", "classless_watch_spell" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 stormshaper
    local book = content.Item {
        id = "novice_stormshaper_book",
        category = "manuals",
        name = content.plural_text("An Introduction to Applied Meteorology", "copies of An Introduction to Applied Meteorology"),
        description = content.text("A professional-looking book on stormshaping, structured after many college textbooks.  It has less to apply than one might expect from its size."),
        mass_milligrams = 900000,
        volume_ml = 1200,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "electric_arts", "windrun" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Magus, 1 Biomancer, 1 Kelvinist, 1 Druid, 1 classless spell
    local book = content.Item {
        id = "wizard_utility",
        category = "manuals",
        name = content.plural_text("Wizarding Guide to Backpacking", "copies of Wizarding Guide to Backpacking"),
        description = content.text("This appears to be the spell version of a guide for what things to take with you when backpacking.  It's a little bulky, but will certainly prove useful."),
        mass_milligrams = 1000000,
        volume_ml = 1250,
        price_cents = 35000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "create_lighter", "create_electric_lighter", "pain_split", "protection_aura", "magus_force_jar", "druid_healing_herb", "air_bubble" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 Kelvinist spells
    local book = content.Item {
        id = "pyro",
        category = "manuals",
        name = content.plural_text("Pyromancy for Heretics", "copies of Pyromancy for Heretics"),
        description = content.text("This charred husk of a book still contains many ways to light things aflame."),
        mass_milligrams = 450000,
        volume_ml = 1000,
        price_cents = 1904,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "point_flare", "fireball", "burning_hands", "create_lighter", "kelvinist_summon_flamesword" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Magus, 1 biomancer, 2 kelvinist, 1 classless spells
    local book = content.Item {
        id = "wizard_advanced",
        category = "manuals",
        name = content.plural_text("A Treatise on Magical Elements", "copies of A Treatise on Magical Elements"),
        description = content.text("This details complex diagrams, rituals, and choreography that describes various spells."),
        mass_milligrams = 920000,
        volume_ml = 750,
        price_cents = 30000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "point_flare", "ice_spike", "gravity_well", "pain_split", "classless_dispel_magic" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- id for legacy reasons
    -- 1 technomancer, 2 biomancer, 1 druid spells
    local book = content.Item {
        id = "priest_beginner",
        category = "manuals",
        name = content.plural_text("The Limits of Magical Recovery", "copies of The Limits of Magical Recovery"),
        description = content.text("A study of the progress of using magic to cure ailments and heal wounds throughout the ages, from the earliest simple rituals to set bones all the way through modern thaumaturgical research into cancer treatments and curing Orcus's disease.  Some of the descriptions are detailed enough to be used as spell formulae."),
        mass_milligrams = 900000,
        volume_ml = 750,
        price_cents = 15000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "light_healing", "biomancer_cure_disease_minor", "bless", "druid_healing_herb" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 technomancer, 1 animist spells
    local book = content.Item {
        id = "priest_advanced",
        category = "manuals",
        name = content.plural_text("The Paladin's Guide to Modern Spellcasting", "copies of The Paladin's Guide to Modern Spellcasting"),
        description = content.text("Despite the title, this seems to be written in Middle English.  A little obtuse, but you can make out most of the words well enough."),
        mass_milligrams = 830000,
        volume_ml = 750,
        price_cents = 30000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "smite", "holy_blade" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Kelvinist spells
    local book = content.Item {
        id = "winter_grasp",
        category = "manuals",
        name = content.plural_text("Winter's Eternal Grasp", "copies of Winter's Eternal Grasp"),
        description = content.text("This slim book almost seems to be made from ice, it's cold to the touch."),
        mass_milligrams = 450000,
        volume_ml = 1000,
        price_cents = 1904,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "cone_cold", "ice_spike", "hoary_blast", "chilling_touch", "frost_spray" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 7 Stormshaper spells
    local book = content.Item {
        id = "tome_of_storms",
        category = "manuals",
        name = content.plural_text("The Tome of The Oncoming Storm", "copies of The Tome of The Oncoming Storm"),
        description = content.text("A large book embossed with crossed lightning bolts and storm clouds, it tingles to the touch."),
        mass_milligrams = 430000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "electric_arts", "jolt", "windstrike", "windrun", "storm_hammer", "stormfist", "lightning_bolt", "lightning_blast", "shocking_dash", "toxtricity" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 6 Stormshaper spells
    local book = content.Item {
        id = "bioelectricity",
        category = "manuals",
        name = content.plural_text("Bioelectricity, An Arcane Approach", "copies of Bioelectricity, An Arcane Approach"),
        description = content.text("A small, but thick book, that covers the most recent developments in the field, including real examples."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "electric_arts", "storm_superconductor", "shocking_dash", "toxtricity", "electric_eye", "electric_waves" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Stormshaper wind spells
    local book = content.Item {
        id = "tome_of_wind",
        category = "manuals",
        name = content.plural_text("Blow You Away", "copies of Blow You Away"),
        description = content.text("A large, illustrated book, that describes the unpopular side of stormshaping - wind control.  Despite being less \"cool\", it has more control, and can be as devastating as lightning."),
        mass_milligrams = 473000,
        volume_ml = 825,
        price_cents = 7000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "windstrike", "windrun", "stormshaper_wall_of_fog", "explosive_decompression", "air_bubble", "stormshaper_heart_of_hurricane" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Stormshaper electric spells
    local book = content.Item {
        id = "tome_electric",
        category = "manuals",
        name = content.plural_text("How Electromancy Changed the Vietnam War", "copies of How Electromancy Changed the Vietnam War"),
        description = content.text("A scholarly work, that discusses the electromancy boom in the 60's and how the mass military draft of fresh, inexperienced mages changed the war, with examples of tactics and spells used by year.  Summary says \"it changed nothing\"."),
        mass_milligrams = 378000,
        volume_ml = 660,
        price_cents = 11700,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "storm_superconductor", "summon_teravolt", "storm_hammer", "stormfist", "electric_waves", "electric_eye", "toxtricity", "shocking_dash" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 technomancer, 1 earthshaper, 1 classless spell
    local book = content.Item {
        id = "generic_spellbook",
        category = "manuals",
        name = content.plural_text("Nondescript Spellbook", "copies of Nondescript Spellbook"),
        description = content.text("A small book, containing spells created by a novice magician."),
        mass_milligrams = 355000,
        volume_ml = 500,
        looks_like = "cookbook",
        symbol = "?",
        color = "magenta",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "seismic_stomp", "create_atomic_lamp", "ethereal_grasp" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 3 technomancer, 4 classless spell
    local book = content.Item {
        id = "light_manipulation_spellbook",
        category = "manuals",
        name = content.plural_text("Of Light and Falsehoods", "copies of Of Light and Falsehoods"),
        description = content.text("A small white book, it subtly amplifies the ambient light around it."),
        mass_milligrams = 430000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "dark_sight", "blinding_flash", "obfuscated_body", "create_atomic_light", "mirror_image", "invisibility", "holographic_transposition", "shadow_field" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Biomancer spells
    local book = content.Item {
        id = "biomancer_spellbook",
        category = "manuals",
        name = content.plural_text("The Tome of Flesh", "copies of The Tome of Flesh"),
        description = content.text("A small tome, seemingly covered in tanned human skin."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "vicious_tentacle", "bio_grotesque", "bio_acidicspray", "bio_fleshpouch", "bio_bonespear" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Druid spells
    local book = content.Item {
        id = "druid_spellbook",
        category = "manuals",
        name = content.plural_text("The Book of Trees", "copies of The Book of Trees"),
        description = content.text("A bark covered book, though the pages inside are modern typed ones.  Contains several druid spells."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_veggrasp", "druid_summon_brambles", "druid_growth", "druid_natures_commune", "druid_healing_herb" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 classless, 1 technomancer, 1 animist, 1 druid, 1 earthshaper spell
    local book = content.Item {
        id = "recovery_spellbook",
        category = "manuals",
        name = content.plural_text("The Utility of Mana as an Energy Source", "copies of The Utility of Mana as an Energy Source"),
        description = content.text("This book details spells that use your mana to recover various physiological effects."),
        mass_milligrams = 728000,
        volume_ml = 3000,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_restore_crystal_mana", "recover_mana", "recover_bionic_power", "recover_pain", "recover_sleepiness", "recover_stamina", "druid_healing" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 earthshaper spells, 4 druid spells, 1 stormshaper spell
    local book = content.Item {
        id = "farmer_spellbook",
        category = "manuals",
        name = content.plural_text("The Farm-Wizard's Almanac", "copies of The Farm-Wizard's Almanac"),
        description = content.text("While no longer popular in the age of nitrogen fertilizer and industrial farm equipment, copies of this tome continued to be published for years for a small audience of back-to-nature, do-it-yourself organic mage-farmers."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_turning_of_earth", "move_earth", "druid_growth", "druid_natures_commune", "druidic_regrowth", "purify_seed", "electric_eye" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Magus spells
    local book = content.Item {
        id = "magus_spellbook",
        category = "manuals",
        name = content.plural_text("The Tome of The Battle Mage", "copies of The Tome of The Battle Mage"),
        description = content.text("Your standard wizardy looking spellbook, filled with Magus combat spells.  You sure lucked out!"),
        mass_milligrams = 434000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "magus_mana_beam", "magus_mana_bolt", "magus_mana_blast", "magus_summon_impact_sling", "magus_mage_conjured_armor", "magus_mage_conjured_blade" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 earthshaper spells
    local book = content.Item {
        id = "eshaper_spellbook",
        category = "manuals",
        name = content.plural_text("The Tome of the Hollow Earth", "copies of The Tome of the Hollow Earth"),
        description = content.text("This large dusty spellbook seems perpetually, well, dusty.  It contains a considerable amount of earthly power."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "eshaper_rockbolt", "eshaper_shardspray", "eshaper_piercing_bolt", "eshaper_shardstorm", "eshaper_impalement" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 6 earthshaper spells
    local book = content.Item {
        id = "eshaper_spellbook_melee",
        category = "manuals",
        name = content.plural_text("Memoirs of the Champion of Earth", "copies of Memoirs of the Champion of Earth"),
        description = content.text("A book written by someone obviously very self-absorbed who describes himself as \"Chosen of Gaia, the Only Champion of Terra\".  Despite his arrogance, his mastery in combining different earthshaper's abilities as described in the book make him an accomplished sorcerer worth learning from."),
        mass_milligrams = 247000,
        volume_ml = 398,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "pertifying_touch", "earthshaper_stoneskin", "reactive_armor", "eshaper_melee_damage", "eshaper_crystal_wrap", "earthshaper_sleep_in_earth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 earthshaper spell. yes, the whole book is only for one, that's the idea
    local book = content.Item {
        id = "eshaper_spellbook_tool",
        category = "manuals",
        name = content.plural_text("One Spell is All You Need!", "copies of One Spell is All You Need!"),
        description = content.text("This advertising booklet promotes one spell that allows you to create a different tool for different purposes.  Surprisingly, it works as the book says - you can change the shape of your tool, depending on your needs."),
        mass_milligrams = 83000,
        volume_ml = 132,
        price_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "eshaper_spawn_tools" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 6 Magus spells
    local book = content.Item {
        id = "magus_spellbook_move",
        category = "manuals",
        name = content.plural_text("The Tome of Magical Movement", "copies of The Tome of Magical Movement"),
        description = content.text("This small lightweight book seems to almost not entirely exist, let's say it 97% does.  It contains Magus spells focused on movement."),
        mass_milligrams = 231000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "phase_door", "magus_escape", "magus_haste", "magus_slow", "magus_slowfall", "magus_spiderclimb", "magus_ranged_increase" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "summon_scroll_smudged",
        category = "manuals",
        name = content.plural_text("Smudged Scroll", "Smudged Scrolls"),
        description = content.text("This looks like someone was designing a new spell, but spilled a mug of coffee on it and crumpled it up in anger.  You can tell that it will definitely cast something, but you can't be sure that it will work very well."),
        mass_milligrams = 129000,
        volume_ml = 100,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "summon_bear" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 3 Animist spells
    local book = content.Item {
        id = "summon_undead_spellbook",
        category = "manuals",
        name = content.plural_text("Necromantic Minions for Dummies", "copies of Necromantic Minions for Dummies"),
        description = content.text("This book details various ways of summoning an undead minion to fight for you.  They all appear to disappear after a short time, crumbling to dust."),
        mass_milligrams = 788000,
        volume_ml = 2250,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "summon_undead", "summon_undead_swarm", "convert", "dominate", "life_detonation" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 Technomancer spells
    local book = content.Item {
        id = "techno_fundamentals",
        category = "manuals",
        name = content.plural_text("Fundamentals of Technomancy", "copies of Fundamentals of Technomancy"),
        description = content.text("This thick manual instructs the spellcaster on manipulating and empowering various forms of matter and energy."),
        mass_milligrams = 258000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "synaptic_stimulation", "animated_blade", "mirror_image", "technomancer_knifeshot" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Technomancer spells
    local book = content.Item {
        id = "techno_idiots",
        category = "manuals",
        name = content.plural_text("Complete Idiot's Guide to Technomancy", "copies of Complete Idiot's Guide to Technomancy"),
        description = content.text("This colorful guide, full of diagrams and cartoons, teaches a couple of very basic Technomancy spells for the not-so-bright pupils."),
        mass_milligrams = 211000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "taze", "quantum_tunnel_lesser" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Technomancer spells
    local book = content.Item {
        id = "techno_em",
        category = "manuals",
        name = content.plural_text("Technomancy and the Electromagnetic Spectrum", "copies of Technomancy and the Electromagnetic Spectrum"),
        description = content.text("This lab reference material book is thick and overflowing with information on combining magic with EM radiation."),
        mass_milligrams = 284000,
        volume_ml = 1000,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "taze", "laze", "technomancer_knifeshot", "technomancer_conjure_ups", "technomancer_recharge_vehicle" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 Technomancer spells, 2 Stormshaper spells
    local book = content.Item {
        id = "techno_electrical_work",
        category = "manuals",
        name = content.plural_text("The Mage-Engineer's Practical Guide", "copies of The Mage-Engineer's Practical Guide"),
        description = content.text("This is a heavy, university thaumaturgical-program-level guidebook.  It discusses the various practical applications of magic in repairwork and engineering, with a focus on immediately-usable techniques instead of airy theoretical approaches."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "electric_eye", "electric_arts", "technomancer_conjure_radio", "technomancer_welder", "technomancer_conjure_ups", "technomancer_recharge_vehicle" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 animist and 1 classless spells
    local book = content.Item {
        id = "animist_spirits",
        category = "manuals",
        name = content.plural_text("Liminal Pathways", "copies of Liminal Pathways"),
        description = content.text("A famous animist grimoire from early modernity.  Its cryptic passages describe and map connections between the spiritual world and ours."),
        mass_milligrams = 920000,
        volume_ml = 750,
        price_cents = 30000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "wrathful_spirits", "spirit_walk", "ethereal_grasp" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 animist spells
    local book = content.Item {
        id = "animist_shadows",
        category = "manuals",
        name = content.plural_text("Runic Tablet shard", "Runic Tablet shards"),
        description = content.text("A small tablet of blackened stone, apparently cut from a much larger slab.  Golden runes glow over its surface, and slowly shift into intelligible sentences when you stare at them."),
        mass_milligrams = 4000000,
        volume_ml = 2500,
        price_cents = 5000,
        looks_like = "material_shrd_limestone",
        symbol = "?",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:clear_use_actions()
    book:teach_spells({ "soulrend", "wrathful_spirits" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 classless spell
    local book = content.Item {
        id = "translocate_spellbook",
        category = "manuals",
        name = content.plural_text("Geospatial Systems: The Lie Of Linearity", "copies of Geospatial Systems: The Lie Of Linearity"),
        description = content.text("This book outlines in great detail how time and space are wibbly-wobbly and non-Euclidean.  It also appears to have a dozen different coordinate systems that it uses nearly interchangeably, which makes it hard to follow.  There's lots of jargon, but with intense study you can probably learn a thing or two about portals."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "translocate_self" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Magus spell, 1 Druid spell, 2 Animist spells
    local book = content.Item {
        id = "forbidden_tome",
        name = content.plural_text("Forbidden Tome", "Forbidden Tomes"),
        description = content.text("A very, very old and heavy tome of various spells lost to the ages, either for good reason, or simply through the passage of time.  There are very few copies in existence, usually owned by those of great power, and yet all of them seem to have the last dozen pages or so torn out, in haste."),
        mass_milligrams = 2400000,
        volume_ml = 5000,
        price_cents = 7500,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "focused_bolt", "rupture", "disruption_bolt", "cause_rot", "devour" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 Technomancer spells
    local book = content.Item {
        id = "stat_up_spellbook",
        category = "manuals",
        name = content.plural_text("Transcendence of the Human Condition", "copies of Transcendence of the Human Condition"),
        description = content.text("The Human is the only creature that seeks to improve himself.  This study examines different spells that can heighten various senses temporarily, in hopes to discover a more permanent solution."),
        mass_milligrams = 1300000,
        volume_ml = 2500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "technomancer_dexterity_buff_spell", "technomancer_strength_buff_spell", "technomancer_intelligence_buff_spell", "technomancer_perception_buff_spell" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 3 Magus spells, 1 Technomancer spell
    local book = content.Item {
        id = "magic_movement_book",
        name = content.plural_text("Wherever You've Gone, There You Can Be", "copies of Wherever You've Gone, There You Can Be"),
        description = content.text("A very sarcastically-written guide to using magic to get into and out of places you absolutely are not supposed to be."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 7500,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "magus_teleport_mark", "magus_word_of_recall", "magus_spiderclimb", "quantum_tunnel_lesser" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 3 Druid spells, 1 Earthshaper spell, 1 Biomancer spell, 2 Kelvinist spells
    local book = content.Item {
        id = "prepper_spellbook",
        category = "manuals",
        name = content.plural_text("It's the End of the World, But You'll Feel Fine", "copies of It's the End of the World, But You'll Feel Fine"),
        description = content.text("This thick paperback book is a collection of the proper magical preparations to survive various disasters.  Unfortunately, the zombie apocalypse section doesn't account for everything that's gone wrong in the Cataclysm, but there's still a lot of useful knowledge here."),
        mass_milligrams = 473000,
        volume_ml = 825,
        price_cents = 3500,
        looks_like = "cookbook",
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_harvest_hunter", "druid_naturebow1", "biomancer_carrion_feast", "purify_seed", "earthshaper_turning_of_earth", "create_lighter", "kelvinist_anti_cold" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 7 Druid spells
    local book = content.Item {
        id = "plant_spellbook",
        name = content.plural_text("The Elven Path", "copies of The Elven Path", "spellbook"),
        description = content.text("Written by the elven archdruid Tylindel Melithilarahd over 500 years ago, this weighty tome was considered *the* most important book of the Harmonist druidic movement up until just before the Cataclysm.  Archdruid Melithilarahd's death in 2016 ended his overt patronage of his own works, allowing other writers to attempt to make their mark, especially younger elves who did not have such a strident anti-modern attitude.  In addition to all the philosophical essays about the importance of living in harmony with nature and allowing plants to grow where they will are several plant-based druidic spells."),
        price_cents = 15000,
        symbol = "?",
        looks_like = "cookbook",
        color = "green",
        mass_milligrams = 2041000,
        volume_ml = 1500,
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_whisper_leaves", "druid_summon_tanglevine", "druid_summon_brambles", "druid_renew_forest_spell", "druid_wood_living_tree_spell", "druid_rootstrike", "druidic_regrowth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 7 Druid spells
    local book = content.Item {
        id = "plant_spellbook_expurgated",
        name = content.plural_text("The Elven Path (popular edition)", "copies of The Elven Path (popular edition)", "spellbook"),
        description = content.text("Written by the elven archdruid Tylindel Melithilarahd over 500 years ago, this weighty tome was considered *the* most important book of the Harmonist druidic movement up until just before the Cataclysm.  Archdruid Melithilarahd's death in 2016 ended his overt patronage of his own works, allowing other writers to attempt to make their mark, especially younger elves who did not have such a strident anti-modern attitude.  In addition to all the philosophical essays about the importance of living in harmony with nature and allowing plants to grow where they will are several plant-based druidic spells.  This particular copy has the restricted spells present in the original excised."),
        price_cents = 15000,
        symbol = "?",
        looks_like = "cookbook",
        color = "green",
        mass_milligrams = 2041000,
        volume_ml = 1500,
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_whisper_leaves", "druid_summon_brambles", "druid_renew_forest_spell", "druid_wood_living_tree_spell", "druidic_regrowth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Magus spell, 1 Earthshaper spell, 1 Stormshaper spell, 1 Technomancer spell, 1 Classless spell
    local book = content.Item {
        id = "book_lazy_magic",
        category = "manuals",
        name = content.plural_text("The Lazy Mage's How-to Guide", "copies of The Lazy Mage's How-to Guide"),
        description = content.text("A thin book full of spells designed to help the practitioner short-cut having to actually do any work.  Considering the effort involved in studying magic, you're not sure any actual time is being saved."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "magus_far_hand_pull", "classless_watch_spell", "create_electric_lighter", "earthshaper_turning_of_earth", "summon_floating_disk" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 classless, 1 druid spell
    local book = content.Item {
        id = "camping_time_spellbook",
        category = "manuals",
        name = content.plural_text("Arcano-hiking for Fun", "copies of Arcano-hiking for Fun"),
        description = content.text("A thin book about the usefulness of magic in hiking, such as keeping clean, keeping the weather good, staying dry, and otherwise avoiding all the problems of the mundane outdoors."),
        mass_milligrams = 900000,
        volume_ml = 1200,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_clean_clothing_and_self", "druid_traverse_the_wilds" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 technomancer, 2 classless spells
    local book = content.Item {
        id = "magic_history_tech_spellbook",
        category = "manuals",
        name = content.plural_text("The Effects of Technological Progress on Magic", "copies of The Effects of Technological Progress on Magic"),
        description = content.text("A thick book about the history of magic's interactions with technology.  It delves deeply into why technological solutions have mostly replaced magic in daily life even though mages can have immense personal power: the incompatibility of Control and Harmony schools, the technological ease-of-use from the end-user perspective, and even the way some nations' legal systems have worked to discourage magic use so as to prevent individuals from attaining too much power."),
        mass_milligrams = 1728000,
        volume_ml = 3000,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_watch_spell", "create_atomic_light", "technomancer_conjure_radio" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Biomancer, 2 Druid spell
    local book = content.Item {
        id = "magic_healing_home_spellbook",
        category = "manuals",
        name = content.plural_text("The Home Mage's Healthcare Manual", "copies of The Home Mage's Healthcare Manual"),
        description = content.text("A reference book for the practical use of magic in healing the sort of wounds that are likely to occur at home: burns from cooking, scraped knees, cuts from knives, bruises, colds and the flu, and so on."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "magenta",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "light_healing", "biomancer_cure_disease_minor", "druid_disinfectant", "druid_bandage_heal" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Animist spell
    local book = content.Item {
        id = "animist_summon_wisps_spellbook",
        category = "manuals",
        name = content.plural_text("Travels Among the Ljósálfar: Their Customs, Food, Lifestyle, Celebrations, and Ceremonies", "copies of Travels Among the Ljósálfar: Their Customs, Food, Lifestyle, Celebrations, and Ceremonies"),
        description = content.text("An old 19th-century travelogue, detailing the author's travels among the elven tribes of northern Greenland.  The section about the midwinter festival and the northern lights is particularly detailed."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "summon_wisps" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 stormshaper spell
    local book = content.Item {
        id = "stormshaper_electric_immune_spellbook",
        category = "manuals",
        name = content.plural_text("Storm Chasing In Complete Safety", "copies of Storm Chasing In Complete Safety"),
        description = content.text("A description of weather patterns, geological formations in particularly storm-prone areas, essays from well-known storm chasers, proper equipment and safety, how to keep dry, and a way to use magic to completely avoid any possible danger from the storm itself.  The book does explicitly warn that if a tree falls on you, you're on your own, though, so the title seems to be more than half marketing."),
        mass_milligrams = 585000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "electric_arts" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 kelvinist spells
    local book = content.Item {
        id = "avoid_all_temperatures_spellbook",
        category = "manuals",
        name = content.plural_text("Fashion Over Function: A Thaumaturgical Guide to Wearing Whatever, Whenever", "copies of Fashion Over Function: A Thaumaturgical Guide to Wearing Whatever, Whenever"),
        description = content.text("A thin guide to using magic to avoid extremes of both hot and cold, allowing you to design your wardrobe around always looking good rather than having to account for summer's heat or winter's chill."),
        mass_milligrams = 430000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_anti_cold", "kelvinist_anti_heat" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Druid spell
    local book = content.Item {
        id = "summon_cats_spellbook",
        category = "manuals",
        name = content.plural_text("A Cat Cafe at Home!", "copies of A Cat Cafe at Home!"),
        description = content.text("A very thin book, filled with glossy photos, about how to use druidic magic to call up cats whenever you are feeling lonely, if you can't afford one, or if you live in a place that doesn't normally allow pets.  The people in the photos watching half-a-dozen cats play sure look happy."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "summon_cats" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 classless spell
    local book = content.Item {
        id = "freshen_up_spellbook",
        category = "manuals",
        name = content.plural_text("Save Water and Time, with Magic!", "copies of Save Water and Time, with Magic!"),
        description = content.text("This very thin booklet about the ecological benefits of using magic instead of a mundane morning cleaning routine.  At the bottom of the back cover is an abstract logo of two people holding both hands with a tree growing through the resulting circle, and the words \"Gaia's Children\" beneath it."),
        mass_milligrams = 83000,
        volume_ml = 132,
        price_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_clean_clothing_and_self" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Biomancer, 1 Druid, 1 Kelvinist, and 1 classless spell.
    local book = content.Item {
        id = "post_apocalypse_guide_spellbook",
        category = "manuals",
        name = content.plural_text("Mystic Survival in the End Times", "copies of Mystic Survival in the End Times"),
        description = content.text("A somewhat alarmist book about the ways to survive after the collapse of civilization, using simple magic to deal with common problems.  Sadly, there are no anti-zombie combat spells within."),
        mass_milligrams = 434000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_clean_clothing_and_self", "biomancer_carrion_feast", "purify_seed", "create_lighter" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Earthshaper spells
    local book = content.Item {
        id = "earthshaper_landscaping_spellbook",
        category = "manuals",
        name = content.plural_text("Landscaping with Earthshaping", "copies of Landscaping with Earthshaping"),
        description = content.text("A guide to using earthshaping magic to shortcut the backbreaking work of digging and hauling needed to redo one's yard."),
        mass_milligrams = 211000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "move_earth", "earthshaper_turning_of_earth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Classless spells
    local book = content.Item {
        id = "crystallize_mana_economy_spellbook",
        category = "manuals",
        name = content.plural_text("The Limitations of the Mana Economy", "copies of The Limitations of the Mana Economy"),
        description = content.text("A study of the inherent non-scalability of magical solutions to problems, touching on the difficulty of producing crystallized mana in the quantities needed for industrial use, the long time period necessary for magical materials like orichalcum, mithril, or crimsonite to reach reliability, the way that earthshaping and druidism specifically require wilderness for some of their spells, and the way that an average mage exhausts their mana pool within fifteen minutes of working on any major project without extensive study and training."),
        mass_milligrams = 1728000,
        volume_ml = 3000,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_restore_crystal_mana", "crystallize_mana" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Animist spell, 1 Magus spell, 1 Stormshaper spell, 1 Classless spell
    local book = content.Item {
        id = "special_effects_spellbook",
        category = "manuals",
        name = content.plural_text("Make Your Own Special Effects", "copies of Make Your Own Special Effects"),
        description = content.text("A guide to using magic to create practical special effects, whether for a birthday celebration, house party, or simply for your own amusement."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "shadow_field", "summon_wisps", "sound_bomb", "stormshaper_cloak_of_fog" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Druid, 1 Earthshaper spell
    local book = content.Item {
        id = "magical_gardening_spellbook",
        category = "manuals",
        name = content.plural_text("Gardening the Druidic Way", "copies of Gardening the Druidic Way"),
        description = content.text("A reference tome for using magic to garden in a \"organic, traditional, earth-centered way\", as the back cover states."),
        mass_milligrams = 258000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_growth", "earthshaper_turning_of_earth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 technomancer spells
    local book = content.Item {
        id = "bypass_portals_spellbook",
        category = "manuals",
        name = content.plural_text("Let No Wall Stand in Your Way!", "copies of Let No Wall Stand in Your Way!"),
        description = content.text("This book claims to be an aid to people who always forget their keys or need to get into their car quickly, but the selection of spells seems pretty suspicious to you."),
        mass_milligrams = 585000,
        volume_ml = 550,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "knock", "quantum_tunnel_lesser" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Animist spell
    local book = content.Item {
        id = "sense_outsiders_spellbook",
        category = "manuals",
        name = content.plural_text("A Study of Nethereum Incursions", "copies of A Study of Nethereum Incursions"),
        description = content.text("An academic book about the history of known Nethereum incursions, including the 1908 Tunguska incident, the disappearance of the army of Cambyses, various dancing plagues, the earthquake that destroyed the kingdom of Mgarzhbag, the Week Without Sun in the 7th century, and more, along with a variety of speculation about possible other historical and pre-historical incursions."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "animist_sense_outsiders" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Stormshaper spell
    local book = content.Item {
        id = "windrunning_spellbook",
        category = "manuals",
        name = content.plural_text("Born of a Gale: A Taxonomy of Air and Weather Spirits", "copies of Born of a Gale: A Taxonomy of Air and Weather Spirits"),
        description = content.text("A formal study of the various sylphs, anemoi, shedim, hytersprites, hyades, ame-onna, and other spirits associated with air, wind, or weather."),
        mass_milligrams = 1588000,
        volume_ml = 2250,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "windrun" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Earthshaper spells
    -- Akyâluaban and Ghâzkhud are words from a fictional language and should not be translated.
    local book = content.Item {
        id = "stone_powers_spellbook",
        category = "manuals",
        name = content.plural_text("Akyâluaban: the Book of the Living Stone", "copies of Akyâluaban: the Book of the Living Stone"),
        description = content.text("A copy of a religious text from the Ghâzkhud dwarven religion.  Amidst the prayers and songs and meditations on the ancestors and the earth and the stones are some spells, though pious traditional ghâzkhudians would react with shock if you called them that."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_boulder", "earthshaper_harden_earth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 classless, 1 magus spell
    local book = content.Item {
        id = "staying_clean_spellbook",
        category = "manuals",
        name = content.plural_text("The Magical Method of Tidying Up", "copies of The Magical Method of Tidying Up"),
        description = content.text("This obvious cash-in book does have some actual practical spells amongst all the philosophical-sounding essays about the importance of cleanliness."),
        mass_milligrams = 585000,
        volume_ml = 550,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "protection_aura", "classless_clean_clothing_and_self", "magus_far_hand_pull" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Druid spell + potion fruit recipes
    local book = content.Item {
        id = "druid_healing_power_spellbook",
        category = "manuals",
        name = content.plural_text("The Healing Power of Nature", "copies of The Healing Power of Nature"),
        description = content.text("A description of the various ways to use natural herbs and plants to fuel magical healing.  There is a lot of useful knowledge of here if you sift through the book and filter out the various chapters about the dangers of allopathic medicine and modern post-industrial lifestyles."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "druid_healing_herb" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 Technomancer spells
    local book = content.Item {
        id = "hologram_and_teleport_spellbook",
        category = "manuals",
        name = content.plural_text("Now You See We: Technomantic Transit In Action", "copies of Now You See We: Technomantic Transit In Action"),
        description = content.text("A book about how technomancy, usually thought of as being based around electricity and human enhancement, somehow also encompasses quick moment but only when holograms are involved.  At least half the book is descriptions of experiments performed by research thaumaturges to find the exact boundaries of technomancy when movement is involved."),
        mass_milligrams = 355000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mirror_image", "holographic_transposition" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 2 druid spells, 1 stormshaper spell, 1 animist spell, all spells the pun ones
    local book = content.Item {
        id = "messed_up_spells_spellbook",
        category = "manuals",
        name = content.plural_text("Magical Mishaps: When Spells Go Wrong", "copies of Magical Mishaps: When Spells Go Wrong"),
        description = content.text("A series of stories of the various ways magic can go wrong if the wrong ingredients, words, or gestures are used.  A lot of the stories are merely funny, like the magus who in trying to alter the Sorcerer's Hand spell caused music to follow her everywhere she went, but there's the occasional real tragedy mixed in as a cautionary tale.  This version of the book contains the actual formulae for the spells."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "summon_bear", "druid_tornskin", "stormshaper_cloak_of_frog", "animist_magic_fissile" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Biomancy spell
    local book = content.Item {
        id = "biomancy_fasting_spellbook",
        category = "manuals",
        name = content.plural_text("Intermittent Fasting Using Biomancy", "copies of Intermittent Fasting Using Biomancy"),
        description = content.text("A guide to using biomancy to perform extreme intermittent fasting, eating an enormous amount of food only once every 2-5 days, depending on the mage's skill.  The book is filled with both glossy photos of extremely fit, beautiful people and warnings to make sure that your stomach isn't full when the spell wears off."),
        mass_milligrams = 284000,
        volume_ml = 550,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "pink",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "biomancer_eat_tons_of_food" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Classless spell
    local book = content.Item {
        id = "anti_magic_dispel_spellbook",
        category = "manuals",
        name = content.plural_text("A Year of Living Without Magic", "copies of A Year of Living Without Magic"),
        description = content.text("A guide to living without any magic at all, including ways to perform tasks that were traditionally performed with magic, such as starting fires, tending minor wounds, cooking and preserving food, doing laundry, and so on.  Somewhat hypocritically, it does include a dispelling spell in the back of the book."),
        mass_milligrams = 258000,
        volume_ml = 750,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_dispel_magic" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 1 Classless spell
    local book = content.Item {
        id = "easy_sleeping_spellbook",
        category = "manuals",
        name = content.plural_text("Beyond Sleeping Easy with Sorcery", "copies of Beyond Sleeping Easy with Sorcery"),
        description = content.text("This self-help book is themed around the Peaceful Rest spell, famed before the Cataclysm as an easy way to avoid tossing and turning.  Laudably, the book seems to be mostly about eventually weaning the reader off the need to cast a spell to be able to fall asleep on time."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "classless_easy_sleep_spell" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 7 Kelvinist spells
    local book = content.Item {
        id = "basic_pyromancy",
        category = "manuals",
        name = content.plural_text("Practical Pyromancy, Seventh Edition (Scholarly Edition)", "copies of Practical Pyromancy, Seventh Edition (Scholarly Edition)"),
        description = content.text("The 2020 edition of the classic tome of fire magic.  This is the restricted version, also containing information about combat spells."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_firebolt", "point_flare", "kelvinist_extinguish_fire_spell", "create_lighter", "kelvinist_heat_food", "kelvinist_anti_cold", "burning_hands" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 4 Kelvinist spells
    local book = content.Item {
        id = "basic_pyromancy_expurgated",
        category = "manuals",
        name = content.plural_text("Practical Pyromancy, Seventh Edition", "copies of Practical Pyromancy, Seventh Edition"),
        description = content.text("The 2020 edition of the classic tome of fire magic.  This is the expurgated version with all info about restricted battle magic removed."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 9000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_extinguish_fire_spell", "create_lighter", "kelvinist_heat_food", "kelvinist_anti_cold" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- All 3 first circle mana trait upgrade spells
    local book = content.Item {
        id = "all_first_circle_upgrades_spellbook",
        category = "manuals",
        name = content.plural_text("The Rites of the First Circle", "copies of The Rites of the First Circle"),
        description = content.text("A weighty tome containing all three of the Rites of the First Circle, the rituals used by dedicated mages to increase their ability to channel and recover mana."),
        mass_milligrams = 1588000,
        volume_ml = 2250,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_efficiency_01", "mana_upgrade_regeneration_01", "mana_upgrade_sensitivity_01" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "first_circle_mana_amount_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the First Circle: Mana Pool", "copies of The Rite of the First Circle: Mana Pool"),
        description = content.text("A lengthy list of the rituals and components necessary to slightly increase the efficiency by which the mage's body processes mana."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_efficiency_01" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "second_circle_mana_amount_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the Second Circle: Mana Pool", "copies of The Rite of the Second Circle: Mana Pool"),
        description = content.text("A lengthy list of the rituals and components necessary to increase the efficiency by which the mage's body processes mana."),
        mass_milligrams = 900000,
        volume_ml = 1200,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_efficiency_02" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "first_circle_mana_regen_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the First Circle: Mana Flow", "copies of The Rite of the First Circle: Mana Flow"),
        description = content.text("A lengthy list of the rituals and components necessary to slightly increase the rate by which the mage's body regains mana."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_regeneration_01" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "second_circle_mana_regen_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the Second Circle: Mana Flow", "copies of The Rite of the Second Circle: Mana Flow"),
        description = content.text("A lengthy list of the rituals and components necessary to increase the rate by which the mage's body regains mana."),
        mass_milligrams = 900000,
        volume_ml = 1200,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_regeneration_02" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "first_circle_mana_mult_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the First Circle: Mana Sense", "copies of The Rite of the First Circle: Mana Sense"),
        description = content.text("A lengthy list of the rituals and components necessary to slightly increase the sensitivity that the mage's body has to  mana."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_sensitivity_01" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "second_circle_mana_mult_upgrade_spellbook",
        category = "manuals",
        name = content.plural_text("The Rite of the Second Circle: Mana Sense", "copies of The Rite of the Second Circle: Mana Sense"),
        description = content.text("A lengthy list of the rituals and components necessary to increase the sensitivity that the mage's body has to mana."),
        mass_milligrams = 900000,
        volume_ml = 1200,
        price_cents = 50000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "mana_upgrade_sensitivity_02" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 3 Stormshaper spells, 1 Technomancer spell
    local book = content.Item {
        id = "pirate_spellbook",
        category = "manuals",
        name = content.plural_text("Sail the High Seas with Sorcery on Your Side", "copies of Sail the High Seas with Sorcery on Your Side"),
        description = content.text("This romanticized book of dubious historical accuracy details how pirates used magic to their advantage while sailing.  From better telescopes to banks of fog to hide their approach, it seems that according to this author at least, piracy was a true terror to behold."),
        mass_milligrams = 437000,
        volume_ml = 825,
        price_cents = 7000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_cloak_of_fog", "storm_shipwrecker", "air_bubble", "technomancer_far_sight" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 5 Animist spells, 2 Biomancer spell
    local book = content.Item {
        id = "necronomicon",
        name = content.plural_text("grimoire", "grimoires"),
        price_cents = 4500000,
        price_postapoc_cents = 100000,
        copy_from = "necronomicon",
        looks_like = "necronomicon",
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_see_invisibility", "rupture", "dominate", "animist_sense_outsiders", "biomancer_baleful_polymorph", "biomancer_carrion_feast", "animist_do_psionic_damage_to_head" })
    content.replace(book)
end
