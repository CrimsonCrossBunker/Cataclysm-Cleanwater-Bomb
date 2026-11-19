local ccb = require("ccb")

-- drops mammoth wools, tusks and large bone
ccb.content.define_harvest {
    id = "woolly_mammoth",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.02 },
            { output = "large_bone", category = "bone", mass_ratio = 0.13 },
            { output = "wool_staple", category = "skin", mass_ratio = 0.21 },
            { output = "mammoth_tusk", skill_quantity = { 1, 2 }, maximum = 2, category = "bone" },
        },
    },
}

-- drops large stomach, mammoth wool, but no tusks
ccb.content.define_harvest {
    id = "woolly_mammoth_baby",
    copy_from = "mammal_large_leather",
    extend = { drops = { { output = "wool_staple", category = "skin", mass_ratio = 0.21 } } },
}

-- drops large bones, tusks
ccb.content.define_harvest {
    id = "mammoth",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.02 },
            { output = "large_bone", category = "bone", mass_ratio = 0.13 },
            { output = "mammoth_tusk", skill_quantity = { 1, 2 }, maximum = 2, category = "bone" },
        },
    },
}

-- drops large stomach, shell
ccb.content.define_harvest {
    id = "glyptotherium",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        },
    },
    extend = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.1 },
            { output = "large_bone", category = "bone", mass_ratio = 0.05 },
            { output = "glypto_shell", skill_quantity = { 1, 1 }, maximum = 1, category = "bone" },
            { output = "raw_leather", category = "skin", mass_ratio = 0.005 },
        },
    },
}

-- drops large bones, pelts
ccb.content.define_harvest {
    id = "pelt_megafauna",
    copy_from = "mammal_large_fur",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        },
    },
    extend = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.02 },
            { output = "large_bone", category = "bone", mass_ratio = 0.13 },
            { output = "raw_fur", category = "skin", mass_ratio = 0.005 },
        },
    },
}

-- drops large bones, leather
ccb.content.define_harvest {
    id = "leather_megafauna",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        },
    },
    extend = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.02 },
            { output = "large_bone", category = "bone", mass_ratio = 0.13 },
            { output = "raw_leather", category = "skin", mass_ratio = 0.005 },
        },
    },
}
