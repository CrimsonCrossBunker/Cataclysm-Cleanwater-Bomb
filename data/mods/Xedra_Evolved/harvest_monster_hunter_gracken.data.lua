local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- zombie with long gangly arms
ccb.content.define_harvest {
    id = "zombie_grabber",
    copy_from = "zombie_grabber",
    delete = { drops = { { output = "sinew", mass_ratio = 0.00035 } } },
    extend = { drops = { { output = "grappler_sinew", mass_ratio = 0.00035 } } },
}

ccb.content.define_harvest {
    id = "pig_with_skull",
    copy_from = "pig_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "boar_with_skull",
    copy_from = "boar_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "sheep_with_skull",
    copy_from = "sheep_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "goat_with_skull",
    copy_from = "goat_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = {
            { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
            { output = "bezoar", skill_quantity = { 0, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "cow_with_skull",
    copy_from = "cow_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "horse_with_skull",
    copy_from = "horse_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = {
            { output = "herbivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "deer_with_skull",
    copy_from = "deer_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "moose_with_skull",
    copy_from = "moose_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "tusked_moose_with_skull",
    copy_from = "tusked_moose_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_fur",
    copy_from = "dog_with_skull_fur",
    delete = { drops = { { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } } },
    extend = {
        drops = {
            { output = "carnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_fur_mutant",
    copy_from = "dog_with_skull_fur_mutant",
    delete = { drops = { { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } } },
    extend = {
        drops = {
            { output = "carnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_leather",
    copy_from = "dog_with_skull_leather",
    delete = { drops = { { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } } },
    extend = {
        drops = {
            { output = "carnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "cougar_with_skull",
    copy_from = "cougar_with_skull",
    delete = { drops = { { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } } },
    extend = {
        drops = {
            { output = "carnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "raccoon_with_skull",
    copy_from = "raccoon_with_skull",
    extend = {
        drops = {
            { output = "small_omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "raccoon_with_skull_mutant",
    copy_from = "raccoon_with_skull_mutant",
    extend = {
        drops = {
            { output = "small_omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "bear_with_skull",
    copy_from = "bear_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "opossum_with_skull",
    copy_from = "opossum_with_skull",
    extend = {
        drops = {
            { output = "small_omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "skunk_with_skull",
    copy_from = "skunk_with_skull",
    extend = {
        drops = {
            { output = "small_omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "beaver_with_skull",
    copy_from = "beaver_with_skull",
    extend = {
        drops = {
            { output = "small_herbivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_triclopean_with_skull",
    copy_from = "dog_triclopean_with_skull",
    extend = {
        drops = {
            { output = "small_carnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

ccb.content.define_harvest {
    id = "spideer_with_skull",
    copy_from = "spideer_with_skull",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "ruminant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "cerbearus_with_skulls",
    copy_from = "cerbearus_with_skulls",
    delete = {
        drops = { { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "giant_ant",
    message = "<arachnid_harvest>",
    copy_from = "arachnid",
    extend = {
        drops = { { output = "ant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "giant_acid_ant",
    message = "<arachnid_harvest>",
    copy_from = "arachnid_acid",
    extend = {
        drops = { { output = "ant_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

ccb.content.define_harvest {
    id = "human",
    copy_from = "human",
    delete = {
        drops = { { output = "hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
    extend = {
        drops = { { output = "omnivore_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" } },
    },
}

-- your child sized humanoid zombie
ccb.content.define_harvest {
    id = "zombie_child",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_generic_harvest>",
    delete = { drops = { { output = "sinew", category = "bone", mass_ratio = 0.00035 } } },
    extend = {
        drops = {
            { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
            { output = "underdeveloped_sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
}

-- your runner humanoid zombie
ccb.content.define_harvest {
    id = "zombie_runner",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_generic_harvest>",
    delete = { drops = { { output = "sinew", category = "bone", mass_ratio = 0.00035 } } },
    extend = {
        drops = {
            { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
            { output = "runner_sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
}
