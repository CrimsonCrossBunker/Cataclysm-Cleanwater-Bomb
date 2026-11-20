local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_TEXT",
    name = ccb.content.text("Find a gunsmithing textbook"),
    description = ccb.content.text("Find a gunsmithing textbook for Jenny.  <color_yellow>A book with 'Gunsmithing' and/or 'Firearm Design' in its name</color> will do."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "text_gunsmith",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I hate to admit it, but my first few tests haven't gone well.  I think I know what's wrong, but I need more information."),
        offer = ccb.content.text("I need a good quality reference book on gunsmithing.  This isn't my area of expertise, and I don't want to blow anybody up."),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("This is a bit of a tricky one.  A college library would be a good start, and I imagine maybe military bases have that kind of thing?  I'm not entirely sure."),
        inquire = ccb.content.text("Any luck looking for that gunsmithing text?"),
        success = ccb.content.text("Oh yeah.  Ooooh yeah.  Now we're cookin' with gas.  Here's a bit more merch, you beautiful gofer maniac."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought.  Back to the drawing board I guess."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        actions = {
            { item = "FMCNote", count = 5 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_Jenny_mission_3", "yes"),
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "timer_flag_Jenny_project_timer" }),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_1" },
        },
    },
}
