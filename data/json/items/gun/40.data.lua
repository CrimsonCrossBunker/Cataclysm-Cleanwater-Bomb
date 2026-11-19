local ccb = require("ccb")

ccb.content.define_item {
    id = "glock_22",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock 22 pistol"),
    description = ccb.content.text("A .40 S&W variant of the popular Glock 17 pistol.  The standard-issue firearm of the FBI from 1997-2016, and of countless other law enforcement agencies worldwide."),
    ascii_picture = "glock_17",
    mass = "645 g",
    volume = "433 ml",
    length = "234 mm",
    price = "690 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "250 ml",
            allowed_items = { "glock40mag_10", "glock40mag", "glock40bigmag" },
        },
    },
    gun = {
        barrel_length = "125 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_23",
    copy_from = "glock_22",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 23 pistol"),
    description = ccb.content.text("A compact version of the Glock 22, chambered in .40 S&W.  Popular among civilian and law enforcement alike for its capacity, durability, and reliability."),
    mass = "600 g",
    volume = "401 ml",
    length = "187 mm",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "250 ml",
            allowed_items = { "glock40mag_10", "glock40mag", "glock40bigmag" },
        },
    },
    gun = {
        barrel_length = "102 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_27",
    copy_from = "glock_22",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 27 pistol"),
    description = ccb.content.text("A diminutive pistol chambered in .40 S&W.  Widely popular among concealed carriers, its popularity soared further in the months leading up to the Cataclysm, partly due to its ability to fit the higher capacity magazines of its older brothers."),
    mass = "550 g",
    volume = "349 ml",
    length = "165 mm",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "250 ml",
            allowed_items = { "glock40mag_9", "glock40mag_10", "glock40mag", "glock40bigmag" },
        },
    },
    gun = {
        barrel_length = "87 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "px4_40",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Beretta Px4 Storm .40 S&W pistol"),
    description = ccb.content.text("Lighter than Beretta's iconic 92 series of guns, the Px4 Storm was built by utilizing light-weight polymer construction with steel inserts.  Its shape was also optimized for concealed carry.  This one is chambered in .40 S&W."),
    mass = "785 g",
    volume = "520 ml",
    length = "231 mm",
    price = "650 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "250 ml",
            allowed_items = { "px4_40mag_10", "px4_40mag" },
        },
    },
    gun = {
        barrel_length = "102 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sig_40",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.plural_text("SIG Pro .40", "SIG Pro .40"),
    description = ccb.content.text("Originally marketed as a lightweight and compact alternative to older SIG handguns, the Pro .40 is popular among European police forces."),
    ascii_picture = "sig_pro_40",
    mass = "822 g",
    volume = "509 ml",
    length = "221 mm",
    price = "750 USD",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", magazine_well = "250 ml", allowed_items = { "sig40mag" } } },
    gun = {
        barrel_length = "99 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Crafting recipe must make use of angle grinder, bench grinder, set square and vise, which don't yet exist in game. No factory mags until UMP40, mp5/40, or other straight .40 mags are implemented.
ccb.content.define_item {
    id = "smg_40",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "hk_mp5",
    name = ccb.content.text(".40 S&W Luty submachine gun"),
    description = ccb.content.text("A Luty pattern makeshift smoothbore SMG crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop, but still very unreliable.  This one is chambered for .40 S&W cartridges and accepts custom-made makeshift magazines."),
    mass = "3520 g",
    volume = "1110 ml",
    length = "538 mm",
    price = "200 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "smg_40_mag" } } },
    gun = {
        barrel_length = "229 mm",
        skill = "smg",
        damage = { type = "bullet", amount = -4 },
        dispersion = 590,
        durability = 4,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 600 } },
        loudness = 25,
        barrel_volume = "250 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hi_power_40",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Browning Hi-Power .40 S&W"),
    description = ccb.content.text("The Browning Hi-Power is a semi-automatic handgun developed shortly before the Second World War.  Widely issued since then, it remains in use by India, Canada, and Australia.  This is a commercial variant produced by Browning Arms in .40 S&W."),
    mass = "907 g",
    volume = "274 ml",
    length = "228 mm",
    price = "540 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "185 ml", kind = "MAGAZINE_WELL", allowed_items = { "bhp40mag" } } },
    gun = {
        barrel_length = "119 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hptjcp",
    copy_from = "gun_base_40_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.plural_text("Hi-Point Model JCP", "Hi-Point Model JCP"),
    description = ccb.content.text("The Hi-Point Model JCP is a blowback operated semi-automatic pistol designed by Hi-Point Firearms, which is known for making inexpensive firearms, and for making said firearms bulky and uncomfortable.  Hi-Points have slides made with a zinc pot-metal which is relatively fragile compared to steel slides."),
    mass = "990 g",
    volume = "546 ml",
    length = "234 mm",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = { { magazine_well = "312 ml", kind = "MAGAZINE_WELL", allowed_items = { "hptjcpmag" } } },
    gun = {
        barrel_length = "110 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
