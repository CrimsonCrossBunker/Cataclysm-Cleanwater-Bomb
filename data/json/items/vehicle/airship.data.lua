local ccb = require("ccb")

-- 25 kg per cubic meter, in the lower half of the range for compressed hydrogen.
ccb.content.define_item {
    id = "c_hydrogen_gas",
    name = ccb.content.plural_text("hydrogen gas", "hydrogen gas"),
    category = "chems",
    description = ccb.content.text("A light, flammable gas compressed for use as fuel.  Requires a lot of energy to produce, even moreso without pre-cataclysm industry.  Quite energy dense, though not very volume-efficient."),
    mass = "2500 mg",
    volume = "100 ml",
    price = "50 cent",
    survival_price = "5 cent",
    symbol = "=",
    color = "white",
    default_container = "metal_tank_little",
    phase = "liquid",
    materials = { "hydrogen" },
    ammunition = {
        damage = { type = "heat", amount = 9, penetration = 2 },
        range = 6,
        dispersion = 120,
        type = "c_hydrogen",
        effects = { "INCENDIARY" },
    },
}

ccb.content.define_item {
    id = "airship_balloon_item",
    name = "airship balloon",
    description = "A big plastic airbag filled with hydrogen gas.  Provides lift if installed on a vehicle, but you'll need a propeller to do anything more than float up and down.",
    symbol = "o",
    color = "light_gray",
    category = "veh_parts",
    mass = "3 kg",
    volume = "100 L",
    price = "5 USD",
    survival_price = "25 cent",
    explode_in_fire = true,
    materials = { "plastic" },
    melee_damage = { bash = 4 },
    blast = { power = 100 },
}
