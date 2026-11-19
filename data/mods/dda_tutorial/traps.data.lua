local ccb = require("ccb")

-- Should be an abstract but traps don't support abstracts rn
ccb.content.define_trap {
    id = "tr_tutorial",
    name = ccb.content.text_without_extraction("tutorial message"),
    color = "white",
    symbol = "x",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    always_invisible = true,
    flags = { "UNDODGEABLE", "AVATAR_ONLY" },
    action = "none",
}

for _, index in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15 }) do
    ccb.content.define_trap {
        id = "tr_tutorial_" .. index,
        copy_from = "tr_tutorial",
        action = "none",
        trigger_handler = "tutorial_lesson",
    }
end

ccb.content.define_trap {
    id = "tr_tutorial_13",
    copy_from = "tr_tutorial",
    action = "none",
}
