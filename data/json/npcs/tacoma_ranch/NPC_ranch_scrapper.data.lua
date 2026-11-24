local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_scrapper_1",
    suffix = ccb.content.text("Scrapper"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_SCRAPPER",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER",
    line = ccb.content.text("Don't mind me."),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_SCRAPPER_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.has_mission("MISSION_RANCH_SCRAPPER_TOOLS_FOR_SCRAP")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } })) }),
        },
        {
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_SCRAPPER_JOB",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_RANCH_SCRAPPER_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER_JOB",
    line = ccb.content.text("I chop up useless vehicles for spare parts and raw materials.  If we can't use a vehicle immediately, we haul it into the ring we are building to surround the outpost.  It provides a measure of defense in the event that we get attacked."),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_RANCH_SCRAPPER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER_HIRE",
    line = ccb.content.text("I don't personally, the teams we send out to recover the vehicles usually need a hand, but can be hard to catch since they spend most of their time outside the outpost."),
    replies = { { text = ccb.content.text("OK."), next_topic = "TALK_RANCH_SCRAPPER" } },
}

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
