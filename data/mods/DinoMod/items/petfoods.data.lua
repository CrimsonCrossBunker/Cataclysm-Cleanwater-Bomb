local ccb = require("ccb")

ccb.content.define_item {
    id = "cattlefodder",
    copy_from = "cattlefodder",
    name = ccb.content.plural_text("cattle fodder", "cattle fodder"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_C" } } },
}

ccb.content.define_item {
    id = "dogfood",
    copy_from = "dogfood",
    name = ccb.content.plural_text("wet dog food", "wet dog food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_A" } } },
}

ccb.content.define_item {
    id = "dogfood_dry",
    copy_from = "dogfood_dry",
    name = ccb.content.plural_text("dry dog food", "dry dog food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_A" } } },
}

ccb.content.define_item {
    id = "dogfood_raw",
    copy_from = "dogfood_raw",
    name = ccb.content.plural_text("raw dog food", "raw dog food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_A" } } },
}

ccb.content.define_item {
    id = "catfood",
    copy_from = "catfood",
    name = ccb.content.plural_text("wet cat food", "wet cat food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_B" } } },
}

ccb.content.define_item {
    id = "catfood_dry",
    copy_from = "catfood_dry",
    name = ccb.content.plural_text("dry cat food", "dry cat food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_B" } } },
}

ccb.content.define_item {
    id = "catfood_raw",
    copy_from = "catfood_raw",
    name = ccb.content.plural_text("raw cat food", "raw cat food"),
    comestible = {},
    inheritance = { add = { pet_food = { "DINOFOOD_B" } } },
}
