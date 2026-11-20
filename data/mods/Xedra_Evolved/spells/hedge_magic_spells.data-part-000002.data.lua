local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hedge_make_plants_grow_real",
    name = ccb.content.text_without_extraction("To Bring Health to the Soil and Life to the Crops Real"),
    description = ccb.content.text_without_extraction("The actual effect of the charm.  Should not be player-visible"),
    message = "",
    magic_type = "xe_hedge_magick",
    valid_targets = { "ground" },
    spell_class = "HEDGE_MAGIC",
    skill = "survival",
    effect = "fertilize_plant",
    min_damage = 30,
    max_damage = 30,
    shape = "blast",
    min_aoe = 2,
    max_aoe = 2,
    max_level = 1,
}
