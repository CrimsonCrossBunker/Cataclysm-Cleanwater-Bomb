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
