local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        -- Sets the latitude used for sunrise/sunset times.  Set to Raleigh.
        LATITUDE = 35.787743,
        -- Sets the longitude used for sunrise/sunset times.  Set to Raleigh.
        LONGITUDE = -78.644257,
        -- Used here to enable body slots for magical tattoos
        CBM_SLOTS_ENABLED = true,
        SPAWN_ANIMAL_DENSITY = 1.5,
        DISABLE_ANIMAL_CLASH = true,
        INT_BASED_LEARNING_FOCUS_ADJUSTMENT = 6,
        ZOMBIFY_INTO_ENABLED = false,
        -- Higher-evo monsters should mostly be spawned through mapgen or map extras, so just crank
        -- this up so we don't have to edit a ton of monsters to turn evolution off
        EVOLUTION_INVERSE_MULTIPLIER = 99.0,
    },
}
