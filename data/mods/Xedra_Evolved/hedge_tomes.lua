local ccb = require("ccb")
local content = ccb.content
local research = require("hedge_tome_activity")

do
    local item = content.Item {
        id = "spellbook_hedge_farm",
        name = ccb.content.plural_text("Goody Osborne's Booke of Remedies", "copies of Goody Osborne's Booke of Remedies"),
        description = ccb.content.text("This purports to be the 'Reale and True Acounting of the Works and Devices of Sarah Osbourne, a Most Puissant Wiche', but you're pretty sure it's all a front and it was actually written within the last couple decades.  There are some pretty detailed descriptions of rituals in here, mixed among diary entries and accounts of fanciful meetings in the woods."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_farm",
        stub = "spellbook_hedge_farm_stub",
        deciphered = "deciphered_spellbook_hedge_farm",
        time_limit = 129600,
        difficulty = 300,
        retry_difficulty = 270,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_ward_demons",
        name = ccb.content.plural_text("Malleus Maleficarum", "copies of Malleus Maleficarum"),
        description = ccb.content.text("A hardcover translation of the infamous 15th century book used as a reference work for witchcraft trials for centuries.  This translation seems to have some handwritten notes in some of the margins."),
        mass_milligrams = 721000,
        volume_ml = 791,
        price_cents = 1500,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    item:material("paper", 1)
    item:material("cardboard", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_ward_demons",
        stub = "spellbook_hedge_ward_demons_stub",
        deciphered = "deciphered_spellbook_hedge_ward_demons",
        time_limit = 252000,
        difficulty = 700,
        retry_difficulty = 630,
        failure_book = "spellbook_hedge_doctor_book",
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_doctor_book",
        name = ccb.content.plural_text("The Cunning Book of Home and Hearth", "copies of The Cunning Book of Home and Hearth"),
        description = ccb.content.text("This mass-market paperback purports to pass down the ancient traditional secrets of English cunning folk, though if that were true, they probably could have gotten more than $12.95 for it.  There are a lot of descriptions of rituals and procedures in here, though--maybe some of them deserve further investigation."),
        mass_milligrams = 537000,
        volume_ml = 930,
        price_cents = 1295,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_green",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_doctor_book",
        stub = "spellbook_hedge_doctor_book_stub",
        deciphered = "deciphered_spellbook_hedge_doctor_book",
        time_limit = 115200,
        difficulty = 270,
        retry_difficulty = 243,
        activity_completion = "deciphered_spellbook_hedge_blood_book",
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_blood_book",
        name = ccb.content.plural_text("Bloodstoppers and Bearwalkers: Folk Traditions of Michigan's Upper Peninsula", "copies of Bloodstoppers and Bearwalkers: Folk Traditions of Michigan's Upper Peninsula"),
        description = ccb.content.text("This is an anthropological collection of American folk beliefs in the Upper Peninsula of Michigan, consisting of stories, legends, descriptions of rituals, tall tales, and anything else the author heard during his period of study.  The \"Bloodstoppers\" of the title are individuals believed to be able to stop the flow of blood from a wound, with an incantation or ritual or sheer force of will, and the bearwalkers were allegedly sorcerers who could assume the shape of a bear and cause misfortune."),
        mass_milligrams = 211000,
        volume_ml = 500,
        price_cents = 5000,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_red",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_blood_book",
        stub = "spellbook_hedge_blood_book_stub",
        deciphered = "deciphered_spellbook_hedge_blood_book",
        time_limit = 162000,
        difficulty = 405,
        retry_difficulty = 365,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_ward_dreams",
        name = ccb.content.plural_text("Ward your Dreams for a Good Night's Sleep!", "copies of Ward your Dreams for a Good Night's Sleep!"),
        description = ccb.content.text("This is a very thin booklet, more of a pamphlet, about various ways to protect from nightmares.  There are quite a few techniques in here, though you're a bit skeptical about whether the author took the end of the world into their calculations."),
        mass_milligrams = 83000,
        volume_ml = 132,
        price_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_ward_dreams",
        stub = "spellbook_hedge_ward_dreams_stub",
        deciphered = "deciphered_spellbook_hedge_ward_dreams",
        time_limit = 36000,
        difficulty = 70,
        retry_difficulty = 63,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_snare_changelings",
        name = ccb.content.plural_text("Monas Hieroglyphica", "copies of Monas Hieroglyphica"),
        description = ccb.content.text("This is a thin reproduction of John Dee's Monas Hieroglyphica.  A complicated work whose meaning has long been lost without access to the occult oral tradition of it's time.  It's possible that some remnants of that oral tradition still exist today, but it is unknown if they would be able to fully interpret this spellbook."),
        mass_milligrams = 83000,
        volume_ml = 132,
        price_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_snare_changelings",
        stub = "spellbook_hedge_snare_changelings_stub",
        deciphered = "deciphered_spellbook_hedge_snare_changelings",
        time_limit = 108000,
        difficulty = 275,
        retry_difficulty = 248,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    -- divination spells are appropriate here too
    local item = content.Item {
        id = "spellbook_hedge_bathhouse_midnight",
        name = ccb.content.plural_text("The Bathhouse at Midnight: An Historical Survey of Magic and Divination in Russia", "copies of The Bathhouse at Midnight: An Historical Survey of Magic and Divination in Russia"),
        description = ccb.content.text("This encyclopediac tome by W. F. Ryan concerns a wide variety of folk magic practices in pre-modern Russia, including their social context, the way that the Church had to work against folk practices like leaving items on the altar for six weeks so they would gain protective powers, the dangers of being alone in the bathhouse, ways to find and keep a husband or wife, when to throw an axe handle over your shoulder when walking into the forest, and how the government mostly suppressed magic because magical power (real or imagined) would have been a threat to secular power.  The description of some of these rituals are extremely detailed."),
        mass_milligrams = 771000,
        volume_ml = 1357,
        looks_like = "paper",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_bathhouse_midnight",
        stub = "spellbook_hedge_bathhouse_midnight_stub",
        deciphered = "deciphered_spellbook_hedge_bathhouse_at_midnight",
        time_limit = 216000,
        difficulty = 550,
        retry_difficulty = 495,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_abramelin_the_mage",
        name = ccb.content.plural_text("The Book of the Sacred Magic of Abramelin the Mage", "copies of The Book of the Sacred Magic of Abramelin the Mage"),
        description = ccb.content.text("Translated from the French edition by Samuel L MacGregor Mathers, this tome compiles the journeys of a man named Abraham of Worms to Egypt, where he learned occult secrets from the wizard Abramelin who lived in a small town near the Nile.  The magic contained within focuses mostly on the creation of magic squares which, when used in ceremonies by an initiate, provide magical effects."),
        mass_milligrams = 539000,
        volume_ml = 674,
        looks_like = "paper",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_abramelin_the_mage",
        stub = "spellbook_hedge_abramelin_the_mage_spell_stub",
        deciphered = "deciphered_spellbook_hedge_abramelin_the_mage",
        time_limit = 302400,
        difficulty = 800,
        retry_difficulty = 720,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_psychic_defense",
        name = ccb.content.plural_text("Psychic Self-Defense: The Classic Instruction Manual for Protecting Yourself Against Paranormal Attack", "copies of Psychic Self-Defense: The Classic Instruction Manual for Protecting Yourself Against Paranormal Attack"),
        description = ccb.content.text("A very popular 20th century occult book about protecting yourself against psychic attack, haunting, vampirism (the psychic kind, not the kind with fangs), and other otherworldly phenomenon."),
        mass_milligrams = 318000,
        volume_ml = 800,
        price_cents = 2500,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_psychic_defense",
        stub = "spellbook_hedge_psychic_defense_stub",
        deciphered = "deciphered_spellbook_hedge_psychic_defense",
        time_limit = 162000,
        difficulty = 352,
        retry_difficulty = 320,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_book_of_raziel",
        name = ccb.content.plural_text("Sefer Raziel HaMalakh", "copies of Sefer Raziel HaMalakh"),
        description = ccb.content.text("The Book of Raziel the Angel, originally written in Hebrew and Aramaic but despite the title, this is an English translation.  Supposedly given to Adam the First Man by Raziel after Adam and Eve were expelled from Eden, it contains knowledge of the holy names of God, the divisions of Heaven and Hell, and the names and hierarchy of the angels and spirits."),
        mass_milligrams = 539000,
        volume_ml = 674,
        price_cents = 2500,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_book_of_raziel",
        stub = "spellbook_hedge_book_of_raziel_spell_stub",
        deciphered = "deciphered_spellbook_hedge_book_of_raziel",
        time_limit = 302400,
        difficulty = 800,
        retry_difficulty = 720,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end

do
    local item = content.Item {
        id = "spellbook_hedge_avodah_zarah",
        name = ccb.content.plural_text("Excerpts of Avodah Zarah", "copies of Excerpts of Avodah Zarah"),
        description = ccb.content.text("A partial english-translated copy of Avodah Zarah, summarizing and explaining many passages of the Talmud."),
        mass_milligrams = 450000,
        volume_ml = 562,
        price_cents = 2500,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    item:material("paper", 1)
    local study = research.register_tome {
        id = "spellbook_hedge_avodah_zarah",
        stub = "spellbook_hedge_avodah_zarah_spell_stub",
        deciphered = "deciphered_spellbook_hedge_avodah_zarah",
        time_limit = 129600,
        difficulty = 300,
        retry_difficulty = 270,
    }
    item:on_use(study, ccb.content.text("Activate"), ccb.content.text("Study the occult text."))
    content.add(item)
end
