local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_CURE",
    line = {
        when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_DELUDED"),
        yes = ccb.content.text("Why would I want that?  Being a vampire is great!  If you try to cure me, you're good as dead."),
        no = ccb.content.text("Yes, please cure me!"),
    },
    replies = {
        {
            text = ccb.content.text("Being a vampire is not great.  It's something you don't want to become."),
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_DELUDED"),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_VAMPIRE_MISSION_TARGET_CURE_CONVINCED" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Vampire hunters are great at killing vampires.  Do you want to be another name on their kill list?"),
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_DELUDED"),
            trial = { kind = "intimidate", difficulty = 10 },
            success = { next_topic = "TALK_VAMPIRE_MISSION_TARGET_CURE_CONVINCED" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("You don't want the cure?  I'll kill you then."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_DELUDED"),
            actions = { "hostile" },
        },
        {
            text = ccb.content.text("[Give them the cure]"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_UNWILLING"),
            actions = { actions.transfer_items("blood_treatment"), actions.set_actor_value("speaker", "completed_hunter_cure_target", "yes"), actions.handler("dlg_a_xedra_evolved_311733d56240") },
        },
    },
}
