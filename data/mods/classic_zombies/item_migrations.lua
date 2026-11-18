local content = require("ccb").content

-- items/gunmods.json
content.add(content.ItemMigration {
    from = { "retool_ar15_300blk", "retool_ar15_50beowulf", "retool_ar15_450", "retool_ar15_762" },
    to = "retool_ar15_223rem",
})
content.add(content.ItemMigration {
    from = { "retool_ar15_300blk_medium", "retool_ar15_50beowulf_medium", "retool_ar15_450_medium" },
    to = "retool_ar15_223rem_medium",
})
content.add(content.ItemMigration {
    from = { "retool_ar15_300blk_short", "retool_ar15_50beowulf_short", "retool_ar15_450_short" },
    to = "retool_ar15_223rem_short",
})

-- items/migration.json
content.add(content.ItemMigration { from = { "m17", "m18" }, to = "hi_power_9mm" })
content.add(content.ItemMigration { from = { "p320mag_10rd_9x19mm", "p320mag_17rd_9x19mm" }, to = "bhp9mag_13rd" })
content.add(content.ItemMigration { from = "p320mag_21rd_9x19mm", to = "bhp9mag_15rd" })
content.add(content.ItemMigration { from = "protein_bar_evac", to = "protein_bar_zero" })
content.add(content.ItemMigration { from = "mp3", to = "portable_music_player" })
