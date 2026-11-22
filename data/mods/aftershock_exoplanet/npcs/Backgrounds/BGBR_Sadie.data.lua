local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_Sadie_STORY1",
    line = {
        joined = {
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_6d6b923beb69"),
            yes = ccb.content.text("This feels like a good place to relax.  Want to play doctor with real scalpels?"),
            no = ccb.content.text("This might not be a very private place."),
        },
            ccb.content.text("  "),
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_8090a987dd23"),
            yes = ccb.content.text("This place is so boring.  We should take people and kill some drugs."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_04435162cfce"),
            yes = ccb.content.text("Water water everywhere.  Let's go skinny dipping.  I bet you'll attract some leeches.  I need them for something I want to do to you.  It'll be so weird."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_0990569f7b8f"),
            yes = ccb.content.text("I like it down here.  This reminds me of that time I was down in a place like this and someone creeped up behind me and hit me in the back of the head with a shovel.  *shiver*  It still gives me goosebumps."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_e61133812756"),
            yes = ccb.content.text("I love nature.  It smells so good out here, like living things growing and multiplying and dying and returning from the dead with horrifying new powers and trying to slowly rip us apart and eat us.  It brings back really happy memories for me."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_bf043626a620"),
            yes = ccb.content.text("I love swampy places like this.  The smell of the pussy willows, the sound of the crickets, the giant mutant mosquitoes hungry for our blood.  It's like we're in a sexy vampire romance novel."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_0322a64a012a"),
            yes = ccb.content.text("What a beautiful facility.  I bet they have all kinds of lovely toys to play with.  We should kill everyone here and do some creative self-experimentation."),
            no = "",
        },
            {
            when = predicates.handler("dlg_p_aftershock_exoplanet_7278c42b1690"),
            yes = ccb.content.text("Ooh, it's like a murder mystery here.  Are we the murderers, the murdered, or the mystery?"),
            no = "",
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
