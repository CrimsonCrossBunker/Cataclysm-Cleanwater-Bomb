local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup",
    line = ccb.content.text("Hmm.\"  Smokes looks thoughtful, rubbing his chin.  \"Well, most of the people downstairs aren't willing to come up for things like that, and a lot of folks that are up here have a lot of bad memories from that.  You could try asking around some of the people we have upstairs, but it'll be tough.  If you have some merch you could spare, though, I could get some people off guard duty and into your little crew for some hazard pay.  You might also have luck asking the Old Guard rep in the southwest bay, near the library - I hear they've got some volunteers lately."),
    replies = {
        {
            text = ccb.content.text("[5 merch] Five merch for someone sounds fair to me."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup1",
            when = predicates.has_inventory("speaker", "FMCNote", 5),
            actions = { actions.handler("dlg_a_dda_1771a2e9be11"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_0a12ed09c118") },
        },
        {
            text = ccb.content.text("[10 merch] How about ten merch to do it?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup2",
            when = predicates.has_inventory("speaker", "FMCNote", 10),
            actions = { actions.handler("dlg_a_dda_b041becec6c3"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_73da091850f1") },
        },
        {
            text = ccb.content.text("Thanks for the advice.  Maybe I'll come back with some more merch."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup1",
    line = ccb.content.text("That's enough to get someone off guard duty, yeah.  Hand it here and I'll set it up.\"  The money exchanges hands.  \"Right.  I haven't updated this list in a while, so some people are still assigned to watch the back bay, which is technically a free shift now.  I'll let one of them know about what's up and they can spend the time helping to clean up back there.  Hope it helps."),
    replies = { { text = ccb.content.text("Thank you!"), next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup2",
    line = ccb.content.text("Woah, you're really intent, hey?  That's a lot for most people here.\"  The money exchanges hands.  \"That's enough to get two people off guard duty for an afternoon, even with all the ugliness back there.  And you know what?  I'll help out, too, so make that three.  I can appreciate someone who's willing to put their money where their mouth is."),
    replies = {
        {
            text = ccb.content.text("Thank you very much!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission",
    line = ccb.content.text("*looks at you cautiously.  \"He hasn't been bothering you, has he?  Dave's usually pretty harmless.\""),
    replies = {
        {
            text = ccb.content.text("He wants permission to build himself a little shelter outside of your lobby, somewhere out of the way.  He'd need access to your washrooms and things, but you could clear him out of this space."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
    line = ccb.content.text("Sure, sounds great on paper, but *where*?  We aren't swimming in real estate here, the place is seriously overcrowded.  And I won't have him living out of a soggy cardboard box on the doorstep, it's an even worse look than the lobby."),
    replies = {
        {
            text = ccb.content.text("What about the rooftop?  There's a stair access there, I can see it from outside, and he'd probably be able to do a bit of a lookout job."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission3",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}
