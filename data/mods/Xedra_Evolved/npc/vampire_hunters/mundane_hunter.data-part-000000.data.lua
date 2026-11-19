local ccb = require("ccb")

-- The hunter that hunted regular animals as part of the cover-up.  She is now responsible to hunt animals for food.
ccb.content.define_npc {
    id = "vampire_hunter_mundane",
    suffix = ccb.content.text("regular hunter"),
    class = "NC_vampire_hunter_mundane",
    unique_name = ccb.content.text("Elsa Nielsen"),
    gender = "female",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_MUNDANE",
    personality = { aggression = 2, bravery = 6, collector = 5, altruism = 2 },
    faction = "vampire_hunters",
}

-- Was recruited as part of the cover-up that hid the vampire-hunting group as a bunch of regular crossbow hunters.
-- She's great at hunting animals but has little combat training and barely knows anything about vampires except the necessity to kill them all, thus the low deduction, low combat and high shooting skills.
-- She also teaches the new recruits and explains to wanderers how they're just an exclusive hunting club, thus high social and being willing to teach how to use crossbows.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_mundane",
    name = ccb.content.text("regular hunter"),
    job_description = ccb.content.text("I hunt, but I don't hunt vampires."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Irish" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 2, 3 } },
    dexterity = { rng = { 1, 3 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 3, 5 } },
    sells_belongings = false,
    shop_groups = "hunter_mundane_sold_items",
    consumption_rates = "basic_shop_rates",
    worn = "VAMPIRE_HUNTER_DEFAULT_worn",
    weapon = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield",
    skills = {
        { skill = "ALL", level = { mul = { { sum = { { dice = { 1, 2 } } } } } } },
        { skill = "rifle", bonus = { rng = { 6, 8 } } },
        { skill = "gun", bonus = { rng = { 6, 8 } } },
        { skill = "survival", bonus = { rng = { 5, 6 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "deduction", bonus = { rng = { -3, -2 } } },
        { skill = "speech", bonus = { rng = { 3, 4 } } },
    },
}
