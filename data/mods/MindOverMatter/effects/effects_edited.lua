local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "taint",
    speed_name = ccb.content.text("Tainted"),
    name = ccb.content.text("Touched Mind"),
    description = ccb.content.text("You are disoriented as strange visions flash through your mind."),
    rating = "bad",
    maximum_intensity = 4,
    maximum_duration_turns = 7200,
    intensity_add_value = 1,
    intensity_duration_turns = 300,
}
    :name(ccb.content.text("Touched Mind"))
    :name(ccb.content.text("Tainted Mind"))
    :name(ccb.content.text("Badly Tainted Mind"))
    :description(ccb.content.text("You are overwhelmed by the disturbing imagery and concepts you're flooded with."))
    :description(ccb.content.text("You can't comprehend the things around you…"))
    :description(ccb.content.text("You don't know what is and isn't real anymore…"))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("TEEPSHIELD")
    :modifier("speed", "amount", { base = -20, per_intensity = -10 })
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -1 })
    :modifier("perception", "amount", { base = -2, per_intensity = -2 })
    :modifier("vomiting", "chance_numerator", { base = 20 })
    :modifier("intelligence", "amount", { per_intensity = -2 })
    :miss_message(ccb.content.text("Your sense of reality warps!"), 3)
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("vision", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("night_vis", { multiplier = 0.9, per_intensity = -0.1 }))

content.upsert_effect_type(content.EffectType {
    id = "tindrift",
}
    :immune_character_flag("TEEPSHIELD"))

content.upsert_effect_type(content.EffectType {
    id = "attention",
}
    :immune_character_flag("TEEPSHIELD")
    :immune_character_flag("TELESTOP"))

content.upsert_effect_type(content.EffectType {
    id = "teleglow",
}
    :immune_character_flag("TELESTOP"))

content.upsert_effect_type(content.EffectType {
    id = "LIXA_illuminated",
    name = ccb.content.text("illuminated"),
    description = ccb.content.text("You're covered in congealed light!"),
    apply_message = ccb.content.text("The sticky globs of light cover you, and begin to burn!"),
    rating = "bad",
    maximum_duration_turns = 6,
    maximum_intensity = 3,
    intensity_duration_turns = 2,
    show_in_info = true,
}
    :immune_character_flag("PHOTOKIN_CHAR_IMMUNE")
    :modifier("hurt", "minimum", { base = 1, per_intensity = 1 })
    :modifier("hurt", "chance_numerator", { base = 3 }))
