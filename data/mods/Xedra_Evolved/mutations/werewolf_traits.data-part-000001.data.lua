local ccb = require("ccb")

-- Tier 2 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
    name = ccb.content.text("Sense the Outsider"),
    points = 2,
    description = ccb.content.text("The People have long fought the things from Outside and developed a keen sense when one of them is near.  When active, you can sense nearby creatures of the Nether or beings from Under the Hill."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 5,
    activation_message = ccb.content.text("You open your senses to the presence of your prey."),
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}
