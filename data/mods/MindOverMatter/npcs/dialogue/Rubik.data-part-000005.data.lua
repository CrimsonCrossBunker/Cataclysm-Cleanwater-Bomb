local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_New", "TALK_EXODII_MERCHANT_Talk", "TALK_EXODII_MERCHANT_Exodus", "TALK_EXODII_MERCHANT_Exodus2", "TALK_EXODII_MERCHANT_Exodus3", "TALK_EXODII_MERCHANT_Survival2" },
    replies = {
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EXODII_MERCHANT_scan",
            when = predicates.handler("dlg_p_mindovermatter_c24efe0eb6fd"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_scan" },
    line = ccb.content.text("&You weren't expecting to be able to understand Rubik's thoughts.  Whatever language it is, this \"Anglic\", the resemblance to English is clearly a fortunate coincidence.  But you are surprised that your telepathic scan doesn't pick up anything at all.  Just a faint static hum, rising and falling in an irregular pattern."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from <npc_name>'s mind*."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("[Telepathy] *Go deeper*."),
            next_topic = "TALK_EXODII_MERCHANT_deep_scan",
            when = predicates.handler("dlg_p_mindovermatter_ed589545a0d1"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_deep_scan" },
    line = ccb.content.text("&Your awareness of the outside world fades as you fall into Rubik's mind.\n\nYou see a child in a thriving metropolis, doing odd jobs for spare coins, playing in the alleys with friends, coming home at dusk for supper.  You see a young adult running from a group of zombies.  You see this castle, or near enough--some towers are missing, some missing towers are there, but obviously the same--and its denizens fending off an attack from a group of winged things.  You see a conversation in a language you've never heard before among a group of Exodii, before everyone files into rooms, secures themselves with restraints, and there's a brief moment of searing pain and then darkness, filled with static and bursts of light half-glimpsed in your peripheral vision.\n\nYou see worlds.  World after world, in a procession over…decades?  Centuries?  You can't tell; you have no sense of time during the vision.  Most worlds were less advanced than the Earth, and the few survivors fought the dead with human wave tactics and trench warfare, or lines of musketeers, or archers from behind the trees.  Sometimes, doughty warriors clad in iron or bronze hurled themselves at the enemy with sword and shield in hand, until they fell and their corpses rose again.  In one world, the survivors fought with powered armor and particle-beam weapons.  But on every world, slowly, inexorably, the dead or the fungus or the walking trees or things you have no name for ground down the defenders until humanity was on the brink of extinction and, with a few survivors in tow, the Exodii powered up their jump devices and continued the Long Retreat.\n\nIn the end, not once, in a dozen or a hundred or you know not how many worlds, was there anything left to save."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from Rubik's mind*."),
            next_topic = "TALK_EXODII_MERCHANT_Post_Scan",
            actions = { actions.handler("dlg_a_mindovermatter_df936e254f08") },
        },
    },
}
