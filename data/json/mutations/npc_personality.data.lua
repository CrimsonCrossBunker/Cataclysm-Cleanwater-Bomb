local ccb = require("ccb")

-- This file contains *personality* traits, intended to give players an idea of an NPC's decision making via TALK_ASSESS_PERSON and other dialogue.
-- None of them should provide gameplay effects (e.g. more HP or more damage).
-- All of them are reset when the game is loaded, and otherwise applied to any newly generated NPCs at the time of generation.
-- No support for this right now, but maybe in the future? These traits are descriptory, so there's no real problem if the player describes themself however they want.
ccb.content.define_mutation {
    id = "personality_ultra_selfish",
    name = ccb.content.text("Survivor at any cost"),
    description = ccb.content.text("<npc_name> is certainly a survivor.  You can only wonder how many they've abandoned to save themself."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    vanity = false,
    personality = { max_aggression = -3, max_bravery = -2, max_altruism = -4 },
}

ccb.content.define_mutation {
    id = "personality_neg_aggressive",
    name = ccb.content.text("Timid"),
    description = ccb.content.text("<npc_name> tries to avoid conflict, even when they have good reason not to."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { max_aggression = -3 },
}

ccb.content.define_mutation {
    id = "personality_aggressive_mixed",
    name = ccb.content.text("Hardass"),
    description = ccb.content.text("<npc_name> loves to fight a good fight, but only for themself."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_bravery = 3, min_aggression = 3, max_altruism = -2 },
}

ccb.content.define_mutation {
    id = "personality_aggressive_plus_mixed",
    name = ccb.content.text("Freedom fighter"),
    description = ccb.content.text("<npc_name> believes in fighting… mostly for others, even at risk to their own wellbeing."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_bravery = 1, min_aggression = 5, min_altruism = 2 },
}

ccb.content.define_mutation {
    id = "personality_aggressive_plus",
    name = ccb.content.text("Volatile"),
    description = ccb.content.text("<npc_name> is just looking for an excuse."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_aggression = 7 },
}

-- A straightforward tell for the NPC's bravery, since it has a huge impact on how they engage in combat.
ccb.content.define_mutation {
    id = "personality_neg_bravery",
    name = ccb.content.text("Coward"),
    description = ccb.content.text("<npc_name> flinches at the thought of fighting, whether it be other people or the undead."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { max_bravery = -4 },
}

-- A straightforward tell for the NPC's bravery, since it has a huge impact on how they engage in combat.
ccb.content.define_mutation {
    id = "personality_neg_bravery_plus",
    name = ccb.content.text("Craven"),
    description = ccb.content.text("<npc_name> is afraid of the dark, spiders, and unexplained sounds.  So are you, but only because you've lived through the apocalypse.  <npc_name> has always been like this."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { max_bravery = -7 },
}

-- A straightforward tell for the NPC's bravery, since it has a huge impact on how they engage in combat.
ccb.content.define_mutation {
    id = "personality_brave",
    name = ccb.content.text("Brave"),
    description = ccb.content.text("<npc_name> knows the name of fear, but only as a long-defeated foe.  Little can shake them."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_bravery = 4 },
}

ccb.content.define_mutation {
    id = "personality_brave_plus",
    name = ccb.content.text("Hero"),
    description = ccb.content.text("<npc_name> is an ideal ally to those they call friend, always willing to help others."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_bravery = 5, min_altruism = 2 },
}

ccb.content.define_mutation {
    id = "personality_collector",
    name = ccb.content.text("Miser"),
    description = ccb.content.text("<npc_name> loves their trinkets, and hates giving them away."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_collector = 3, max_altruism = -1 },
}

ccb.content.define_mutation {
    id = "personality_collector_plus",
    name = ccb.content.text("Scrooge"),
    description = ccb.content.text("<npc_name> collects trash like an RPG protagonist collects potions."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_collector = 6 },
}

ccb.content.define_mutation {
    id = "personality_altruist",
    name = ccb.content.text("Kind", "personality trait"),
    description = ccb.content.text("<npc_name> just wants to help."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { min_altruism = 4 },
}

ccb.content.define_mutation {
    id = "personality_neg_altruist",
    name = ccb.content.text("Self-centered"),
    description = ccb.content.text("<npc_name> steers every interaction into discussing how it will help them."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
    personality = { max_altruism = -3 },
}
