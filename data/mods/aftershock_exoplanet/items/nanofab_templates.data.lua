local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_10mm_smart_template",
    copy_from = "standard_template_construct",
    name = "Wraitheon production chip",
    description = "An encrypted Wraitheon industrial production chip.  The executive logo embossed on its lower right imply its contents are extremely valuable.",
    color = "yellow",
    nanofab_template_group = "afs_template_10mm_smart",
    template_requirements = "afs_nanofab_material_3",
}

ccb.content.define_item {
    id = "afs_template_bio1",
    copy_from = "standard_template_construct",
    name = "bioprinter chip",
    description = "A small slate of glass storing bioprinting instructions.  This specific chip allows for unlimited production, and is exceedingly valuable.",
    color = "yellow",
    nanofab_template_group = "afs_template_bio1",
    template_requirements = "afs_nanofab_biomaterial_1",
}

ccb.content.define_item {
    id = "afs_template_bio1_expendable",
    copy_from = "standard_template_construct",
    name = "bioprinter chip",
    description = "A small slate of glass storing bioprinting instructions.",
    color = "yellow",
    nanofab_template_group = "afs_template_bio1_expendable",
    template_requirements = "afs_nanofab_biomaterial_1",
    flags = { "NANOFAB_TEMPLATE", "NANOFAB_TEMPLATE_SINGLE_USE" },
}
