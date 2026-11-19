local ccb = require("ccb")

-- Stats are based off of a brick.
ccb.content.define_item {
    id = "technomancer_booster_1",
    symbol = ",",
    color = "brown",
    name = ccb.content.plural_text("technomancer's clay tablet", "technomancer's clay tablets"),
    description = ccb.content.text("A fire-hardened clay tablet depicting a technomancer rune.  Breaking the tablet will release the stored magical energy, boosting your technomancer caster level by 1 for a while."),
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "clay", "stone" },
    mass = "969 g",
    volume = "500 ml",
    tool = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel a surge of power as the clay tablet crumbles between your fingers."),
            effects = { { id = "technomancer_cl_booster_effect", duration = "2 h" } },
            moves = 50,
        },
    },
}

-- based on a bone shiv.
ccb.content.define_item {
    id = "biomancer_booster_1",
    name = ccb.content.plural_text("biomancer's bone syringe", "biomancer's bone syringes"),
    description = ccb.content.text("A hollow bone, about 20 cm long, which has been broken at one end and sharpened into a crude syringe.  A biomancer rune is carved on the surface.  By jabbing it into yourself, you can release stored biomancer booster sludge into yourself, thereby boosting your biomancer caster level by 1 for a while.  Doing so is about as painful as it sounds."),
    symbol = "/",
    color = "white",
    mass = "169 g",
    volume = "188 ml",
    length = "20 cm",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = { grip = "solid", length = "hand", surface = "point", balance = "neutral" },
    materials = { "bone" },
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 12 } },
    flags = { "SHEATH_KNIFE", "FRAGILE_MELEE", "ALLOWS_BODY_BLOCK" },
    weapon_categories = { "KNIVES" },
    melee_damage = { bash = 3, stab = 12 },
    pockets = { { kind = "MAGAZINE", watertight = true, ammunition = { biomancer_booster_sludge = 5 } } },
    tool = { charges_per_use = 1, ammo_types = { "biomancer_booster_sludge" } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel a surge of power as the bone syringe deposits the sludge inside your body."),
            effects = { { id = "biomancer_cl_booster_effect", duration = "8 h" } },
            stat_adjustments = { pain = 5 },
            moves = 50,
        },
    },
}

-- based on a bone shiv.
ccb.content.define_item {
    id = "biomancer_booster_2",
    name = ccb.content.plural_text("biomancer's syringe", "biomancer's syringes"),
    description = ccb.content.text("An elegant, sturdy metal syringe with a biomancer rune carved on the outside.  It can be used to administer stored biomancer booster sludge into yourself, thereby boosting your biomancer caster level by 2 for a while."),
    symbol = "/",
    color = "white",
    mass = "230 g",
    volume = "200 ml",
    length = "20 cm",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE", watertight = true, ammunition = { biomancer_booster_sludge = 10 } } },
    tool = { charges_per_use = 1, ammo_types = { "biomancer_booster_sludge" } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel a surge of power as the syringe deposits the sludge inside your body."),
            effects = {
                { id = "biomancer_cl_booster_effect", duration = "8 h" },
                { id = "biomancer_cl_booster_effect", duration = "8 h" },
            },
            moves = 50,
            stat_adjustments = { pain = 2 },
        },
    },
}
