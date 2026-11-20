local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "a_bp_RL_enc_splint",
    width = 1,
    style = "layout",
    arrange = "minimum_columns",
    bodypart = "leg_r",
    clauses = {
        { id = "splinted", when = reading.test("worn_flag", "SPLINT"), widgets = { "i_splinted_sym" } },
        { id = "intact", when = predicate.negate(reading.test("worn_flag", "SPLINT")), widgets = { "i_bp_RL_enc_graph" } },
    },
}
