local ccb = require("ccb")

ccb.content.define_spell {
    id = "afs_cryosuit_ui_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("updates the cryosuit UI"),
    description = ccb.content.text_without_extraction("EOCs the player."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "hostile", "ally" },
    min_range = 0,
    min_aoe = 1,
    max_aoe = 1,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_88055f2d9f6f",
}
