local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    line = ccb.content.gendered_line("*eyes you up and down with a nervous smile.  \"I almost didn't expect you to show up.\"  He hesitates, letting out a soft laugh.  \"That sounds bad.  I just mean, I can't really believe we're doing this.  Thank you… for doing this.  You ready to get Uncle Barry?\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("You got it, let's go!"),
            native_actions = { "follow_only" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Not yet, just give me a minute."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    line = {
        when = predicates.handler("w16b_p_dda_a3b7bae96d63"),
        yes = {
            choices = {
                ccb.content.gendered_line("Barry!  Oh my god, you found him!", { "speaker" }),
                ccb.content.text("Barry!  You're okay!"),
                ccb.content.text("Oh god, oh thank god.  Let's get Barry out of here."),
            },
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_barry_following" } }),
            yes = {
                choices = {
                    ccb.content.gendered_line("Barry!  Oh my god, you found him!", { "speaker" }),
                    ccb.content.text("Barry!  You're okay!"),
                    ccb.content.text("Oh god, oh thank god.  Let's get Barry out of here."),
                },
            },
            no = {
                choices = {
                    ccb.content.text("What's up?  Change of plans?"),
                    ccb.content.text("Everything OK?"),
                    ccb.content.text("Not really a good time for a chat."),
                    ccb.content.text("I can't believe this is happening."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("We've got him, let's get out of here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_e2c5118024d8"),
            actions = { actions.clear_actor_value("speaker", "general_meeting_barry_following"), actions.set_actor_value("speaker", "u_saved_barry_isherwood", "yes"), actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1", { success = true }), actions.update_map("isherwood_rescue_remove_npcs", "isherwood_barry_rescue_field"), actions.handler("w16b_a_dda_bf57c07d7299") },
        },
        {
            text = ccb.content.text("Right.  Let's do this."),
            next_topic = "TALK_DONE",
        },
    },
}
