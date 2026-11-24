local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Random NPC, can direct you to the free merchants and nearest FEMA camp.
ccb.content.define_npc {
    id = "NC_caravan_refugee_A",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_REFUGEE_A1",
    faction = "wasteland_scavengers",
}

-- Random NPC, can be recruited away.
ccb.content.define_npc {
    id = "NC_caravan_refugee_B",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_CARAVAN_REFUGEE_B1",
    faction = "wasteland_scavengers",
}

-- Random NPC, demands heroin and can accept.
ccb.content.define_npc {
    id = "NC_caravan_refugee_C",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_REFUGEE_C1",
    faction = "wasteland_scavengers",
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A2",
    line = ccb.content.gendered_line("You again.  Any good news?  Haven't heard any in a long time.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_Story",
        },
        { text = ccb.content.text("No, I don't have any."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A1_Job",
    line = ccb.content.text("We're just trying to find a safe place right now.  I think there's a FEMA camp nearby that should have room for us."),
    replies = {
        {
            text = ccb.content.text("That's it?  What's your story?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_Story",
        },
        {
            text = ccb.content.text("Good luck with that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEES_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The refugee nods along"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.text(", then frowns.  \"Nope, not ringing any bells, sorry.\""),
            no = ccb.content.gendered_line(", looking thoughtful.  \"Maybe, yeah.  I saw a weird building sort of like that a while back, but we were on the move and couldn't stop to check it out.\"", { "interlocutor" }),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_Story",
    line = ccb.content.text("We were at the same little evacuation hut, but it was all messed up, just used condoms and broken bottles and lipstick writing on the walls.  We found another group of refugees like us on the road, but they had all been killed, all ripped up, blood everywhere.  We took their food and made it all the way to a big refugee center, but somebody there with a gun told us there was no room, so we're going to a FEMA camp.  They should have more room and supplies.  No guarantees, but it's a chance."),
    replies = {
        {
            text = ccb.content.text("Can you give me directions to that FEMA camp?  I want to go there too if it's so great."),
            next_topic = "TALK_CARAVAN_REFUGEE_A_FEMA",
        },
        {
            text = ccb.content.text("I haven't been to any refugee center.  Can you tell me where it is?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_CENTER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_FEMA",
    line = ccb.content.text("Of course, we're all in this together.  Let me mark that on your map."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_FEMA_CA") } } },
    replies = {
        {
            text = ccb.content.text("I haven't been to any refugee center.  Can you tell me where it is?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_CENTER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the information.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REACH_FEMA_CA",
    name = ccb.content.text("Reach FEMA Camp"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { target = { terrain = "fema", reveal_radius = 5, special = "FEMA Camp" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "fema",
    dialogue = {
        describe = ccb.content.text("Things must be better at the camp…"),
        offer = ccb.content.text("We're all in this together, looking forward to meeting you there."),
        accepted = ccb.content.text("Everything is going to be all right."),
        rejected = ccb.content.text("No worries friend, good luck to you."),
        advice = ccb.content.text("The hard part is getting there."),
        inquire = ccb.content.text("Any progress on getting to the camp?"),
        success = ccb.content.text("Well, success I guess."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Such a disappointment…"),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_CENTER",
    line = ccb.content.text("Here, I'll mark it on your map.  I wouldn't bet they'll treat you any differently than us though.  You might try and bring something to trade, they like that."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Can you give me directions to where you're going too?  I love cartography."),
            next_topic = "TALK_CARAVAN_REFUGEE_A_FEMA",
        },
        {
            text = ccb.content.text("Thanks for the information.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1",
    line = ccb.content.text("Looking good there.  I like your whole setup.  What's your story?"),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_REFUGEE_B2") } } },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Job",
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B2",
    line = ccb.content.text("Nice.  Good to see you again.  What do you want from me?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Job",
        },
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("Nothing, just saying hi."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Job",
    line = ccb.content.gendered_line("I'm a refugee, but don't get the wrong idea.  I've got big dreams of settling down after this and starting a big family.  I just need to find the right place and the right person.  Last couple of places didn't work out so well.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So you're not attached right now?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Attached",
        },
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("Why, where were you before?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Not interested.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Attached",
    line = ccb.content.text("No, I'm not really with them.  We just got stuck together in the same messed up evacuation place.  This one guy was really nice, but they wouldn't let us stay.  They got there first so they told us we needed to find our own place, but if we got anything they wanted they'd trade some of the stuff they have.  I tried to talk them into helping but they were so cold to me."),
    replies = {
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Yeah, I guess it's hard all over.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Join_Yes",
    line = ccb.content.text("This is the beginning of a beautiful thing.  I'm with you."),
    on_enter = { { actions = { "follow" } } },
    replies = { { text = ccb.content.text("Yes!"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Join_No",
    line = ccb.content.text("Actually, I think I'm on the right track here, but you might have some luck finding a little something something back at the Free Merchant base.  They seemed pretty desperate."),
    replies = {
        {
            text = ccb.content.text("Of course.  How do I get there?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        { text = ccb.content.text("Yes.  I'll be on my way then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Directions",
    line = ccb.content.text("Sure, I can mark it on your map if you like.  Here."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for the tip!  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for the tip!  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_C1",
    line = ccb.content.text("Hey man.  Do you have any heroin?  I'm in a bit of a bind."),
    replies = {
        {
            text = ccb.content.text("Oh, uh, sorry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Never, that heroin is for me and me alone."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "heroin"),
        },
        {
            text = ccb.content.text("I think you might need it even more than me.  Here you go."),
            next_topic = "TALK_CARAVAN_REFUGEE_C_LOVE",
            when = predicates.has_item("speaker", "heroin"),
            actions = { actions.transfer_items("heroin") },
            opinion = { trust = 2, value = 2 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_C_LOVE",
    line = ccb.content.text("I love you."),
    replies = {
        { text = ccb.content.text("Oh, uh, thanks.  I guess."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("No thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A1",
    line = ccb.content.text("Please don't hurt us, we're just trying to get to safety."),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_CARAVAN_REFUGEE_A2") } },
    },
    replies = {
        {
            text = ccb.content.text("What's your situation here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A1_Job",
        },
        {
            text = ccb.content.text("I don't mean any harm.  I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_CARAVAN_REFUGEES_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("I don't have time for zombie bait like you."),
            next_topic = "TALK_DONE",
        },
    },
}
