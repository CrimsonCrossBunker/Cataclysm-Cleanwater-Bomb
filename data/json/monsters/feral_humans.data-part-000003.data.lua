local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_axe",
    name = ccb.content.plural_text("axe murderer", "axe murderers"),
    description = ccb.content.text("They stumble along dragging a large bloodstained axe.  Their face is twisted into a sadistic grin, and they walk among the dead as though already one of them."),
    copy_from = "mon_feral_human_pipe",
    attacks = { { id = "feral_weapon_axe" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    fungalize_into = "mon_feral_human_axe_fungal_infected",
    death = { drops = "feral_humans_death_drops_axe" },
}
