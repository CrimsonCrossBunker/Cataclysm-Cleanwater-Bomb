local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY2",
    name = ccb.content.text("Trophy Hunt II"),
    description = ccb.content.text("Continue the quest for trophies by finding an unhatched spider egg."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_RUSSELL_TROPHY3",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("<the_cataclysm> didn't spare us humans.  Our former selves would look at us in disgust at the things we do for survival.  At least, that's what I was told.  I heard reports of arachnids deep in the woods.  I can't exactly pinpoint where their webs are, but I'm sure you'll figure it out once you're stuck in them.  I'd like me a spider egg!"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever beast is waiting for you."),
        rejected = ccb.content.text("That's all right.  Not everyone is cut out for this."),
        advice = ccb.content.text("Don't worry <name_g>, I wouldn't send you on a suicide mission, would I?"),
        inquire = ccb.content.text("Managed to succeed, survivor?"),
        success = ccb.content.text("Nice catch!  Friend, you've proven yourself to be an extraordinary survivor.  Maybe there's still hope for humanity.  I'll take that egg, thank you very much.  Here's your reward and some bullets for your effort."),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        item_rewards = { { item = "270win_jsp", count = 8 }, { item = "icon", count = 6 } },
        handler = "deliver_mission_godco_russell_trophy2",
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    complete_when = "complete_mission_godco_russell_trophy2",
}
