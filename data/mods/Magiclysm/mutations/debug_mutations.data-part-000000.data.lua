local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAULT_DEFENDER",
    name = ccb.content.text_without_extraction("Vault Defender"),
    points = 99,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("To cast bug killing spells."),
    debug = false,
    enchantments = { "INLINE_ENCH_VAULT_DEFENDER_0" },
}
