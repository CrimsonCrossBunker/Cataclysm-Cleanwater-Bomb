local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_THORN_SKIN",
    name = ccb.content.text("Hidden Thorns"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Every rose has its thorn and so do you.  With a moment's concentration, you can exude thorns through your skin that have a chance of damaging attackers while increasing the damage of your unarmed attacks.  However, you cannot wear rigid armor over your thorns."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    types = { "ARMOR" },
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Stiff wooden thorns push out from your skin."),
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}
