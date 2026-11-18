local ccb = require("ccb")
local content = ccb.content

do
    -- book data is used so item can work as book and provide recipes
    local book = content.Item {
        id = "bag_durasack_cement",
        name = ccb.content.plural_text("durable plastic sack, cement", "durable plastic sack, cements"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A large and sturdy sack, made out of woven polypropylene.  Stores cement and has instructions on how to use it to make mortar."),
        copy_from = "bag_durasack",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end
