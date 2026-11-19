local ccb = require("ccb")

ccb.content.define_spell {
    id = "shocking_lash",
    name = ccb.content.text("Shocking Lash"),
    description = ccb.content.text("A quick burst of electricity strikes a target and possibly one other nearby."),
    copy_from = "shocking_lash_base",
    field = "none",
    extra_spells = { { spell = "shocking_lash_2" }, { spell = "eoc_evocation_setup" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shocking_lash_2",
    name = ccb.content.text_without_extraction("Shocking Lash Jump"),
    description = ccb.content.text_without_extraction("The secondary jump from Shocking Lash."),
    copy_from = "shocking_lash_base",
    field = "none",
    flags = { "RANDOM_TARGET" },
    min_range = 1,
    max_range = 2,
    range_increment = 0.07,
}
