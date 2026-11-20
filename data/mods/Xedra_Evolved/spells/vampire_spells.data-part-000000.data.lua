local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xe_vampire_blood_powers",
    energy_source = { source = "VITAMIN", vitamin = "human_blood_vitamin", color = "c_red" },
    cannot_cast_flags = { "NO_VAMPIRE_BLOOD_POWERS" },
    cannot_cast_message = ccb.content.text("Your blood will not respond to you!"),
    failure_cost_fraction = 0.75,
    max_book_level = 0,
}
