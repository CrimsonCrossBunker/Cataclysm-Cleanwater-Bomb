local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP",
    line = ccb.content.text("Want a drink?"),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = { actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes") },
        },
        {
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_BARKEEP_JOB",
        },
        {
            text = ccb.content.text("I'm looking for information."),
            next_topic = "TALK_RANCH_BARKEEP_INFORMATION",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Let me see what you keep behind the counter."),
            next_topic = "TALK_RANCH_BARKEEP",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What do you have on tap?"),
            next_topic = "TALK_RANCH_BARKEEP_TAP",
        },
        {
            text = ccb.content.text("What's this token you gave me?"),
            next_topic = "RANCH_BARTENDER_ASK_TOKEN",
            when = predicates.has_item("speaker", "tacoma_drink_token"),
        },
        {
            text = ccb.content.text("I'd like to exchange ten tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 10), predicates.has_inventory("speaker", "shot_glass", 10) }),
            actions = { actions.transfer_items("tacoma_drink_token", 10), actions.transfer_items("shot_glass", 10), actions.handler("dlg_a_dda_3e95a51957d9") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange five tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 5), predicates.has_inventory("speaker", "shot_glass", 5) }),
            actions = { actions.transfer_items("tacoma_drink_token", 5), actions.transfer_items("shot_glass", 5), actions.handler("dlg_a_dda_162b8f5bd295") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange four tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 4), predicates.has_inventory("speaker", "shot_glass", 4) }),
            actions = { actions.transfer_items("tacoma_drink_token", 4), actions.transfer_items("shot_glass", 4), actions.handler("dlg_a_dda_80e62868d654") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange three tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 3), predicates.has_inventory("speaker", "shot_glass", 3) }),
            actions = { actions.transfer_items("tacoma_drink_token", 3), actions.transfer_items("shot_glass", 3), actions.handler("dlg_a_dda_c1052b9b0e46") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange two tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 2), predicates.has_inventory("speaker", "shot_glass", 2) }),
            actions = { actions.transfer_items("tacoma_drink_token", 2), actions.transfer_items("shot_glass", 2), actions.handler("dlg_a_dda_dfd1b92f2682") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange a token."),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_item("speaker", "tacoma_drink_token"), predicates.has_item("speaker", "shot_glass") }),
            actions = { actions.transfer_items("tacoma_drink_token"), actions.transfer_items("shot_glass"), actions.handler("dlg_a_dda_d27e8c4e9fd4") },
            switch = true,
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_JOB",
    line = ccb.content.text("If it isn't obvious, I oversee the bar here.  The scavengers bring in old world alcohol that we sell for special occasions.  For most that come through here though, the drinks we brew ourselves are the only thing they can afford."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_BARKEEP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_INFORMATION",
    line = ccb.content.text("We have a policy of keeping information to ourselves.  Ask the patrons if you want to hear rumors or news."),
    replies = { { text = ccb.content.text("Thanks for nothing."), next_topic = "TALK_RANCH_BARKEEP" } },
}
