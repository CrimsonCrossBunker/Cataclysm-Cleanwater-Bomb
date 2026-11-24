local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_npc {
    id = "forge_lord_pirate",
    suffix = ccb.content.text("Former Pirate"),
    class = "NC_FORGE_PIRATE",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_FORGE_PIRATE",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_PIRATE",
    name = ccb.content.text("Pirate"),
    job_description = ccb.content.text("My adventures would curdle your blood."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "TOUGH3" },
    },
    common = false,
    dexterity = { one_in = 4 },
    perception = { one_in = 4 },
    strength = { one_in = 4 },
    worn = "NC_FORGE_PIRATE_clothes",
    weapon = "NC_FORGE_PIRATE_wield",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "cutting", bonus = { one_in = 2 } },
        { skill = "pistol", bonus = { rng = { 0, 2 } } },
        { skill = "gun", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 3, 5 } } },
    },
}

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
