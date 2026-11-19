local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_anti_psi",
    category = "weapons",
    looks_like = "grenade",
    name = ccb.content.plural_text("null grenade", "null grenades"),
    description = ccb.content.text("A strange grenade, designed like nothing you've seen before.  It's round, with flat black crystalline panels like television screens on four sides, and two buttons on either end.  On both of the buttons is a large Ψ, surrounded by a circle with a line through it."),
    mass = "397 g",
    volume = "540 ml",
    price = "10000 USD",
    survival_price = "200 USD",
    materials = { "steel", "plastic", "nether_crystal" },
    symbol = "*",
    color = "dark_gray",
    flags = { "GRENADE" },
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_anti_psi_act",
            message = ccb.content.text("You press the buttons on the sides of the null grenade."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Push buttons"),
        },
    },
}

ccb.content.define_item {
    id = "grenade_anti_psi_act",
    category = "weapons",
    name = ccb.content.plural_text("active null grenade", "active null grenades"),
    description = ccb.content.text("This null grenade is activate and ready to unleash its pulse.  You'd better throw it!"),
    mass = "397 g",
    volume = "270 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -1,
    materials = { "steel", "plastic", "nether_crystal" },
    symbol = "*",
    color = "dark_gray",
    flags = { "BOMB", "TRADER_AVOID", "DANGEROUS" },
    revert_to = "grenade_anti_psi_expended",
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Push buttons"),
        },
    },
    countdown_action = { kind = "cast_spell", spell = "grenade_anti_psi_explosion", no_fail = true, level = 0 },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "grenade_anti_psi_expended",
    category = "weapons",
    looks_like = "grenade",
    name = ccb.content.plural_text("expended null grenade", "expended null grenades"),
    description = ccb.content.text("A strange grenade, designed like nothing you've seen before.  It's round, with flat black crystalline panels like television screens on four sides, and two buttons on either end.  On both of the buttons is a large Ψ, surrounded by a circle with a line through it.  The buttons on either end are depressed."),
    mass = "397 g",
    volume = "540 ml",
    price = "10000 USD",
    survival_price = "0 USD",
    materials = { "steel", "plastic", "nether_crystal" },
    symbol = "*",
    color = "dark_gray",
    melee_damage = { bash = 6 },
    tool = {},
}

ccb.content.define_item {
    id = "pyrokinetic_matrix_crystal_bomb",
    category = "weapons",
    looks_like = "matrix_crystal_pyrokinesis",
    copy_from = "matrix_crystal_pyrokinesis",
    name = ccb.content.plural_text("pyrokinetic matrix crystal bomb", "pyrokinetic matrix crystal bombs"),
    description = ccb.content.text("A matrix crystal attuned to pyrokinesis.  This one has a (currently) stable loop of energy set up within it.  It would take only a thought to destabilize the energy loop and set up a reaction that would lead to a massive explosion."),
    flags = { "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "pyrokinetic_matrix_crystal_bomb_act",
            message = ccb.content.text("With a thought, you destabilize the matrix crystal."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Overcharge the crystal"),
        },
    },
}
