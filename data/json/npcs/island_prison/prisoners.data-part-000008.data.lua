local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_GIVES_WORK",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
        yes = ccb.content.text("So, what are you waiting for?"),
        no = ccb.content.text("I need you to retrieve some stuff from a locked safe.  Interested?"),
    },
    replies = {
        {
            text = ccb.content.text("[Show the military ID card.] You mean this stuff?"),
            next_topic = "TALK_PRISONER_LEADER_SHOW_MILITARY_ID",
            when = predicates.all({ predicates.has_item("speaker", "id_military"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("What's in the safe?"),
            next_topic = "TALK_PRISONER_LEADER_ASKED_ABOUT_SAFE_CONTENTS",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("What for do you need it?"),
            next_topic = "TALK_PRISONER_LEADER_ASKED_ABOUT_WHAT_FOR_DO_YOU_NEED_IT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Yeah, sure."),
            next_topic = "TALK_MISSION_OFFER",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })),
        },
        {
            text = ccb.content.text("I'm on my way."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }) }),
        },
    },
}
