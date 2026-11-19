local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_sight_beyond_sight_active",
    name = ccb.content.text_without_extraction("Sight Beyond Sight Active"),
    points = 0,
    player_display = false,
    description = ccb.content.text_without_extraction("Your Sight Beyond Sight is active.  You should never see this."),
    enchantments = { "INLINE_ENCH_perk_sight_beyond_sight_active_0" },
    flags = { "BLIND" },
}
