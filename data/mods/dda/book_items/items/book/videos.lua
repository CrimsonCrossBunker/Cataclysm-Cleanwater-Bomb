local content = require("ccb").content

do
    local book = content.Item {
        id = "efile_video",
        symbol = "o",
        name = content.plural_text("abstract video", "abstract videos"),
        description = content.text("An abstract video file, implemented as a book."),
        looks_like = "story_book",
        color = "light_cyan",
        copy_from = "abstract_efile",
        abstract = true,
        electronic_size_kb = 128000,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
