local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NPC_ROBOFAC_MERC_PAT",
    name = ccb.content.text("Hub Mercenary"),
    traits = { { trait = "RETURN_TO_START_POS" } },
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    worn = "NPC_ROBOFAC_MERC_PAT_worn",
    carry = "NPC_ROBOFAC_MERC_PAT_carry",
}
