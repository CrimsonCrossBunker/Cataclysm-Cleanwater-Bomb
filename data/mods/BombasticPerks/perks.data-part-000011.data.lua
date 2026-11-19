local ccb = require("ccb")

-- The beginning of this description is a reference to the Looney Tunes short 'Robin Hood Daffy'
ccb.content.define_mutation {
    id = "perk_fencing_footwork",
    name = ccb.content.text("Fancy Footwork"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Ho!  Ha-Ha!  Guard!  Turn!  Parry!  Dodge!  Spin!  Ha!  Thrust!  When wielding a fencing weapon, you gain +1 bonus dodge and slightly reduced move cost on flat terrain."),
    enchantments = { "INLINE_ENCH_perk_fencing_footwork_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_fish_in_water",
    name = ccb.content.text("Like a Fish in the Water"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("So unremarkable that there's no proverb about it.  When in deep water, your stamina regeneration is doubled, and you can swim 25% faster."),
    enchantments = { "INLINE_ENCH_perk_fish_in_water_0" },
    flags = { "PERK" },
}
