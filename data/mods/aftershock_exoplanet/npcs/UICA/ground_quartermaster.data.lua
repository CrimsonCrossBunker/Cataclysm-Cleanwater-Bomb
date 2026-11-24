local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_UICA_GROUND_QUARTERMASTER",
    name = ccb.content.text("UICA Quartermaster"),
    job_description = ccb.content.text("Supply Trader"),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_GROUND_SOLDIER_worn",
    carry = "NC_UICA_GROUND_SOLDIER_carry",
    weapon = "NC_UICA_GROUND_SOLDIER_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "pistol", bonus = { rng = { 4, 6 } } },
        { skill = "smg", bonus = { rng = { 4, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
    },
    shop_groups = {
        { id = "afs_uica_quartermaster_money", rigid = true },
        { id = "afs_uica_quartermaster_armor", rigid = true },
        { id = "afs_uica_quartermaster_medical", rigid = true },
        { id = "afs_uica_quartermaster_military", rigid = true },
    },
    price_rules = { { group = "afs_general_armory", fixed_adjustment = 0 } },
}

ccb.content.define_npc {
    id = "uica_quartermaster",
    suffix = ccb.content.text("UICA Quartermaster"),
    class = "NC_UICA_GROUND_QUARTERMASTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_UICA_GROUND_QUARTERMASTER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER" },
    line = ccb.content.text("&You find the Quartermaster lazily reclined against a stack of intermodal crates.  <npc_name> barely acknowledges your presence, their eyes never leaving their PDA as they address you.\n\"Need something salvor?\""),
    replies = {
        {
            text = ccb.content.text("Show me what you have."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_can_trade" } }),
        },
        {
            text = ccb.content.text("Can I buy supplies here?"),
            next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_can_trade" } })), predicates.negate(predicates.has_effect("interlocutor", "afs_tried_to_bribe")) }),
        },
        {
            text = ccb.content.text("Can I buy supplies here?"),
            next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_RECENTLY_FAILED",
            when = predicates.has_effect("interlocutor", "afs_tried_to_bribe"),
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE" },
    line = ccb.content.text("This isn't a store.  Go to the Spaceport if you want to buy supplies."),
    replies = {
        {
            text = ccb.content.text("I'm sure we can work something out.  [Bribe $3000]"),
            trial = { kind = "persuade", difficulty = 50 },
            success = { next_topic = "TALK_DONE", actions = { actions.set_actor_value("interlocutor", "player_can_trade", "yes"), actions.handler("w16b_a_aftershock_exoplanet_a8c0944b1770") } },
            failure = { next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_FAILURE", actions = { actions.add_effect("interlocutor", "afs_tried_to_bribe", { turns = 86400 }) } },
        },
        {
            text = ccb.content.text("Nevermind then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_FAILURE" },
    line = ccb.content.text("I think you should leave."),
    replies = { { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_RECENTLY_FAILED" },
    line = ccb.content.text("I already told you no."),
    replies = { { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" } },
}
