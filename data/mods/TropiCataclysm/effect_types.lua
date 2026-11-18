local ccb = require("ccb")
local content = ccb.content

-- 30 m to max, 7.5 m overhead, copied from the poisonous wound but with a milder effect so it feels like its burning your skin
content.add(content.EffectType {
    id = "toxic_glue",
    name = ccb.content.text("Termite Glue"),
    description = ccb.content.text("You're covered in thick noxious glue!"),
    apply_message = ccb.content.text("You're covered in thick noxious glue!"),
    remove_message = ccb.content.text("The glue has washed up but it surely left a mark."),
    blood_analysis_description = ccb.content.text("Chemical Allergen"),
    show_intensity = false,
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    maximum_intensity = 125,
    maximum_effective_intensity = 100,
    intensity_duration_turns = 18,
    maximum_duration_turns = 2250,
    show_in_info = true,
}
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -25 })
    :modifier("pain", "amount", { base = 3, resisted_base = 1 })
    :modifier("pain", "minimum", { per_intensity = 0.05, resisted_base = -2, resisted_per_intensity = 0.01 })
    :modifier("pain", "chance_numerator", { base = 10, per_intensity = -0.15, resisted_base = 50, resisted_per_intensity = -0.8 })
    :modifier("pain", "maximum_value", { base = 30, resisted_base = 15 })
    :modifier("hurt", "amount", { base = 3 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 13, per_intensity = -0.11, resisted_base = 100, resisted_per_intensity = -0.81 })
    :modifier("hurt", "tick", { base = 36 })
    :modifier("vomiting", "chance_numerator", { base = 250 })
    :miss_message(ccb.content.text("The glue restricts your movement."), 2))
