local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_GENERIC_GUARD",
    line = {
        choices = {
            {
                when = predicates.has_trait("speaker", "VAMPIRE"),
                yes = ccb.content.text("If you're looking for a cure, you'll find that inside.  If you're not, go away now."),
                no = {
                    choices = {
                        ccb.content.text("I'm not in charge here, you're looking for someone else…"),
                        ccb.content.text("Keep civil or I'll bring the pain."),
                        ccb.content.text("Just on watch, move along."),
                        ccb.content.text("Don't distract me.  I'm on watch."),
                        {
                            when = predicates.conversation_state("daylight"),
                            yes = { choices = { ccb.content.text("Hello.  Welcome to our safe zone.") } },
                            no = {
                                choices = { ccb.content.text("Good evening.  Welcome to our safe zone.") },
                            },
                        },
                        {
                            when = predicates.actor_state("speaker", "male"),
                            yes = {
                                choices = {
                                    ccb.content.text("Sir."),
                                    ccb.content.text("Rough out there, isn't it?"),
                                },
                            },
                            no = {
                                choices = {
                                    ccb.content.text("Ma'am"),
                                    ccb.content.text("Ma'am, you really shouldn't be traveling out there."),
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" } },
}
