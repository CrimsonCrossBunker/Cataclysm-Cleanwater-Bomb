local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_dinoexhibit",
    name = ccb.content.text("Dinosaur exhibit"),
    targets = { "dinoexhibit" },
}

ccb.content.define_start_location {
    id = "sloc_dinolab",
    name = ccb.content.text("DinoLab"),
    targets = { "microlab_DinoLab_edge" },
}

ccb.content.define_start_location {
    id = "sloc_dinozoo_cafeteria",
    name = ccb.content.text("DinoZoo (Cafeteria)"),
    targets = { "dinozoo_0_1" },
}

ccb.content.define_start_location {
    id = "sloc_swamp",
    name = ccb.content.text("Middle of Swamp"),
    targets = { "forest_water" },
    flags = { "ALLOW_OUTSIDE" },
}
