local content = require("ccb").content

do
    local book = content.Item {
        id = "book_newage_generic",
        name = content.plural_text("new-age book", "new-age books"),
        description = content.text("A mishmash of self-contradictory advice on spirits, auras, chakras, crystals, and psychic powers."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_inpsychic",
        name = content.plural_text("Your Inner Psychic", "copies of Your Inner Psychic"),
        description = content.text("Could you secretly have psychic powers?  Learn to see auras, attune to your chakras, and get down and dirty with your astral self."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_healcrystals",
        name = content.plural_text("The Healing Power of Crystals", "copies of The Healing Power of Crystals"),
        description = content.text("Why waste time with 'doctors' or 'medicine'?  This guide will teach you to harness the innate healing power of crystals and nurture your soul."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_oilsecrets",
        name = content.plural_text("Essential Secrets", "copies of Essential Secrets"),
        description = content.text("The secret to happiness is simple: aromatherapy.  Surround yourself with products from our line of essential oils, using the discount code HAPPY for 10 percent off your first purchase, and you too can have it all."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_witchcraftbeg",
        name = content.plural_text("Witchcraft for Beginners", "copies of Witchcraft for Beginners"),
        description = content.text("This book starts with a spell for self-confidence (hang some lavender above your bathroom mirror), and works its way up to a hex for an ex (slash their tires)."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_witchcraftadv",
        name = content.plural_text("Advanced Witchcraft", "copies of Advanced Witchcraft"),
        description = content.text("This book apparently contains instructions for summoning and battling powerful spirits from other realms.  It doesn't say anything about zombies, though."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_beyondveil",
        name = content.plural_text("Beyond The Veil", "copies of Beyond The Veil"),
        description = content.text("What happens beyond death might be a mystery to the unlearned, but with careful use of a crystal ball, available for purchase on our website, you too can see beyond the veil."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_weapcrys",
        name = content.plural_text("Weaponizing Crystals", "copies of Weaponizing Crystals"),
        description = content.text("While this book claims crystals can be used to cast offensive spells, you suspect it might be more effective to just throw them."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_newage_aliens",
        name = content.plural_text("Ancient Alien Secrets", "copies of Ancient Alien Secrets"),
        description = content.text("Who made the Bermuda Triangle?  How did they build Stonehenge?  What did the alien king whisper in Cleopatra's ear that passionate night in the dunes?  These answers and more in the Alien Theorists' latest exposé."),
        copy_from = "book_pulp_newage_tpl",
    }
    content.add(book)
end
