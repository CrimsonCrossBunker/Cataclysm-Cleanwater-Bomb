local ccb = require("ccb")
local text = ccb.content.text

local antivirals = ccb.content.EffectType {
    id = "antivirals",
    rating = "good",
    blood_analysis_description = text("Antivirals"),
    maximum_duration_turns = 86400,
    duration_add_percent = 25,
}
antivirals:blocks_effect("zombie_virus")
ccb.content.add(antivirals)

local virus = ccb.content.EffectType {
    id = "zombie_virus",
    name = "",
    description = "",
    apply_message = text("An ominous prickling feeling reverberates through your body."),
    death_message = text("You succumb to your deadly necrotic condition."),
    apply_memorial_log = "Contracted a deadly necrotic virus.",
    death_event = "dies_of_infection",
    maximum_intensity = 4,
    intensity_add_value = 1,
    intensity_decay_step = 1,
    intensity_decay_tick = 86400,
    rating = "bad",
    show_intensity = false,
    harmful_cough = true,
}
virus:name(text("Pallor"))
virus:name(text("Itchy pale skin"))
virus:name(text("Necrotic skin"))
virus:description(text("Your skin is pale and there are dark spots around your eyes."))
virus:description(text("Your skin is pale and there are dark spots around your eyes.  You feel a constant itching sensation, like your skin could fall off at any moment."))
virus:description(text("Your skin is pale and covered in gross sores.  It's like your skin is rotting right off your body."))
virus:resist_effect("antivirals")

for _ = 1, 3 do
    virus:death_chance {
        numerator = -1, denominator = 1,
        resisted_numerator = -1, resisted_denominator = 1,
    }
end
virus:death_chance {
    numerator = 1, denominator = 100000,
    resisted_numerator = 1, resisted_denominator = 2000000,
}

for _, symptom in ipairs({ "cough", "pain" }) do
    virus:modifier(symptom, "chance_numerator", {
        base = -10, per_intensity = 5.5,
        resisted_base = -10, resisted_per_intensity = 3.5,
    })
    virus:modifier(symptom, "chance_denominator", {
        base = 1000, per_intensity = 1,
        resisted_base = 10000, resisted_per_intensity = 5,
    })
end
virus:modifier("pain", "minimum", { base = 1, resisted_base = 0 })
virus:modifier("pain", "maximum", { base = 5, resisted_base = 1 })
ccb.content.add(virus)
