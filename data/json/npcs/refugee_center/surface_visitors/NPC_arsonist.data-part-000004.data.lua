local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    name = ccb.content.text("Supply the arsonist"),
    description = ccb.content.text("Bring the arsonist 120 units of commercial fertilizer."),
    difficulty = 1,
    value = 500,
    origins = { "ORIGIN_SECONDARY" },
    goal = "MGOAL_FIND_ITEM",
    item = "fertilizer_commercial",
    item_count = 120,
    dialogue = {
        describe = ccb.content.text("I could use some help getting some materials."),
        offer = ccb.content.text("I could use some help getting some materials.  Molotovs are nice for burning down buildings but aren't all that for keeping yourself safe.  If you could get me 120 units of commercial fertilizer I could make something a lot more potent."),
        accepted = ccb.content.text("Oh man, thanks so much friend.  You won't regret it."),
        rejected = ccb.content.text("Think it over."),
        advice = ccb.content.text("Commercial fertilizer tends to be made from ammonium nitrate, which is also usable as an explosive.  Try looking for some around the abandoned farms."),
        inquire = ccb.content.text("Did you find any fertilizer?  Are you sure this is the ammonium nitrate kind?"),
        success = ccb.content.text("This is great!  I'll get to work making something of this.  You can have some of my Molotovs, I won't need quite so many now."),
        success_lie = ccb.content.text("I guess I could convince the shelter to sell me some."),
        failure = ccb.content.text("Damn.  Perhaps I wasn't the only one who thought of this."),
    },
    finish = {
        handler = "mark_talk_flag_TALK_ARSONIST_SUPPLIED",
        item_rewards = { { item = "molotov", count = 10 } },
    },
}
