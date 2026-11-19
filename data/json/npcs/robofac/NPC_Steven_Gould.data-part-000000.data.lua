local ccb = require("ccb")

-- Appears at the field station during the quest Invasive "Meteorology:" contact the field team.
ccb.content.define_npc {
    id = "robofac_merc_monster_corpse_1",
    unique_name = ccb.content.text("Steven Gould"),
    suffix = ccb.content.text("Hub Mercenary"),
    class = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1",
    name = ccb.content.text("Hub Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "hair_medium", variant = "black" },
        { trait = "natural_hair_color_black" },
        { trait = "eye_color", variant = "brown" },
        { trait = "SKIN_PINK" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = 1,
    dexterity = 1,
    perception = 1,
    intelligence = 4,
    worn = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_worn",
    carry = "NC_ROBOFAC_MERC_MONSTER_CORPSE_1_carry",
}
