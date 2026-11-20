local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "mon_shocker_chargeup",
    accuracy = 8,
    cooldown = 8,
    move_cost = 100,
    range = 5,
    dodgeable = false,
    blockable = false,
    effects_require_damage = false,
    damage = { { type = "pure", amount = 0 } },
    avatar_hit = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    npc_hit = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    avatar_miss = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    npc_miss = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    avatar_no_damage = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    npc_no_damage = ccb.content.text("With a crackling sound, %1$s begins glowing brighter!"),
    when = "shocker_can_charge",
    on_hit = "shocker_charge",
}

-- We need a second effect to cancel out the charge-up
ccb.content.define_monster_attack {
    kind = "melee",
    id = "mon_shocker_chargeup_attack",
    cooldown = 1,
    move_cost = 150,
    damage = { { type = "electric", amount = 40 } },
    dodgeable = true,
    blockable = true,
    spread_damage = true,
    self_effects_on_hit = { { id = "effect_shocker_zombie_charge_up_removal", duration = 12 } },
    avatar_hit = ccb.content.text("%1$s touches your %2$s and unleashes a massive burst of electricity!"),
    npc_hit = ccb.content.text("%1$s touches <npcname>'s %2$s and unleashes a massive burst of electricity!"),
    avatar_miss = ccb.content.text("%1$s tries to touch you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to touch <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s touches your %2$s and unleashes a massive burst of electricity, but you are unaffected."),
    npc_no_damage = ccb.content.text("%1$s touches <npcname>'s %2$s and unleashes a massive burst of electricity, but they are unaffected."),
    when = "allow_mon_shocker_chargeup_attack",
}

-- If the shocker is grabbing you, it doesn't need to try to touch you to zap you
ccb.content.define_monster_attack {
    kind = "melee",
    id = "mon_shocker_chargeup_attack_grab",
    cooldown = 1,
    move_cost = 150,
    damage = { { type = "electric", amount = 40 } },
    dodgeable = false,
    blockable = false,
    spread_damage = true,
    self_effects_on_hit = { { id = "effect_shocker_zombie_charge_up_removal", duration = 12 } },
    avatar_hit = ccb.content.text("%1$s touches your %2$s and unleashes a massive burst of electricity!"),
    npc_hit = ccb.content.text("%1$s touches <npcname>'s %2$s and unleashes a massive burst of electricity!"),
    avatar_miss = ccb.content.text("%1$s tries to touch you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to touch <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s touches your %2$s and unleashes a massive burst of electricity, but you are unaffected."),
    npc_no_damage = ccb.content.text("%1$s touches <npcname>'s %2$s and unleashes a massive burst of electricity, but they are unaffected."),
    when = "allow_mon_shocker_chargeup_attack_grab",
}
