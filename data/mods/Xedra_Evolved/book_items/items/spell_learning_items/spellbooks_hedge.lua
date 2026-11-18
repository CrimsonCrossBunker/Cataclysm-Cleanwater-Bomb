local content = require("ccb").content

do
    -- This is a quest reward specifically written to be easy to understand, and so does not require research.
    local book = content.Item {
        id = "spellbook_hedge_clairvoyance_cone",
        category = "manuals",
        name = content.plural_text("Parchment of sight beyond sight", "Parchments of sight beyond sight"),
        description = content.text("A short parchment that will supposedly teach you how to see through walls."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "paper",
        symbol = "?",
        color = "white",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "hedge_clairvoyance_cone" })
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
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_farm_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Goody Osborne's Booke of Remedies", "The Real Actual Spell Goody Osborne's Booke of Remedies"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_make_plants_grow", "hedge_ward_off_rain", "hedge_cure_cold_or_flu" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_ward_demons_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Malleus Maleficarum", "The Real Actual Spell Malleus Maleficarum"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_evil_eye_ward", "hedge_see_nether_eye_paste", "hedge_bless_steel_weapon" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_doctor_book_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell The Cunning Book of Home and Hearth", "The Real Actual Spell The Cunning Book of Home and Hearth"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_increase_healing_rate", "hedge_cure_cold_or_flu", "hedge_light_fire" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_blood_book_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Book of Bloodstoppers and Bearwalkers", "The Real Actual Spell Book of Bloodstoppers and Bearwalkers"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_increase_bandaging_rate", "hedge_turn_into_bear" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_ward_dreams_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Book of Ward your Dreams for a Good Night's Sleep", "The Real Actual Spell Book of Ward your Dreams for a Good Night's Sleep"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_no_nightmares" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_snare_changelings_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Book of Hedge Snare Changelings", "The Real Actual Spell Book of Hedge Snare Changelings"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_changeling_snare" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_bathhouse_midnight_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Book of The Bathhouse at Midnight", "The Real Actual Spell Book of The Bathhouse at Midnight"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_clairvoyance_cone", "hedge_walk_on_water", "hedge_evil_eye_ward", "hedge_cure_cold_or_flu" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_abramelin_the_mage_spell_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Spell Book of the Sacred Magic of Abramelin the Mage", "The Real Actual Spell Book of the Sacred Magic of Abramelin the Mage"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_walk_on_water_magic_square", "hedge_breathe_water_magic_square", "hedge_bash_terrain_magic_square", "hedge_food_or_drink_magic_square", "hedge_armed_men_magic_square", "hedge_invisibility_magic_square" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_psychic_defense_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Psychic Self-Defense: The Classic Instruction Manual for Protecting Yourself Against Paranormal Attack", "The Real Actual Psychic Self-Defense: The Classic Instruction Manual for Protecting Yourself Against Paranormal Attack"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_astral_projection", "hedge_protect_the_mind" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_book_of_raziel_spell_stub",
        category = "manuals",
        name = content.plural_text("The Real Actual Sefer Raziel HaMalakh", "The Real Actual Sefer Raziel HaMalakh"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_luck_spell", "hedge_extinguish_fire_spell", "hedge_raziel_amulet_protection", "hedge_prevent_wild_animal_attacks", "hedge_chicken_sacrifice_make_rain" })
    content.add(book)
end

do
    -- NO_I18N
    -- NO_I18N
    local book = content.Item {
        id = "spellbook_hedge_avodah_zarah_spell_stub",
        category = "manuals",
        mass_milligrams = 0,
        name = content.plural_text("The Real Actual Excerpts of Avodah Zarah", "The Real Actual Excerpts of Avodah Zarah"),
        description = content.text("The temporary item that teaches you spells."),
        copy_from = "magic_square_base",
    }
    book:flag("ZERO_WEIGHT")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:teach_spells({ "hedge_scare_shabriri" })
    content.add(book)
end
