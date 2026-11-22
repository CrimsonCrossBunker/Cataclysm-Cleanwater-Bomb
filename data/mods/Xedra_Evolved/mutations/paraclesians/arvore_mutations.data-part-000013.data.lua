local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_TREE_FORM",
    name = ccb.content.text("One with the Forest"),
    points = 8,
    description = ccb.content.text("You may transform into a tree, extending roots and spreading leaves out to the sun.  You will heal faster, gain more benefit from sleep, and almost all monsters will ignore you, but you will only be dimly aware of the outside world and will be nearly unable to move."),
    prerequisites = { "ARVORE_HEAL_LIMB_REGEN" },
    secondary_prerequisites = { "ARVORE_SUN_FOODS" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your legs fuse together and your arms stretch toward the sky as you put down roots and transform into a towering tree."),
    on_activate = "arvore_tree_form_on",
    on_deactivate = "arvore_tree_form_off",
}
