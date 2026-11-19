local ccb = require("ccb")

ccb.content.define_npc {
    id = "xe_vampire_mission_target",
    suffix = ccb.content.text("vampire"),
    class = "NC_XE_VAMPIRE_MISSION_TARGET",
    attitude = 0,
    mission = "SHELTER",
    chat = "TALK_VAMPIRE_MISSION_TARGET",
    faction = "no_faction",
}

-- Having the vampire be the same one every time is far easier to balance than full-random vampires.
ccb.content.define_npc_class {
    id = "NC_XE_VAMPIRE_MISSION_TARGET",
    name = ccb.content.text("Vampire"),
    job_description = ccb.content.text("A vampire that may or may not want to be cured from their condition.  The only way to find out is to ask them."),
    common = false,
    worn = "xe_vampire_mission_target_worn",
    weapon = "xe_vampire_mission_target_wield",
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "Random_vampire_reason" },
        { trait = "VAMPIRE_BLOOD_ARTS" },
        { trait = "VAMPIRE" },
        { trait = "VAMPIRE2" },
        { trait = "VAMPIRE3" },
        { trait = "EYEGLEAM" },
        { trait = "VAMPIRIC_STRENGTH" },
        { trait = "VAMPIRIC_RESILIENCE" },
        { trait = "VAMPIRE_HEALTH_BONUS" },
        { trait = "BLOODHEAL" },
        { trait = "VAMPIRIC_DODGE" },
        { trait = "VAMPIRE_SEE_HEAT" },
        { trait = "VAMPIRE_BLOOD_TEMPORARY_BOOST" },
        { trait = "MAGICFORBLOOD" },
        { trait = "VAMPIRE_COMMAND_BEAST" },
        { trait = "VAMPIRE_CARDIO_BONUS" },
        { trait = "VAMPIRE_BONUS_HP" },
        { trait = "VAMPIRE_WEAKNESS_MORE_BLOOD" },
    },
}
