local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Aside from just having a safe place to live?  We're here to mine, you understand.  Picking the scraps, seeing if this world has any tech worth reverse engineering.  No sense letting good scraps go to waste.  If we're lucky, maybe we'll get some new Exodii before we teleport out.  Pickin' up the pieces of our sweet, shattered dreams, such as they are.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose2",
    line = ccb.content.text("Aside from jus' livin' in such a cozy nook?  Us be minin', ye kennit.  Pickin' the scraps, seein' if for your otherland has any tech worth an upside-down.  No sense lettin' good scraps go to waste.  If we're lucky, pickin' a few new Exodii afore we wobble out.  Pickin' up the pieces of our sweet, shattered dreams, suchlike."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_know_exodii_purpose2", "yes") } } },
    replies = {
        {
            text = ccb.content.text("What do you mean 'go to waste'?  The zombies aren't using the scrap, and there's plenty to go around."),
            next_topic = "TALK_EXODII_MERCHANT_Purpose3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
