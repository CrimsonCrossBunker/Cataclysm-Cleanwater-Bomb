local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_artifact_resonance_reduction",
    name = ccb.content.text("Relic Wielder"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your frequent handling of artifacts has allowed you to bleed off some of the side effects of their presence.  Your accumulated artifact resonance is reduced by 1500."),
    enchantments = { "INLINE_ENCH_perk_artifact_resonance_reduction_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_artifact_resonance_exploitation",
    name = ccb.content.text("Resonating Empowerment"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your frequent handling of artifacts has allowed you to redirect some of the otherworldly power they carry.  When suffering from resonance effects, you gain a variety of minor bonuses such as resistance to fire, electricity, or cold, increased dodge, or increased stamina regeneration."),
    enchantments = { "INLINE_ENCH_perk_artifact_resonance_exploitation_0" },
    flags = { "PERK" },
}
