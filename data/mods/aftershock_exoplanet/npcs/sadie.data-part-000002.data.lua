local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_injection",
    line = ccb.content.text("I hope you like it, it's one of my favorite things in the world, actually a lot of them all blended together.  It should feel really good.  Or really bad, I guess I don't know much about your body chemistry.  You're still alive, that's a really good sign!"),
    replies = {
        {
            text = ccb.content.text("Wonderful.  Please don't inject me with anything else unless I ask for it in the future."),
            actions = {
                actions.clear_actor_value("speaker", "general_injection_sadie_injection"),
                actions.set_actor_value("speaker", "general_heart_sadie_heart", "yes"),
            },
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_injection2",
    line = ccb.content.text("I'm so glad you liked it.  It really means a lot to me that we have similar body chemistry.  That's so important for all kinds of biological and emotional compatibility for example organ transplants and the reproductive act.  This shows how I feel about you, I think."),
    replies = {
        {
            text = ccb.content.text("I'm glad we get along so well Sadie."),
            actions = { "give_aid", actions.add_effect("speaker", "sadie_injection", { turns = 200000 }) },
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } }),
        yes = {
            choices = {
                ccb.content.text("Let's go explore.  There's still so much these eyes haven't seen.  Wait, are these new eyes?  Where did I put my old eyes?  Are they pretty?"),
            },
        },
        no = {
            choices = {
                ccb.content.text("I can't wait to see how wonderful the world must be.  I've heard the shrieking and moaning and cries for help and I just know it's going to be perfect if everyone out there is as sweet and loving as you and Billy."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yes, everyone left is exactly like Billy and me, or worse."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } })),
            actions = { "follow", actions.set_actor_value("speaker", "general_free_u_freed_sadie", "yes") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("They're even better.  Let's go."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } }) }),
            actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}
