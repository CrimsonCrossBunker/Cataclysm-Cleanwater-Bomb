local ccb = require("ccb")

-- The exodii PAPR, with space for a baselard and Diyua grenade shells
ccb.content.define_item {
    id = "nomad_papr_blower_273grenade_off",
    name = ccb.content.plural_text("nomad utility belt", "nomad utility belts"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has a custom open-top pouch lined with 10 cartridge loops fit for 27.3x Diyua grenades.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  Activate it to turn it on."),
    mass = "1549 g",
    volume = "2250 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { { id = "leather", portions = 4 }, { id = "plastic", portions = 1 } },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            id = "papr_blower_filter",
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
            rigid = true,
        },
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
        {
            kind = "CONTAINER",
            max_item_length = "120 mm",
            capacity = "1760 ml",
            mass_limit = "1760 g",
            moves = 25,
            allowed_items = { "273x44HE", "273x44flare", "273x44trainer", "273x44thermobaric" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE", "USES_BIONIC_POWER" },
    subtype_order = { "armor", "tool" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 6 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    tool = { ammo_types = { "battery", "gasfilter_m" } },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            message = ccb.content.text("You activate the PAPR blower on your %s."),
            target = "nomad_papr_blower_273grenade_on",
        },
    },
}
