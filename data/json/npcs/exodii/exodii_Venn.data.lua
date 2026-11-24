local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- The Exodii autodoc operator
ccb.content.define_npc {
    id = "exodii_surgeon",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_EXODII_TYPE_1b_surgeon",
    unique_name = ccb.content.text("Venn"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_EXODII_VENN",
    faction = "exodii",
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_1b_surgeon",
    name = ccb.content.text("Cyborg, type 1b"),
    job_description = ccb.content.text("I'm a cyborg."),
    traits = {
        { trait = "EXODII_BODY_1b" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 0, 6 } },
    dexterity = { rng = { 0, 6 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 4 } },
    weapon = "EMPTY_GROUP",
    worn = "EMPTY_GROUP",
    shop_groups = { { id = "EXODII_Bionic_Limb_Store_Tier1", rigid = true } },
    consumption_rates = "basic_shop_rates",
    blacklist = "rubik_shopkeep_blacklist",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = 0 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
        { skill = "speech", bonus = { rng = { 5, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN",
    line = ccb.content.text("&A very human-like cyborg stands before you.  Its steel frame is perfectly clean, but tarnished and clouded as if it were constantly exposed to harsh chemical cleansers.\n\nIt stares at you, not moving."),
    replies = {
        {
            text = ccb.content.text("[Motion to your belongings] Can we trade?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            native_actions = { "start_trade" },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Motion to the surgical bot] Can you help me with CBM surgery?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_EXODII_VENN_Bionic_Install",
        },
        {
            text = ccb.content.text("[Motion to your bionic limbs] Could you repair my Cyberframe?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_EXODII_VENN_repair",
        },
        {
            text = ccb.content.text("Good talk, Venn.  See you later."),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Well, nevermind, I guess."),
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "EXODII_BODY_1")), predicates.negate(predicates.has_trait("speaker", "EXODII_BODY_1b")), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN_repair",
    line = ccb.content.text("&You sit on the surgical table and Venn pulls an aging CRT into view.  The spider-like surgical robot starts to greedily poke and prod you.  The monitor highlights your needs on a low resolution blueprint of your Cyberframe."),
    replies = {
        {
            text = ccb.content.text("[Offer to trade for the repairs]"),
            actions = { "repair_bionic_limbs" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Actually, nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN_Bionic_Install",
    line = ccb.content.text("&You sit on the surgical table and Venn pulls an aging CRT into view.  The spider-like surgical robot starts to greedily poke and prod you.  The monitor highlights your current bionics, and available upgrades, all accompanied by text you don't understand."),
    replies = {
        {
            text = ccb.content.text("[Point to a CBM on the screen to install]"),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("[Point to a CBM on the screen to remove]"),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_remove" },
        },
    },
}
