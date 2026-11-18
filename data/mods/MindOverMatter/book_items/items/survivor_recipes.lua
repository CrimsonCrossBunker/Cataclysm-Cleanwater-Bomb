local content = require("ccb").content

do
    local book = content.Item {
        id = "recipe_survivor_matrix_crystal_ground",
        name = content.plural_text("scribbled matrix crystal notes", "scribbled matrix crystal notes"),
        description = content.text("A series of notes, musings, and marginalia about grinding up matrix crystals, refining the dust and then…mixing it with water and drinking the results?  Hopefully it won't make you go blind."),
        symbol = "ç",
        color = "blue",
        copy_from = "file",
        looks_like = "file",
    }
    book:book {
        required_level = 7,
        maximum_level = 7,
        intelligence = 11,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end
