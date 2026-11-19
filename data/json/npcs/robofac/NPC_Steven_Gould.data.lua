local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_2",
    line = ccb.content.text("I'm just paid to stand guard and watch the drones.  Talk to the boss in the pavilion if you need something."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}
