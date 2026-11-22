local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM",
    name = ccb.content.text("Form of Billowing Smoke"),
    points = 8,
    description = ccb.content.text("The Salamander may transform into smoke.  They will have only a dim awareness of their surroundings, but can freely move including through the air and will be nearly immune to attack.  They will be unable to attack anyone else themselves, however."),
    prerequisites = { "SALAMANDER_SUMMON_WINGS", "SALAMANDER_SUMMON_WINGS_ON" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    activation_setup_only = true,
    cooldown = 10,
    consumes_calories = true,
    cost = 1,
    on_activate = "salamander_smoke_form_on",
    on_deactivate = "salamander_smoke_form_off",
}
