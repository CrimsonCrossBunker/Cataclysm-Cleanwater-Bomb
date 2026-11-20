local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_BLACK_BOX_TRANSCRIPT",
    name = ccb.content.text("Retrieve Black Box Transcript"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "black_box_transcript",
    start = {
        target = {
            terrain = "microlab_generic_surface",
            special = "4x4_microlab_surface",
            reveal_radius = 3,
            random = true,
            z = 0,
        },
        item_rewards = { { item = "black_box" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_EXPLORE_SARCOPHAGUS",
    dialogue = {
        describe = ccb.content.text("With the black box in hand, we need to find a lab."),
        offer = ccb.content.text("Thanks to your searching we've got the black box but now we need to have a look inside her.  Now, most buildings don't have power anymore but there are a few that might be of use.  Have you ever seen one of those science labs that have popped up in the middle of nowhere?  Them suckers have a glowing terminal out front so I know they have power somewhere inside 'em.  If you can get inside and find a computer lab that still works you ought to be able to find out what's in the black box."),
        accepted = ccb.content.text("Fuck yeah, America!"),
        rejected = ccb.content.text("Do you have any better ideas?"),
        advice = ccb.content.text("When I was playin' with the terminal for the one I ran into it kept asking for an ID card.  Finding one would be the first order of business."),
        inquire = ccb.content.text("How 'bout that black box?"),
        success = ccb.content.text("America, fuck yeah!  I was in the guard a few years back so I'm confident I can make heads-or-tails of these transmissions."),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, I maybe we can find an egg-head to crack the terminal."),
    },
}
