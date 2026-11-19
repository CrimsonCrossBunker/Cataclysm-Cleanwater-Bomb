local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_shotgun",
    copy_from = "mossberg_590",
    name = ccb.content.text("Benelli 315"),
    description = ccb.content.text("A widely popular combat shotgun featuring minor iterative refinements to a base design nearly three centuries old.  Whether the design is outdated or unsurpassable remains a matter of personal opinion."),
    price = "510 USD",
    survival_price = "510 USD",
    variants = {
        {
            id = "vatforged",
            name = ccb.content.text("vatforged shotgun"),
            description = ccb.content.text("A crude but otherwise serviceable pump-action shotgun built from a hacked or scavenged template.  Frequently seen in the hands of frontier pirates, settlers or salvors.  Not that such groups are much different from one another."),
            weight = 3,
        },
        {
            id = "military",
            name = ccb.content.text("m2101-UASTA shotgun"),
            description = ccb.content.text("The standard issue combat shotgun of UICA marine and colonial forces.  Shot shells have poor performance against modern combat armor, so the M2101 is more often used during policing and peacekeeping operations."),
            weight = 2,
        },
        {
            id = "branded",
            name = ccb.content.text("Benelli 315"),
            description = ccb.content.text("A widely popular combat shotgun featuring minor iterative refinements to a base design nearly three centuries old.  Whether the design is outdated or unsurpassable remains a matter of personal opinion."),
            weight = 2,
        },
    },
    gun = {
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "brass catcher", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_shotgun_magnastorm",
    copy_from = "mossberg_590",
    name = ccb.content.plural_text("Accipiter Magnastorm-12", "Accipiter Magnastorm-12"),
    description = ccb.content.text("An advanced shotgun that combines chemical and electromagnetic propulsion systems to accelerate and focus a cloud of steel flechettes.  Resulting in a longer effective range and greater penetration than whats conventionally possible.  Most often deployed during low-intensity corporate conflicts."),
    variants = {},
    price = "4 kUSD",
    survival_price = "4 kUSD",
    gun = {
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "brass catcher", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        built_in_mods = { "afs_magnetic_choke", "afs_shotgun_gauss" },
    },
}

ccb.content.define_item {
    id = "afs_raketa_shotgun",
    copy_from = "gun_base_shotgun_semi",
    looks_like = "remington_870",
    name = ccb.content.text("Raketa"),
    description = ccb.content.text("A massive TSKBEM-design shotgun intended for exosuit forces, the Raketa aka 'Rocket' is a magazine-fed bullpup shotgun featuring twin barrels.  This design remains popular for extra-atmospheric operations as the 12ga rounds are less likely to pierce a ship or station's delicate hull."),
    mass = "8 kg",
    volume = "3064 ml",
    length = "1250 mm",
    min_strength = 16,
    materials = { "qt_steel", "plastic", "carbide" },
    symbol = "r",
    color = "light_gray",
    price = "2510 USD",
    survival_price = "2510 USD",
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "afs_raketa30mag" } } },
    melee_damage = { bash = 20 },
    gun = {
        dispersion = 125,
        durability = 7,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("single"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("2 rd."), quantity = 2 },
        },
        barrel_volume = "500 ml",
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "brass catcher", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_drotik_shotpistol",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("Drotik Shotpistol"),
    description = ccb.content.text("A massive TSKBEM-designed 'sidearm' intended for exosuits and uplifts, the Drotik aka 'Dart' is a large revolver firing 12ga shells."),
    mass = "2250 g",
    price = "1510 USD",
    survival_price = "1510 USD",
    volume = "1450 ml",
    length = "475 mm",
    min_strength = 14,
    materials = { "qt_steel", "plastic", "carbide" },
    symbol = "r",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { shot = 8 },
            allowed_speedloaders = { "afs_shot_speedloader8" },
        },
    },
    melee_damage = { bash = 16 },
    gun = {
        ammunition = { "shot" },
        dispersion = 350,
        clip_size = 8,
        mod_locations = {
            { id = "grip", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
