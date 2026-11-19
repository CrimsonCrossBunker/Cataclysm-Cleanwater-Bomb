local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spawn_raptor_pyro_hot_air",
    copy_from = "mon_spawn_raptor",
    looks_like = "mon_spawn_raptor",
    name = ccb.content.plural_text("heatwave flesh-raptor", "heatwave flesh-raptors"),
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet.  It looks like nothing you've seen on Earth, and yet strangely like it is made of human parts.  The air around it shimmers with heat haze."),
    upgrade = {},
    emissions = { { id = "emit_pyrokinetic_summon_heat_3", delay = "1 s" } },
}
