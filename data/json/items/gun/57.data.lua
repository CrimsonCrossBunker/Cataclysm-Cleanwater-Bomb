local ccb = require("ccb")

ccb.content.define_item {
    id = "fn57",
    copy_from = "gun_base_57_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("FN 5.7mm pistol"),
    description = ccb.content.text("Firing the armor-piercing 5.7x28mm round, this lightweight handgun was developed for NATO use as a sidearm capable of penetrating body armor.  Its proprietary and nonprolific ammunition kept it comparatively rare among both civilian and militant use, but the gun's ability to ignore most forms of conventional ballistic armor can't be argued with.  Given that its tiny bullets have next to no stopping power, its armor-penetrating capability comes at a considerable trade-off."),
    variant_kind = "gun",
    variants = {
        {
            id = "fn57",
            name = ccb.content.text("FN Five-seveN pistol"),
            description = ccb.content.text("Designed to work with FN's proprietary 5.7x28mm round, the Five-seveN is a lightweight pistol with a very high capacity, best used against armored opponents."),
        },
    },
    ascii_picture = "FN_five_seven",
    mass = "600 g",
    volume = "551 ml",
    length = "164 mm",
    price = "1 kUSD 249 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "fn57mag", "fn57mag_10rd" },
        },
    },
    gun = {
        barrel_length = "122 mm",
        damage = { type = "bullet", amount = -2 },
        dispersion = 440,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fn_p90",
    copy_from = "gun_base_57_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("P90 automatic PDW"),
    description = ccb.content.text("A late 90s manufactured personal defense weapon (PDW), this automatic firearm fires the high-velocity, proprietary 5.7x28mm cartridge.  Making use of top-mounted 50-round custom magazines which lock into the receiver of the weapon behind the grip, this little submachine gun packs quite the nasty payload.  Its small, high-speed caliber makes it excellent at both defeating armored opponents and firing short bursts manageably."),
    variant_kind = "gun",
    variants = {
        {
            id = "fn_p90",
            name = ccb.content.text("FN P90 submachine gun"),
            description = ccb.content.text("The first in a new genre of guns, termed \"personal defense weapons.\"  FN designed the P90 to use their proprietary high-velocity 5.7x28mm ammunition.  Made to fulfill NATO requests for a weapon chambered in a more suitable cartridge for defeating body armor than standard 9x19mm submachine guns, the FN P90 is excellent at firing short and controllable bursts manageably.  The PDW's small and high-speed 5.7mm ammunition, of which 50 rounds fit in the P90's top mounted magazine, packs quite the lethal payload for any armored opponent, whilst the firearm's bullpup design makes it commendably compact to boot."),
        },
    },
    mass = "2640 g",
    volume = "3817 ml",
    length = "511 mm",
    price = "3 kUSD 500 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "500 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "fnp90mag", "fnp90mag_10rd" },
        },
    },
    gun = {
        barrel_length = "264 mm",
        range = 4,
        skill = "smg",
        dispersion = 260,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 900 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ruger_57",
    copy_from = "gun_base_57_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Ruger-57 handgun"),
    description = ccb.content.text("Produced by the Ruger gun company, this full-sized pistol makes use of the 5.7x28mm cartridge.  One of the first pistols to both make use of the unusual round and achieve market success within the civilian world, it opened the door for accessible 5.7mm shooting due to its low price and reliable design."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_57",
            name = ccb.content.text("Ruger-57 handgun"),
            description = ccb.content.text("A full-sized polymer framed handgun chambered in the unusual 5.7x28mm cartridge, the Ruger-57 was one of the first commercially available 5.7mm pistols on the market, with its main competitor being FN's decades-old, and far pricier, Five-seveN pistol.  Featuring a lightweight ergonomic design, 1911-style thumb-safety, a high visibility green front-sight with adjustable black rear iron-sights, and a price point which hovered a good 500 dollars below its competition, the Ruger-57 made the comparatively niche 5.7x28mm round far more accessible to a wider margin of potential shooters."),
        },
    },
    mass = "690 g",
    volume = "937 ml",
    length = "220 mm",
    price = "799 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "ruger_57mag", "ruger_57_10_round_mag" },
        },
    },
    gun = {
        barrel_length = "125 mm",
        damage = { type = "bullet", amount = -2 },
        dispersion = 400,
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
    id = "fn_ps90",
    copy_from = "fn_p90",
    name = ccb.content.text("semi-automatic P90 carbine"),
    description = ccb.content.text("The civilian version of the older 5.7mm PDW, this carbine features a 16 inch long barrel, feeds from the same 50-round magazines as its predecessor, and is only capable of semi-automatic fire in order to keep it in line with American firearm restrictions."),
    variant_kind = "gun",
    variants = {
        {
            id = "fn_ps90",
            name = ccb.content.text("FN PS90 carbine"),
            description = ccb.content.text("Originally introduced in 2005, the PS90 is the civilian clone of the venerable FN P90, sharing much of the same characteristics and features as its fully-automatic older brother.  Chambering the same 5.7x28mm cartridge as its predecessor, in order to make it a legally distributable carbine in the eyes of the law the PS90 was manufactured to only be capable of semi-automatic fire, with a fitted-on 16-inch long barrel to sidestep NFA regulations on short-barreled rifles."),
        },
    },
    length = "670 mm",
    price = "1 kUSD 995 USD",
    gun = {
        barrel_length = "407 mm",
        skill = "rifle",
        range = 6,
        damage = { type = "bullet", amount = 2 },
        modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
        },
    },
}
