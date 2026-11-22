local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_INFO_REWARD",
    line = ccb.content.text("For your services rendered we can either offer you some riot gear armor or the USP 9x19mm pistol with compatible magazines."),
    replies = {
        {
            text = ccb.content.text("Sounds equitable to me.  Be back with that information in a jiff."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("That's too little for a whole lot of risk.  I'll pass on this."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("Deal!  Now listen close."),
            next_topic = "TALK_GIVE_ROBOFAC_EXODII_INFO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("I'll take the riot armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } }),
            actions = { actions.handler("dlg_a_dda_54d5f5b21399") },
        },
        {
            text = ccb.content.text("I'll take the USP."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } }),
            actions = { actions.handler("dlg_a_dda_1abaa1b8273b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG",
    line = {
        when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
        yes = ccb.content.text("&The intercom flicks on slower than usual.  \"You sound like <u_name>.  But you look like an Exodii.  What's happened, exactly?\""),
        no = ccb.content.text("&The intercom flicks on slower than usual.  \"You sound like <u_name>.  But you look like some sort of cyborg.  What's happened, exactly?\""),
    },
    replies = {
        {
            text = ccb.content.text("I volunteered for this.  A group of cyborgs called the Exodii sold me everything I needed to get these cool mechanical bits."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_EXODII_INFO",
            when = predicates.handler("dlg_p_dda_22c8f45ae117"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) },
        },
        {
            text = ccb.content.text("I volunteered for the Exodii to give me these implants.  Gotta do what you gotta do to survive, no?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) },
        },
        {
            text = ccb.content.text("I volunteered for the Exodii to give me these implants, but don't worry, there's still a red white and blue American in this shell, ready to serve science and humanity."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) },
        },
        {
            text = ccb.content.text("Those crazed cyborgs did this against my will!  But I managed to escape, and it's still me, in here."),
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            trial = { kind = "lie", difficulty = 30 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.adjust_faction_trust(-10), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) } },
        },
        {
            text = ccb.content.text("Not much to say, because I'm not sure.  I just woke up like this.  Crazy stuff, isn't it?"),
            trial = { kind = "lie", difficulty = 15 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.adjust_faction_trust(-10), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_EXODII_INFO",
    line = ccb.content.text("Exodii?  What can you tell us about them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes"), actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf") } },
    },
    replies = {
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension, or dimensions, really.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(4), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}
