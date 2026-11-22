local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_SILVER_CLAWS",
    name = ccb.content.text("Argent Claws"),
    points = 4,
    description = ccb.content.text("While in war form, transform your claws into silver, causing them to do additional damage to creatures of the Nether."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 6,
    activation_message = "",
    on_activate = "werewolf_silver_claws_on",
    on_deactivate = "werewolf_silver_claws_off",
}
