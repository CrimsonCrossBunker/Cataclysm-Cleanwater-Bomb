local ccb = require("ccb")

-- He sells cure & some medical supplies.  Very interested by alchemical recipes and magical/high-science medical treatments.
-- His main goal is to break the vampires' monopoly on agelessness and perfect health to reduce the amount of new vampires.  A very hard goal to reach even before the cataclysm, but he'll try nonetheless.
ccb.content.define_npc {
    id = "vampire_hunter_doctor",
    suffix = ccb.content.text("hunter"),
    class = "NC_vampire_hunter_doctor",
    unique_name = ccb.content.text("Blaine Weiss"),
    gender = "male",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_DOCTOR",
    personality = { aggression = 0, bravery = 6, collector = 6, altruism = 8 },
    faction = "vampire_hunters",
}

-- Worked as a doctor and performed medical research but little else.  Has a crossbow mainly for self-defense.
-- He's also the de facto cook due to him being the best available for this task.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_doctor",
    name = ccb.content.text("doctor"),
    job_description = ccb.content.text("I tend up wounded hunters."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_African" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 1, 2 } },
    dexterity = { rng = { 1, 2 } },
    intelligence = { rng = { 3, 4 } },
    perception = { rng = { 1, 2 } },
    sells_belongings = false,
    shop_groups = { { id = "hunter_doctor_sold_items", rigid = true } },
    consumption_rates = "basic_shop_rates",
    worn = "VAMPIRE_HUNTER_DEFAULT_worn",
    weapon = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield",
    skills = {
        { skill = "rifle", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 3 } } },
        { skill = "firstaid", bonus = { rng = { 6, 7 } } },
        { skill = "chemistry", bonus = { rng = { 6, 7 } } },
        { skill = "cooking", bonus = { rng = { 6, 7 } } },
        { skill = "dodge", bonus = { rng = { 0, 1 } } },
        { skill = "deduction", bonus = { rng = { 1, 2 } } },
    },
}
