local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RESCUED_1",
    line = {
        choices = {
            ccb.content.text("I've been listening to those things eat the others they've brought back to here."),
            ccb.content.text("Please, help me."),
            ccb.content.text("Can you get me out of this spider pit?"),
            ccb.content.text("Who are you?  Are you real?"),
            ccb.content.text("Can you please save me?  I have to get out of here."),
            ccb.content.text("Hallelujah, rescue!"),
            ccb.content.text("I can't believe my eyes.  Thank you, thank you!"),
            ccb.content.text("You're… you're actually real!"),
            ccb.content.text("I hate spiders!"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's get out of here before more spiders show up."),
            next_topic = "TALK_DONE",
            actions = { "follow" },
        },
        {
            text = ccb.content.text("I don't need another mouth to feed.  Get out of my sight."),
            next_topic = "TALK_DONE",
            actions = { "flee" },
        },
        {
            text = ccb.content.text("[Investigation 2] Are you feeling ok after all of this?  I can see some of your wounds."),
            next_topic = "TALK_RESCUED_INFESTED",
            when = predicates.handler("dlg_p_xedra_evolved_39c0e8670625"),
            actions = { actions.set_actor_value("speaker", "knowledge_reproduction_u_knows_goblinspider_eggs", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RESCUED_INFESTED",
    line = ccb.content.text("They bit me and when I woke up I had wounds that feel like they have something under them.  You don't think they could have put something in me, do you?"),
    replies = {
        {
            text = ccb.content.text("I'm going to bring you a bottle of antiparasitics.  Let's do ten to make sure."),
            next_topic = "TALK_RESCUED_1",
            when = predicates.negate(predicates.any({ predicates.has_mission("BRING_INFESTED_ANTIPARASITICS"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_antiparasitic" } }) })),
            actions = { actions.assign_mission("BRING_INFESTED_ANTIPARASITICS") },
        },
        {
            text = ccb.content.text("I've brought the antiparasitic for you.  Do you want it?"),
            next_topic = "TALK_RESCUED_1",
            when = predicates.all({ predicates.has_inventory("speaker", "antiparasitic", 10), predicates.has_mission("BRING_INFESTED_ANTIPARASITICS") }),
            actions = { actions.transfer_items("antiparasitic", 10), actions.handler("dlg_a_xedra_evolved_5e49603d16bc"), actions.finish_mission("BRING_INFESTED_ANTIPARASITICS", { success = true }) },
        },
    },
}

ccb.content.define_mission {
    id = "BRING_INFESTED_ANTIPARASITICS",
    name = ccb.content.text("Bring 10 antiparasitic pills to %s"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("If you think those things put something inside of me we need to get me medicine asap!"),
        offer = ccb.content.text("Please bring me some antiparasitic drugs, I don't want anything hatching out of ME!"),
        accepted = ccb.content.text("Thank you!"),
        rejected = ccb.content.text("Hopefully nothing is wrong with me"),
        advice = ccb.content.text("You've managed to terrify me."),
        inquire = ccb.content.text("Every itch leaves me with a panic attack now"),
        success = ccb.content.text("Thank you so very much I hope this works!"),
        success_lie = ccb.content.text("You're telling me you brought it but you aren't giving them to me."),
        failure = ccb.content.text("Please try harder and get me some medicine, I don't know how long I've got!"),
    },
    finish = { handler = "mark_mission_completed_antiparasitic" },
}
