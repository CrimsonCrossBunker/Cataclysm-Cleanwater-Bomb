local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_prepper_1_SHELTER",
    name = ccb.content.text("Check out that LMOE shelter"),
    description = ccb.content.text("Maybe there's something left in that LMOE shelter you heard about."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { special = "Locked LMOE Shelter", terrain = "lmoe", reveal_radius = 3 } },
    finish = {
        actions = {
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You approach the LMOE and do as you were told, prying back a thin piece of metal atop the doorframe, revealing an opening.  You reach inside and grab a handle attached to a wire, pull hard on it, and hear a heavy metal *clunk*.  The door is open."), "good"),
            ccb.content.dialogue_actions.update_map("LMOE_unlock_door", "lmoe"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_BGSS_prepper_1_finished_quest", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Any luck finding the LMOE shelter?"),
        success = ccb.content.text("Damn, can't believe we finally made it.  I was smart enough not to store anything that might rot, so as long as nobody else already broke in, I bet there's at least two weeks of good food just sitting there.  Pristine workshop down there, too.  It cost me a pretty penny to get built.  I could tell you all about it sometime if you ever wanted.  Anyway, thanks for helping me get back here.  It sure ain't safe to travel on your own anymore."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("Not that surprising."),
    },
}
