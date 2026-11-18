local ccb = require("ccb")

ccb.dialogue.register_topic {
    id = "SKYISLAND_QUESTIONS",
    dynamic_line = "Ask what you will.",
    dynamic_line_translation = {},
    responses = {
        { text = "Can you summarize this for me, briefly?", text_translation = {}, topic = "SKYISLAND_WHAT" },
        { text = "Explain expeditions.", text_translation = {}, topic = "SKYISLAND_EXPLAIN1" },
        { text = "Explain missions.", text_translation = {}, topic = "SKYISLAND_EXPLAIN2" },
        { text = "Explain upgrades.", text_translation = {}, topic = "SKYISLAND_EXPLAIN3" },
        { text = "Explain warp shards and rewards.", text_translation = {}, topic = "SKYISLAND_EXPLAIN4" },
        { text = "Explain services.", text_translation = {}, topic = "SKYISLAND_EXPLAIN5" },
        { text = "Let's return to discussing upgrades.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
        { text = "That's all for now.", text_translation = {}, topic = "TALK_DONE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_WHAT",
    dynamic_line = "This floating island is your base of operations, isolated and safe.  When you are ready, use the Warp Obelisk to teleport down to the surface and begin an expedition.  Scavenge, kill, explore, and reach the exit to return here.\n\nShould you die, you will be saved from death and returned to the island, though you will lose EVERYTHING that you were carrying.\n\nGo on expeditions, clear missions, stockpile supplies, upgrade this island, and prepare yourself for your next outing with the equipment you have retrieved.  Repeat until you are an unstoppable force!\nGood luck.",
    dynamic_line_translation = {},
    responses = {
        { text = "I see…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_EXPLAIN1",
    dynamic_line = "Use the Warp Obelisk to reach the surface and begin an expedition to a random place on the surface.  Find the exit marked on your map and get there in time with all the loot you can carry and to bring it back to the island!\nDying on expedition will return you home safely, but you will lose EVERYTHING you had with you.  Keep spare gear at home so you can quickly resupply!\n\nThe time limit is enforced by warp pulses, which hit you at regular intervals.  After 8 pulses, you suffer warpsickness, which rapidly reduces your stats with each pulse.  After 12 pulses, your body begins to disintegrate, taking damage until you die.  Get home safely to reset the pulses!\n\nCertain upgrades can unlock new varieties of expeditions, or improve your survivability.",
    dynamic_line_translation = {},
    responses = {
        { text = "Interesting…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_EXPLAIN2",
    dynamic_line = "After you have unlocked them, missions are generated randomly once an expedition begins.  These mostly involve finding and killing targeted enemies, and any remaining missions fail when you return home.  There is no penalty for failing missions, so if they are too far out of the way or too difficult, you can try for better luck in the next expedition.  Completed missions reward warp shards.  Harder missions give more shards!\n\nYou can also unlock slaughter missions, which require a total amount of kills in a single expedition.  These can be completed anywhere, but reward a smaller amount of shards.",
    dynamic_line_translation = {},
    responses = {
        { text = "Interesting…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_EXPLAIN3",
    dynamic_line = "You can unlock and upgrade many features here.  For the right price, you can improve things like how much map is revealed around you, how many missions are available per trip, what sort of expeditions you can go on, and even instantly construct things on this island.\n\nTo upgrade, simply accept a mission here, then turn in the required materials by just crafting the associated recipe.  Find them under the warp upgrades category of your crafting menu.\n\nSome upgrades and recipes will not be available to unlock until you have reached a higher rank.  To increase your rank, survive enough expeditions and you will be notified that a rank up mission has become available.",
    dynamic_line_translation = {},
    responses = {
        { text = "Interesting…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_EXPLAIN4",
    dynamic_line = "Warp shards are rewarded for completing missions.  They can be spent on special warp-related recipes in your crafting menu, and are also required for various upgrades.  If you need, warp shards can be spent here to heal yourself instantly.\n\nYou will also acquire material tokens, rewarded any time you complete an expedition, even if you did no missions.  Longer expeditions yield more tokens.  These tokens can be crafted into common raw resources, like wood, sand, scrap metal, and so on, as long as you have an infinity source nearby.  Infinity sources come in three varieties, each providing different resources, and are acquired by crafting.  Find them under the warp tools category of your crafting menu.",
    dynamic_line_translation = {},
    responses = {
        { text = "Interesting…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_EXPLAIN5",
    dynamic_line = "This statue offers a variety of services.  You can be instantly healed, dispel an ongoing portal storm, check your current statistics and progress, and tweak your expedition difficulty settings.\n\nHealing is free until you have survived 10 expeditions.  After this point, healing costs 4 warp shards per treatment.\n\nExpedition difficulty is set to default when you start a new game, but here you can change many finer details to suit your own playstyle.",
    dynamic_line_translation = {},
    responses = {
        { text = "Interesting…", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
    },
}
