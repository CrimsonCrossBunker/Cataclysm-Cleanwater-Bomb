local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_limb_leg_l",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Limb - Left Leg CBM", "Bionic Limb - Left Leg CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("CBM which replaces the left leg with a bionic counterpart."),
    price = "2 kUSD 200 USD",
    mass = "30000 g",
    volume = "8000 ml",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_limb_leg_r",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Limb - Right Leg CBM", "Bionic Limb - Right Leg CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("CBM which replaces the left leg with a bionic counterpart."),
    price = "2 kUSD 200 USD",
    mass = "30000 g",
    volume = "8000 ml",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_limb_arm_l",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Limb - Left Arm CBM", "Bionic Limb - Left Arm CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("CBM which replaces the left leg with a bionic counterpart."),
    price = "2 kUSD 200 USD",
    mass = "20000 g",
    volume = "5000 ml",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_limb_arm_r",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Limb - Right Arm CBM", "Bionic Limb - Right Arm CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("CBM which replaces the left leg with a bionic counterpart."),
    price = "2 kUSD 200 USD",
    mass = "20000 g",
    volume = "5000 ml",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_limb_treads",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Limb - Tank Treads CBM", "Bionic Limb - Tank Treads CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("CBM which replaces the left leg with a bionic counterpart."),
    price = "2 kUSD 200 USD",
    mass = "120000 g",
    volume = "40000 ml",
    bionic = { difficulty = 3 },
}
