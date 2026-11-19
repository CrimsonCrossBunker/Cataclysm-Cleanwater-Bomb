local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_PIRATE",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Walk away afore I kill ya where you stand."),
                ccb.content.text("You've got a lot of nerve wearing that badge these days."),
                ccb.content.text("Boys, I think we should drown this fool."),
            },
        },
        no = {
            choices = {
                ccb.content.text("Watch your step."),
                ccb.content.text("Talk to Captain Tavrel."),
                ccb.content.text("Ahoy and other nautical terms!"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Obviously I should speak to someone else."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Pirates should be hung until dead."),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}
