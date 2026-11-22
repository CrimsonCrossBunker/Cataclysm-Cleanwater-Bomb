local ccb = require("ccb")

ccb.content.define_spell {
    id = "veiled_butterfly_irradiate",
    shape = "blast",
    name = ccb.content.text_without_extraction("Irradiate Player"),
    description = ccb.content.text_without_extraction("Adds minor radiation to player."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 1,
    max_range = 5,
    min_aoe = 1,
    max_aoe = 1,
    base_casting_time = 200,
    impact_handler = "w16b_sp_imp_dda_db98276fff7d",
}

ccb.content.define_spell {
    id = "mon_zombie_summoner_summon_hordes_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Summon Horde"),
    description = ccb.content.text_without_extraction("Calls hordes to the player's location."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 10,
    max_range = 10,
    impact_handler = "w16b_sp_imp_dda_26c4e01c0faf",
}
