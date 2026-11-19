local ccb = require("ccb")

ccb.content.define_mutation { id = "INTERSTICE_MIND", copy_from = "INTERSTICE_MIND", add = { flags = { "TEEPSHIELD" } } }

ccb.content.define_mutation {
    id = "INTERSTICE_RESONANCE_2",
    copy_from = "INTERSTICE_RESONANCE_2",
    enchantments = { "INLINE_ENCH_INTERSTICE_RESONANCE_2_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESONANCE_3",
    copy_from = "INTERSTICE_RESONANCE_3",
    enchantments = { "INLINE_ENCH_INTERSTICE_RESONANCE_3_0" },
}
