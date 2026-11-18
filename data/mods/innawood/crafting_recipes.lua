local content = require("ccb").content


content.retire_recipe("nomex_sockmitts", "nomex_sockmitts")

content.retire_recipe("legguard_tire", "legguard_tire")

content.retire_recipe("xs_legguard_tire", "xs_legguard_tire")

content.retire_recipe("xl_legguard_tire", "xl_legguard_tire")

content.retire_recipe("armguard_tire", "armguard_tire")

content.retire_recipe("xs_armguard_tire", "xs_armguard_tire")

content.retire_recipe("xl_armguard_tire", "xl_armguard_tire")

content.retire_recipe("xs_lsurvivor_armor", "xs_lsurvivor_armor")

content.retire_recipe("xl_lsurvivor_armor", "xl_lsurvivor_armor")

content.retire_recipe("xs_aketon_nylon", "xs_aketon_nylon")

content.retire_recipe("aketon_nylon", "aketon_nylon")

content.retire_recipe("xl_aketon_nylon", "xl_aketon_nylon")

content.retire_recipe("xs_aketon_nylon_vest", "xs_aketon_nylon_vest")

content.retire_recipe("aketon_nylon_vest", "aketon_nylon_vest")

content.retire_recipe("xl_aketon_nylon_vest", "xl_aketon_nylon_vest")

content.retire_recipe("aketon_hood_nylon", "aketon_hood_nylon")

content.retire_recipe("aketon_pants_nylon", "aketon_pants_nylon")

content.retire_recipe("aketon_gloves_nylon", "aketon_gloves_nylon")

content.retire_recipe("xs_aketon_hood_nylon", "xs_aketon_hood_nylon")

content.retire_recipe("xl_aketon_hood_nylon", "xl_aketon_hood_nylon")

content.retire_recipe("xl_aketon_pants_nylon", "xl_aketon_pants_nylon")

content.retire_recipe("xs_aketon_pants_nylon", "xs_aketon_pants_nylon")

content.retire_recipe("xs_aketon_gloves_nylon", "xs_aketon_gloves_nylon")

content.retire_recipe("xl_aketon_gloves_nylon", "xl_aketon_gloves_nylon")

content.retire_recipe("xl_wetsuit_gloves_thick", "xl_wetsuit_gloves_thick")

content.retire_recipe("wetsuit_gloves_thick", "wetsuit_gloves_thick")

content.retire_recipe("wetsuit_booties_thick", "wetsuit_booties_thick")

content.retire_recipe("xs_wetsuit_booties_thick", "xs_wetsuit_booties_thick")

content.retire_recipe("xl_wetsuit_booties_thick", "xl_wetsuit_booties_thick")

content.retire_recipe("xs_wetsuit_gloves_thick", "xs_wetsuit_gloves_thick")

content.retire_recipe("xl_wetsuit_thick", "xl_wetsuit_thick")

content.retire_recipe("xs_wetsuit_thick", "xs_wetsuit_thick")

content.retire_recipe("wetsuit_thick", "wetsuit_thick")

content.retire_recipe("wetsuit_hood_thick", "wetsuit_hood_thick")

content.retire_recipe("xs_wetsuit_hood_thick", "xs_wetsuit_hood_thick")

content.retire_recipe("xl_wetsuit_hood_thick", "xl_wetsuit_hood_thick")

content.retire_recipe("xl_wsurvivor_jumpsuit_nofur", "xl_wsurvivor_jumpsuit_nofur")

content.retire_recipe("wsurvivor_jumpsuit_nofur", "wsurvivor_jumpsuit_nofur")

content.retire_recipe("xs_wsurvivor_jumpsuit_nofur", "xs_wsurvivor_jumpsuit_nofur")

content.retire_recipe("xs_hood_wsurvivor_nofur", "xs_hood_wsurvivor_nofur")

content.retire_recipe("xl_hood_wsurvivor_nofur", "xl_hood_wsurvivor_nofur")

content.retire_recipe("hood_wsurvivor_nofur", "hood_wsurvivor_nofur")

content.retire_recipe("xs_boots_wsurvivor_nofur", "xs_boots_wsurvivor_nofur")

content.retire_recipe("boots_wsurvivor_nofur", "boots_wsurvivor_nofur")

content.retire_recipe("xl_boots_wsurvivor_nofur", "xl_boots_wsurvivor_nofur")

content.retire_recipe("xl_gloves_wsurvivor_nofur", "xl_gloves_wsurvivor_nofur")

content.retire_recipe("xs_gloves_wsurvivor_nofur", "xs_gloves_wsurvivor_nofur")

content.retire_recipe("gloves_wsurvivor_nofur", "gloves_wsurvivor_nofur")

content.retire_recipe("xl_wetsuit_booties", "xl_wetsuit_booties")

content.retire_recipe("wetsuit_booties", "wetsuit_booties")

content.retire_recipe("xs_wetsuit_booties", "xs_wetsuit_booties")

content.retire_recipe("xl_duster_faux_fur", "xl_duster_faux_fur")

content.retire_recipe("duster_faux_fur", "duster_faux_fur")

content.retire_recipe("armor_faux_farmor_xs", "armor_faux_farmor_xs")

content.retire_recipe("armor_faux_farmor", "armor_faux_farmor")

content.retire_recipe("xl_armor_faux_farmor", "xl_armor_faux_farmor")

content.retire_recipe("xs_boots_faux_fur", "xs_boots_faux_fur")

content.retire_recipe("boots_faux_fur", "boots_faux_fur")

content.retire_recipe("xl_boots_faux_fur", "xl_boots_faux_fur")

content.retire_recipe("xs_gloves_faux_fur", "xs_gloves_faux_fur")

content.retire_recipe("xl_gloves_faux_fur", "xl_gloves_faux_fur")

content.retire_recipe("gloves_faux_fur", "gloves_faux_fur")

content.replace(content.Recipe {
    id = "bandages_makeshift",
    result = "bandages_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    skill = "tailor",
    duration_moves = 900,
    activity_level = NO_EXERCISE,
    autolearn = true,
    result_multiplier = 1,
    flags = { "BLIND_EASY" },
}:component_any({
    { id = "cotton_patchwork", count = 1 },
    { id = "fibercloth_patchwork", count = 1 },
}))
