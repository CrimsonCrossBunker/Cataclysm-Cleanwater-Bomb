local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN",
    line = {
        when = predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Bartender_rewarded" } }),
        yes = ccb.content.text("Hello again.  If you have no other business with me, I'd like to talk to you about something."),
        no = {
            when = predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Doctor_rewarded" } }),
            yes = ccb.content.text("Hello again.  If you have no other business with me, I'd like to talk to you about something."),
            no = {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("Can I help you, marshal?"),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("Morning sir, how can I help you?"),
                    no = ccb.content.text("Morning ma'am, how can I help you?"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What is it?"),
            next_topic = "TALK_RANCH_FOREMAN_reward",
            when = predicates.any({ predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Bartender_rewarded" } }), predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Doctor_rewarded" } }) }),
        },
        {
            text = ccb.content.text("The merchant at the Refugee Center sent me to get a prospectus from you."),
            next_topic = "TALK_RANCH_FOREMAN_PROSPECTUS",
            when = predicates.all({ predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_3"), predicates.negate(predicates.has_effect("speaker", "has_prospectus")) }),
        },
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_FOREMAN_ANESTHETIC_FOR_DOCTOR",
            when = predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"),
        },
        {
            text = ccb.content.text("I heard you were setting up an outpost out here."),
            next_topic = "TALK_RANCH_FOREMAN_OUTPOST",
        },
        {
            text = ccb.content.text("What's your job here?"),
            next_topic = "TALK_RANCH_FOREMAN_JOB",
        },
        {
            text = ccb.content.text("What do you need done?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I figured you might be looking for some help…"),
            next_topic = "TALK_RANCH_FOREMAN",
            actions = { actions.handler("dlg_a_dda_057883a7b153") },
        },
        {
            text = ccb.content.text("Hey, are you looking for workers here?  I know a couple people back at the refugee center that might be willing to come."),
            next_topic = "TALK_RANCH_FOREMAN_Nunez",
            when = predicates.all({ predicates.has_mission("MISSION_TACOMA_Nunez"), predicates.any_equal({ "phase_1", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }) }),
            actions = { actions.handler("dlg_a_dda_18ae4cdcf60d") },
        },
        {
            text = ccb.content.text("Hey, are you looking for workers here?"),
            next_topic = "TALK_RANCH_FOREMAN_Nunez_Clue",
            when = predicates.negate(predicates.any_equal({ "phase_1", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } })),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_PROSPECTUS",
    line = ccb.content.gendered_line("I was starting to wonder if they were really interested in the project or were just trying to get rid of me.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_RANCH_FOREMAN",
            actions = { actions.handler("dlg_a_dda_0d12bbe84a7a"), actions.add_effect("speaker", "has_prospectus", { permanent = true }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_ANESTHETIC_FOR_DOCTOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }),
            yes = ccb.content.text("I'm afraid I don't have anything to offer."),
            no = ccb.content.text("I don't have anything to offer, but maybe the scrappers could help find some materials."),
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }),
            yes = ccb.content.text("I don't have anything to offer, but maybe the scavenger boss could help find some materials."),
            no = ccb.content.text("I don't have anything to offer, but you could talk to the scavenger boss and the scrappers; They might be able to help."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_RANCH_FOREMAN",
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } })) }),
        },
        {
            text = ccb.content.text("Thanks anyway."),
            next_topic = "TALK_RANCH_FOREMAN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
