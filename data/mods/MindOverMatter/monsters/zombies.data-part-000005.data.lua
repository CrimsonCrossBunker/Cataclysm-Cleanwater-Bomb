local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spawn_raptor_teleport_blink",
    copy_from = "mon_spawn_raptor",
    looks_like = "mon_spawn_raptor",
    name = ccb.content.plural_text("blinking flesh-raptor", "blinking flesh-raptors"),
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet.  It looks like nothing you've seen on Earth, and yet strangely like it is made of human parts.  Occasionally, it vanishes and reappears elsewhere."),
    upgrade = {},
    inheritance = {
        add = {
            attacks = {
                {
                    move_cost = 50,
                    allow_no_target = true,
                    maximum_range = 6,
                    message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
                    kind = "leap",
                    cooldown = { 3, 9 },
                    when = "monster_attack_psionics_available",
                },
            },
        },
    },
}
