local ccb = require("ccb")

-- Sickly beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar4",
    unique_name = ccb.content.text("Brandon Garder"),
    gender = "male",
    suffix = ccb.content.text("Carpenter"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_4",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_4",
    faction = "lobby_beggars",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_4",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -1 } },
    dexterity = { rng = { -4, -1 } },
    intelligence = { rng = { -6, -2 } },
    perception = { rng = { -3, -1 } },
    worn = "NC_BEGGAR_4_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "ASTHMA" },
        { trait = "SLOWHEALER3" },
        { trait = "SLOWRUNNER" },
        { trait = "HEAVYSLEEPER" },
        { trait = "FLIMSY3" },
        { trait = "WEAKSTOMACH" },
        { trait = "MYOPIC" },
        { trait = "HYPEROPIC" },
        { trait = "JITTERY" },
        { trait = "SMELLY" },
        { trait = "PROJUNK" },
        { trait = "BADBACK" },
        { trait = "BADKNEES" },
        { trait = "BADCARDIO" },
        { group = "Appearance_demographics" },
    },
    skills = { { skill = "fabrication", bonus = { rng = { 2, 6 } } } },
}
