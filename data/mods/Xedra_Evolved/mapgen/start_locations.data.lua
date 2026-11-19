local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_ierde",
    name = ccb.content.text("Ierde"),
    targets = {
        "ierde_genius_loci_NW",
        "ierde_genius_loci_NE",
        "ierde_genius_loci_SW",
        "ierde_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_undine",
    name = ccb.content.text("Undine"),
    targets = {
        "undine_genius_loci_NW",
        "undine_genius_loci_NE",
        "undine_genius_loci_SW",
        "undine_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_arvore",
    name = ccb.content.text("Arvore"),
    targets = {
        "arvore_genius_loci_NW",
        "arvore_genius_loci_NE",
        "arvore_genius_loci_SW",
        "arvore_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_salamander",
    name = ccb.content.text("Salamander"),
    targets = {
        "salamander_genius_loci_NW",
        "salamander_genius_loci_NE",
        "salamander_genius_loci_SW",
        "salamander_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_sylph",
    name = ccb.content.text("Sylph"),
    targets = {
        "sylph_genius_loci_NW",
        "sylph_genius_loci_NE",
        "sylph_genius_loci_SW",
        "sylph_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_homullus",
    name = ccb.content.text("Homullus"),
    targets = {
        "homullus_genius_loci_NW",
        "homullus_genius_loci_NE",
        "homullus_genius_loci_SW",
        "homullus_genius_loci_SE",
    },
}

ccb.content.define_start_location {
    id = "sloc_xedra_chronomancer",
    name = ccb.content.text("Monochrome Meadow"),
    targets = { "xedra_monochrome_meadow" },
    flags = { "ALLOW_OUTSIDE" },
}
