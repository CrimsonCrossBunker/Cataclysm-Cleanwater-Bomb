local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_AleeshaSeward",
    unique_name = ccb.content.text("Aleesha Seward"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Aleesha",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Aleesha_1",
    faction = "free_merchants",
}

-- Aleesha is fourteen and lost her family
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Aleesha",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -1, 4 } },
    perception = { rng = { -1, 1 } },
    worn = "REFUGEE_Aleesha_worn",
    carry = "REFUGEE_Aleesha_carried",
    weapon = "REFUGEE_Aleesha_wield",
    traits = { { group = "Appearance_African" }, { trait = "NO_BASH" }, { trait = "RETURN_TO_START_POS" } },
}
