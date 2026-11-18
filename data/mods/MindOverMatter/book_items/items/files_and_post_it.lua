local ccb = require("ccb")
local content = ccb.content

do
    -- Book is so it can be scanned in
    local book = content.Item {
        id = "lab_file_shadow_urge_password",
        name = ccb.content.plural_text("SHADOW URGE access codes", "copies of SHADOW URGE access codes"),
        category = "books",
        description = ccb.content.text("A series of scribbled-down alphanumeric codes, each of them at least sixteen characters long, as well as some notes about the usage of something referred to as the \"SHADOW URGE process.\"  There's no way you'd be able to memorize all of these without having this as a reference, which is presumably why it exists.  Someone would have gotten in a lot of trouble for writing this down and then leaving it lying around, but they're probably dead by now anyway."),
        mass_milligrams = 15000,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
        melee_to_hit = -3,
    }
    book:material("paper", 1)
    book:clear_flags()
    book:flag("TRADER_AVOID")
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
