local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_SOLDIER",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Hello, marshal."),
                ccb.content.text("Marshal, I'm afraid I can't talk now."),
                ccb.content.text("I'm not in charge here, marshal."),
                ccb.content.text("I'm supposed to direct all questions to my leadership, marshal."),
            },
        },
        no = {
            choices = {
                ccb.content.text("Hey, citizen… I'm not sure you belong here."),
                ccb.content.text("You should mind your own business, nothing to see here."),
                ccb.content.text("If you need something you'll need to talk to someone else."),
                {
                    when = predicates.actor_state("speaker", "male"),
                    yes = {
                        choices = {
                            ccb.content.text("Sir."),
                            ccb.content.text("Dude, if you can hold your own you should look into enlisting."),
                        },
                    },
                    no = {
                        choices = {
                            ccb.content.text("Ma'am"),
                            ccb.content.text("Hey miss, don't you think it would be safer if you stuck with me?"),
                        },
                    },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" } },
}
