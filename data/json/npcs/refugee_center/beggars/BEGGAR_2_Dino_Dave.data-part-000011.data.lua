local ccb = require("ccb")

-- todo2: migrate u refugee happiness to global
ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_PERMISSION",
    name = ccb.content.text("Talk to Smokes about finding Dave a place to call home."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_CONDITION",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have it, I have it all, but I can't find a place to put it.  Will you ask the masters?  Maybe?  I've tried but they ignore me."),
        offer = ccb.content.text("I have it, I have it all, but I can't find a place to put it.  Will you ask the masters?  Maybe?  I've tried but they ignore me.  I just need a place to put it all, a place I can be safe, and not make anyone upset."),
        accepted = ccb.content.text("Thank you!  I'm sorry, I thought we were done, but we can do this!"),
        rejected = ccb.content.text("Oh man, but we're so close!"),
        advice = ccb.content.text("Maybe somewhere they can't see me?  Where I can just be me?"),
        inquire = ccb.content.text("Did you ask the masters?"),
        success = ccb.content.text("The roof!  So high!  So lofty!  Come see me there, my friend.  I will not disappoint you."),
        success_lie = ccb.content.text("I don't understand."),
        failure = ccb.content.text("No!  Oh god, no, this can't be happening…"),
    },
    finish = {
        actions = {
            { handler = "advance_world_dave_castle_stage_by_1" },
            { handler = "advance_counter_refugee_center_refugee_happiness_by_1" },
            ccb.content.dialogue_actions.update_map("refcenter_unlock_roofstairs", "evac_center_13"),
            ccb.content.dialogue_actions.update_map("beggar_2_remove_lobbycardboard", "evac_center_18"),
        },
    },
    complete_when = "complete_mission_beggar_2_permission",
}
