local ccb = require("ccb")

-- Generic guard for the dinomod variant of the old guard.
ccb.content.define_npc {
    id = "old_guard_red_soldier",
    suffix = ccb.content.text("Soldier"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_RED_SOLDIER",
    faction = "old_guard",
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_RED_SOLDIER",
    line = {
        choices = {
            ccb.content.text("I'm afraid I can't talk now."),
            ccb.content.text("Stay safe out there."),
            ccb.content.text("Kill all dinosaurs."),
            ccb.content.text("Welcome to whatever this is."),
            ccb.content.text("I'm supposed to direct all questions to my leadership, that's Red over there."),
        },
    },
    replies = { { text = ccb.content.text("Sure sure…"), next_topic = "TALK_DONE" } },
}
