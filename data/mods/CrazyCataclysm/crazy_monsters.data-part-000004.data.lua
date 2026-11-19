local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_infected",
    name = ccb.content.plural_text("party rocker", "party rockers"),
    copy_from = "mon_feral_human_pipe_fungal_infected",
    description = ccb.content.text("A party rocker who's not dancing with as much energy, and they seem to be stopping often to cough and catch their breath."),
    death = { drops = "party_rocker_death_drop_pipe" },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_corpse",
    name = ccb.content.plural_text("party rocker", "party rockers"),
    copy_from = "mon_feral_human_pipe_fungal_corpse",
    description = ccb.content.text("A party rocker who's grown painful mushroom stalks out of their body, writhing in pain as their last neurons still instruct them to dance."),
    death = { drops = "party_rocker_death_drop_pipe" },
}
