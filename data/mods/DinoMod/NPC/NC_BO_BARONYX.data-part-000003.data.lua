local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SWAMPER_GATHER_MEAT",
    name = ccb.content.text("Gather meat for Bo Baronyx.  About 8 should do it."),
    difficulty = 1,
    value = 10000,
    goal = "MGOAL_FIND_ITEM",
    item = "meat",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_mission_NC_SWAMPER_MISSION_1", "yes"),
            ccb.content.dialogue_actions.purchase_pet("mon_eoraptor", { count = 1, name = ccb.content.text("Bamm-Bamm") }),
        },
    },
    dialogue = {
        describe = ccb.content.text("The eaters are hungry.  They need meat."),
        offer = ccb.content.text("If you wish to feed the eaters, your work will be rewarded.  Go out, butcher a pure animal.  Not a false eater, the meat must be good to eat.  Then bring me the meat and I will see to the eaters."),
        accepted = ccb.content.text("Excellent.  The eaters must feed."),
        rejected = ccb.content.text("Understood.  The great eaters will feed either way."),
        advice = ccb.content.text("Some of the animals have become touched by the pretenders in recent days, larger and more dangerous, producing tainted mutant meat.  This will not work for the great eaters, it must be the true meat."),
        inquire = ccb.content.text("Have you brought meat?"),
        success = ccb.content.text("The eaters will feed.  Oh, this one seems to like you."),
        success_lie = ccb.content.text("The eaters will feed I am sure."),
        failure = ccb.content.text("I see no meat.  There is meat in the forests and swamps waiting for the eaters."),
    },
}
