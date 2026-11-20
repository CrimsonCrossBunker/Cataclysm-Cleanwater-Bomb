local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_BLACK_BOX",
    name = ccb.content.text("Retrieve Military Black Box"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "black_box",
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GET_BLACK_BOX_TRANSCRIPT",
    dialogue = {
        describe = ccb.content.text("We've got the flag, now we need to locate US forces."),
        offer = ccb.content.text("We have the flag but now we need to locate US troops to see what we can do to help.  I haven't seen any but I'm figurin' one of those choppers that were flyin' round during th' outbreak would have a good idea.  If you can get me a black box from one of the wrecks I'll look into where we might open 'er at."),
        accepted = ccb.content.text("Fuck yeah, America!"),
        rejected = ccb.content.text("Do you have any better ideas?"),
        advice = ccb.content.text("Survivors were talkin' 'bout seeing 'em falling out of the sky but I don't know where.  If I were a pilot I'd avoid crash landing in a city or forest though.  Black boxes are housed in the tail to survive the crash so check there when you do find one.  Now get to it!"),
        inquire = ccb.content.text("How 'bout that black box?"),
        success = ccb.content.text("America, fuck yeah!"),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, I'll have to find 'er myself."),
    },
}
