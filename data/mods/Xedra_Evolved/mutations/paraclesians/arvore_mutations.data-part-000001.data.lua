local ccb = require("ccb")

-- This is currently character creation only, ideally there will be ways to get this later in game.
ccb.content.define_mutation {
    id = "ARVORE_SEED_BEARER",
    name = ccb.content.text("Seed Bearer"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Arvore with this ability have a seed pocket on their body that over time fills with a set of from this region of the world.  Each time new seeds appear they will all be of the same type, but the types will vary at random."),
    categories = { "ARVORE" },
    purifiable = false,
    active = true,
    consumes_mana = true,
    cost = 500,
    activation_message = "",
    on_activate = "arvore_seed_bearer",
}
