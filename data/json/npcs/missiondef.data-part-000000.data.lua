local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_EXPLORE_SARCOPHAGUS",
    name = ccb.content.text("Follow Sarcophagus Team"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 50000,
    start = {
        target = {
            terrain = "haz_sar_b_4",
            special = "Hazardous Waste Sarcophagus",
            reveal_radius = 1,
            min_distance = 60,
        },
        item_rewards = { { item = "sarcophagus_access_code" } },
        native_actions = { "follow" },
    },
    origins = { "ORIGIN_SECONDARY" },
    destination = "haz_sar_b_4",
    dialogue = {
        describe = ccb.content.text("You wouldn't believe what I found…"),
        offer = ccb.content.text("Holy hell, the crash you recovered the black box from wasn't as old as I thought.  Check this out, it was on its approach to pick up a team sent to secure and destroy something called a 'Hazardous Waste Sarcophagus' in the middle of nowhere.  If the bird never picked up the team then we may still have a chance to meet up with them.  It includes an access code for the elevator and an encoded message for the team leader, I guess.  If we want to join up with what remains of the government then now may be our only chance."),
        accepted = ccb.content.text("Fuck ya, America!"),
        rejected = ccb.content.text("Are you going to forfeit your duty when the country needs you the most?"),
        advice = ccb.content.text("If there is a military team down there then we better go in prepared if we want to impress them.  Carry as much ammo as you can and prepare to ditch this place if they have a second bird coming to pick them up."),
        inquire = ccb.content.text("Having any trouble following the map?  Remember to search underground."),
        success = ccb.content.text("Maybe these things are what remains of the team we were searching for…"),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, we were so close."),
    },
}
