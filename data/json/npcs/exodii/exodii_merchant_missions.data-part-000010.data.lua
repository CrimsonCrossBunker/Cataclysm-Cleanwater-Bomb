local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_intro1",
    line = ccb.content.text("Just so.  'Tis like yarkin' fit f'r me beloved jaryi, y'kennit so fine.  What say you?"),
    replies = {
        {
            text = ccb.content.text("What, now that I think on it, I am not sure what you meant about juts and figs."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_clarify",
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Beloved jaryi?  What did you just call me?"),
            next_topic = "TALK_EXODII_MERCHANT_jaryi",
            actions = { actions.handler("dlg_a_dda_c9b772244028") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi",
    line = ccb.content.text(
        --~ No, I'm not calling you jaryi.  Jaryi is my mother's mother.  It's a King's Landing word for a grandmother, I'm making a little joke at you.
        "Ha, not callin' y'me jaryi.  Jaryi be the mother-twice.  'Tis but a King's Landing assert f'r a grandmother, Rubik's makin' a chestnut at ye."),
    replies = {
        {
            text = ccb.content.text("That word doesn't sound like any of the other Anglic words you've used, though.  What's it from?"),
            next_topic = "TALK_EXODII_MERCHANT_jaryi2",
        },
        {
            text = ccb.content.text("What were you talking about before?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
