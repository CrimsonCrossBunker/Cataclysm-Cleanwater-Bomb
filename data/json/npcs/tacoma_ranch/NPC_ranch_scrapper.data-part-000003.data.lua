local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER_ANESTHETIC_FOR_DOCTOR",
    line = ccb.content.gendered_line("Hmm, let me think.  There might be a few things I could scrounge up to help, but it's going to take some time to sort through the scrap to find exactly what you need.  How about this… some of my tools are getting a bit worn and are in need of replacement.  If you could bring me a new angle grinder and a hacksaw, I should be able to find all the parts you need by the time you get back.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("An angle grinder and a hacksaw?  I'll see what I can do."),
            next_topic = "TALK_DONE",
            actions = { actions.offer_mission("MISSION_RANCH_SCRAPPER_TOOLS_FOR_SCRAP") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_SCRAPPER_TOOLS_FOR_SCRAP",
    name = ccb.content.text("Tools for Scrap"),
    description = ccb.content.text("The scrapper is willing to part with some scrap to help build an anesthetic machine in exchange for an angle grinder and a hacksaw."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_NULL",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you found the tools yet?"),
        success = ccb.content.text("These will be very useful, thanks!  I found the parts that you needed and can work with the doctor to build the equipment whenever they are ready."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
    finish = {
        handler = {
            "deliver_angle_grinder_1_items",
            "deliver_hacksaw_1_items",
            "mark_mission_tacoma_ranch_doctor_anesthetic_scrappers_helped",
        },
    },
    complete_when = "complete_mission_ranch_scrapper_tools_for_scrap",
}
