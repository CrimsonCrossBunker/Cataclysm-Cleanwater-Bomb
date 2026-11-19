local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM2",
    copy_from = "base_drone",
    name = ccb.content.plural_text("BM security drone", "BM security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "cyan",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "blue_maintenance_check2" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_BM2",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}
