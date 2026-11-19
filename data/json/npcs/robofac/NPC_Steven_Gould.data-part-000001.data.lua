local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1" },
    line = ccb.content.text("Ah, the other contractor.  We've got things covered up here… but I guess you're going down into the \"thing.\"  If you've got coins, I've got a bit of spare equipment that might be useful."),
    replies = {
        {
            text = ccb.content.text("Any idea what's going on down there?"),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_RECON",
        },
        {
            text = ccb.content.text("What kind of equipment you looking to trade?"),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "bought_gear_monster_corpse_merc" } })),
        },
        { text = ccb.content.text("I'll see you around."), next_topic = "TALK_DONE" },
    },
}
