local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_FEIGN_DEATH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Corpse's Countenance"),
    description = ccb.content.text("You are close enough to death now that you can easily imitate it; your heartbeat slows to a near-stop, your breathing ceases, your flesh grows pale, and you show no signs of life.  You will be unable to move or act while feigning death, but enemies will generally ignore you.  You will be unable to feign death twice in a short time if you are seen ending your masquerade."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You collapse in an imitation of death."),
    on_deactivate = "vampire_feign_death_off",
    enchantments = { "INLINE_ENCH_VAMPIRE_FEIGN_DEATH_0" },
}
