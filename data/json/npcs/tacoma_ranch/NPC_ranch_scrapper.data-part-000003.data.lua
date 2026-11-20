local ccb = require("ccb")

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
