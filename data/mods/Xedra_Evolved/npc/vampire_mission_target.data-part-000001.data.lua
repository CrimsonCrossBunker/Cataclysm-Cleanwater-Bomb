local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Depending on their reason to become a vampire, they will be more or less open to be cured.
ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET",
    line = {
        when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_VENGEFUL"),
        yes = ccb.content.text("You're back to finish the job, aren't you?  They sent you to kill me!"),
        no = {
            choices = { ccb.content.text("What do you want?"), ccb.content.text("Why are you here?") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I am here to cure you from your vampirism."),
            next_topic = "TALK_VAMPIRE_MISSION_TARGET_CURE",
            when = predicates.all({ predicates.has_any_trait("interlocutor", { "VAMPIRE_REASON_UNWILLING", "VAMPIRE_REASON_DELUDED" }), predicates.has_item("speaker", "blood_treatment") }),
        },
        {
            text = ccb.content.text("I am here to cure you from your vampirism."),
            next_topic = "TALK_VAMPIRE_MISSION_TARGET_CURE_REFUSE",
            when = predicates.all({ predicates.has_trait("interlocutor", "VAMPIRE_REASON_POWER_HUNGRY"), predicates.has_item("speaker", "blood_treatment") }),
        },
        {
            text = ccb.content.text("I am here to kill you."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("interlocutor", { "VAMPIRE_REASON_UNWILLING", "VAMPIRE_REASON_POWER_HUNGRY", "VAMPIRE_REASON_DELUDED" }),
            native_actions = { "hostile" },
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_VENGEFUL"),
            native_actions = { "hostile" },
        },
        {
            text = ccb.content.text("I'm just passing.  Bye."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("interlocutor", { "VAMPIRE_REASON_UNWILLING", "VAMPIRE_REASON_DELUDED" }),
        },
        {
            text = ccb.content.text("I'm just passing.  Bye."),
            next_topic = "TALK_VAMPIRE_MISSION_TARGET_POWER_HUNGRY_ATTACK",
            when = predicates.has_trait("interlocutor", "VAMPIRE_REASON_POWER_HUNGRY"),
        },
    },
}
