local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_SUMMON_SHADOW_PACK",
    name = ccb.content.text("Summon the Shadow Pack"),
    points = 2,
    description = ccb.content.text("Even death cannot always stop the Hunt.  You may summon the spirits of werewolves long dead back to join you in the Hunt."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_summon_shadow_pack_spell = 1 },
}
