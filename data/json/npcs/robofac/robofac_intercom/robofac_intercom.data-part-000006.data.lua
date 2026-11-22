local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_4",
    line = ccb.content.text("Exodii?  What can you tell us about them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes"), actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf") } },
    },
    replies = {
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(4), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
    line = ccb.content.text("Interesting, interesting, interesting.  Hm.  I'll note that information.  Now, about that dangerous task."),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        {
            text = ccb.content.text("Risk my neck for the privilege of trading with you?  Maybe another time."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 7776000 }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_WHO_SENT_YOU",
    line = ccb.content.text("&\"We are listening…\"\n\nYou detect a slight elevation in their voice, with a start you realize they are nervous."),
    replies = {
        {
            text = ccb.content.text("Actually I was just joking.  Our meeting is indeed a fortunate accident but now that I have your attention would you be interested in trading in some goods?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 80 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("Some mercenaries I met mentioned this place, said it's a good place to find some work and possibly some valuable post-apocalyptic gear."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 90 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("You guys aren't as slick as you think.  You think no one's gonna notice a pristine looking meteorological station in the middle of nowhere with not a potted plant out of place?"),
            next_topic = "TALK_ROBOFAC_EXODII_EXISTENCE",
        },
    },
}
