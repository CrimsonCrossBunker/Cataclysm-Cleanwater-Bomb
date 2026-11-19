local ccb = require("ccb")

-- effectively a weird single-shot self-loading Oerlikon KBA (but longer, and of course not an autocannon) with a 23x152mm round
-- desired to be single shot or with attachable mag, but because MAGAZINE and MAGAZINE_WELL are mortal enemies, 4 round magazine is used instead.
ccb.content.define_item {
    id = "ree_33",
    copy_from = "gun_base_rifle_semi",
    looks_like = "m2browning",
    name = ccb.content.text("exodii naval rifle"),
    description = ccb.content.text("Originally designed for naval defense of a small island country, this gun served Exodii as long as they existed, being one of its reliable tools in later stages of world decay.  Cheap ammunition, a simple mechanism, and immense power output would make it a great weapon for any survivor who is able to carry nearly a hundred kilo of its weight and is in need to penetrate a small bunker.  Unless your body is compatible with Exodii Standard Combat Bodyframe, you can only use it with a heavy-duty tripod, and only while prone.  Due to the size of a top-mounted magazine, the user needs to use a scope mounted on the side of a gun."),
    variant_kind = "gun",
    variants = {
        {
            id = "ree_33",
            name = ccb.content.plural_text("Ree 3.3 exodii rifle", "Ree 3.3 exodii rifle", "`Ree` in this case is butchered `Roe`, to carry some sort of nautical vibe"),
            description = ccb.content.text("Originally designed for naval defense of a small island country, this gun served Exodii as long as they existed, being one of its reliable tools in later stages of world decay.  Cheap ammunition, a simple mechanism, and immense power output would make it a great weapon for any survivor who is able to carry nearly a hundred kilo of its weight and is in need to penetrate a small bunker.  Unless your body is compatible with Exodii Standard Combat Bodyframe, you can only use it with a heavy-duty tripod, and only while prone.  Due to the size of a top-mounted magazine, the user needs to use a scope mounted on the side of a gun."),
        },
    },
    min_strength = 90,
    mass = "77000 g",
    volume = "151425 ml",
    length = "3365 mm",
    survival_price = "200 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "qt_steel" },
    flags = { "NEVER_JAMS", "SINGLE_ACTION" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ree_33_4_mag", "ree_33_53_mag" } } },
    melee_damage = { bash = 7 },
    gun = {
        barrel_length = "2890 mm",
        ammunition = { "33naval" },
        range = 100,
        dispersion = 130,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        min_cycle_recoil = 80000,
        default_mods = { "ree_33_tripod", "rifle_scope" },
    },
}
