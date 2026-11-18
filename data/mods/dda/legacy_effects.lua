local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "genetics_damaged",
    name = ccb.content.text("Spent Phenotype"),
    description = ccb.content.text("Mutation has left you with a persistent mild discomfort.  It seems harmless for now, but you can't predict if it'll get worse."),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Depleted Phenotype"))
    :name(ccb.content.text("Bankrupt Phenotype"))
    :description(ccb.content.text("There's an enervating sense of dysmorphia throughout your whole body.  It waxes and wanes, but never quite goes away.  Mutating this much can't be good for you…"))
    :description(ccb.content.text("You're haunted by phantom pains across your entire body now.  Everything aches from an exhaustion that never seems to fade.  Any further mutation right now is very unlikely to have a happy ending.")))

-- For player, indistinguishable from pre_conjunctivitis_bacterial, but separate here to allow for separate resistances from antibiotics.
content.add(content.EffectType {
    id = "pre_conjunctivitis_viral",
    blood_analysis_description = ccb.content.text("Viral Infection"),
    show_in_info = false,
    maximum_duration_turns = 255600,
}
    :immune_character_flag("INFECTION_IMMUNE")
    :immune_character_flag("SEESLEEP"))

-- For player, indistinguishable from pre_conjunctivitis_viral, but separate here to allow for separate resistances from antibiotics.
content.add(content.EffectType {
    id = "pre_conjunctivitis_bacterial",
    blood_analysis_description = ccb.content.text("Bacterial Infection"),
    show_in_info = false,
    maximum_duration_turns = 255600,
}
    :immune_character_flag("INFECTION_IMMUNE")
    :immune_character_flag("SEESLEEP"))

-- For player, indistinguishable from conjunctivitis_bacterial, but separate here to allow for separate resistances from antibiotics.
content.add(content.EffectType {
    id = "conjunctivitis_viral",
    apply_memorial_log = "Got pinkeye.",
    remove_memorial_log = "Got over a pinkeye infection.",
    name = ccb.content.text("Conjunctivitis"),
    description = ccb.content.text("Commonly known as pinkeye, this minor infection can be treated with antihistamines.  If it's bacterial, antibiotics may help, but you can't tell without a lab analysis."),
    apply_message = ccb.content.text("Your itchy eye leaks a filmy discharge."),
    blood_analysis_description = ccb.content.text("Viral Infection"),
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INFECTION_IMMUNE")
    :immune_character_flag("SEESLEEP")
    :resist_effect("took_antihistamine")
    :resist_effect("took_flumed")
    :resist_trait("INFRESIST")
    :resist_trait("PER_SLIME_OK")
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 400, resisted_base = 1000 })
    :miss_message(ccb.content.text("It feels like there's sand in your eye."), 1)
    :limb_score("vision", { multiplier = 0.8, resisted_multiplier = 0.9 })
    :limb_score("night_vis", { multiplier = 0.8, resisted_multiplier = 0.9 }))

-- For player, indistinguishable from conjunctivitis_bacterial, but separate here to allow for separate resistances from antibiotics.
content.add(content.EffectType {
    id = "conjunctivitis_bacterial",
    apply_memorial_log = "Got pinkeye.",
    remove_memorial_log = "Got over a pinkeye infection.",
    name = ccb.content.text("Conjunctivitis"),
    description = ccb.content.text("Commonly known as pinkeye, this minor infection can be treated with antihistamines.  If it's bacterial, antibiotics may help, but you can't tell without a lab analysis."),
    apply_message = ccb.content.text("Your itchy eye leaks a filmy discharge."),
    blood_analysis_description = ccb.content.text("Bacterial Infection"),
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INFECTION_IMMUNE")
    :immune_character_flag("SEESLEEP")
    :resist_effect("took_antihistamine")
    :resist_effect("took_flumed")
    :resist_trait("INFRESIST")
    :resist_trait("PER_SLIME_OK")
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 400, resisted_base = 1000 })
    :miss_message(ccb.content.text("It feels like there's sand in your eye."), 1)
    :limb_score("vision", { multiplier = 0.8, resisted_multiplier = 0.9 })
    :limb_score("night_vis", { multiplier = 0.8, resisted_multiplier = 0.9 }))

content.add(content.EffectType {
    id = "slippery_terrain",
    name = ccb.content.text("Slick Surface"),
    description = ccb.content.text("There's a slippery surface here, running may be a bad idea."),
    maximum_duration_turns = 1,
    rating = "bad",
    show_intensity = true,
    show_in_info = true,
}
    :name(ccb.content.text("Slippery Terrain"))
    :name(ccb.content.text("Dangerously Slippery"))
    :description(ccb.content.text("It's quite slippery, it may not be safe to stand here."))
    :description(ccb.content.text("This area is extremely slippery."))
    :resist_trait("GASTROPOD_BALANCE"))

content.add(content.EffectType {
    id = "bile",
    name = ccb.content.text("Bile Splashed"),
    description = ccb.content.text("You're splattered with a greasy layer of liquified putrescence."),
    apply_message = ccb.content.text("You're covered in bile!"),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("BILE_AFFLICTED")
    :resist_trait("SAPROVORE")
    :resist_trait("SAPROPHAGE")
    :resist_trait("EATDEAD")
    :modifier("vomiting", "chance_numerator", { base = 500 })
    :modifier("health", "chance_numerator", { base = 1 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_denominator", { base = 300 }))

-- Applied as a timer while waiting for logs to refresh from the lumbermill shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "lumbermill_waiting_for_log",
})

-- Applied as a timer while waiting for wood panels to refresh from the lumbermill shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "lumbermill_waiting_for_wood_panel",
})

-- Applied as a timer while waiting for wood sheets to refresh from the lumbermill shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "lumbermill_waiting_for_wood_sheet",
})

-- Applied as a timer while waiting for wood beams to refresh from the lumbermill shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "lumbermill_waiting_for_wood_beam",
})

content.add(content.EffectType {
    id = "star_vampire_blood_drink",
    name = ccb.content.text("Hemorrhage"),
    description = ccb.content.text("The monster is sucking up your blood!"),
    rating = "bad",
    show_in_info = true,
    maximum_intensity = 2,
    show_intensity = false,
    intensity_decay_step = -2,
    intensity_decay_tick = 1,
}
    :resist_trait("BLEED_IMMUNE")
    :vitamin("blood", {
        rates = { { minimum = -125, maximum = -325 } },
        tick_turns = { 1 },
    })
    :vitamin("redcells", {
        rates = { { minimum = -125, maximum = -325 } },
        tick_turns = { 1 },
    }))

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_leg_l_fake_blocker",
    name = "",
    description = "",
    maximum_duration_turns = 1,
})

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_leg_r_fake_blocker",
    name = "",
    description = "",
    maximum_duration_turns = 1,
})

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_arm_l_fake_blocker",
    name = "",
    description = "",
    maximum_duration_turns = 1,
})

content.upsert_effect_type(content.EffectType {
    id = "prosthetic_arm_r_fake_blocker",
    name = "",
    description = "",
    maximum_duration_turns = 1,
})
