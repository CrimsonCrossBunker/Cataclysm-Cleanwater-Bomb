local ccb = require("ccb")

-- Hungry beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar1",
    unique_name = ccb.content.text("Reena Sandhu"),
    gender = "female",
    suffix = ccb.content.text("Teacher"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_1",
    faction = "lobby_beggars",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_1",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -6, -2 } },
    dexterity = { rng = { -4, -1 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { -3, -1 } },
    worn = "NC_BEGGAR_1_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "VEGETARIAN" },
        { trait = "SQUEAMISH" },
        { trait = "MOODSWINGS" },
        { trait = "SEASONAL_ALLERGIES" },
        { trait = "SLOWHEALER" },
        { trait = "SLOWRUNNER" },
        { trait = "DISORGANIZED" },
        { trait = "BADKNEES" },
        { trait = "FLIMSY3" },
        { trait = "MYOPIC" },
        { trait = "PACIFIST" },
        { trait = "Exp_Teaching2" },
        { group = "Appearance_Mixed" },
    },
    skills = {
        { skill = "speech", bonus = { rng = { 0, 3 } } },
        { skill = "cooking", bonus = { rng = { 0, 3 } } },
    },
}
