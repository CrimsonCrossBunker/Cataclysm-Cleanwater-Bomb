local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_amalgamation_spotter",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    name = ccb.content.plural_text("vigilant amalgamation", "vigilant amalgamations"),
    description = ccb.content.text("An inflated white body carried by five dainty legs, waving its remaining two limbs constantly.  Each one is tipped by a head-sized compound eye, independently scanning the horizon for prey."),
    attacks = {
        {
            spell = { id = "create_noise", hit_self = true },
            casting_message = ccb.content.text("The amalgamation screams!"),
            cooldown = 12,
            kind = "spell",
        },
    },
    vision_day = 60,
    melee_damage = { { type = "cut", amount = 2 } },
    tracking_distance = 12,
    armor = { stab = 4, acid = 5, bullet = 12, electric = 5, bash = 10, cut = 5 },
    inheritance = { add = { flags = { "KEENNOSE", "KEEP_DISTANCE" } } },
}
