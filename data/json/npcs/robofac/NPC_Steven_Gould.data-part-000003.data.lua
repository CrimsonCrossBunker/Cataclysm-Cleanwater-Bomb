local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT",
    line = ccb.content.text("I've got an extra recon helmet and a powered air purifying respirator system.  The light amplification on the helmet still works.  The PAPR is a scavenged military mask with an old commercial blower.  Package deal.  Don't ask where I got 'em.  Ten coins."),
    replies = {
        {
            text = ccb.content.text("No, thanks."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[10 HGC] You have a deal."),
            next_topic = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT_ACCEPTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 10),
            actions = { actions.handler("dlg_a_dda_ecb25882f709"), actions.set_actor_value("speaker", "bought_gear_monster_corpse_merc", "yes") },
        },
    },
}
