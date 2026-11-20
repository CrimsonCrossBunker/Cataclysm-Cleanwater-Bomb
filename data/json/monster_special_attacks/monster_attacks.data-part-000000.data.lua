local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "acid_charge",
    cooldown = 15,
    move_cost = 220,
    damage = { { type = "acid", amount = 0 } },
    self_effects_always = { { id = "acid_charged", duration = 15 } },
    dodgeable = false,
    blockable = false,
    npc_no_damage = ccb.content.text("%s strains for a moment, and its claws are covered in a thick film of acid!"),
    avatar_no_damage = ccb.content.text("%s strains for a moment, and its claws are covered in a thick film of acid!"),
    npc_miss = ccb.content.text("%s strains for a moment, and its claws are covered in a thick film of acid!"),
    avatar_miss = ccb.content.text("%s strains for a moment, and its claws are covered in a thick film of acid!"),
    when = "allow_acid_charge",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "acid_slash",
    cooldown = 5,
    move_cost = 100,
    damage = { { type = "cut", amount = 15 }, { type = "acid", amount = 16 } },
    effects = { { id = "corroding", duration = { 10, 30 }, affect_hit_body_part = true } },
    effects_require_damage = true,
    self_effects_always = { { id = "maimed_acid_gland", duration = 5 } },
    avatar_hit = ccb.content.text("%1$s slashes your %2$s, covering it in acid!"),
    npc_hit = ccb.content.text("%1$s slashes at <npcname>, covering them in acid!"),
    avatar_miss = ccb.content.text("%1$s tries to slash at your %2$s, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to slash at <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s slashes your %2$s, covering the armor in acid!"),
    npc_no_damage = ccb.content.text("%1$s slashes at <npcname>, covering their armor in acid!"),
    when = "allow_acid_slash",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "elec_charge",
    cooldown = 25,
    move_cost = 300,
    damage = { { type = "electric", amount = 0 } },
    self_effects_always = { { id = "elec_charged", duration = 15 } },
    dodgeable = false,
    blockable = false,
    npc_no_damage = ccb.content.text("%s pauses, and the swollen organ on its back starts glowing brighter!"),
    avatar_no_damage = ccb.content.text("%s pauses, and the swollen organ on its back starts glowing brighter!"),
    npc_miss = ccb.content.text("%s pauses, and the swollen organ on its back starts glowing brighter!"),
    avatar_miss = ccb.content.text("%s pauses, and the swollen organ on its back starts glowing brighter!"),
    when = "allow_elec_charge",
}

-- grab_strength preferentially set in the monster definition for clarity
ccb.content.define_monster_attack {
    kind = "melee",
    id = "grab",
    cooldown = 10,
    move_cost = 100,
    minimum_hit_size = 1,
    damage = { { type = "bash", amount = 0 } },
    grab = true,
    grab_settings = { effect = "grabbed" },
    avatar_hit = ccb.content.text("%1$s grabs your %2$s!"),
    npc_hit = ccb.content.text("%1$s grabs <npcname>'s %2$s!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s grabs your %2$s!"),
    npc_no_damage = ccb.content.text("%1$s grabs <npcname>'s %2$s!"),
    when = "allow_free_arm_grab",
}

-- We can't count grab filters, so grabbing 2 works as a soft cooldown
ccb.content.define_monster_attack {
    kind = "melee",
    id = "grab_2",
    cooldown = 0,
    damage = { { type = "bash", amount = 0 } },
    grab = true,
    grab_settings = { effect = "grabbed" },
    self_effects_on_hit = { { id = "grabbing_2", duration = 150, permanent = false } },
    avatar_hit = ccb.content.text("%1$s grabs your %2$s with another appendage!"),
    npc_hit = ccb.content.text("%1$s grabs <npcname>'s %2$s with another appendage!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s grabs your %2$s with another appendage!"),
    npc_no_damage = ccb.content.text("%1$s grabs <npcname>'s %2$s with another appendage!"),
    when = "allow_grab_2",
}

-- We can't count grab filters, so grabbing 3 works as a soft cooldown
ccb.content.define_monster_attack {
    kind = "melee",
    id = "grab_3",
    cooldown = 0,
    damage = { { type = "bash", amount = 0 } },
    grab = true,
    grab_settings = { effect = "grabbed" },
    self_effects_on_hit = { { id = "grabbing_3", duration = 150, permanent = false } },
    avatar_hit = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_hit = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_no_damage = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    when = "allow_grab_3",
}

-- We can't count grab filters, so grabbing 3 works as a soft cooldown
ccb.content.define_monster_attack {
    kind = "melee",
    id = "grab_4",
    cooldown = 0,
    damage = { { type = "bash", amount = 0 } },
    grab = true,
    grab_settings = { effect = "grabbed" },
    self_effects_on_hit = { { id = "grabbing_4", duration = 150, permanent = false } },
    avatar_hit = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_hit = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_no_damage = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    when = "allow_grab_4",
}

-- We can't count grab filters, so grabbing 3 works as a soft cooldown
ccb.content.define_monster_attack {
    kind = "melee",
    id = "grab_5",
    cooldown = 0,
    damage = { { type = "bash", amount = 0 } },
    grab = true,
    grab_settings = { effect = "grabbed" },
    self_effects_on_hit = { { id = "grabbing_5", duration = 150, permanent = false } },
    avatar_hit = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_hit = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s grabs your %2$s with its other hand!"),
    npc_no_damage = ccb.content.text("%1$s grabs <npcname>'s %2$s with its other hand!"),
    when = "allow_grab_5",
}
