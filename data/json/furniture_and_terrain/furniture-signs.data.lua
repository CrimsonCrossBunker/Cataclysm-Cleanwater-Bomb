local ccb = require("ccb")

-- 36x36 inch aluminum sign on 7 feet U-channel post (post weight is 3 pound per foot, but we don't really have any sort of beams, so pipe is used instead), mounted using 2 bolts
ccb.content.define_furniture {
    id = "f_sign_stop",
    name = ccb.content.text("stop sign"),
    symbol = "P",
    description = ccb.content.text("An octagonal red sign on a long metal pole, marked with the word STOP."),
    color = "red",
    builtin_examine = "sign",
    move_cost_mod = 1,
    coverage = 10,
    rotates_to = "PAVEMENT",
    required_strength = -1,
    flags = { "TRANSPARENT", "NO_SELF_CONNECT" },
    deconstruct = {
        drops = {
            { item = "sheet_aluminum", count = 2 },
            { item = "pipe", count = 4 },
            { item = "nuts_bolts", count = 2 },
        },
    },
    bash = {
        minimum_strength = 10,
        maximum_strength = 20,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
    },
}
