local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "afs_cryosuit_warning",
})

content.add(content.EffectType {
    id = "afs_tried_to_buy_car",
    name = "Asked to buy car",
    description = "You tried and failed to buy the car off this npc recently.  If you see this it's a bug.",
})

content.add(content.EffectType {
    id = "afs_tried_to_bribe",
    name = "Asked to Bribe",
    description = "You tried and failed to bribe this NPC recently.  If you see this it's a bug.",
})

content.add(content.EffectType {
    id = "u_met_cyrus",
})

content.add(content.EffectType {
    id = "u_met_millyficent",
})

content.add(content.EffectType {
    id = "u_met_prepnet_gardener",
})

content.add(content.EffectType {
    id = "u_met_sadie",
})

content.add(content.EffectType {
    id = "sadie_injection",
    name = ccb.content.text("Sadie's injection"),
    description = "",
    apply_message = ccb.content.text("A wave of cold runs through your body and you feel dizzy"),
    remove_message = ccb.content.text("The effects of Sadie's injection appear to be wearing off now"),
    blood_analysis_description = ccb.content.text("Several hundred lines of text list a series of complex biological molecules with unknown interactions.  Many appear to be associated with healing and immune response.  Only a few are known to be poisonous and many are known carcinogens.  Several have psychological and hormonal effects."),
    rating = "mixed",
}
    :removes_effect("bite")
    :removes_effect("flu")
    :blocks_effect("bite")
    :blocks_effect("cold")
    :blocks_effect("flu")
    :modifier("strength", "amount", { base = 1 })
    :modifier("sleep", "chance_numerator", { base = -1003 })
    :modifier("sleep", "minimum", { base = 2500 })
    :modifier("sleep", "maximum", { base = 3500 }))

content.add(content.EffectType {
    id = "u_met_whately",
})

content.add(content.EffectType {
    id = "effect_telepathic_suggestion",
    name = ccb.content.text("Mind Trick"),
    description = ccb.content.text("You are preparing to influence the minds of others to make them more amenable to your point of view."),
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
})
