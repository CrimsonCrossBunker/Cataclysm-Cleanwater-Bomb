local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ANCHORCROWN_NOSPELL",
    name = ccb.content.text_without_extraction("Psionic negation"),
    description = ccb.content.text_without_extraction("The anchor crown you're wearing is shutting down your psionic powers."),
    points = 5,
    visibility = 0,
    ugliness = 0,
    player_display = false,
    valid = false,
    flags = { "NO_PSIONICS" },
}

ccb.content.define_mutation {
    id = "TELEPATHICDAMPENER_SHIELD",
    name = ccb.content.text("Telepathic Dampening"),
    description = ccb.content.text("The telepathic dampener you're wearing is protecting your mind."),
    points = 5,
    visibility = 0,
    ugliness = 0,
    player_display = true,
    valid = false,
    flags = { "TEEPSHIELD" },
}

ccb.content.define_mutation {
    id = "PHOTOLIXIR_LIGHT",
    name = ccb.content.text("Golden Radiance"),
    points = 0,
    description = ccb.content.text("You can make the air around you emit a strong light."),
    active = true,
    player_display = true,
    purifiable = false,
    valid = false,
    cost = 0,
    transform = {
        target = "PHOTOLIXIR_LIGHT_active",
        message = ccb.content.text("The air around you starts glowing brightly."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "PHOTOLIXIR_LIGHT_active",
    name = ccb.content.text("Golden Radiance (on)"),
    description = ccb.content.text("The air around you is emitting a bright light."),
    copy_from = "PHOTOLIXIR_LIGHT",
    valid = false,
    transform = {
        target = "PHOTOLIXIR_LIGHT",
        message = ccb.content.text("The air around you loses its radiance."),
        active = false,
        moves = 10,
    },
    enchantments = { "INLINE_ENCH_PHOTOLIXIR_LIGHT_active_0" },
}
