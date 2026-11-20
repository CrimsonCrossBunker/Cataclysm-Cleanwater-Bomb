local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_OLWEN_2",
    name = ccb.content.text("Radio-active"),
    description = ccb.content.text("Get six antennae for Olwen Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "antenna",
    item_count = 6,
    difficulty = 4,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            { item = "icon", count = 6 },
            ccb.content.dialogue_actions.update_map("olwen_radio_adapter", "godco_1_2"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_mission_godco_has_radio", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get six antennae."),
        offer = ccb.content.text("Corrie and I have been working on a way to get in touch with anyone who's still out there, and we've started rigging up an internet-to-radio broadcast.  The only thing we need are antennae, six of them specifically."),
        accepted = ccb.content.text("This could give us a prosperous future, <name_g>."),
        rejected = ccb.content.text("We've got to see how many people are out there."),
        advice = ccb.content.text("A radio tower should have some lying around in storage."),
        inquire = ccb.content.text("Have you found the antennae?"),
        success = ccb.content.text("Now we can get in touch with a lot more people, see what's out there.  Thank you, <name_g>."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
