local ccb = require("ccb")

ccb.content.define_harvest {
    id = "harvest_morningflower",
    drops = { { output = "morningflower_leaves", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "harvest_harfry",
    drops = { { output = "harfry_root", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "harvest_harfry_summer",
    drops = { { output = "harfry_root", base_quantity = { 2, 4 } } },
}

ccb.content.define_harvest {
    id = "harvest_maidenshair",
    drops = { { output = "maidens_hair", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "harvest_witchwood",
    drops = { { output = "witchwood_bark", base_quantity = { 3, 6 } } },
}

ccb.content.define_harvest {
    id = "harvest_starsbreath",
    drops = { { output = "starsbreath_harvested", base_quantity = { 2, 4 } } },
}

ccb.content.define_harvest {
    id = "harvest_corpsefire",
    drops = { { output = "corpsefire_cap", base_quantity = { 1, 3 } } },
}
