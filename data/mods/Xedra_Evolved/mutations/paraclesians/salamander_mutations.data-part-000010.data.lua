local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM_APPEARANCE",
    name = ccb.content.text_without_extraction("Form of Billowing Smoke Appearance"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the sprite override info for Form of Billowing Smoke.  You shouldn't be able to see it in game."),
    valid = false,
    player_display = false,
    appearance = { id = "fd_nuke_gas", tile_category = "field" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    flags = { "CANNOT_CONSUME_DRUGS" },
}
