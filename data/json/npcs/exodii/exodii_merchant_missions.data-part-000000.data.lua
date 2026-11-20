local ccb = require("ccb")

ccb.content.define_mission {
    id = "RUBIK_ANUS_FETICK",
    name = ccb.content.text("Bring 1000 units of anesthetic to Rubik"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("If'n us'll to add the metal an' plastic for ye, us'll need a thousand unit o' them anus-feticks, half for your thinkin'-meat an' half for our stock."),
        offer = ccb.content.text("If'n us'll to add the metal an' plastic for ye, us'll need a thousand unit o' them anus-feticks, half for your thinkin'-meat an' half for our stock."),
        accepted = ccb.content.text("King's own luck!"),
        rejected = ccb.content.text("That be a choice an' you can tass.  Come back to this'n if you like."),
        advice = ccb.content.text("Check round the chirurgery an' such, I'd razz."),
        inquire = ccb.content.text("Us'n waits patient-like for that anus-fetick."),
        success = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        success_lie = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
    finish = { handler = "mark_mission_completed_anusfetick" },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_CONTACT_HUB",
    name = ccb.content.text("Investigate the Mysterious Bunker"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "robofachq_surface_entrance",
    start = {
        target = {
            terrain = "robofachq_surface_entrance",
            special = "hub_01",
            reveal_radius = 1,
            random = false,
        },
    },
    finish = { handler = "mark_mission_completed_u_scouted_bunker" },
    difficulty = 2,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("What've ye scolted, then, o'the clunker?"),
        success = ccb.content.text("Aye and fine!  One for the paper-claim an' so.  An I'm ken, these'n's could be a right thorn.  For ol' Rubik's sake, let's hope they be'n't for to drive us out o' your otherlands."),
        success_lie = ccb.content.text("Hm.  The escoltin' our way be less.  This'n'll yark at the Scythy mayhaps."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_CHOP_SHOP",
    name = ccb.content.text("Recover the Missing Exodii"),
    description = ccb.content.text("Rubik believes a missing Exodii scout is being kept hostage, or worse, has been killed, by members of Hub 01.  Rubik says the scout will look a bit like him: a mostly-metal cyborg, but with a recognizable red frame.  I either need to rescue the Exodii, or bring back a piece of their \"body\" as proof that they have perished."),
    goal = "MGOAL_NULL",
    destination = "robofac_strip_mall_x1y0",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "robofac_strip_mall_x1y0",
            special = "robofac_strip_mall",
            reveal_radius = 4,
            random = false,
        },
    },
    finish = { handler = "mark_mission_completed_exodii_mission_chop_shop" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
