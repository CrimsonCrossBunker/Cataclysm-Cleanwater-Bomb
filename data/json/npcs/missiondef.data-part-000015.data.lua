local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RECRUIT_TRACKER",
    name = ccb.content.text("Recruit Tracker"),
    description = ccb.content.text("Go to the cabin in the woods where the Tracker is camping and <color_yellow>recruit them</color>."),
    goal = "MGOAL_RECRUIT_NPC",
    difficulty = 5,
    value = 70000,
    start = {
        target = { terrain = "cabin", special = "Cabin", reveal_radius = 2 },
        map_updates = {
            { layout = { npc_placements = { { id = "tracker_gunslinger", x = 11, y = 11, target = true } } } },
        },
        native_actions = { "follow" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("You seem to know this new world better than most…"),
        offer = ccb.content.text("We've got another problem to deal with but I don't think we can handle it on our own.  So, I sent word out and found us a volunteer… of sorts.  He's vain as hell but has a little skill with firearms.  He was supposed to collect whatever he had of value and is going to meet us at a cabin in the woods.  Wasn't sure how long we were going to be so I told him to just camp there until we picked him up."),
        accepted = ccb.content.text("Roger, if he's a no-show then any other gunslinger will do… but I doubt he'll quit before we even begin."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either… but then I remember that most of us survivors won't make it unless someone decides to take the initiative."),
        advice = ccb.content.text("I hope the bastard is packing heat… else we'll need to grab him a gun before we hit our next target."),
        inquire = ccb.content.text("Found a gunslinger?"),
        success = ccb.content.text("Great, just let me know when you are ready to wade knee-deep in an ocean of blood."),
        success_lie = ccb.content.text("I don't think so…"),
        failure = ccb.content.text("Quitting already?"),
    },
}
