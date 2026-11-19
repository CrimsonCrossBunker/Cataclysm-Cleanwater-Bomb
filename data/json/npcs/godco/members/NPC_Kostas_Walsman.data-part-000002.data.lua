local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Herbalism",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } }),
        yes = {
            choices = {
                ccb.content.text("Nature can provide.  You can live off the land if you learn how."),
                ccb.content.text("Foraging is about recognizing the abundance that is around us all the time, not seeking out rare species."),
                ccb.content.text("You'll need a good book to confidently identify edible and poisonous wild foods.  I'd recommend the book 'Autobiography of a Mountain Man' for detailed descriptions."),
                ccb.content.text("Never eat any wild food without first being sure of its identity.  It only takes one mistake."),
                ccb.content.text("The huge diversity of wild plants and fungi can be very daunting to the novice forager.  Don't be too ambitious.  Try to enjoy the learning process without getting frustrated or taking risks around uncertain identifications."),
            },
        },
        no = ccb.content.text("I can tell you this: pine needles make the best tea.  Perhaps I'll make you one someday."),
    },
    replies = {
        {
            text = ccb.content.text("Can I try your pine needle tea?"),
            next_topic = "TALK_GODCO_Kostas_Tea",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } })),
            actions = {
                actions.set_actor_value("interlocutor", "knowledge_completed_godco_kostas_tea", "in-progress"),
            },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
