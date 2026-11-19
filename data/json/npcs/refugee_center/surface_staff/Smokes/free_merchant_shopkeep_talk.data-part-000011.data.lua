local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants",
    line = {
        when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
        yes = ccb.content.text("Well, from taking a look at you, I can only guess what these Exodii are all about.  But trade's trade, so tell me more."),
        no = ccb.content.text("Exodii?  Tell me more."),
    },
    replies = {
        {
            text = ccb.content.text("[Boot up the Exodii TV-radio] Maybe it's best if their representative does the talking.  We'll call them on this screen.  They sort of speak English, and I can try and translate back and forth."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations",
        },
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours.  And they're very interested in trade."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            actions = { actions.adjust_faction_trust(1) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(2) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(3) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion - they use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(4) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(5) },
        },
    },
}
