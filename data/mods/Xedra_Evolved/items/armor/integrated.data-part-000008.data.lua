local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_claws_werewolf",
    category = "armor",
    name = ccb.content.plural_text("werewolf claws", "werewolf claws"),
    description = ccb.content.text("You have massive claws on your end of your furry fingers."),
    mass = "100 g",
    volume = "250 ml",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 6 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "chitin" },
    symbol = ";",
    color = "dark_gray",
    techniques = {
        "CLAWS_SHAPESHIFTER", "CLAWS_SHAPESHIFTER_RENDING", "CLAWS_SHAPESHIFTER_CRIT",
        "CLAWS_SHAPESHIFTER_REDHANDED_RAGE_KNOCKBACK", "CLAWS_SHAPESHIFTER_REDHANDED_RAGE_AOE_SLASH",
    },
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { cut = 16 },
    armor = {
        portions = {
            {
                materials = { { id = "chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 20,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_werewolf_teeth",
    category = "armor",
    name = ccb.content.plural_text("werewolf teeth", "werewolf teeth"),
    description = ccb.content.text("A mouth full of vicious sharp teeth, almost twice as large as a wolf's."),
    mass = "50 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ",",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE_SHAPESHIFTER", "FANGS_BITE_SHAPESHIFTER_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 13 },
    armor = {
        warmth = 5,
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth" },
                subparts = { "mouth_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_werewolf_primal_form_fangs",
    category = "armor",
    name = ccb.content.plural_text("primal form teeth", "primal form teeth"),
    description = ccb.content.text("A gigantic mouth full of vicious sharp teeth, large enough to bite off a person's head."),
    mass = "50 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = ",",
    color = "white",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 4 } },
    techniques = { "FANGS_BITE_SHAPESHIFTER_WOLF_FORM", "FANGS_BITE_SHAPESHIFTER_WOLF_CRIT" },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "PADDED",
        "PROVIDES_TECHNIQUES",
    },
    melee_damage = { stab = 25 },
    armor = {
        warmth = 5,
        portions = {
            {
                materials = { { id = "bone", coverage = 100, thickness = 3.2 } },
                covers = { "mouth" },
                subparts = { "mouth_lips" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}
