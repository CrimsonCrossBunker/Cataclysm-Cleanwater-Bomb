local ccb = require("ccb")

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
