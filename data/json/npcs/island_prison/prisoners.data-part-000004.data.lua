local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_GREET",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } }),
        yes = ccb.content.text("I have nothing more to say to you.  Get the fuck out of here."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
            yes = ccb.content.text("So, what are you waiting for?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }),
                yes = ccb.content.gendered_line("I don't know if you know, but there are sewers underneath the prison.  I was planning an escape long before <the_cataclysm>, and while I was working on cleaning the sewers, I noticed a damaged wall section.  There was a flow of fresh air coming out of it, so I think it's leading to the surface.  It could be your way to freedom.  Feel free to use it.", { "interlocutor" }),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }),
                    yes = {
                        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cannibal_talked_to_leader" } }),
                        yes = ccb.content.text("You are what you eat, as they say."),
                        no = ccb.content.text("It's you again."),
                    },
                    no = ccb.content.text("Hello there.  Haven't seen you around before.  You must be from the other wing.  Managed to survive, huh?"),
                },
            },
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_leader", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I've been through situations far worse than that."),
            next_topic = "TALK_PRISONER_LEADER_INQUIRY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("It was a nightmare, lots of <zombies>, blood everywhere!  Thank god I'm among living people again."),
            next_topic = "TALK_PRISONER_LEADER_FROWN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("[CANNIBAL] It's hard to die of hunger when there's so many tasty corpses lying around."),
            next_topic = "TALK_PRISONER_LEADER_LEARNED_ABOUT_CANNIBAL",
            when = predicates.all({ predicates.has_trait("speaker", "CANNIBAL"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cannibal_talked_to_leader" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I want to get out of this <freaking> prison.  I hoped you could help me with that."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("I'm on my way."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } }),
        },
        {
            text = ccb.content.text("I don't know if I'll take your advice, but thanks nevertheless."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Wait, what?  A <freaking> can of beans?!  I went through hell to get this <freaking> thing for you, and all you give me as reward is a <freaking> can of beans?!  I demand something more substantial."),
            next_topic = "TALK_PRISONER_LEADER_DEMANDED_SUBSTANTIAL_REWARD",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Nice talking to ya.  Farewell."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_leader" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_accepted_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_prisoner_leader_mission" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } })) }),
        },
        {
            text = ccb.content.text("Okay."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_military_id_prisoner_leader_mission" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_LEARNED_ABOUT_CANNIBAL",
    line = ccb.content.text("Huh, even so?  I'm not saying I approve your… tastes, but I definitely respect people who use all possibilities life has to offer."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cannibal_talked_to_leader", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, we share the same opinions on this matter."),
            next_topic = "TALK_NONE",
        },
    },
}
