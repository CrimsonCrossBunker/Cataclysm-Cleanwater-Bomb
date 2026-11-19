local ccb = require("ccb")

-- Schizophrenic beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar2",
    unique_name = ccb.content.text("Dino Dave"),
    gender = "male",
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_2",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_2",
    faction = "lobby_beggars",
    missions_offered = "MISSION_BEGGAR_2_BOX_SMALL",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_2",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -3, -2 } },
    dexterity = { rng = { -5, -1 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { -6, -2 } },
    worn = "NC_BEGGAR_2_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "ADDICTIVE" },
        { trait = "HOARDER" },
        { trait = "SLOWHEALER" },
        { trait = "SLOWRUNNER" },
        { trait = "CHEMIMBALANCE" },
        { trait = "HEAVYSLEEPER" },
        { trait = "FLIMSY2" },
        { trait = "SCHIZOPHRENIC" },
        { trait = "SLOWLEARNER" },
        { trait = "PACIFIST" },
        { group = "Appearance_demographics" },
    },
}
