local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM_ASCEND",
    name = ccb.content.text("Smoke Form Ascension"),
    points = 10,
    description = ccb.content.text("While in hot air or a fire, you may ascend upwards"),
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    valid = false,
    on_activate = "salamander_smoke_form_ascend",
}
