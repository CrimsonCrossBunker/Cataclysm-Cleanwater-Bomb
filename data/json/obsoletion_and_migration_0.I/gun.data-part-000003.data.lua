local ccb = require("ccb")

ccb.content.define_item {
    id = "rm121aux",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("caseless aux shotgun", "caseless aux shotguns"),
    description = ccb.content.text("Designated the Rivtech RM121 auxiliary weapon system, this is a magazine-fed semi-automatic caseless shotgun, which can be mounted under the barrel of many rifles.  Accepts RMSA10 box magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "rm121aux",
            name = ccb.content.plural_text("RM121 aux shotgun", "RM121 aux shotguns"),
            description = ccb.content.text("The Rivtech RM121 auxiliary weapon system is a magazine-fed semi-automatic caseless shotgun, which can be mounted under the barrel of many rifles.  Accepts RMSA10 box magazines."),
        },
    },
    mass = "1140 g",
    volume = "750 ml",
    length = "380 mm",
    price = "1 kUSD 200 USD",
    survival_price = "50 USD",
    materials = { "superalloy", "ceramic" },
    symbol = ":",
    color = "dark_gray",
    flags = { "WATERPROOF_GUN", "NEVER_JAMS" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "20x66_10_mag" } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "419 mm",
        ammunition = { "20x66mm" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        dispersion = 320,
        durability = 9,
        reload_time = 125,
    },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("underbarrel"),
        incompatible_mods = {
            "knife_combat_army", "knife_combat", "enfield_bayonet", "knife_combat_marine",
            "makeshift_bayonet", "sword_bayonet",
        },
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 2 }, { id = "shotgun", count = 2 } },
}

ccb.content.define_item {
    id = "rm121aux_mod",
    copy_from = "rm121aux",
    name = ccb.content.plural_text("modified RM121 aux shotgun", "modified RM121 aux shotguns"),
    description = ccb.content.text("The Rivtech RM121 auxiliary weapon system is a magazine-fed semi-automatic caseless shotgun, which can be mounted under the barrel of many rifles.  Accepts RMSA10 box magazines.  This one was modified and customized to mount on pretty much any weapon other than pistols, if you so want."),
    gunmod = {
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
    },
}
