local ccb = require("ccb")

-- Appears in the surface of Hub 01 as an external mercenary.
ccb.content.define_npc {
    id = "robofac_merc_1",
    unique_name = ccb.content.text("Cranberry Foster"),
    suffix = ccb.content.text("Hub Mercenary"),
    missions_offered = "MISSION_ROBOFAC_MERC_1_RADIO",
    class = "NC_ROBOFAC_MERC_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_1",
    faction = "robofac_auxiliaries",
}

-- Cranberry is a former park ranger that held out at home for a while during and after the Cataclysm.  They lived near Hub 01's headquarters and was curious what was inside the building, so when they left their home, they went to it.
-- They are generally laid back and talk in an informal, relaxed way.  Things have been hard, but they're generally optimistic and have largely come to terms with the new state of the world.
-- Writing note: Cranberry's appearance and voice are androgynous, and so their gender is never specified; they directly tease the player about it in a dialogue option that appears once they have enough trust with the player.  Use neutral terms and pronouns when referring to them.
ccb.content.define_npc_class {
    id = "NC_ROBOFAC_MERC_1",
    name = ccb.content.text("Hub Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "TOUGH" },
        { trait = "QUICK" },
        { trait = "OPTIMISTIC" },
        { trait = "FORGETFUL" },
        { trait = "PACIFIST" },
        { trait = "TRUTHTELLER" },
        { trait = "hair_medium", variant = "blond" },
        { trait = "natural_hair_color_blond" },
        { trait = "eye_color", variant = "blue" },
        { trait = "SKIN_PINK" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = 2,
    dexterity = 3,
    perception = 1,
    worn = "NC_ROBOFAC_MERC_1_worn",
    carry = "NC_ROBOFAC_MERC_1_carry",
    weapon = "NC_ROBOFAC_MERC_1_wield",
    skills = {
        { skill = "gun", bonus = 4 },
        { skill = "rifle", bonus = 4 },
        { skill = "pistol", bonus = 1 },
        { skill = "melee", bonus = 4 },
        { skill = "cutting", bonus = 3 },
        { skill = "fabrication", bonus = 1 },
        { skill = "firstaid", bonus = 1 },
        { skill = "swimming", bonus = 3 },
        { skill = "survival", bonus = 4 },
        { skill = "cooking", bonus = 4 },
        { skill = "computer", bonus = 6 },
        { skill = "electronics", bonus = 4 },
        { skill = "driving", bonus = 3 },
    },
}
