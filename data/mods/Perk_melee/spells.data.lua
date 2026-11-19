local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "make_way_push",
    name = ccb.content.text_without_extraction("Make Way Push"),
    description = ccb.content.text_without_extraction("Pushes all objects outside."),
    message = "",
    effect = "area_push",
    shape = "blast",
    valid_targets = { "ground", "hostile" },
    min_range = 5,
    max_range = 15,
    range_increment = 2.5,
    min_aoe = 2,
    max_aoe = 2,
    max_level = 20,
    difficulty = 1,
    base_casting_time = 10,
    energy_source = "NONE",
}
