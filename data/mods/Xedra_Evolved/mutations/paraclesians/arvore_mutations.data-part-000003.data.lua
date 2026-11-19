local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_TOXIC_FLESH",
    name = ccb.content.text("Essence of Hemlock"),
    points = 8,
    description = ccb.content.text("With a brief effort of will, the Arvore may infuse their blood with a poison that harms any who bite them."),
    prerequisites = { "ARVORE_BLOOD" },
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    cooldown = 15,
    consumes_mana = true,
    cost = 1,
    activation_message = ccb.content.text("Your skin itches."),
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}

ccb.content.define_mutation {
    id = "ARVORE_POISON_POLLEN",
    name = ccb.content.text("Scent of Night-Blooming Flowers"),
    points = 5,
    description = ccb.content.text("The Arvore may release clouds of pollen that ruin the coordination of their enemies when breathed in."),
    prerequisites = { "ARVORE_FLORAL_SCENT", "ARVORE_MIND_CONTROL_POLLEN" },
    secondary_prerequisites = { "ARVORE_TOXIC_FLESH" },
    categories = { "ARVORE" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    cooldown = 5,
    consumes_mana = true,
    cost = 1,
    activation_message = ccb.content.text("The air fills with clouds of pollen."),
    on_activate = "enable_form_effect",
    on_deactivate = "disable_form_effect",
}
