local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_VINE_DRAG",
    name = ccb.content.text("Entangling Vines"),
    points = 6,
    description = ccb.content.text("At will, you can extend a cluster of grasping vines to grab one target and drag them in.  They have a range equal to 1/2 your Dexterity."),
    prerequisites = { "ARVORE_CLIMBING_VINE_SPELL" },
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    consumes_mana = true,
    cost = 25,
    activation_message = ccb.content.text("Vines lash out toward your target."),
    on_activate = "arvore_vine_drag",
}

ccb.content.define_mutation {
    id = "ARVORE_WOOD_CLAWS",
    name = ccb.content.text("Jagged Wooden Claws"),
    points = 2,
    description = ccb.content.text("At will, you can transform your hands into jagged wooden claws.  They are potent weapons but make anything other than combat more difficult."),
    types = { "CLAWS" },
    prerequisites = { "JAUNDICE_ARVORE_ALCHEMY", "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    activation_setup_only = true,
    active = true,
    activation_message = ccb.content.text("Your fingers itch as jagged wood rapidly covers them."),
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}
