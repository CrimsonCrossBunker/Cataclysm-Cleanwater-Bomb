local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_family",
    line = ccb.content.gendered_line("Did you find them, <name_g>?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("We did it.  All safe."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.all({ predicates.has_mission("MISSION_lighthouse_man_3"), predicates.negate(predicates.actor_state("interlocutor", "mission_complete")), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_girl" } }) }),
            actions = { "mission_success", actions.set_first_topic("TALK_lighthouse_man_1") },
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring them alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }) }),
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring your wife alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_girl" } }) }),
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring your daughter alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "mission_complete")), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }) }),
        },
        { text = ccb.content.text("Nothing, really."), next_topic = "TALK_DONE" },
    },
}
