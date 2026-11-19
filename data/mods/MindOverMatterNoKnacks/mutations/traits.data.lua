local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PSYCHIC_KNACK",
    copy_from = "PSYCHIC_KNACK",
    name = ccb.content.text("Psychic"),
    description = ccb.content.text("You can use the hidden power of your mind to affect the physical world."),
    player_display = true,
    flags = { "ATTUNEMENT" },
}
