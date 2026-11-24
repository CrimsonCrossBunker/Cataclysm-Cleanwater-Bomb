local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "xe_vampire_mission_target",
    suffix = ccb.content.text("vampire"),
    class = "NC_XE_VAMPIRE_MISSION_TARGET",
    attitude = 0,
    mission = "SHELTER",
    chat = "TALK_VAMPIRE_MISSION_TARGET",
    faction = "no_faction",
}

-- Having the vampire be the same one every time is far easier to balance than full-random vampires.
ccb.content.define_npc_class {
    id = "NC_XE_VAMPIRE_MISSION_TARGET",
    name = ccb.content.text("Vampire"),
    job_description = ccb.content.text("A vampire that may or may not want to be cured from their condition.  The only way to find out is to ask them."),
    common = false,
    worn = "xe_vampire_mission_target_worn",
    weapon = "xe_vampire_mission_target_wield",
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "Random_vampire_reason" },
        { trait = "VAMPIRE_BLOOD_ARTS" },
        { trait = "VAMPIRE" },
        { trait = "VAMPIRE2" },
        { trait = "VAMPIRE3" },
        { trait = "EYEGLEAM" },
        { trait = "VAMPIRIC_STRENGTH" },
        { trait = "VAMPIRIC_RESILIENCE" },
        { trait = "VAMPIRE_HEALTH_BONUS" },
        { trait = "BLOODHEAL" },
        { trait = "VAMPIRIC_DODGE" },
        { trait = "VAMPIRE_SEE_HEAT" },
        { trait = "VAMPIRE_BLOOD_TEMPORARY_BOOST" },
        { trait = "MAGICFORBLOOD" },
        { trait = "VAMPIRE_COMMAND_BEAST" },
        { trait = "VAMPIRE_CARDIO_BONUS" },
        { trait = "VAMPIRE_BONUS_HP" },
        { trait = "VAMPIRE_WEAKNESS_MORE_BLOOD" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_CURE_REFUSE",
    line = ccb.content.text("How insulting.  You still think you hunters can do anything against me?  I'll prove you wrong."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE", native_actions = { "hostile" } } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_POWER_HUNGRY_ATTACK",
    line = ccb.content.text("Insufficiently servile.  No matter, there are more servants elsewhere."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE", native_actions = { "hostile" } } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_CURE_CONVINCED",
    line = ccb.content.text("Okay, I'll take the cure."),
    replies = {
        {
            text = ccb.content.text("[Give them the cure]"),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("blood_treatment"), actions.set_actor_value("speaker", "completed_hunter_cure_target", "yes"), actions.handler("dlg_a_xedra_evolved_59715f55401e") },
        },
    },
}
