local content = require("ccb").content

do
    local book = content.Item {
        id = "eater_book_artifact",
        name = content.plural_text("Enemy of the World", "copies of Enemy of the World"),
        description = content.text("A small Korean novel that describes the journey of an incredibly strong protagonist attempting to save the world."),
        mass_milligrams = 460000,
        volume_ml = 500,
        symbol = "[",
        color = "brown",
        looks_like = "book_newage_generic",
    }
    book:material("forged_dreamstuff", 1)
    book:clear_use_actions()
    book:teach_spells({ "spell_melee_damage" })
    book:melee_damage("bash", 1)
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
