local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_lighthouse_girl",
    unique_name = ccb.content.text("Angelina Frolova"),
    gender = "female",
    class = "NC_NONE",
    attitude = 1,
    mission = "GUARD_PATROL",
    chat = "TALK_lighthouse_girl_start",
    faction = "fisherman_family",
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_girl_start",
    line = ccb.content.text("I'm scared.  Where is my papa?"),
    on_enter = {
        { once = "met", actions = { "follow_only", actions.offer_mission("MISSION_lighthouse_girl_0") } },
    },
    replies = {
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_lighthouse_girl_start",
            when = predicates.actor_state("interlocutor", "following"),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("We're here."),
            next_topic = "TALK_lighthouse_girl_safe",
            when = predicates.handler("dlg_p_dda_f7417ddd0af4"),
            actions = { "mission_success", "clear_mission", "stop_following", actions.set_first_topic("TALK_lighthouse_girl_safe"), actions.set_actor_value("speaker", "flag_safe_lighthouse_girl", "yes") },
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_girl_safe",
    line = {
        when = predicates.has_mission("MISSION_lighthouse_man_3"),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_woman_dead" } }),
            yes = ccb.content.text("Thank you for saving me.  It's a shame my mother didn't make it… you did everything you could, and I don't blame you for it…"),
            no = ccb.content.text("Thank you!"),
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_woman_dead" } }),
            yes = ccb.content.text("Poor, poor mama…"),
            no = ccb.content.text("Hello."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi."),
            next_topic = "TALK_lighthouse_girl_1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_help_lighthouse_family_safe" } }),
            actions = { actions.set_first_topic("TALK_lighthouse_girl_1") },
            switch = true,
        },
        {
            text = ccb.content.text("I'm sorry…"),
            false_text = ccb.content.text("…"),
            text_when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_woman_dead" } }),
            next_topic = "TALK_DONE",
            switch = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_lighthouse_girl_1", "TALK_lighthouse_girl_Background" },
    line = ccb.content.text("How are you today?"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            when = predicates.assigned_missions(1, 1),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "TALK_lighthouse_girl_Background",
        },
        { text = ccb.content.text("Do you need any help?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_girl_Background",
    line = ccb.content.text("I don't have much to tell, sorry.  I'm busy with helping my mom, tiding this place to make it our new home.  You should talk to my dad, he doesn't look busy right now.  Or always…"),
}

ccb.content.define_mission {
    id = "MISSION_lighthouse_girl_0",
    generic_rewards = false,
    name = ccb.content.text("Protect fisherman's daughter"),
    description = ccb.content.text("She looks like a nice girl.  Maybe you should not let her die?"),
    goal = "MGOAL_CONDITION",
    difficulty = 0,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("-"),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
    failure = { handler = "mark_flag_death_lighthouse_girl_dead" },
}
