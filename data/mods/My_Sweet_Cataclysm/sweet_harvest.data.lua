local ccb = require("ccb")

ccb.content.define_harvest {
    id = "marshmallow_boy",
    leftovers = "ruined_candy",
    drops = {
        { output = "marshmallow_flesh", category = "flesh", mass_ratio = 0.7 },
        { output = "bone_sugar", category = "bone", mass_ratio = 0.15 },
        { output = "syrup_corn", category = "blood", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "armored_marshmallow_boy",
    leftovers = "ruined_candy",
    drops = {
        { output = "smores_flesh", category = "flesh", mass_ratio = 0.65 },
        { output = "bone_sugar", category = "bone", mass_ratio = 0.15 },
        { output = "syrup_corn", category = "blood", mass_ratio = 0.05 },
        { output = "grahmcrackers_shell", category = "skin", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "gummy_bear",
    leftovers = "ruined_candy",
    drops = {
        { output = "candy3_flesh", category = "flesh", mass_ratio = 0.7 },
        { output = "bone_sugar", category = "bone", mass_ratio = 0.15 },
        { output = "syrup_corn", category = "blood", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "cracker_boy",
    leftovers = "ruined_candy",
    drops = { { output = "grahmcrackers_shell", category = "flesh", mass_ratio = 0.7 } },
}

ccb.content.define_harvest {
    id = "cookie_beast",
    leftovers = "ruined_candy",
    drops = { { output = "cookie_flesh", category = "flesh", mass_ratio = 0.7 } },
}

ccb.content.define_harvest {
    id = "gum_spider",
    leftovers = "ruined_candy",
    drops = { { output = "gum_flesh", category = "flesh", mass_ratio = 0.7 } },
}

ccb.content.define_harvest {
    id = "caff_gum_spider",
    leftovers = "ruined_candy",
    drops = { { output = "caff_gum_flesh", category = "flesh", mass_ratio = 0.7 } },
}

ccb.content.define_harvest {
    id = "choc_cows",
    message = ccb.content.text("As you butcher the chocolate corpse, you break the large pieces of flesh down into more manageable chunks."),
    drops = {
        { output = "cow_candy_flesh", category = "flesh", mass_ratio = 0.7 },
        { output = "bone_sugar", category = "bone", mass_ratio = 0.15 },
        { output = "blood_chocolate", category = "blood", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "licorice_snake",
    leftovers = "ruined_candy",
    message = ccb.content.text("You carefully open the snake to extract the sweet fillets."),
    drops = {
        { output = "licorice_flesh", category = "flesh", mass_ratio = 0.7 },
        { output = "bone_sugar", category = "bone", mass_ratio = 0.05 },
        { output = "syrup_corn", category = "blood", mass_ratio = 0.05 },
    },
}
