local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "null",
})

-- AI EFFECTS BELOW THIS
content.add(content.EffectType {
    id = "hit_by_player",
    name = "Hit By Player",
    description = "AI tag for when monsters are hit by player.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "ridden",
    name = "Ridden",
    description = "AI tag for when critter is being ridden.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_suspend",
    name = "Suspended NPC",
    description = "AI tag for when an NPC needs to be rebooted after an infinite loop.",
})

content.add(content.EffectType {
    id = "harnessed",
    name = ccb.content.text("Harnessed"),
    description = "AI tag for when critter is being harnessed by a vehicle.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "docile",
    name = "Docile Monster",
    description = "AI tag for when monsters are tamed.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "controlled",
    name = "Controlled Monster",
    description = "AI tag for when monsters are being controlled by another.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "run",
    name = "Hit-and-run Running",
    description = "AI tag for when hit-and-run monsters run away.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "spooked",
    name = "Cornered Fighter Spooked",
    description = "AI tag to let CORNERED_FIGHTER monsters try to flee.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "spooked_recent",
    name = "Cornered Fighter Recently Spooked",
    description = "AI tag to allow CORNERED_FIGHTER monsters to turn and fight.  This is a bug if you have it.",
})

-- This effect is automatically applied in C++.
content.add(content.EffectType {
    id = "critter_well_fed",
    name = ccb.content.text("Well Fed"),
    description = "AI tag for when critter has had enough to eat.  This is a bug if you have it.",
    show_in_info = true,
})

-- This effect is automatically applied in C++.
content.add(content.EffectType {
    id = "critter_underfed",
    name = ccb.content.text("Underfed"),
    description = "AI tag for when critter has not had enough to eat.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "dragging",
    name = ccb.content.text("Dragging"),
    description = "AI tag for when a monster is dragging you behind it.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "operating",
    name = "Operating",
    description = "AI tag for when a monster is operating on you.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "countdown",
    name = "Counting Down",
    description = "AI tag for monster's counting down.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "no_ammo",
    name = "No Ammo",
    description = "AI tag used to stop a monster reviving with ammo.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_to_lead",
    name = "Asked to Lead",
    description = "AI tag for asking to lead NPCs.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_to_follow",
    name = "Asked to Follow",
    description = "AI tag for asking to NPCs to follow you.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_to_train",
    name = ccb.content.text("Recently trained"),
    description = ccb.content.text("You recently finished a training session and need a mental break before teaching again."),
})

content.add(content.EffectType {
    id = "asked_to_socialize",
    name = "Asked to Socialize",
    description = "AI tag: for having recently asked an NPC to socialize.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_to_hint",
    name = "Asked to Hint",
    description = "AI tag: for having recently asked an NPC to give a hint.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_personal_info",
    name = "Asked Info",
    description = "AI tag for asking to NPCs for personal information.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "asked_for_item",
    name = "Asked for Item",
    description = "AI tag for asking NPCs for items.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "currently_busy",
    name = "Currently Busy",
    description = "AI cooldown tag for items or services.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "gave_quest_item",
    name = "Already Gave Quest Item",
    description = "AI tag to prevent you from getting multiple quest items.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "catch_up",
    name = "Catch Up",
    description = "AI tag for telling NPCs to catch up.  This is a bug if you have it.",
    intensity_add_value = 1,
    maximum_intensity = 15,
})

content.add(content.EffectType {
    id = "allow_sleep",
    name = "Allow to Sleep",
    description = "AI tag for telling NPCs to sleep.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_said",
    name = "Said Something Recently",
    description = "AI tag to control NPC verbosity.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "socialized_recently",
    name = "Socialized Recently",
    description = "AI tag for asking to NPCs to socialize.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_run_away",
    name = ccb.content.text("Running Away"),
    description = "AI tag to enable NPCs to flee.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_flee_player",
    name = ccb.content.text("Running Away"),
    description = "AI tag to enable NPCs to flee the player.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_fire_bad",
    name = "Avoiding a Fire",
    description = "AI tag to enable NPCs to escape uncontrolled fires.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "npc_player_still_looking",
    name = "Waiting till You Find Something",
    description = "AI tag to prevent NPCs from following the player while the player is finding an additional copy of an item.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "infection",
    name = "Infection",
    description = "AI tag used for the infected NPC quest.  This is a bug if you have it.",
}
    :modifier("speed", "amount", { base = -80 }))

content.add(content.EffectType {
    id = "pet",
    name = "Pet",
    description = "AI tag used for pet critters.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "paid",
    name = "Paid",
    description = "AI tag used for paid critters.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "pacified",
    name = "Pacified",
    description = "AI tag used for pacified critters.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "has_bag",
    name = "Has Bag",
    description = "AI tag used for critters holding your bags.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "monster_armor",
    name = "Has Armor",
    description = "AI tag used for critters wearing armor.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "monster_saddled",
    name = "Has Saddle",
    description = "AI tag used for critters wearing a saddle.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "leashed",
    name = "Has Leash",
    description = "AI tag used for critters wearing a leash.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "led_by_leash",
    name = ccb.content.text("Being Led by Leash"),
    description = "AI tag used for critters forced to follow using a leash.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "tied",
    name = ccb.content.text("Tied Up"),
    description = "AI tag used for tied up critters.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "shrieking",
    name = ccb.content.text("Shrieking"),
    description = "AI tag used for screecher sounds.  This is a bug if you have it.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "targeted",
    name = "Turret Is Targeted",
    description = "AI tag used for turret targeting sounds.  This is a bug if you have it.",
})

-- This prevents you from building value with NPCs too quickly by just talking to them constantly.
content.add(content.EffectType {
    id = "npc_value_interaction_timer_short",
})

content.add(content.EffectType {
    id = "frenzy",
    name = ccb.content.text("Frenzied"),
    description = "Monster effect used to buff allies.  This is a bug if you have it.",
    maximum_intensity = 5,
    intensity_add_value = 1,
    maximum_duration_turns = 900,
    show_in_info = true,
}
    :modifier("speed", "amount", { base = 10, per_intensity = 10 })
    :modifier("hit", "amount", { base = 1, per_intensity = 1 })
    :modifier("dodge", "amount", { base = 1, per_intensity = 0.5 }))

content.add(content.EffectType {
    id = "pushed",
    name = "Pushed",
    description = "AI tag used for monsters pushing each other.  This is a bug if you have it.",
})

content.add(content.EffectType {
    id = "worked_on",
    name = "Worked On",
    description = "AI tag used for robots being disabled.  This is a bug if you have it.",
})

-- 10+0,5/s dmg, from max duration avg 70 (range 10-130)
content.add(content.EffectType {
    id = "venom_player1",
    name = "Weak Player Venom",
    description = "Don't worry, you shouldn't get this.",
    maximum_duration_turns = 120,
}
    :immune_character_flag("VENOM_IMMUNE")
    :modifier("hurt", "amount", { base = 10 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 2 }))

-- 20+2/s dmg, from max duration avg 260 (range 20-480)
content.add(content.EffectType {
    id = "venom_player2",
    name = "Strong Player Venom",
    description = "Don't worry, you really shouldn't get this.",
    maximum_duration_turns = 120,
}
    :immune_character_flag("VENOM_IMMUNE")
    :modifier("hurt", "amount", { base = 20 })
    :modifier("hurt", "minimum", { base = 4 })
    :modifier("hurt", "chance_numerator", { base = 2 })
    :modifier("speed", "amount", { base = -50 }))

content.add(content.EffectType {
    id = "dripping_mechanical_fluid",
    name = ccb.content.text("Mechanical Fluid Dripping"),
    description = "AI tag used for robot monsters losing mechanical fluid.  This is a bug if you have it.",
    show_in_info = true,
})

-- Intended for monsters, has no effect except to create a new weak point.
content.add(content.EffectType {
    id = "shattered",
    name = ccb.content.text("Shattered Armor"),
    description = ccb.content.text("Your armor has been shattered by a heavy attack."),
    apply_message = ccb.content.text("Your armor has been shattered."),
    rating = "bad",
    show_in_info = true,
})

-- Mainly for monsters
content.add(content.EffectType {
    id = "staggered",
    name = ccb.content.text("Staggered"),
    description = ccb.content.text("You've been knocked off-balance by an attack."),
    apply_message = ccb.content.text("You're staggered off-balance."),
    maximum_duration_turns = 5,
    rating = "bad",
    show_in_info = true,
}
    :removes_effect("grabbing")
    :removes_effect("grabbing_2")
    :removes_effect("grabbing_3")
    :removes_effect("grabbing_4")
    :removes_effect("grabbing_5")
    :modifier("speed", "amount", { base = -20 }))

content.add(content.EffectType {
    id = "sneezing",
    name = ccb.content.text("Sneezing"),
    description = ccb.content.text("It's hard to pay attention to anything when you're in the middle of sneezing!"),
    rating = "bad",
    maximum_duration_turns = 1,
}
    :modifier("speed", "amount", { base = -20 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -4 }))

-- Enables special attacks where specified
content.add(content.EffectType {
    id = "acid_charged",
    name = "Charged Acid Glands",
    description = "Your acid glands are full and ready to burst.  Ew.",
})

-- Disables special attacks where specified
content.add(content.EffectType {
    id = "maimed_acid_gland",
    name = ccb.content.text("Maimed Acid Glands"),
    description = "Your acid glands got all leaky.",
    show_in_info = true,
})

-- Disables javelin throwing.
content.add(content.EffectType {
    id = "maimed_huntsman_arm",
    name = ccb.content.text("Broken Appendage"),
    description = "Your long grotesque throwing appendage has been compromised.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "elec_charged",
    name = "Charged Capacitor",
    description = "Your capacitors sizzle with bioelectricity.",
})

content.add(content.EffectType {
    id = "maimed_capacitor",
    name = ccb.content.text("Maimed Capacitor"),
    description = "You can't deal with this charge.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "maimed_tail",
    name = ccb.content.text("Maimed Tail"),
    description = "Your tail is broken.  You're not sure what to do with this information.",
    show_in_info = true,
})

-- Disables special attacks where specified
content.add(content.EffectType {
    id = "maimed_claws",
    name = ccb.content.text("Maimed Claws"),
    description = "Your claws broke.  Like a broken nail, but somehow worse.",
    show_in_info = true,
})

-- Exposes certain weakpoints
content.add(content.EffectType {
    id = "maimed_armor",
    name = ccb.content.text("Cracked Shell"),
    description = "You feel exposed -and pretty buggy- without your shell.",
    show_in_info = true,
})

-- Disables monster weapon attacks
content.add(content.EffectType {
    id = "disarmed",
    name = "Disarmed",
    description = "You have been forced to drop any wielded weapon.  You can wield them again if you manage to survive.",
})

-- Disables base grabs, scratches and monster weapon attacks
content.add(content.EffectType {
    id = "maimed_arm",
    name = ccb.content.text("Broken Arm"),
    description = "Your arms are broken.  Your imaginary monster arms, so this is probably a bug.",
    show_in_info = true,
})

-- Given by weakpoints, used to disable bites if specified in the bite def
content.add(content.EffectType {
    id = "maimed_mandible",
    name = ccb.content.text("Maimed Mandibles"),
    description = "Your mandibles are unusable.  What, you don't have mandibles?  Then it must be a bug if you have it.",
    show_in_info = true,
})

-- Given by weakpoints, used to disable pulls if specified in the attack def
content.add(content.EffectType {
    id = "maimed_tongue",
    name = ccb.content.text("Injured Tongue"),
    description = "Cat got your tongue?  No?  Then it must have been a bug.",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "maimed_leg",
    name = ccb.content.text("Maimed Legs"),
    description = "Your bugged legs are maimed beyond recognition.  How will you leap now?",
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -20 }))

-- Same as maimed_mandible, no effect unless specified in the attack's definition
content.add(content.EffectType {
    id = "maimed_stinger",
    name = ccb.content.text("Maimed Stinger"),
    description = "Your beautiful stinger is broken!  That must be a bug, right?",
    show_in_info = true,
})

-- Hardcoded effect handled by monster::flies via effect flag
content.add(content.EffectType {
    id = "maimed_wings",
    name = ccb.content.text("Maimed Wings"),
    description = "Your wings are useless, robbing you of unlimited flight.",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT"))

content.add(content.EffectType {
    id = "stumbled_into_invisible",
    name = "Stumbled Into Invisible Player",
    description = "This creature has stumbled into an invisible player and is now aware of their presence.",
})

content.add(content.EffectType {
    id = "milked",
    name = ccb.content.text("Milked"),
    description = "The creature has been partially or fully milked.",
    maximum_duration_turns = 86400,
    show_in_info = true,
})

content.add(content.EffectType {
    id = "sheared",
    name = ccb.content.text("Sheared"),
    description = "The creature has been fully sheared.",
    maximum_duration_turns = 7776000,
    show_in_info = true,
})

content.add(content.EffectType {
    id = "fragile_frog",
    name = "Fragile Frog",
    description = "Applied by leap special attack of burned frog zombies, conditional for related spell.",
    maximum_duration_turns = 300,
})

-- Limits the number of police bots summoned to 3 every 6 hours
content.add(content.EffectType {
    id = "eyebot_assisted",
    intensity_add_value = 1,
    maximum_intensity = 3,
    maximum_duration_turns = 21600,
})

-- The eyebot can no longer summon police bots
content.add(content.EffectType {
    id = "eyebot_depleted",
    intensity_add_value = 1,
    maximum_intensity = 10,
})

-- max_duration doesn't seem to work here, the effect stays forever
content.add(content.EffectType {
    id = "photophobia",
    name = ccb.content.text("Photophobia"),
    description = "It burns!  Thankfully, this can't ever happen to you.  This is a bug if you have it.",
    maximum_duration_turns = 5,
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_photophobia_0"))

-- stats modified by the zombie_fuse special attack.
-- scaling:
-- /50 HP: +0,5 melee_skill, +5 Speed (bigger steps&more to attack with), +4 bash
-- /250 HP: +1 size
-- Effective max intensity is currently 320.
content.add(content.EffectType {
    id = "grown_of_fuse",
    name = "Grown of Fusion",
    description = "AI effect to increase stats after fusing with another critter.  1 stack means one absorbed max_hp.",
    maximum_intensity = 500,
    intensity_decay_step = 0,
}
    :enchantment("INLINE_ENCH_grown_of_fuse_0")
    :enchantment("INLINE_ENCH_grown_of_fuse_1")
    :enchantment("INLINE_ENCH_grown_of_fuse_2")
    :modifier("hit", "amount", { base = 0.01, per_intensity = 0.01 })
    :modifier("bash", "amount", { base = 0.08, per_intensity = 0.08 })
    :modifier("size", "amount", { per_intensity = 0.004 }))

-- This tells a devourer that it has absorbed an acidic monster (one with the flag ACID_BLOOD or ACIDTRAIL)
content.add(content.EffectType {
    id = "absorbed_acidic",
})

-- This tells a devourer that it has absorbed an electric monster (one with the flag ELECTRIC)
content.add(content.EffectType {
    id = "absorbed_electric",
})

-- This tells a devourer that it has absorbed a pupating zombie and can now produce flesh raptors
content.add(content.EffectType {
    id = "absorbed_pupating",
})

content.add(content.EffectType {
    id = "Shadow_Reveal",
    name = ccb.content.text("Revealed"),
    description = "The shadows no longer hide you!",
    maximum_duration_turns = 60,
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_Shadow_Reveal_0"))

content.add(content.EffectType {
    id = "yrax_overcharged",
    name = "▙▜▛▜",
    description = "▙▚▛▜▝▞▟",
    show_in_info = true,
})

-- ACTUAL PLAYER EFFECTS START HERE
content.add(content.EffectType {
    id = "downed",
    name = ccb.content.text("Downed"),
    description = ccb.content.text("You're knocked to the ground.  You have to get up before you can move."),
    apply_message = ccb.content.text("You're knocked to the floor!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("GASTROPOD_FOOT")
    :limb_score("balance", { multiplier = 0.1, resisted_multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.5 })
    :limb_score("block", { multiplier = 0.5 }))

-- This has no apply message because there's an existing application message in Pickup::do_pickup().
-- You're carrying too much and are overburdened!
content.add(content.EffectType {
    id = "overburdened",
    name = ccb.content.text("Overburdened"),
    description = ccb.content.text("You strain to move with all you're carrying."),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT"))

content.add(content.EffectType {
    id = "assisted",
    name = ccb.content.text("Assisted"),
    description = ccb.content.text("You're receiving assistance to practice a surgery."),
    maximum_intensity = 1000,
})

content.add(content.EffectType {
    id = "masked_scent",
    name = ccb.content.text("Masked Scent"),
    description = ccb.content.text("Your scent is masked by another one."),
})

content.add(content.EffectType {
    id = "got_checked",
    name = ccb.content.text("Got a Check-up"),
    description = ccb.content.text("Your received a complete check-up and are now aware of the state of your health."),
})

content.add(content.EffectType {
    id = "heating_bionic",
    name = ccb.content.text("Heated"),
    description = ccb.content.text("At least one of your bionics is producing heat and warming you."),
    maximum_intensity = 1000,
})

content.add(content.EffectType {
    id = "winded",
    name = ccb.content.text("Winded"),
    description = ccb.content.text("You're short of breath.  Running and fighting will be difficult until you recover."),
    apply_message = ccb.content.text("Your breath gives out!"),
    remove_message = ccb.content.text("You catch your breath."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 5 })
    :modifier("pain", "maximum_value", { base = 20 })
    :limb_score("reaction", { multiplier = 0.5 }))

content.add(content.EffectType {
    id = "winded_leg",
    name = ccb.content.text("Winded"),
    description = ccb.content.text("You're short of breath.  Your leg has impaired function until you recover."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 20 })
    :limb_score("block", { multiplier = 0.9 })
    :limb_score("swim", { multiplier = 0.7 })
    :limb_score("move_speed", { multiplier = 0.8 })
    :limb_score("footing", { multiplier = 0.8 })
    :limb_score("balance", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "winded_arm",
    name = ccb.content.text("Winded"),
    description = ccb.content.text("You're short of breath.  Your arm has impaired function until you recover."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("EFFECT_LIMB_DISABLE_CONDITIONAL_FLAGS")
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 20 })
    :limb_score("lift", { multiplier = 0.8 })
    :limb_score("block", { multiplier = 0.8 })
    :limb_score("swim", { multiplier = 0.8 })
    :limb_score("manip", { multiplier = 0.8 })
    :limb_score("grip", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "winded_crab_leg",
    name = ccb.content.text("Winded"),
    description = ccb.content.text("You're short of breath.  One of your crab legs has impaired function until you recover."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -3 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 20 })
    :limb_score("block", { multiplier = 0.95 })
    :limb_score("move_speed", { multiplier = 0.9 })
    :limb_score("footing", { multiplier = 0.85 })
    :limb_score("balance", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "winded_tentacle",
    name = ccb.content.text("Winded"),
    description = ccb.content.text("You're short of breath.  One of your tentacles has impaired function until you recover."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -3 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 20 })
    :limb_score("block", { multiplier = 0.95 })
    :limb_score("move_speed", { multiplier = 0.9 })
    :limb_score("footing", { multiplier = 0.85 })
    :limb_score("balance", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "no_power_leg",
    name = ccb.content.text("Low Power"),
    description = ccb.content.text("You're low on power.  Your leg is operating in emergency mode and has limited function."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -5 })
    :limb_score("block", { multiplier = 0.5 })
    :limb_score("swim", { multiplier = 0.5 })
    :limb_score("move_speed", { multiplier = 0.5 })
    :limb_score("footing", { multiplier = 0.5 })
    :limb_score("balance", { multiplier = 0.5 }))

content.add(content.EffectType {
    id = "no_power_arm",
    name = ccb.content.text("Low Power"),
    description = ccb.content.text("You're low on power.  Your arm is operating in emergency mode and has limited function."),
    rating = "bad",
    maximum_duration_turns = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -5 })
    :limb_score("lift", { multiplier = 0.5 })
    :limb_score("block", { multiplier = 0.5 })
    :limb_score("swim", { multiplier = 0.5 })
    :limb_score("manip", { multiplier = 0.5 })
    :limb_score("grip", { multiplier = 0.5 }))

content.add(content.EffectType {
    id = "no_power_eyes",
    name = ccb.content.text("Low Power"),
    description = ccb.content.text("You're low on power.  Your eyes are operating in emergency mode and have limited function."),
    rating = "bad",
    maximum_duration_turns = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -2 })
    :limb_score("vision", { multiplier = 0.5 })
    :limb_score("night_vis", { multiplier = 0.5 })
    :limb_score("reaction", { multiplier = 0.5 }))

content.add(content.EffectType {
    id = "darkness",
    apply_message = ccb.content.text("Your vision flickers and goes gray!"),
    remove_message = ccb.content.text("The world flickers back to normality."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("PER_SLIME_OK")
    :limb_score("vision", { multiplier = 0.5, resisted_multiplier = 1.0 })
    :limb_score("night_vis", { multiplier = 0.1, resisted_multiplier = 1.0 }))

content.add(content.EffectType {
    id = "effect_true_seeing",
    apply_message = ccb.content.text("Details stand out in stark relief!"),
    remove_message = ccb.content.text("The world returns to its normal appearance."),
    rating = "good",
}
    :flag("TRUE_SEEING"))

content.add(content.EffectType {
    id = "immobilization",
    name = ccb.content.text("Immobilized"),
    description = ccb.content.text("You can't move!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_IMPEDING"))

content.add(content.EffectType {
    id = "stunned",
    name = ccb.content.text("Stunned"),
    description = ccb.content.text("Your movement is randomized."),
    apply_message = ccb.content.text("You're stunned!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_SPELLCASTING")
    :flag("NO_PSIONICS")
    :limb_score("balance", { multiplier = 0.2 })
    :limb_score("reaction", { multiplier = 0.0 }))

content.add(content.EffectType {
    id = "sensor_stun",
    name = ccb.content.text("Sensor scrambling"),
    description = ccb.content.text("Your artificial senses are scrambled and report false readings."),
    apply_message = ccb.content.text("You're stunned!"),
    rating = "bad",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "dazed",
    name = ccb.content.text("Dazed"),
    description = ccb.content.text("You're visibly shaken up, and are having a hard time focusing on what's going on around you."),
    apply_message = ccb.content.text("The scream dazes you!"),
    rating = "bad",
    maximum_intensity = 10,
    maximum_duration_turns = 600,
    intensity_add_value = 2,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { per_intensity = -3 })
    :limb_score("balance", { multiplier = 0.5 })
    :limb_score("reaction", { multiplier = 0.35 })
    :limb_score("vision", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "riding",
    name = ccb.content.text("Riding"),
    description = ccb.content.text("You are riding an animal."),
    apply_message = ccb.content.text("You mount your steed."),
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.75 }))

-- is applied when you ride a mech. Ideally should be jsonified in some way
content.add(content.EffectType {
    id = "mech_recon_vision",
    name = "",
    description = ccb.content.text("."),
}
    :enchantment("THERMAL_VISION_GOOD_PASSIVE")
    :enchantment("nvg_great_mech"))

content.add(content.EffectType {
    id = "bouldering",
    name = ccb.content.text("Unstable Footing"),
    description = ccb.content.text("Your footing is unstable.  It's more difficult to fight while standing here."),
    apply_message = ccb.content.text("You try to keep your balance."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("GASTROPOD_BALANCE")
    :resist_trait("BIRD_LEGS")
    :limb_score("balance", { multiplier = 0.75 })
    :limb_score("footing", { multiplier = 0.4 }))

-- Copy of blind effect, used to temporarily remove vision as a utility function. Only use outside of EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW with extreme caution.
content.add(content.EffectType {
    id = "blind_no_msg",
    name = ccb.content.text("Blind"),
    description = "Range of Sight: 0.  You cannot see anything.  You shouldn't be able to see this description either!",
    rating = "bad",
    show_in_info = false,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("BLIND")
    :limb_score("vision", { multiplier = 0.0 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "earphones",
    name = ccb.content.text("Wearing Earphones"),
    description = ccb.content.text("You are wearing earphones and can't hear much from outside world."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_earphones_0")
    :limb_score("reaction", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "deaf",
    name = ccb.content.text("Impaired Hearing"),
    description = ccb.content.text("Your hearing is impaired."),
    apply_message = ccb.content.text("Your ears ring!"),
    remove_message = ccb.content.text("You can hear again!"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 100,
}
    :name(ccb.content.text("Ringing Ears"))
    :name(ccb.content.text("Deaf"))
    :description(ccb.content.text("You can barely hear anything and your ears hurt."))
    :description(ccb.content.text("You can't hear anything and your head aches from all the noise.  You can't converse with NPCs."))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = -50, per_intensity = 150 })
    :modifier("pain", "chance_denominator", { base = 1000 })
    :modifier("pain", "maximum_value", { per_intensity = 5 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "glowy_led",
    apply_message = ccb.content.text("A bionic LED is glowing softly beneath your skin."),
    rating = "mixed",
})

content.add(content.EffectType {
    id = "staggered_character",
    name = ccb.content.text("Staggered"),
    description = ccb.content.text("You've been knocked off-balance by an attack."),
    apply_message = ccb.content.text("You're staggered off-balance."),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "poison",
    name = ccb.content.text("Poisoned"),
    description = ccb.content.text("You have been poisoned!"),
    blood_analysis_description = ccb.content.text("Poison"),
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    maximum_intensity = 10,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("perception", "amount", { base = -2, resisted_base = -1 })
    :modifier("dexterity", "amount", { base = -1, resisted_base = -1 })
    :modifier("strength", "amount", { base = -2 })
    :modifier("health", "amount", { base = -2, resisted_base = -1 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 450, resisted_base = 2700 })
    :miss_message(ccb.content.text("You feel bad inside."), 1)
    :limb_score("manip", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 })
    :limb_score("lift", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 })
    :limb_score("grip", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 })
    :limb_score("block", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 })
    :limb_score("reaction", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 })
    :limb_score("balance", { multiplier = 0.85, resisted_multiplier = 0.92, per_intensity = -0.05, resisted_per_intensity = -0.016 }))

content.add(content.EffectType {
    id = "badpoison",
    name = ccb.content.text("Badly Poisoned"),
    description = ccb.content.text("You have been badly poisoned!"),
    blood_analysis_description = ccb.content.text("Poison"),
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    show_in_info = true,
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("perception", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("strength", "amount", { base = -3, resisted_base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("health", "amount", { base = -4, resisted_base = -1 })
    :modifier("health", "minimum", { base = -2 })
    :modifier("health", "chance_numerator", { base = 100, resisted_base = 500 })
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, resisted_base = 500 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = 300, resisted_base = 1800 })
    :miss_message(ccb.content.text("You feel bad inside."), 2))

content.add(content.EffectType {
    id = "tpollen",
    name = ccb.content.text("Short of Breath"),
    description = ccb.content.text("The pollen makes it hard to breathe!"),
    blood_analysis_description = ccb.content.text("Unknown Organic Toxin"),
    rating = "bad",
    harmful_cough = true,
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -2, resisted_base = -1 })
    :modifier("dexterity", "amount", { base = -1, resisted_base = -1 })
    :modifier("strength", "amount", { base = -2 })
    :modifier("health", "amount", { base = -3 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("hurt", "minimum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = 450, resisted_base = 2700 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("cough", "chance_numerator", { base = 10 })
    :miss_message(ccb.content.text("You cough out pollen."), 1)
    :limb_score("breathing", { multiplier = 0.6 }))

-- 30 m to max, 7,5 m overhead, dmg chance scales from 1/13 to 1/3, Pain from 1/20 to 1/5
content.add(content.EffectType {
    id = "venom_dmg",
    name = ccb.content.text("Poisoned Wound"),
    description = ccb.content.text("The wound swells visibly and burns like hell."),
    apply_message = ccb.content.text("Ow, that stings!"),
    remove_message = ccb.content.text("The burning pain subsides, but the damage is done."),
    blood_analysis_description = ccb.content.text("Necrotizing Venom"),
    show_intensity = false,
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    maximum_intensity = 125,
    maximum_effective_intensity = 100,
    intensity_duration_turns = 18,
    maximum_duration_turns = 2250,
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("health", "amount", { base = -5 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 20, resisted_base = 100 })
    :modifier("health", "tick", { base = 15, resisted_base = 60 })
    :modifier("pain", "amount", { base = 5, resisted_base = 2 })
    :modifier("pain", "minimum", { per_intensity = 0.05, resisted_base = -4, resisted_per_intensity = 0.01 })
    :modifier("pain", "chance_numerator", { base = 20, per_intensity = -0.15, resisted_base = 100, resisted_per_intensity = -0.8 })
    :modifier("pain", "maximum_value", { base = 60, resisted_base = 20 })
    :modifier("hurt", "amount", { base = 5 })
    :modifier("hurt", "minimum", { base = 2, resisted_base = 1 })
    :modifier("hurt", "chance_numerator", { base = 13, per_intensity = -0.11, resisted_base = 100, resisted_per_intensity = -0.81 })
    :modifier("hurt", "tick", { base = 36 }))

-- 4h to max, 1h overhead; Str/Dex to -6/3; Stam chance 0,25-0,5 / 0,1-0,2; Vomit ~1 per max duration
content.add(content.EffectType {
    id = "venom_weaken",
    speed_name = ccb.content.text("Poisoned"),
    name = ccb.content.text("Weakening Poison"),
    description = ccb.content.text("You feel feeble."),
    apply_message = ccb.content.text("The sting itself barely hurt, but suddenly you feel exhausted."),
    remove_message = ccb.content.text("The weight on your chest lessens."),
    blood_analysis_description = ccb.content.text("Systemic Inflammatory Agents"),
    rating = "bad",
    maximum_intensity = 125,
    maximum_effective_intensity = 100,
    maximum_duration_turns = 18000,
    intensity_duration_turns = 144,
    duration_add_percent = 500,
    show_intensity = false,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("strength", "amount", { base = -2, per_intensity = -0.05, resisted_per_intensity = -0.04 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = -0.05, resisted_per_intensity = -0.04 })
    :modifier("stamina", "amount", { base = -2000, resisted_base = -1000 })
    :modifier("stamina", "minimum", { base = -5, per_intensity = -0.351, resisted_per_intensity = -0.151 })
    :modifier("stamina", "chance_numerator", { base = 4.5, per_intensity = -0.021, resisted_base = 10, resisted_per_intensity = -0.051 })
    :modifier("speed", "amount", { base = -10, per_intensity = -0.31, resisted_per_intensity = -0.21 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 300, resisted_base = 1800 })
    :modifier("vomiting", "chance_numerator", { base = 15, resisted_base = 150 })
    :modifier("vomiting", "tick", { base = 1200 })
    :limb_score("manip", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.0025 })
    :limb_score("lift", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.0025 })
    :limb_score("grip", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.0025 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.0025 })
    :limb_score("reaction", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.025 })
    :limb_score("balance", { multiplier = 1.0, per_intensity = -0.01, resisted_per_intensity = -0.0025 }))

content.add(content.EffectType {
    id = "venom_blind",
    name = ccb.content.text("Distracted"),
    description = ccb.content.text("You find it hard to concentrate on your surroundings properly."),
    apply_message = ccb.content.text("Your vision grows blurry."),
    maximum_intensity = 3,
    intensity_add_value = 1,
    intensity_decay_step = -1,
    intensity_decay_tick = 90,
    intensity_decay_removes = true,
}
    :name(ccb.content.text("Inattentive"))
    :name(ccb.content.text("Dissociated"))
    :description(ccb.content.text("You're not even listening, are you?"))
    :description(ccb.content.text("Everything will be fine.  Just ignore all you see, and everything will be fine."))
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_trait("ELFA_NV")
    :modifier("perception", "amount", { base = -3, per_intensity = -2, resisted_per_intensity = -1 })
    :modifier("health", "amount", { base = -3 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 300, resisted_base = 1800 })
    :miss_message(ccb.content.text("It was right here, wasn't it?"), 2)
    :miss_message(ccb.content.text("Are you sure there's something there?"), 1)
    :limb_score("vision", { multiplier = 0.75, resisted_multiplier = 1.0, per_intensity = -0.25, resisted_per_intensity = -0.1 })
    :limb_score("night_vis", { multiplier = 1.0, resisted_multiplier = 1.0, per_intensity = 0.0, resisted_per_intensity = 0.0 })
    :limb_score("reaction", { multiplier = 1.0, resisted_multiplier = 1.0, per_intensity = 0.0, resisted_per_intensity = 0.0 }))

content.add(content.EffectType {
    id = "venom_pain",
    name = ccb.content.text("Distracting Wound"),
    description = ccb.content.text("The wound throbs with sharp pain."),
    apply_message = ccb.content.text("A dull pain starts spreading from the wound!"),
    maximum_intensity = 6,
    intensity_add_value = 1,
    intensity_decay_step = -1,
    intensity_decay_tick = 100,
    intensity_decay_removes = true,
}
    :name(ccb.content.text("Painful Wound"))
    :name(ccb.content.text("Searing Wound"))
    :resist_trait("PAINRESIST")
    :modifier("health", "amount", { base = -3 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 150, resisted_base = 900 })
    :modifier("pain", "amount", { base = 10, resisted_base = 2 })
    :modifier("pain", "minimum", { base = 5, per_intensity = 5, resisted_base = 1, resisted_per_intensity = 1 })
    :modifier("pain", "chance_numerator", { base = 10, per_intensity = -1, resisted_base = 20 })
    :modifier("pain", "tick", { base = 5 }))

-- In formal usage, 'nauseous' technically means 'to cause nausea [in others],' not 'feeling sick.'
content.add(content.EffectType {
    id = "foodpoison",
    name = ccb.content.text("Food Poisoning"),
    description = ccb.content.text("Your stomach is extremely upset, and you are quite nauseated."),
    rating = "bad",
}
    :resist_trait("POISRESIST")
    :resist_trait("VOMITSTOMACH")
    :modifier("perception", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -3, resisted_base = -1 })
    :modifier("speed", "amount", { base = -20 })
    :modifier("health", "amount", { base = -10 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 300, resisted_base = 900 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 300, resisted_base = 900 })
    :modifier("vomiting", "chance_numerator", { base = 600, resisted_base = 1200 })
    :miss_message(ccb.content.text("Your stomach bothers you."), 1))

-- Worse for fine manipulation than large movements
content.add(content.EffectType {
    id = "paralyzepoison",
    name = ccb.content.text("Slowed"),
    description = ccb.content.text("You are being slowed by a paralyzing poison!"),
    blood_analysis_description = ccb.content.text("Paralyzing Poison"),
    rating = "bad",
    maximum_intensity = 20,
    intensity_add_value = 1,
    intensity_decay_tick = 600,
    show_in_info = true,
}
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Partially Paralyzed"))
    :name(ccb.content.text("Partially Paralyzed"))
    :name(ccb.content.text("Partially Paralyzed"))
    :name(ccb.content.text("Partially Paralyzed"))
    :name(ccb.content.text("Partially Paralyzed"))
    :name(ccb.content.text("Totally Paralyzed"))
    :name(ccb.content.text("Totally Paralyzed"))
    :name(ccb.content.text("Totally Paralyzed"))
    :name(ccb.content.text("Totally Paralyzed"))
    :name(ccb.content.text("Totally Paralyzed"))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_trait("POISRESIST")
    :modifier("dexterity", "amount", { base = -0.34, per_intensity = -0.34, resisted_base = -0.17, resisted_per_intensity = -0.17 })
    :modifier("speed", "amount", { base = -5, per_intensity = -5, resisted_base = -3, resisted_per_intensity = -3 })
    :modifier("health", "amount", { base = -3 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 200, resisted_base = 750 })
    :miss_message(ccb.content.text("You feel stiff."), 3)
    :limb_score("manip", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.1, resisted_per_intensity = -0.025 })
    :limb_score("lift", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("grip", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.1, resisted_per_intensity = -0.025 })
    :limb_score("block", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("breathing", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("move_speed", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("balance", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.1, resisted_per_intensity = -0.025 })
    :limb_score("swim", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("crawl", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 }))

content.add(content.EffectType {
    id = "nausea",
    name = ccb.content.text("Slightly Nauseous"),
    description = ccb.content.text("You are nauseous and may lead to vomiting."),
    remove_message = ccb.content.text("You no longer feel nauseous."),
    rating = "bad",
    intensity_duration_turns = 180,
    maximum_intensity = 5,
    maximum_duration_turns = 900,
}
    :name(ccb.content.text("Mildly Nauseous"))
    :name(ccb.content.text("Nauseous"))
    :name(ccb.content.text("Very Nauseous"))
    :name(ccb.content.text("Extremely Nauseous"))
    :modifier("vomiting", "chance_numerator", { base = 500 }))

content.add(content.EffectType {
    id = "sleep_deprived",
    name = ccb.content.text("Sleep Deprived"),
    description = ccb.content.text("Your sleep debt has been steadily increasing for a while.  You should get some rest."),
    apply_message = ccb.content.text("You feel weary, your body tired from lack of quality sleep."),
    remove_message = ccb.content.text("You have finally caught up with your lost sleep, and you feel refreshed and awake for a change."),
    rating = "bad",
    maximum_intensity = 20160,
    intensity_duration_turns = 240,
}
    :modifier("speed", "amount", { base = -5, per_intensity = -1 })
    :modifier("intelligence", "amount", { per_intensity = -0.33 })
    :modifier("perception", "amount", { per_intensity = -0.33 })
    :modifier("strength", "amount", { per_intensity = -0.17 })
    :modifier("dexterity", "amount", { per_intensity = -0.17 }))

content.add(content.EffectType {
    id = "melatonin",
    name = ccb.content.text("Melatonin Supplements"),
    description = ccb.content.text("You took some melatonin supplements.  It makes you fall asleep more easily, and you sleep longer."),
    blood_analysis_description = ccb.content.text("Elevated sleep hormone levels (Melatonin)"),
    maximum_duration_turns = 50400,
    rating = "neutral",
}
    :enchantment("INLINE_ENCH_melatonin_0"))

-- Protects the first half hour of melatonin-assisted catch-up sleep from low-sleepiness wakeups.
content.add(content.EffectType {
    id = "melatonin_sleep",
    name = "",
    description = "",
    maximum_duration_turns = 1800,
})

content.add(content.EffectType {
    id = "mutagen",
    name = ccb.content.text("Changing"),
    description = ccb.content.text("You consumed mutagen.  It was probably a good idea."),
    remove_message = ccb.content.text("Your body is starting to feel normal again."),
    blood_analysis_description = ccb.content.text("Mutagen Contamination"),
    main_parts_only = true,
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Warping"))
    :name(ccb.content.text("Mutagen Overdose"))
    :description(ccb.content.text("You can feel your insides shifting.  It feels… nice."))
    :description(ccb.content.text("Your innards churn in an unnatural fashion - if you survive this, you'll be a changed… something."))
    :resist_trait("MUT_JUNKIE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 30 }))

content.add(content.EffectType {
    id = "mutagenic_slurry",
    name = ccb.content.text("Mutagenic Slurry"),
    description = ccb.content.text("Your stomach feels like it's burning.  Hopefully that was a good idea…"),
    apply_message = ccb.content.text("You feel awful!"),
    remove_message = ccb.content.text("You're feeling a little better now."),
    blood_analysis_description = ccb.content.text("Mutagenic Toxins Contamination"),
    main_parts_only = true,
    rating = "bad",
}
    :resist_trait("MUT_JUNKIE")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 300, resisted_base = 900 })
    :modifier("vomiting", "chance_numerator", { base = 600, resisted_base = 1200 }))

content.add(content.EffectType {
    id = "mutagen_chelator",
    name = ccb.content.text("Mutagen Chelator"),
    description = ccb.content.text("You took a dose of chelator.  Any mutagenic drugs in your body are being purged."),
    blood_analysis_description = ccb.content.text("Mutagen Chelator Contamination"),
    main_parts_only = true,
})

content.add(content.EffectType {
    id = "mutagen_alpha",
    name = ccb.content.text("Alpha Mutation"),
    description = ccb.content.text("You consumed alpha primer."),
    blood_analysis_description = ccb.content.text("Alpha Primer Contamination"),
    main_parts_only = true,
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Alpha Transformation"))
    :name(ccb.content.text("Alpha Metamorphosis"))
    :description(ccb.content.text("You feel better.  So much better."))
    :description(ccb.content.text("The world needs you, surely this won't kill you.  It better not."))
    :resist_trait("THRESH_ALPHA")
    :modifier("vomiting", "chance_numerator", { base = 1150, per_intensity = -450 })
    :modifier("vomiting", "tick", { base = 120 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = 500, per_intensity = -240, resisted_per_intensity = -50 })
    :modifier("hurt", "tick", { base = 150, per_intensity = -25 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 90, per_intensity = -30 })
    :modifier("pain", "tick", { base = 50 })
    :modifier("strength", "amount", { per_intensity = 1 })
    :modifier("perception", "amount", { per_intensity = 1 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = 1 }))

content.add(content.EffectType {
    id = "mutagen_batrachian",
    name = ccb.content.text("Frog Mutation"),
    description = ccb.content.text("You consumed frog primer."),
    blood_analysis_description = ccb.content.text("Frog Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Frog Transformation"))
    :name(ccb.content.text("Frog Metamorphosis"))
    :description(ccb.content.text("Now, to find a quiet pond and settle for the wait…"))
    :description(ccb.content.text("You feel like you're about to croak… if you don't keel over first."))
    :resist_trait("THRESH_BATRACHIAN")
    :modifier("vomiting", "chance_numerator", { base = 900, per_intensity = -425 })
    :modifier("vomiting", "tick", { base = 90 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum", { base = 2 })
    :modifier("thirst", "tick", { base = 1000, per_intensity = -400 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("speed", "amount", { per_intensity = 3 })
    :modifier("perception", "amount", { per_intensity = 1.5 }))

content.add(content.EffectType {
    id = "mutagen_beast",
    name = ccb.content.text("Beast Mutation"),
    description = ccb.content.text("You consumed beast primer."),
    blood_analysis_description = ccb.content.text("Beast Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Beast Transformation"))
    :name(ccb.content.text("Beast Metamorphosis"))
    :description(ccb.content.text("There must be prey around.  Stay alert."))
    :description(ccb.content.text("Primal instincts overwhelm your mind, and your saliva has turned to froth."))
    :resist_trait("THRESH_BEAST")
    :modifier("hunger", "minimum", { base = 1 })
    :modifier("hunger", "maximum", { base = 2 })
    :modifier("hunger", "tick", { base = 500, per_intensity = -200 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 1 })
    :modifier("perception", "amount", { per_intensity = 1 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_bird",
    name = ccb.content.text("Bird Mutation"),
    description = ccb.content.text("You consumed bird primer."),
    blood_analysis_description = ccb.content.text("Bird Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Bird Transformation"))
    :name(ccb.content.text("Bird Metamorphosis"))
    :description(ccb.content.text("You feel the pull of the skies."))
    :description(ccb.content.text("Goosebumps stand across your entire body.  You keep feeling that you're falling."))
    :resist_trait("THRESH_BIRD")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = -2 })
    :modifier("perception", "amount", { per_intensity = 1.5 })
    :modifier("speed", "amount", { per_intensity = 3.5 }))

content.add(content.EffectType {
    id = "mutagen_cattle",
    name = ccb.content.text("Cattle Mutation"),
    description = ccb.content.text("You consumed cattle primer."),
    blood_analysis_description = ccb.content.text("Cattle Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Cattle Transformation"))
    :name(ccb.content.text("Cattle Metamorphosis"))
    :description(ccb.content.text("This pasture will grow barren soon.  Keep moving."))
    :description(ccb.content.text("Dull fog clouds your mind, and you feel close to vomiting."))
    :resist_trait("THRESH_CATTLE")
    :modifier("vomiting", "chance_numerator", { base = 1200, per_intensity = -450 })
    :modifier("vomiting", "tick", { base = 90 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 150, per_intensity = -5 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 2.5 })
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :modifier("intelligence", "amount", { per_intensity = -1.5 }))

content.add(content.EffectType {
    id = "mutagen_cephalopod",
    name = ccb.content.text("Cephalopod Mutation"),
    description = ccb.content.text("You consumed cephalopod primer."),
    blood_analysis_description = ccb.content.text("Cephalopod Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Cephalopod Transformation"))
    :name(ccb.content.text("Cephalopod Metamorphosis"))
    :description(ccb.content.text("Become one with your surroundings."))
    :description(ccb.content.text("Your skin crawls and your extremities twitch and jerk."))
    :resist_trait("THRESH_CEPHALOPOD")
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum", { base = 2 })
    :modifier("thirst", "tick", { base = 1000, per_intensity = -400 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 40, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("intelligence", "amount", { per_intensity = 2.5 }))

content.add(content.EffectType {
    id = "mutagen_chimera",
    name = ccb.content.text("Chimera Mutation"),
    description = ccb.content.text("You consumed chimera primer.  Why?"),
    blood_analysis_description = ccb.content.text("Chimera Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Chimera Transformation"))
    :name(ccb.content.text("Chimera Metamorphosis"))
    :description(ccb.content.text("Your flesh is the clay of the new world.  You'll overcome all challenges."))
    :description(ccb.content.text("Your body heaving and changing is a rough time, but what doesn't kill you makes you stronger."))
    :resist_trait("THRESH_CHIMERA")
    :modifier("hunger", "minimum", { base = 1 })
    :modifier("hunger", "maximum", { base = 3 })
    :modifier("hunger", "tick", { base = 300, per_intensity = -120 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 2.5 })
    :modifier("intelligence", "amount", { per_intensity = -2 }))

content.add(content.EffectType {
    id = "mutagen_elfa",
    name = ccb.content.text("Elf-A Mutation"),
    description = ccb.content.text("You consumed Elf-A primer."),
    blood_analysis_description = ccb.content.text("Elf-A Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Elf-A Transformation"))
    :name(ccb.content.text("Elf-A Metamorphosis"))
    :description(ccb.content.text("You must look after this world, if no one else will."))
    :description(ccb.content.text("You see stars.  You see so many stars."))
    :resist_trait("THRESH_ELFA")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 200 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 50, per_intensity = -15 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("perception", "amount", { per_intensity = 2.5 })
    :modifier("intelligence", "amount", { per_intensity = 1 }))

content.add(content.EffectType {
    id = "mutagen_feline",
    name = ccb.content.text("Feline Mutation"),
    description = ccb.content.text("You consumed feline primer."),
    blood_analysis_description = ccb.content.text("Feline Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Feline Transformation"))
    :name(ccb.content.text("Feline Metamorphosis"))
    :description(ccb.content.text("Quiet steps and sharp claws.  They'll never see it coming."))
    :description(ccb.content.text("If this overdose kills you, you've got a few more lives… right?"))
    :resist_trait("THRESH_FELINE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = -0.5 })
    :modifier("perception", "amount", { per_intensity = 1 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = -1.5 }))

content.add(content.EffectType {
    id = "mutagen_fish",
    name = ccb.content.text("Fish Mutation"),
    description = ccb.content.text("You consumed fish primer."),
    blood_analysis_description = ccb.content.text("Fish Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Fish Transformation"))
    :name(ccb.content.text("Fish Metamorphosis"))
    :description(ccb.content.text("The waters call to you.  Leave this exposed wasteland."))
    :description(ccb.content.text("You feel clammy yet dry, absolutely parched no matter how much you drink."))
    :resist_trait("THRESH_FISH")
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum", { base = 2 })
    :modifier("thirst", "tick", { base = 900, per_intensity = -400 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 200 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("perception", "amount", { per_intensity = 1 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 }))

content.add(content.EffectType {
    id = "mutagen_gastropod",
    name = ccb.content.text("Snail Mutation"),
    description = ccb.content.text("You consumed snail primer."),
    blood_analysis_description = ccb.content.text("Snail Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Snail Transformation"))
    :name(ccb.content.text("Snail Metamorphosis"))
    :description(ccb.content.text("Slow and steady wins the race."))
    :description(ccb.content.text("You itch terribly, and your mouth feels salty and dry."))
    :resist_trait("THRESH_GASTROPOD")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 60 })
    :modifier("strength", "amount", { per_intensity = 1.5 })
    :modifier("speed", "amount", { per_intensity = -7.5 }))

content.add(content.EffectType {
    id = "mutagen_human",
    name = ccb.content.text("Human Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Human Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Human Reversion"))
    :name(ccb.content.text("Human Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_insect",
    name = ccb.content.text("Insect Mutation"),
    description = ccb.content.text("You consumed insect primer."),
    blood_analysis_description = ccb.content.text("Insect Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Insect Transformation"))
    :name(ccb.content.text("Insect Metamorphosis"))
    :description(ccb.content.text("You can't wait for your change.  It can't be long now."))
    :description(ccb.content.text("You can't stop shivering and twitching.  Life is so short."))
    :resist_trait("THRESH_INSECT")
    :modifier("vomiting", "chance_numerator", { base = 900, per_intensity = -420 })
    :modifier("vomiting", "tick", { base = 90 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("speed", "amount", { per_intensity = 1.5 })
    :modifier("perception", "amount", { per_intensity = 0.5 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = -1.5 }))

content.add(content.EffectType {
    id = "mutagen_lizard",
    name = ccb.content.text("Lizard Mutation"),
    description = ccb.content.text("You consumed lizard primer."),
    blood_analysis_description = ccb.content.text("Lizard Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Lizard Transformation"))
    :name(ccb.content.text("Lizard Metamorphosis"))
    :description(ccb.content.text("Your skin feels dry and too small.  You'll have to molt soon."))
    :description(ccb.content.text("Your limbs slump, almost ready to tear right out of their sockets."))
    :resist_trait("THRESH_LIZARD")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 50 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 125 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = -1.5 }))

content.add(content.EffectType {
    id = "mutagen_lupine",
    name = ccb.content.text("Lupine Mutation"),
    description = ccb.content.text("You consumed lupine primer."),
    blood_analysis_description = ccb.content.text("Lupine Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Lupine Transformation"))
    :name(ccb.content.text("Lupine Metamorphosis"))
    :description(ccb.content.text("Where's your pack?  How will you survive without them?"))
    :description(ccb.content.text("You pant, unable to stop pacing and full of hunger."))
    :resist_trait("THRESH_LUPINE")
    :modifier("hunger", "minimum", { base = 10 })
    :modifier("hunger", "maximum", { base = 20 })
    :modifier("hunger", "tick", { base = 500, per_intensity = -175 })
    :modifier("hunger", "chance_numerator", { base = 6 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 1.5 })
    :modifier("perception", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = -2 })
    :modifier("speed", "amount", { per_intensity = 2.5 }))

content.add(content.EffectType {
    id = "mutagen_medical",
    name = ccb.content.text("Medical Mutation"),
    description = ccb.content.text("You consumed medical primer."),
    blood_analysis_description = ccb.content.text("Medical Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Medical Transformation"))
    :name(ccb.content.text("Medical Metamorphosis"))
    :description(ccb.content.text("You consumed medical primer.  You should do that again."))
    :description(ccb.content.text("You're tearing yourself apart.  Need to get fixed back up.  Should put some stitches in you."))
    :resist_trait("THRESH_MEDICAL")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 40, per_intensity = -16 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 2 })
    :modifier("dexterity", "amount", { per_intensity = 2 })
    :modifier("intelligence", "amount", { per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_mouse",
    name = ccb.content.text("Mouse Mutation"),
    description = ccb.content.text("You consumed mouse primer."),
    blood_analysis_description = ccb.content.text("Mouse Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Mouse Transformation"))
    :name(ccb.content.text("Mouse Metamorphosis"))
    :description(ccb.content.text("Your heart pounds, knowing that predators could approach at any second!"))
    :description(ccb.content.text("Your heart hammers away with a rapid, irregular beat."))
    :resist_trait("THRESH_MOUSE")
    :modifier("speed", "amount", { base = 1, per_intensity = 6.5 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = -1.5 })
    :modifier("dexterity", "amount", { per_intensity = 1 }))

content.add(content.EffectType {
    id = "mutagen_plant",
    name = ccb.content.text("Plant Mutation"),
    description = ccb.content.text("You consumed plant primer."),
    blood_analysis_description = ccb.content.text("Plant Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Plant Transformation"))
    :name(ccb.content.text("Plant Metamorphosis"))
    :description(ccb.content.text("All this running… why don't you just find a nice, fertile spot and bask in the sun?"))
    :description(ccb.content.text("Your processes are slowing.  You would make great fertilizer."))
    :resist_trait("THRESH_PLANT")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 200 })
    :modifier("strength", "amount", { per_intensity = 1.5 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = -1 })
    :modifier("speed", "amount", { per_intensity = -7.5 }))

content.add(content.EffectType {
    id = "mutagen_raptor",
    name = ccb.content.text("Raptor Mutation"),
    description = ccb.content.text("You consumed raptor primer."),
    blood_analysis_description = ccb.content.text("Raptor Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Raptor Transformation"))
    :name(ccb.content.text("Raptor Metamorphosis"))
    :description(ccb.content.text("Sharpen your talons and clean your feathers.  Your prey won't give itself easily."))
    :description(ccb.content.text("Delusions fill your head… is it true?  Did you die long ago?"))
    :resist_trait("THRESH_RAPTOR")
    :modifier("hunger", "minimum", { base = 5 })
    :modifier("hunger", "maximum", { base = 15 })
    :modifier("hunger", "tick", { base = 500, per_intensity = -200 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 100 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("perception", "amount", { per_intensity = 1 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = -3 })
    :modifier("speed", "amount", { per_intensity = 7.5 }))

content.add(content.EffectType {
    id = "mutagen_rabbit",
    name = ccb.content.text("Rabbit Mutation"),
    description = ccb.content.text("You consumed rabbit primer."),
    blood_analysis_description = ccb.content.text("Rabbit Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Rabbit Transformation"))
    :name(ccb.content.text("Rabbit Metamorphosis"))
    :description(ccb.content.text("So much to do!  Better hop to it!"))
    :description(ccb.content.text("Will you have a future?  Will any new generations be born… your pounding head is full of worry."))
    :resist_trait("THRESH_RABBIT")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 60, per_intensity = -15 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = -1.5 })
    :modifier("dexterity", "amount", { per_intensity = 2.5 })
    :modifier("intelligence", "amount", { per_intensity = -1 })
    :modifier("speed", "amount", { per_intensity = 3.5 }))

content.add(content.EffectType {
    id = "mutagen_rat",
    name = ccb.content.text("Rat Mutation"),
    description = ccb.content.text("You consumed rat primer."),
    blood_analysis_description = ccb.content.text("Rat Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Rat Transformation"))
    :name(ccb.content.text("Rat Metamorphosis"))
    :description(ccb.content.text("This place is too open.  Hide!"))
    :description(ccb.content.text("Dull aches fill your stomach, and every smell seems offensive."))
    :resist_trait("THRESH_RAT")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = -2 })
    :modifier("speed", "amount", { per_intensity = 3.5 }))

content.add(content.EffectType {
    id = "mutagen_chiropteran",
    name = ccb.content.text("Chiropteran Mutation"),
    description = ccb.content.text("You consumed chiropteran primer."),
    blood_analysis_description = ccb.content.text("Chiropteran Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Chiropteran Transformation"))
    :name(ccb.content.text("Chiropteran Metamorphosis"))
    :description(ccb.content.text("You taste iron, and you want more."))
    :description(ccb.content.text("Every sound is a painful screech in your ears.  It's all too much!"))
    :resist_trait("THRESH_CHIROPTERAN")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("dexterity", "amount", { per_intensity = 1 })
    :modifier("intelligence", "amount", { per_intensity = -2 })
    :modifier("speed", "amount", { per_intensity = 3.5 }))

content.add(content.EffectType {
    id = "mutagen_slime",
    name = ccb.content.text("Slime Mutation"),
    description = ccb.content.text("You consumed slime primer."),
    blood_analysis_description = ccb.content.text("Slime Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Slime Transformation"))
    :name(ccb.content.text("Slime Metamorphosis"))
    :description(ccb.content.text("Plop."))
    :description(ccb.content.text("Brain… melting…"))
    :resist_trait("THRESH_SLIME")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 90 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 10, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = -1.5 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = 2.5 })
    :modifier("speed", "amount", { per_intensity = -3.5 }))

content.add(content.EffectType {
    id = "mutagen_spider",
    name = ccb.content.text("Spider Mutation"),
    description = ccb.content.text("You consumed spider primer."),
    blood_analysis_description = ccb.content.text("Spider Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Spider Transformation"))
    :name(ccb.content.text("Spider Metamorphosis"))
    :description(ccb.content.text("An anchor line there and there, connect with capture threads…"))
    :description(ccb.content.text("Perhaps you should curl up, just curl up and give in."))
    :resist_trait("THRESH_SPIDER")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 60, per_intensity = -25 })
    :modifier("pain", "tick", { base = 100 })
    :modifier("dexterity", "amount", { per_intensity = 1.5 })
    :modifier("intelligence", "amount", { per_intensity = -1 })
    :modifier("speed", "amount", { per_intensity = 4 }))

content.add(content.EffectType {
    id = "mutagen_ursine",
    name = ccb.content.text("Ursine Mutation"),
    description = ccb.content.text("You consumed ursine primer."),
    blood_analysis_description = ccb.content.text("Ursine Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Ursine Transformation"))
    :name(ccb.content.text("Ursine Metamorphosis"))
    :description(ccb.content.text("Berries, brood, honey, or meat?  What will today bring?"))
    :description(ccb.content.text("Sleep sounds good.  Sleep forever, maybe."))
    :resist_trait("THRESH_URSINE")
    :modifier("strength", "amount", { base = 1, per_intensity = 2.5 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "chance_numerator", { base = 1100, per_intensity = -500 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("perception", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "mutagen_crustacean",
    name = ccb.content.text("Crustacean Mutation"),
    description = ccb.content.text("You consumed crustacean mutagen."),
    blood_analysis_description = ccb.content.text("Crustacean Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Crustacean Transformation"))
    :name(ccb.content.text("Crustacean Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of crustacean mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of crustacean mutagen."))
    :resist_trait("THRESH_CRUSTACEAN")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_interstice",
    name = ccb.content.text("Interstitial Mutation"),
    description = ccb.content.text("You consumed some interdimensional contaminant."),
    blood_analysis_description = ccb.content.text("Interdimensional Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Interstitial Transformation"))
    :name(ccb.content.text("Interstitial Metamorphosis"))
    :description(ccb.content.text("Who said that?"))
    :description(ccb.content.text("You see all the colors of space."))
    :resist_trait("THRESH_INTERSTICE")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 200 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 50, per_intensity = -15 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("perception", "amount", { per_intensity = 2.5 })
    :modifier("intelligence", "amount", { per_intensity = 1 }))

content.add(content.EffectType {
    id = "beartrap",
    name = ccb.content.text("Stuck in a Beartrap"),
    description = ccb.content.text("You can't move until you get free!"),
    apply_message = ccb.content.text("You are caught!"),
    rating = "bad",
    show_in_info = true,
})

-- Don't multiply speed by 0 or else the effect will never be removed for creatures with 0 damage(e.g. rabbits)
content.add(content.EffectType {
    id = "lightsnare",
    name = ccb.content.text("Snared"),
    description = ccb.content.text("For such a tiny creature, you're in a very big pickle."),
    rating = "bad",
    show_intensity = false,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_lightsnare_0"))

-- No night vision for you
content.add(content.EffectType {
    id = "glare",
    name = ccb.content.text("Glare"),
    description = ccb.content.text("The sun is in your eyes."),
    apply_message = ccb.content.text("The sunlight's glare makes it hard to see."),
    rating = "bad",
    maximum_duration_turns = 60,
}
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :modifier("perception", "amount", { base = -1 })
    :limb_score("vision", { multiplier = 0.5 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "snow_glare",
    name = ccb.content.text("Snow Glare"),
    description = ccb.content.text("The sunlight is reflecting off the snow."),
    apply_message = ccb.content.text("The sunlight reflecting off the snow makes it hard to see."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :modifier("perception", "amount", { base = -1 })
    :limb_score("vision", { multiplier = 0.5 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "laserlocked",
    name = ccb.content.text("Laser-targeted"),
    description = ccb.content.text("A laser sight is targeting you!"),
    apply_message = "",
    rating = "bad",
})

content.add(content.EffectType {
    id = "was_laserlocked",
    name = "",
    description = "",
    apply_message = "",
    rating = "bad",
})

content.add(content.EffectType {
    id = "smoke_lungs",
    name = ccb.content.text("Inhaled Some Smoke"),
    description = ccb.content.text("You draw in a faint whiff of smoke."),
    harmful_cough = true,
    maximum_duration_turns = 180,
    maximum_intensity = 4,
    intensity_decay_tick = 40,
    show_in_info = true,
}
    :name(ccb.content.text("Inhaled Plenty of Smoke"))
    :name(ccb.content.text("Smoke Inhalation"))
    :name(ccb.content.text("Bad Smoke Inhalation"))
    :description(ccb.content.text("A noticeable volume of smoke fills your lungs."))
    :description(ccb.content.text("A dense cloud of smoke enters your lungs."))
    :description(ccb.content.text("You inhale an overwhelming volume of smoke."))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :modifier("cough", "chance_numerator", { per_intensity = 10 })
    :apply_message(ccb.content.text("You draw in a faint whiff of smoke."), "bad")
    :apply_message(ccb.content.text("A noticeable volume of smoke fills your lungs."), "bad")
    :apply_message(ccb.content.text("A dense cloud of smoke enters your lungs."), "bad")
    :apply_message(ccb.content.text("You inhale an overwhelming volume of smoke."), "bad")
    :miss_message(ccb.content.text("Your lungs burn from the smoke."), 1)
    :limb_score("breathing", { resisted_multiplier = 1, per_intensity = -0.25 })
    :limb_score("reaction", { resisted_multiplier = 1, per_intensity = -0.1 })
    :limb_score("balance", { resisted_multiplier = 1, per_intensity = -0.1 })
    :limb_score("lift", { resisted_multiplier = 1, per_intensity = -0.1 })
    :limb_score("manip", { resisted_multiplier = 1, per_intensity = -0.1 }))

content.add(content.EffectType {
    id = "teargas",
    name = ccb.content.text("Tear Gas"),
    description = ccb.content.text("You've been exposed to tear gas!"),
    apply_message = ccb.content.text("You inhale a lungful of tear gas."),
    rating = "bad",
    harmful_cough = true,
    maximum_duration_turns = 1800,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :resist_effect("steroid_eye")
    :modifier("strength", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -5, resisted_base = -2 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("cough", "chance_numerator", { base = 5 })
    :miss_message(ccb.content.text("Your eyes burn from the tear gas."), 2)
    :limb_score("vision", { multiplier = 0.5, resisted_multiplier = 0.75 })
    :limb_score("night_vis", { multiplier = 0.5, resisted_multiplier = 0.75 })
    :limb_score("reaction", { multiplier = 0.75, resisted_multiplier = 0.875 })
    :limb_score("breathing", { multiplier = 0.3 }))

content.add(content.EffectType {
    id = "boomered",
    name = ccb.content.text("Boomered"),
    description = ccb.content.text("Your vision is obscured by a disgusting splatter of bile."),
    apply_message = ccb.content.text("You're covered in bile!"),
    rating = "bad",
    maximum_duration_turns = 30,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :limb_score("vision", { multiplier = 0.1 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "glowing",
    name = ccb.content.text("Glowing"),
    description = ccb.content.text("You are covered in glowing goo!"),
    apply_message = ccb.content.text("You're covered in a glowing goo!"),
    maximum_duration_turns = 360,
    rating = "bad",
    show_in_info = true,
}
    :modifier("vomiting", "chance_numerator", { base = 500 }))

content.add(content.EffectType {
    id = "bile_stink",
    name = ccb.content.text("Bile Stink"),
    description = ccb.content.text("You're splattered with a greasy layer of liquified putrescence."),
    apply_message = ccb.content.text("You're covered in a foul smelling fluid!"),
    rating = "bad",
    maximum_duration_turns = 3600,
    show_in_info = true,
}
    :decay_message(ccb.content.text("The rancid smell of corpse bile finally goes away."), "good")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("SAPROVORE")
    :resist_trait("EATDEAD")
    :enchantment("INLINE_ENCH_bile_stink_0")
    :modifier("vomiting", "chance_numerator", { base = 500, resisted_base = 2000 })
    :limb_score("breathing", { multiplier = 0.95, resisted_multiplier = 1 }))

content.add(content.EffectType {
    id = "bile_irritant",
    name = ccb.content.text("Bile Irritant"),
    description = ccb.content.text("Acidic boomer bile is irritating your skin."),
    rating = "bad",
    maximum_duration_turns = 900,
}
    :decay_message(ccb.content.text("Your skin irritation stops."), "good")
    :immune_character_flag("ACID_IMMUNE")
    :immune_character_flag("IRRITANT_IMMUNE")
    :resist_effect("wet")
    :resist_trait("POISRESIST")
    :modifier("pain", "amount", { base = 1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 4, resisted_base = 2 })
    :modifier("pain", "chance_numerator", { base = 150, resisted_base = 300 })
    :modifier("health_modifier", "minimum", { base = -1 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 120, resisted_base = 360 })
    :modifier("intelligence", "amount", { base = -1 })
    :on_hit_effect_duration("bite", 1.5, false))

content.add(content.EffectType {
    id = "skunk_spray",
    name = ccb.content.text("Skunk Spray"),
    description = ccb.content.text("You were sprayed by a skunk!"),
    apply_message = ccb.content.text("You're covered in a foul smelling fluid!"),
    rating = "bad",
    maximum_duration_turns = 18000,
}
    :modifier("perception", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("vomiting", "chance_numerator", { base = 2000 }))

content.add(content.EffectType {
    id = "skunk_spray_neutralizer",
    name = ccb.content.text("Skunk Spray Neutralized"),
    description = ccb.content.text("A solution that neutralizes skunk odors."),
    apply_message = ccb.content.text("As you apply the solution, the skunk odor dissipates."),
    rating = "good",
    maximum_duration_turns = 120,
}
    :removes_effect("skunk_spray"))

content.add(content.EffectType {
    id = "conjunctivitis",
    name = ccb.content.text("Conjunctivitis"),
    description = ccb.content.text("Your eyes are inflamed."),
    apply_message = ccb.content.text("The chemical irritant damaged your eyes!"),
    rating = "bad",
    maximum_duration_turns = 604800,
    duration_add_percent = 35,
}
    :decay_message(ccb.content.text("The irritation in your eyes stops."), "good")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("POISIMMUNE")
    :immune_character_flag("SEESLEEP")
    :resist_effect("steroid_eye")
    :resist_trait("POISRESIST")
    :resist_trait("PER_SLIME_OK")
    :modifier("perception", "amount", { base = -1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 4, resisted_base = 2 })
    :modifier("pain", "chance_numerator", { base = 400, resisted_base = 1000 })
    :miss_message(ccb.content.text("It feels like there's sand in your eye."), 1)
    :limb_score("vision", { multiplier = 0.85, resisted_multiplier = 0.95 }))

content.add(content.EffectType {
    id = "took_flumed",
    blood_analysis_description = ccb.content.text("Antihistamines"),
    rating = "good",
    maximum_duration_turns = 57600,
    duration_add_percent = 30,
})

content.add(content.EffectType {
    id = "took_xanax",
    blood_analysis_description = ccb.content.text("Fast-acting sedatives"),
    maximum_duration_turns = 14400,
    duration_add_percent = 22,
    rating = "good",
}
    :modifier("stimulant", "tick", { base = 150 })
    :modifier("stimulant", "minimum", { base = -1 })
    :modifier("stimulant", "minimum_value", { base = -1 }))

content.add(content.EffectType {
    id = "took_xanax_visible",
    name = ccb.content.text("Took Fast-acting Sedative"),
    description = ccb.content.text("You took a fast-acting sedative some time ago and you might still be under its influence."),
    maximum_duration_turns = 18000,
    duration_add_percent = 20,
})

content.add(content.EffectType {
    id = "took_prozac",
    blood_analysis_description = ccb.content.text("Antidepressants"),
    rating = "good",
    maximum_duration_turns = 64800,
    duration_add_percent = 40,
})

content.add(content.EffectType {
    id = "took_prozac_bad",
})

content.add(content.EffectType {
    id = "took_prozac_visible",
    name = ccb.content.text("Took Antidepressant"),
    description = ccb.content.text("You took an antidepressant some time ago and you might still be under its influence."),
    maximum_duration_turns = 72000,
    duration_add_percent = 35,
})

content.add(content.EffectType {
    id = "in_pit",
    name = ccb.content.text("Stuck in a Pit"),
    description = ccb.content.text("You're stuck in a pit.  Sight distance is limited and you have to climb out."),
    show_in_info = true,
})

content.add(content.EffectType {
    id = "took_thorazine",
    blood_analysis_description = ccb.content.text("Antipsychotics"),
    rating = "good",
    maximum_duration_turns = 64800,
    duration_add_percent = 50,
})

content.add(content.EffectType {
    id = "took_thorazine_bad",
})

content.add(content.EffectType {
    id = "took_thorazine_visible",
    name = ccb.content.text("Took Antipsychotic"),
    description = ccb.content.text("You took an antipsychotic some time ago and you might still be under its influence."),
    maximum_duration_turns = 72000,
    duration_add_percent = 35,
})

content.add(content.EffectType {
    id = "no_sight",
    name = ccb.content.text("Poor Sight"),
    description = ccb.content.text("You can't see very far from this spot."),
    apply_message = ccb.content.text("Your sight distance is impaired."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("vision", { multiplier = 0.1 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "anticoagulant",
    blood_analysis_description = ccb.content.text("Blood Thinner"),
    maximum_intensity = 3,
    rating = "bad",
}
    :on_hit_effect_duration("bleed", 1.05, false))

-- Blood pressure up.  Remember that this is divided by 10000, so maximum 5% increase.
-- NSAIDs are the drug family that includes ibuprofen.
content.add(content.EffectType {
    id = "nsaid_eff",
    rating = "bad",
}
    :modifier("blood_pressure", "tick", { base = 100 })
    :modifier("blood_pressure", "minimum", { base = 2 })
    :modifier("blood_pressure", "maximum_value", { base = 500 }))

content.add(content.EffectType {
    id = "pkill1_generic",
    blood_analysis_description = ccb.content.text("Minor Painkiller"),
    maximum_duration_turns = 240,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 15 }))

content.add(content.EffectType {
    id = "pkill1_nsaid",
    blood_analysis_description = ccb.content.text("Minor Painkiller (NSAID-based)"),
    maximum_duration_turns = 240,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 15 }))

content.add(content.EffectType {
    id = "pkill1_acetaminophen",
    blood_analysis_description = ccb.content.text("Minor Painkiller (Acetaminophen)"),
    maximum_duration_turns = 240,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 15 }))

content.add(content.EffectType {
    id = "pkill2",
    blood_analysis_description = ccb.content.text("Moderate Painkiller"),
    painkiller_addiction_reduces = true,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 2 }))

content.add(content.EffectType {
    id = "pkill3",
    blood_analysis_description = ccb.content.text("Heavy Painkiller"),
    painkiller_addiction_reduces = true,
    rating = "good",
}
    :modifier("painkiller", "tick", { base = 12 })
    :modifier("painkiller", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "pkill_l",
    blood_analysis_description = ccb.content.text("Slow-Release Painkiller"),
    painkiller_addiction_reduces = true,
    rating = "good",
}
    :modifier("painkiller", "maximum_value", { base = 40 })
    :modifier("painkiller", "tick", { base = 120 })
    :modifier("painkiller", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "pkill_wintergreen",
    blood_analysis_description = ccb.content.text("Ate wintergreen leaves"),
    painkiller_addiction_reduces = true,
    rating = "good",
}
    :modifier("painkiller", "maximum_value", { base = 15 })
    :modifier("painkiller", "tick", { base = 50 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "chance_numerator", { base = 45 }))

content.add(content.EffectType {
    id = "pkill_wintergreen_oil",
    blood_analysis_description = ccb.content.text("Wintergreen Oil"),
    painkiller_addiction_reduces = true,
    rating = "good",
}
    :modifier("painkiller", "maximum_value", { base = 30 })
    :modifier("painkiller", "tick", { base = 42 })
    :modifier("painkiller", "minimum", { base = 2 }))

content.add(content.EffectType {
    id = "webbed",
    name = ccb.content.text("Webbed"),
    description = ccb.content.text("You are covered in webs!"),
    apply_message = ccb.content.text("You're covered in webs!"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_add_value = 1,
    show_in_info = true,
    show_intensity = false,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -20, per_intensity = -5 })
    :miss_message(ccb.content.text("The webs restrict your movement."), 4)
    :limb_score("lift", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("breathing", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "sludged",
    name = ccb.content.text("Sludged"),
    description = ccb.content.text("You're standing in sludge!"),
    apply_message = ccb.content.text("You've stepped into some sludge!"),
    rating = "bad",
    maximum_intensity = 3,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :miss_message(ccb.content.text("The sludge restricts your movement."), 4)
    :limb_score("move_speed", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("footing", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("balance", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "recover",
    name = ccb.content.text("Recovering from Infection"),
    description = ccb.content.text("You are recovering from an infection."),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 115200,
}
    :resist_trait("INFRESIST")
    :modifier("strength", "amount", { base = -1, per_intensity = -1, resisted_per_intensity = -0.5 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -1, resisted_per_intensity = -0.5 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = -2, resisted_per_intensity = -1 })
    :modifier("vomiting", "chance_numerator", { base = 1200, per_intensity = -500, resisted_base = 1800 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum", { base = 3, resisted_base = 2 })
    :modifier("thirst", "chance_numerator", { base = 10, resisted_base = 100 })
    :modifier("thirst", "tick", { base = 60 })
    :modifier("speed", "amount", { base = -5, per_intensity = -5, resisted_per_intensity = -4 })
    :modifier("stamina", "minimum", { base = -8, per_intensity = -6, resisted_per_intensity = -3 })
    :modifier("stamina", "chance_numerator", { base = 10, per_intensity = -1, resisted_base = 20, resisted_per_intensity = -2.5 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "maximum", { base = 5, resisted_base = 3 })
    :modifier("sleepiness", "chance_numerator", { base = 210, per_intensity = -60 })
    :modifier("sleepiness", "maximum_value", { base = 500, resisted_base = 125 })
    :modifier("healing", "amount", { base = 0.5 }))

content.add(content.EffectType {
    id = "bandaged",
    name = ccb.content.text("Bandaged"),
    description = ccb.content.text("The wounds on your %s are bandaged."),
    main_parts_only = true,
    rating = "good",
    intensity_duration_turns = 21600,
    maximum_intensity = 16,
    maximum_effective_intensity = 8,
    part_descriptions = true,
    maximum_duration_turns = 345600,
}
    :modifier("healing", "amount", { base = 2, per_intensity = 2 })
    :modifier("healing_head", "amount", { base = 50 })
    :modifier("healing_torso", "amount", { base = 150 }))

content.add(content.EffectType {
    id = "disinfected",
    name = ccb.content.text("Disinfected"),
    description = ccb.content.text("The wounds on your %s are disinfected."),
    main_parts_only = true,
    rating = "good",
    intensity_duration_turns = 21600,
    maximum_intensity = 16,
    maximum_effective_intensity = 8,
    part_descriptions = true,
    maximum_duration_turns = 345600,
}
    :modifier("healing", "amount", { base = 2, per_intensity = 2 })
    :modifier("healing_head", "amount", { base = 50 })
    :modifier("healing_torso", "amount", { base = 150 }))

content.add(content.EffectType {
    id = "spores",
    speed_name = ccb.content.text("Spore Covered"),
    name = ccb.content.text("Spore Dusted"),
    description = ccb.content.text("You can feel the tiny spores sinking directly into your flesh."),
    maximum_intensity = 3,
    intensity_decay_tick = 720,
    intensity_add_value = 1,
    main_parts_only = true,
    show_in_info = true,
}
    :name(ccb.content.text("Spore Covered"))
    :name(ccb.content.text("Spore Coated"))
    :resist_trait("M_IMMUNE")
    :modifier("speed", "amount", { base = -7, per_intensity = -3 })
    :apply_message(ccb.content.text("You feel your skin prickle with an uncomfortable feeling, and as you try to rub away the specks of dust you realize they've started to embed themselves, sinking into your skin."), "bad"))

content.add(content.EffectType {
    id = "hallucinogenic_acid_light",
    name = ccb.content.text("Bad High"),
    description = ccb.content.text("You've been exposed to fungal acid fumes!"),
    apply_message = ccb.content.text("You inhale a lungful of hallucinogenic acid fumes."),
    rating = "bad",
    harmful_cough = true,
    maximum_duration_turns = 2400,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :resist_trait("M_IMMUNE")
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -3 })
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -5 })
    :modifier("cough", "chance_numerator", { base = 30 })
    :modifier("vomiting", "chance_numerator", { base = 3000 })
    :miss_message(ccb.content.text("The world spins."), 2)
    :limb_score("vision", { multiplier = 0.6 })
    :limb_score("night_vis", { multiplier = 0.7 })
    :limb_score("reaction", { multiplier = 0.8 })
    :limb_score("breathing", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "hallucinogenic_acid_heavy",
    name = ccb.content.text("Really Bad High"),
    description = ccb.content.text("You've been exposed to thick fungal acid fumes!"),
    apply_message = ccb.content.text("You inhale a lungful of thick hallucinogenic acid fumes."),
    rating = "bad",
    harmful_cough = true,
    maximum_duration_turns = 2400,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :resist_trait("M_IMMUNE")
    :modifier("strength", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("perception", "amount", { base = -6 })
    :modifier("intelligence", "amount", { base = -4 })
    :modifier("speed", "amount", { base = -7 })
    :modifier("cough", "chance_numerator", { base = 50 })
    :modifier("vomiting", "chance_numerator", { base = 4000 })
    :miss_message(ccb.content.text("The world fractals."), 2)
    :limb_score("vision", { multiplier = 0.45 })
    :limb_score("night_vis", { multiplier = 0.6 })
    :limb_score("reaction", { multiplier = 0.7 })
    :limb_score("breathing", { multiplier = 0.7 }))

content.add(content.EffectType {
    id = "rat",
    name = ccb.content.text("Ratting"),
    description = ccb.content.text("You feel nauseated and rat-like."),
    maximum_intensity = 100,
}
    :modifier("intelligence", "amount", { base = -0.5, per_intensity = -0.5 })
    :modifier("strength", "amount", { base = -0.2, per_intensity = -0.2 })
    :modifier("perception", "amount", { base = -0.4, per_intensity = -0.4 }))

content.add(content.EffectType {
    id = "pblue",
    blood_analysis_description = ccb.content.text("Prussian Blue"),
    maximum_duration_turns = 10800,
    duration_add_percent = 35,
    rating = "good",
}
    :modifier("radiation", "chance_numerator", { base = 600 })
    :modifier("radiation", "minimum", { base = -1 }))

content.add(content.EffectType {
    id = "iodine",
    blood_analysis_description = ccb.content.text("Potassium Iodide"),
    rating = "good",
})

content.add(content.EffectType {
    id = "shakes",
    name = ccb.content.text("Shakes"),
    description = ccb.content.text("Your hands just won't stop shaking."),
    maximum_duration_turns = 7200,
    duration_add_percent = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -4 })
    :miss_message(ccb.content.text("You tremble."), 4)
    :limb_score("reaction", { multiplier = 0.7 })
    :limb_score("block", { multiplier = 0.5 })
    :limb_score("balance", { multiplier = 0.75 })
    :limb_score("footing", { multiplier = 0.75 }))

-- Intended to be applied with downed to make it nearly impossible for player to stand.
content.add(content.EffectType {
    id = "motor_seizure",
    name = ccb.content.text("Seizure"),
    description = ccb.content.text("Your muscles have seized up, and you can't control them!"),
    remove_message = ccb.content.text("You regain control of your muscles!"),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("strength", "amount", { base = -12 })
    :modifier("dexterity", "amount", { base = -20 })
    :miss_message(ccb.content.text("Your muscles won't cooperate!"), 20)
    :limb_score("reaction", { multiplier = 0.2 })
    :limb_score("block", { multiplier = 0 })
    :limb_score("balance", { multiplier = 0.2 })
    :limb_score("footing", { multiplier = 0.2 })
    :limb_score("crawl", { multiplier = 0 }))

content.add(content.EffectType {
    id = "bleed",
    name = ccb.content.text("Minor Bleeding"),
    description = ccb.content.text("'Tis but a scratch."),
    apply_message = ccb.content.text("You're bleeding!"),
    remove_message = ccb.content.text("The bleeding stops!"),
    main_parts_only = true,
    rating = "bad",
    maximum_intensity = 40,
    intensity_duration_turns = 60,
    maximum_duration_turns = 2400,
    show_in_info = true,
}
    :name(ccb.content.text("Minor Bleeding"))
    :name(ccb.content.text("Minor Bleeding"))
    :name(ccb.content.text("Minor Bleeding"))
    :name(ccb.content.text("Minor Bleeding"))
    :name(ccb.content.text("Bleeding"))
    :name(ccb.content.text("Bleeding"))
    :name(ccb.content.text("Bleeding"))
    :name(ccb.content.text("Bleeding"))
    :name(ccb.content.text("Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Bad Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :name(ccb.content.text("Heavy Arterial Bleeding"))
    :description(ccb.content.text("'Tis but a scratch."))
    :description(ccb.content.text("'Tis but a scratch."))
    :description(ccb.content.text("'Tis but a scratch."))
    :description(ccb.content.text("'Tis but a scratch."))
    :description(ccb.content.text("You are slowly losing blood."))
    :description(ccb.content.text("You are slowly losing blood."))
    :description(ccb.content.text("You are slowly losing blood."))
    :description(ccb.content.text("You are slowly losing blood."))
    :description(ccb.content.text("You are slowly losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("You are rapidly losing blood."))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :description(ccb.content.text("Blood is gushing from you like a fountain!"))
    :immune_character_flag("BLEED_IMMUNE")
    :modifier("strength", "amount", { per_intensity = -0.1 })
    :modifier("perception", "amount", { per_intensity = -0.1 }))

-- 撤销 PR #86067 — 删除 revived_marker 效果（复活怪物标记）
content.add(content.EffectType {
    id = "slimed",
    name = ccb.content.text("Slimed"),
    description = ccb.content.text("You're covered in thick goo!"),
    apply_message = ccb.content.text("You're covered in thick goo!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -25 })
    :modifier("vomiting", "chance_numerator", { base = 2100 })
    :miss_message(ccb.content.text("This goo makes you slip."), 2)
    :limb_score("lift", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("breathing", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "cold",
    speed_name = ccb.content.text("Cold"),
    name = ccb.content.text("Chilly"),
    description = ccb.content.text("Your %s is exposed to the cold."),
    maximum_intensity = 3,
    part_descriptions = true,
}
    :name(ccb.content.text("Cold"))
    :name(ccb.content.text("Freezing"))
    :description(ccb.content.text("Your %s is very exposed to the cold."))
    :description(ccb.content.text("Your %s is dangerously cold!"))
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :modifier("speed", "amount", { base = -2, per_intensity = -7 })
    :modifier("intelligence", "amount", { per_intensity = -0.5 })
    :modifier("dexterity", "amount", { per_intensity = -0.5 })
    :modifier("hurt", "minimum", { per_intensity = 1 })
    :modifier("hurt", "chance_numerator", { per_intensity = 200 })
    :modifier("painkiller", "tick", { per_intensity = 60 })
    :modifier("painkiller", "minimum", { per_intensity = 1 })
    :modifier("painkiller", "maximum_value", { per_intensity = 30 })
    :modifier("stamina", "chance_numerator", { per_intensity = 2 })
    :modifier("stamina", "minimum", { per_intensity = -2 })
    :limb_score("manip", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("grip", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("move_speed", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("crawl", { multiplier = 0.9, per_intensity = -0.1 }))

content.add(content.EffectType {
    id = "wet",
    name = ccb.content.text("Damp"),
    description = ccb.content.text("Your %s is covered in moisture."),
    maximum_intensity = 3,
    part_descriptions = true,
}
    :name(ccb.content.text("Wet"))
    :name(ccb.content.text("Soaked"))
    :description(ccb.content.text("Your %s is wet."))
    :description(ccb.content.text("Your %s is soaked!")))

content.add(content.EffectType {
    id = "chafing",
    name = ccb.content.text("Uncomfortable"),
    description = ccb.content.text("Your %s is uncomfortable.  Wearing something soft under your hard armor would help."),
    maximum_intensity = 1,
    part_descriptions = true,
}
    :modifier("speed", "amount", { base = -2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = -1 }))

-- thirst is ml / 5 someone doing exercise in the sun burns between 500mL to 1000mL extra an hour as sweat so 1.5 thirst a minute split between 10 body parts
content.add(content.EffectType {
    id = "hot",
    name = ccb.content.text("Warm"),
    description = ccb.content.text("Your %s feels warm."),
    maximum_intensity = 3,
    part_descriptions = true,
}
    :name(ccb.content.text("Hot"))
    :name(ccb.content.text("Scorching"))
    :description(ccb.content.text("Your %s is hot."))
    :description(ccb.content.text("Your %s is burning up!"))
    :modifier("thirst", "minimum", { base = 1, per_intensity = 1 })
    :modifier("thirst", "tick", { base = 60 })
    :modifier("thirst", "chance_numerator", { base = 6 })
    :modifier("perspiration", "minimum", { base = 2, per_intensity = 5 })
    :modifier("perspiration", "tick", { base = 60, per_intensity = -15 })
    :modifier("perspiration", "chance_numerator", { base = 1 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = -1, per_intensity = 10 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = -300, per_intensity = 200 })
    :modifier("stamina", "chance_numerator", { base = 2 })
    :modifier("stamina", "minimum", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "hot_speed",
    speed_name = ccb.content.text("Heat slowdown"),
    name = ccb.content.text("Slowdown"),
    description = ccb.content.text("The heat slows you down."),
    maximum_intensity = 3,
    part_descriptions = true,
}
    :name(ccb.content.text("Hampered"))
    :name(ccb.content.text("Crushed"))
    :description(ccb.content.text("You struggle to move in this heat."))
    :description(ccb.content.text("The heat is crushing you."))
    :modifier("speed", "amount", { base = -2, per_intensity = -4 }))

content.add(content.EffectType {
    id = "frostbite",
    speed_name = ccb.content.text("Frostbite"),
    name = ccb.content.text("Frostnip"),
    description = ccb.content.text("Your %s is frostnipped and has gone numb."),
    part_descriptions = true,
    duration_add_percent = 0,
    maximum_intensity = 2,
}
    :name(ccb.content.text("Frostbite"))
    :description(ccb.content.text("Your %s is frostbitten!  Its tissues are frozen from the cold!"))
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :modifier("speed", "amount", { per_intensity = -5 })
    :limb_score("manip", { multiplier = 0 })
    :limb_score("grip", { multiplier = 0 })
    :limb_score("block", { multiplier = 0.5, per_intensity = -0.25 })
    :limb_score("lift", { multiplier = 0.5, per_intensity = -0.25 })
    :limb_score("move_speed", { multiplier = 0.75, per_intensity = -0.25 })
    :limb_score("crawl", { multiplier = 0.75, per_intensity = -0.25 }))

content.add(content.EffectType {
    id = "frostbite_recovery",
    name = ccb.content.text("Defrosting"),
    description = ccb.content.text("Your %s is starting to feel the damage cold has wrought."),
    part_descriptions = true,
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :modifier("pain", "maximum_value", { base = 40 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "blisters",
    name = ccb.content.text("Blisters"),
    description = ccb.content.text("Your %s is blistering from the intense heat."),
    main_parts_only = true,
    part_descriptions = true,
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("pain", "maximum_value", { base = 35 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 4 })
    :modifier("hurt", "minimum", { base = 1 })
    :miss_message(ccb.content.text("Your blisters distract you"), 1))

content.add(content.EffectType {
    id = "dermatik",
    blood_analysis_description = ccb.content.text("Insect Parasite"),
}
    :immune_character_flag("ACIDBLOOD")
    :immune_character_flag("PARAIMMUNE")
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :enchantment("INLINE_ENCH_dermatik_0")
    :modifier("hunger", "minimum", { base = 1 })
    :modifier("hunger", "tick", { base = 20 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "tick", { base = 300 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sleepiness", "tick", { base = 300 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "tick", { base = 300 })
    :modifier("healing", "amount", { base = 0.05 })
    :vitamin("dermatik_larva_size", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 60 },
    })
    :vitamin("vitC", {
        rates = { { minimum = -1, maximum = -1 } },
        tick_turns = { 300 },
    })
    :vitamin("iron", {
        rates = { { minimum = -1, maximum = -1 } },
        tick_turns = { 300 },
    })
    :vitamin("calcium", {
        rates = { { minimum = -1, maximum = -1 } },
        tick_turns = { 300 },
    })
    :vitamin("mutant_toxin", {
        rates = { { minimum = 1, maximum = 1 } },
        tick_turns = { 300 },
    }))

content.add(content.EffectType {
    id = "dermatik_visible",
    name = ccb.content.text("Wriggling Skin"),
    description = ccb.content.text("Maggots the size of eggs roil beneath your skin."),
    rating = "bad",
    maximum_intensity = 3,
    show_in_info = true,
}
    :name(ccb.content.text("Fed Upon"))
    :name(ccb.content.text("Faint"))
    :description(ccb.content.text("Rippling bulges traverse your stomach.  If you strain your ears, you can hear the larvae slurping at your intestines."))
    :description(ccb.content.text("Thick, black bruises run from where the dermatik stung you to the center of your chest.  You think you hear the pupae gnawing at your ribcage, and it sounds like rest.  Perhaps you should sit and listen to it for a while."))
    :modifier("vomiting", "chance_numerator", { base = 25200, per_intensity = -7200 })
    :modifier("pain", "amount", { base = 3, per_intensity = 6 }))

content.add(content.EffectType {
    id = "formication",
    name = ccb.content.text("Itchy"),
    description = ccb.content.text("You stop to scratch yourself frequently; high INT helps you resist the urge."),
    apply_message = ccb.content.text("You feel extremely itchy!"),
    rating = "bad",
    main_parts_only = true,
    show_in_info = true,
    maximum_intensity = 3,
}
    :name(ccb.content.text("Very Itchy"))
    :name(ccb.content.text("Terribly Itchy"))
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_effect("took_flumed")
    :resist_effect("took_antihistamine")
    :modifier("strength", "amount", { base = -0.34, per_intensity = -0.34 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = -1 }))

content.add(content.EffectType {
    id = "sap",
    name = ccb.content.text("Sap-coated"),
    description = ccb.content.text("You're coated in sap!"),
    apply_message = ccb.content.text("You're coated in sap!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -25 })
    :modifier("dexterity", "amount", { base = -3 })
    :miss_message(ccb.content.text("The sap's too sticky for you to fight effectively."), 3)
    :limb_score("lift", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.15 })
    :limb_score("breathing", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "common_cold_immunity",
    name = ccb.content.text("Common Cold Antibodies"),
    description = ccb.content.text("Common cold antibodies in your bloodstream prevent you from catching common cold."),
    blood_analysis_description = ccb.content.text("Common Cold Antibodies"),
    rating = "good",
    maximum_duration_turns = 14515200,
    duration_add_percent = 50,
}
    :blocks_effect("common_cold")
    :blocks_effect("pre_common_cold"))

content.add(content.EffectType {
    id = "fake_common_cold",
    show_in_info = false,
})

content.add(content.EffectType {
    id = "fake_flu",
    show_in_info = false,
})

content.add(content.EffectType {
    id = "flushot",
    name = ccb.content.text("Vaccinated"),
    description = ccb.content.text("You have been vaccinated for the flu recently."),
    blood_analysis_description = ccb.content.text("Antivirals"),
    rating = "good",
    maximum_duration_turns = 14515200,
    duration_add_percent = 50,
}
    :blocks_effect("flu")
    :blocks_effect("pre_flu"))

content.add(content.EffectType {
    id = "prophylactic_antivenom",
    name = ccb.content.text("Antivenom Resistance"),
    description = ccb.content.text("You are temporarily resistant to venoms."),
    blood_analysis_description = ccb.content.text("Prophylactic antivenom"),
    rating = "good",
})

content.add(content.EffectType {
    id = "took_antiasthmatic",
    name = ccb.content.text("Took Antiasthmatic Drugs"),
    description = ccb.content.text("You have taken an antiasthmatic drug recently."),
    blood_analysis_description = ccb.content.text("Antiasthmatics"),
    rating = "good",
    maximum_duration_turns = 86400,
})

content.add(content.EffectType {
    id = "steroid_eye",
    name = ccb.content.text("Used Steroid Eye Drops"),
    description = ccb.content.text("You have used steroid eye drops recently."),
    rating = "good",
    maximum_duration_turns = 10800,
})

content.add(content.EffectType {
    id = "cureall",
}
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("bloodworms")
    :removes_effect("paincysts")
    :removes_effect("brainworms")
    :removes_effect("tapeworm")
    :removes_effect("blind")
    :removes_effect("poison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_optional_effect("stung")
    :removes_effect("badpoison")
    :removes_effect("foodpoison")
    :removes_effect("paralyzepoison")
    :removes_effect("tetanus")
    :removes_effect("rat_bite_fever")
    :removes_effect("infected")
    :removes_effect("asthma")
    :removes_effect("common_cold")
    :removes_effect("flu")
    :removes_effect("pre_flu")
    :removes_effect("pre_common_cold")
    :modifier("painkiller", "minimum", { base = 5 }))

content.add(content.EffectType {
    id = "evil",
})

content.add(content.EffectType {
    id = "raising",
    intensity_add_value = 1,
    maximum_intensity = 100,
})

content.add(content.EffectType {
    id = "jetinjector",
    name = ccb.content.text("RX12 Healing Comedown"),
    description = ccb.content.text("You feel completely drained."),
    apply_message = ccb.content.text("You feel a rush as the chemicals flow through your body!"),
    blood_analysis_description = ccb.content.text("Healing Medication"),
    rating = "good",
    maximum_intensity = 2,
    intensity_duration_turns = 50,
}
    :name(ccb.content.text("RX12 Healing Rush"))
    :description(ccb.content.text("You feel the rush of stimulants in your body!"))
    :decay_message(ccb.content.text("The jet injector's chemicals wear off.  You feel AWFUL!"), "bad")
    :removes_effect("infected")
    :removes_effect("bite")
    :removes_effect("bleed")
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("poison")
    :removes_effect("badpoison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_effect("winded")
    :removes_effect("winded_leg")
    :removes_effect("winded_arm")
    :modifier("strength", "amount", { base = -1, per_intensity = 2 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = 3 })
    :modifier("perception", "amount", { base = -2, per_intensity = 3 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = 1 }))

content.add(content.EffectType {
    id = "stimpack",
    name = ccb.content.text("RX11 Stimulant Comedown"),
    description = ccb.content.text("You feel sluggish and slow."),
    apply_message = ccb.content.text("You feel an intense surge of stimulants pulse through your body!"),
    blood_analysis_description = ccb.content.text("Stimulants"),
    rating = "good",
    maximum_intensity = 2,
    intensity_duration_turns = 50,
}
    :name(ccb.content.text("RX11 Stimulant Rush"))
    :description(ccb.content.text("An intense surge of stimulants pulses through your body."))
    :decay_message(ccb.content.text("The stimulant combo is wearing off.  You feel sluggish."), "bad")
    :removes_effect("winded")
    :removes_effect("winded_leg")
    :removes_effect("winded_arm")
    :modifier("speed", "amount", { base = -5, per_intensity = 15 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = 4 })
    :modifier("perception", "amount", { base = -1, per_intensity = 4 })
    :modifier("intelligence", "amount", { base = -2, per_intensity = -1 })
    :modifier("strength", "amount", { per_intensity = 1 })
    :modifier("stamina", "minimum", { per_intensity = 4 })
    :modifier("stamina", "maximum", { per_intensity = 8 }))

content.add(content.EffectType {
    id = "adrenaline",
    name = ccb.content.text("Adrenaline Comedown"),
    description = ccb.content.text("You feel completely drained."),
    apply_message = ccb.content.text("You feel a surge of adrenaline!"),
    blood_analysis_description = ccb.content.text("Adrenaline Spike"),
    rating = "good",
    maximum_intensity = 2,
    intensity_duration_turns = 150,
}
    :name(ccb.content.text("Adrenaline Rush"))
    :description(ccb.content.text("You feel the rush of adrenaline in your body!"))
    :decay_message(ccb.content.text("Your adrenaline rush wears off.  You feel AWFUL!"), "bad")
    :removes_effect("winded")
    :removes_effect("winded_leg")
    :removes_effect("winded_arm")
    :modifier("speed", "amount", { base = -10, per_intensity = 20 })
    :modifier("strength", "amount", { base = -2, per_intensity = 1.5 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = 1.5 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = -2 })
    :modifier("perception", "amount", { base = -1, per_intensity = 0.5 })
    :modifier("stamina", "minimum", { base = -2, per_intensity = 4 })
    :miss_message(ccb.content.text("Your comedown throws you off."), 1))

content.add(content.EffectType {
    id = "adrenaline_mycus",
    name = ccb.content.text("Mycus Respite"),
    description = ccb.content.text("Our fibers are stretched near breaking.  Local power diverted to regenerate."),
    apply_message = ccb.content.text("Mycal wrath fills our fibers, and we grow turgid."),
    blood_analysis_description = ccb.content.text("Unknown Fungal Stimulants"),
    rating = "good",
    maximum_intensity = 2,
    intensity_duration_turns = 150,
}
    :name(ccb.content.text("Mycus Wrath"))
    :description(ccb.content.text("Our enemies are near, and violent action is imminent.  We are turgid."))
    :decay_message(ccb.content.text("We require repose; our fibers are nearly spent…"), "bad")
    :modifier("speed", "amount", { base = -10, per_intensity = 30 })
    :modifier("strength", "amount", { base = -2, per_intensity = 5 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = 4 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = -7 })
    :modifier("perception", "amount", { base = -1, per_intensity = 2 })
    :modifier("stamina", "minimum", { base = -2, per_intensity = 4 }))

content.add(content.EffectType {
    id = "meth",
    name = ccb.content.text("Meth comedown"),
    blood_analysis_description = ccb.content.text("Methamphetamines"),
    maximum_intensity = 2,
    intensity_duration_turns = 200,
}
    :name(ccb.content.text("High on Meth"))
    :flag("CANNOT_SLEEP")
    :modifier("speed", "amount", { base = -20, per_intensity = 15 })
    :modifier("strength", "amount", { base = -3, per_intensity = 1.5 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = 1 })
    :modifier("intelligence", "amount", { base = -1, per_intensity = 0.5 })
    :modifier("perception", "amount", { base = -2, per_intensity = 1 })
    :modifier("vomiting", "chance_numerator", { base = 2000 })
    :modifier("stamina", "minimum", { base = -4, per_intensity = 8 })
    :modifier("sleepiness", "minimum", { per_intensity = 1 })
    :modifier("sleepiness", "tick", { per_intensity = 9 }))

-- DEX/INT/PER/SPEED scaling of -0.7 is deliberate: stat mods truncate toward zero, giving 0 at intensity 2 (the <=400 mg/day band stays penalty-free), -1 at intensity 3 and -2 at intensity 4.
content.add(content.EffectType {
    id = "caffeine_eff",
    name = ccb.content.text("Caffeinated"),
    description = ccb.content.text("Just a little pick-me-up."),
    blood_analysis_description = ccb.content.text("Caffeine"),
    maximum_intensity = 4,
}
    :name(ccb.content.text("Caffeine Energized"))
    :name(ccb.content.text("Caffeine Overdose"))
    :name(ccb.content.text("Caffeine Toxicity"))
    :description(ccb.content.text("A strong wave of alertness; the buzz is starting to lose its edge."))
    :description(ccb.content.text("You've had far too much caffeine.  You feel shaky and irritable."))
    :description(ccb.content.text("Your heart pounds and skips, your hands tremble, and you feel horribly sick.  This is caffeine poisoning."))
    :modifier("vomiting", "chance_numerator", { base = -20, per_intensity = 15 })
    :modifier("vomiting", "chance_denominator", { base = 1000 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("focus", "minimum", { base = 1, per_intensity = -1 })
    :modifier("focus", "maximum", { base = 1 })
    :modifier("focus", "chance_numerator", { base = 1200 })
    :modifier("focus", "maximum_value", { base = 105, per_intensity = -3 })
    :modifier("sleepiness", "minimum", { base = -1 })
    :modifier("sleepiness", "maximum", { base = -1 })
    :modifier("sleepiness", "chance_numerator", { base = 200 })
    :modifier("sleepiness", "minimum_value", { base = -30, per_intensity = -30 })
    :modifier("sensitivity", "amount", { base = 1 })
    :modifier("sensitivity", "chance_numerator", { base = 300 })
    :modifier("sensitivity", "maximum_value", { base = 200 })
    :modifier("focus", "minimum_value", { per_intensity = -2 })
    :modifier("dexterity", "amount", { per_intensity = -0.7 })
    :modifier("intelligence", "amount", { per_intensity = -0.7 })
    :modifier("perception", "amount", { per_intensity = -0.7 })
    :modifier("speed", "amount", { per_intensity = -0.7 }))

content.add(content.EffectType {
    id = "cig",
    name = ccb.content.text("Nicotine Buzz"),
    description = ccb.content.text("You feel a slight buzz from the tobacco."),
    blood_analysis_description = ccb.content.text("Nicotine"),
    maximum_intensity = 2,
}
    :name(ccb.content.text("Nicotine Overdose"))
    :description(ccb.content.text("You feel awful, you've had far too much."))
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("vomiting", "chance_numerator", { base = -20, per_intensity = 21 })
    :modifier("vomiting", "chance_denominator", { base = 1000 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("focus", "minimum", { base = 1, per_intensity = -8 })
    :modifier("focus", "maximum", { base = 2, per_intensity = -4 })
    :modifier("focus", "chance_numerator", { base = 200 })
    :modifier("focus", "maximum_value", { base = 104 })
    :modifier("focus", "minimum_value", { base = 50, per_intensity = -20 })
    :modifier("sleepiness", "minimum", { base = -1 })
    :modifier("sleepiness", "maximum", { base = -3 })
    :modifier("sleepiness", "chance_numerator", { base = 200 })
    :modifier("sleepiness", "minimum_value", { base = 100 })
    :modifier("sensitivity", "amount", { base = 1 })
    :modifier("sensitivity", "chance_numerator", { base = 600 })
    :modifier("sensitivity", "maximum_value", { base = 200 })
    :modifier("intelligence", "amount", { per_intensity = -1 })
    :modifier("perception", "amount", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "high",
    name = ccb.content.text("High"),
    description = ccb.content.text("You are high as a kite."),
    apply_message = ccb.content.text("You feel lightheaded."),
    blood_analysis_description = ccb.content.text("Intoxicant: Other"),
}
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("vomiting", "tick", { base = 60 }))

content.add(content.EffectType {
    id = "weed_high",
    name = ccb.content.text("Stoned"),
    description = ccb.content.text("You are under the effects of cannabis."),
    apply_message = ccb.content.text("You feel lightheaded."),
    blood_analysis_description = ccb.content.text("Tetrahydrocannabinol"),
    maximum_intensity = 4,
    maximum_duration_turns = 36000,
}
    :name(ccb.content.text("Baked"))
    :name(ccb.content.text("Blazed"))
    :name(ccb.content.text("Zooted"))
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :enchantment("INLINE_ENCH_weed_high_0")
    :modifier("perception", "amount", { base = -1, per_intensity = -0.67 })
    :modifier("painkiller", "maximum_value", { base = 7, per_intensity = 7 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "tick", { base = 45 })
    :modifier("sleepiness", "maximum_value", { base = 90, per_intensity = 40 })
    :modifier("sleepiness", "chance_numerator", { base = 1000, per_intensity = -250 })
    :modifier("sleepiness", "minimum", { base = 1 })
    :modifier("sensitivity", "amount", { base = -1, per_intensity = -1 })
    :modifier("sensitivity", "chance_numerator", { base = 300 })
    :modifier("sensitivity", "minimum_value", { base = 75, per_intensity = -10 })
    :modifier("dexterity", "amount", { per_intensity = -0.67 })
    :modifier("intelligence", "amount", { per_intensity = -1.67 })
    :modifier("speed", "amount", { per_intensity = -5 })
    :miss_message(ccb.content.text("You're too stoned to keep up."), 1))

content.add(content.EffectType {
    id = "contacts",
    name = ccb.content.text("Contact Lenses"),
    description = ccb.content.text("You are wearing contact lenses."),
    apply_message = ccb.content.text("You can see more clearly."),
    remove_message = ccb.content.text("Your vision starts to blur."),
    rating = "good",
})

content.add(content.EffectType {
    id = "transition_contacts",
    name = ccb.content.text("Transition Contact Lenses"),
    description = ccb.content.text("You are wearing photochromic contact lenses that additionally protect you from the sunlight."),
    apply_message = ccb.content.text("You can see more clearly."),
    remove_message = ccb.content.text("Your vision starts to blur."),
    rating = "good",
}
    :blocks_effect("glare"))

content.add(content.EffectType {
    id = "transition_contacts_plano",
    name = ccb.content.text("Transition Contact Lenses (Plano)"),
    description = ccb.content.text("You are wearing non-prescription photochromic contact lenses that protect you from the sunlight, but don't help with any sight issues."),
    apply_message = ccb.content.text("You apply photochromic contact lenses."),
    remove_message = ccb.content.text("you pull off your photochromic contact lenses."),
    rating = "good",
}
    :blocks_effect("glare"))

content.add(content.EffectType {
    id = "amigara",
    apply_message = ccb.content.text("You can't look away from the faultline…"),
    rating = "bad",
})

content.add(content.EffectType {
    id = "fearparalyze",
    name = ccb.content.text("Feared"),
    description = ccb.content.text("You have been paralyzed by the fear."),
    rating = "bad",
    show_in_info = true,
})

content.add(content.EffectType {
    id = "asthma",
    name = ccb.content.text("Asthma"),
    description = ccb.content.text("You suffer from a respiratory disorder that makes breathing difficult.\nAn asthma attack can occur from time to time, so have your inhaler nearby."),
    apply_message = ccb.content.text("You can't breathe… asthma attack!"),
    rating = "bad",
    maximum_intensity = 6,
    intensity_duration_turns = 200,
}
    :name(ccb.content.text("Asthma"))
    :name(ccb.content.text("Asthma"))
    :name(ccb.content.text("Asthma"))
    :name(ccb.content.text("Heavy Asthma"))
    :name(ccb.content.text("Heavy Asthma"))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("strength", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("speed", "amount", { base = -20, per_intensity = -40 })
    :miss_message(ccb.content.text("You're winded."), 3)
    :limb_score("manip", { multiplier = 0.9, per_intensity = -0.25 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.2 })
    :limb_score("grip", { multiplier = 1.0, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.2 })
    :limb_score("breathing", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("reaction", { multiplier = 1.0, per_intensity = -0.2 })
    :limb_score("move_speed", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 1.0, per_intensity = -0.1 })
    :limb_score("swim", { multiplier = 0.75, per_intensity = -0.25 })
    :limb_score("crawl", { multiplier = 0.9, per_intensity = -0.1 }))

-- used so bio_hydraulics could detect bionic is going off. remove if enchantments could produce sound each second or eoc could check you have active bionic
content.add(content.EffectType {
    id = "bio_hydraulics_eff",
})

content.add(content.EffectType {
    id = "effect_bio_hydraulics_active",
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_bio_hydraulics_active_0"))

-- cooldown mark of bio_noise_quiet_burn eoc
content.add(content.EffectType {
    id = "effect_bio_noise_quiet_burn_cooldown",
    name = "",
    description = "",
})

-- cooldown mark of bio_noise_digestive eoc
content.add(content.EffectType {
    id = "effect_bio_noise_digestive_cooldown",
    name = "",
    description = "",
})

-- cooldown mark of bio_noise_gasoline eoc
content.add(content.EffectType {
    id = "effect_bio_noise_gasoline_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "crushed",
    apply_message = ccb.content.text("The ceiling collapses on you!"),
    rating = "bad",
})

content.add(content.EffectType {
    id = "valium",
    blood_analysis_description = ccb.content.text("Benzodiazepines"),
    rating = "good",
    maximum_duration_turns = 64800,
    duration_add_percent = 45,
}
    :removes_effect("shakes")
    :modifier("stimulant", "tick", { base = 150 })
    :modifier("stimulant", "chance_numerator", { base = 2 })
    :modifier("stimulant", "minimum", { base = 1 })
    :modifier("stimulant", "minimum_value", { base = -1 }))

content.add(content.EffectType {
    id = "took_anticonvulsant_visible",
    name = ccb.content.text("Took Anticonvulsant Drugs"),
    description = ccb.content.text("You took anticonvulsant drugs some time ago and you might still be under its influence.\nPrescription note says its effect duration may vary, so your estimate may be inaccurate."),
    blood_analysis_description = ccb.content.text("Anticonvulsants"),
    rating = "good",
    maximum_duration_turns = 64800,
    duration_add_percent = 40,
})

content.add(content.EffectType {
    id = "music",
})

content.add(content.EffectType {
    id = "relax_gas",
    name = ccb.content.text("Relaxation Gas"),
    description = ccb.content.text("You are thoroughly relaxed and don't feel like moving.  Fighting?  Too much effort."),
    apply_message = ccb.content.text("You inhale sweetish gas."),
    remove_message = ccb.content.text("The slackness leaves your muscles."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("strength", "amount", { base = -3 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -4 })
    :limb_score("reaction", { multiplier = 0.5 })
    :limb_score("move_speed", { multiplier = 0.75 })
    :limb_score("balance", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "tapeworm",
    name = ccb.content.text("Unidentified Illness"),
    description = ccb.content.text("You aren't sure what's wrong with you but you don't feel well."),
    blood_analysis_description = ccb.content.text("Intestinal Parasite"),
    rating = "bad",
}
    :resist_trait("VOMITSTOMACH")
    :modifier("hunger", "chance_numerator", { base = 50 })
    :modifier("hunger", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "bloodworms",
    name = ccb.content.text("Unidentified Illness"),
    description = ccb.content.text("You aren't sure what's wrong with you but you don't feel well."),
    blood_analysis_description = ccb.content.text("Hemolytic Parasites"),
    rating = "bad",
}
    :modifier("thirst", "tick", { base = 600 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 512 })
    :modifier("health_modifier", "minimum", { base = -10 })
    :modifier("cough", "chance_numerator", { base = 300 }))

content.add(content.EffectType {
    id = "brainworms",
    name = ccb.content.text("Unidentified Illness"),
    description = ccb.content.text("You aren't sure what's wrong with you but you don't feel well."),
    blood_analysis_description = ccb.content.text("Intracranial Parasites"),
    rating = "bad",
}
    :flag("NO_PSIONICS")
    :modifier("pain", "chance_numerator", { base = 512 })
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "maximum", { base = 8 })
    :modifier("health_modifier", "chance_numerator", { base = 512 })
    :modifier("health_modifier", "minimum", { base = -10 }))

content.add(content.EffectType {
    id = "paincysts",
    name = ccb.content.text("Unidentified Illness"),
    description = ccb.content.text("You aren't sure what's wrong with you but you don't feel well."),
    blood_analysis_description = ccb.content.text("Intramuscular Parasites"),
    rating = "bad",
}
    :modifier("pain", "chance_numerator", { base = 256 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 4 })
    :modifier("sleepiness", "chance_numerator", { base = 256 })
    :modifier("sleepiness", "minimum", { base = 1 }))

content.add(content.EffectType {
    id = "tetanus",
    name = ccb.content.text("Muscle Cramps"),
    description = ccb.content.text("Your muscles are binding up, you should probably find a sedative."),
    apply_message = ccb.content.text("Your muscles start convulsing!"),
    blood_analysis_description = ccb.content.text("Clostridium tetani Infection"),
    rating = "bad",
}
    :resist_effect("valium")
    :modifier("dexterity", "amount", { base = -4 }))

content.add(content.EffectType {
    id = "datura",
    name = ccb.content.text("Experiencing Datura"),
    description = ccb.content.text("Buy the ticket, take the ride.  The datura has you now."),
    blood_analysis_description = ccb.content.text("Anticholinergic Tropane Alkaloids"),
    rating = "bad",
}
    :modifier("perception", "amount", { base = -6 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("thirst", "chance_numerator", { base = 8 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum_value", { base = 20 }))

-- Removal handled in code, so no max duration needed, intensity set by the grab_strength, all effects are local-only
-- No swimmin' or manipulatin' with a held limb, other scores start severly debilitated and reach useless at about 50 grab strength
content.add(content.EffectType {
    id = "grabbed",
    name = ccb.content.text("Grabbed"),
    description = ccb.content.text("You have been grabbed and held in place by an attack.  You're not able to move until breaking the grab, and depending on the strength of your opponent using this limb is difficult to impossible.\nWait in place or attempt to move without attacking to try and remove this effect."),
    rating = "bad",
    maximum_intensity = 100,
    show_in_info = true,
    show_intensity = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD_LOCAL")
    :flag("GRAB")
    :modifier("dodge", "amount", { base = -10 })
    :limb_score("manip", { multiplier = 0.0 })
    :limb_score("grip", { multiplier = 0.0 })
    :limb_score("lift", { multiplier = 0.6, per_intensity = -0.015 })
    :limb_score("block", { multiplier = 0.25, per_intensity = -0.01 })
    :limb_score("breathing", { multiplier = 0.75, per_intensity = -0.005 })
    :limb_score("balance", { multiplier = 0.6, per_intensity = -0.016 })
    :limb_score("move_speed", { multiplier = 0.6, per_intensity = -0.01 })
    :limb_score("footing", { multiplier = 0.6, per_intensity = -0.01 })
    :limb_score("swim", { multiplier = 0.0 }))

content.add(content.EffectType {
    id = "crowd_crushed",
    name = ccb.content.text("Crowd crushed"),
    description = ccb.content.text("You are being crushed by a crowd."),
    maximum_duration_turns = 2,
})

-- -dodge (can't really miss something holding you)
content.add(content.EffectType {
    id = "grabbing",
    name = ccb.content.text("Grabbing"),
    description = ccb.content.text("Grabbing another creature and holding them in place."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("GRAB_FILTER")
    :modifier("dodge", "amount", { base = -8 }))

-- -dodge (can't really miss something holding you)
content.add(content.EffectType {
    id = "grabbing_2",
    name = ccb.content.text("Grabbing"),
    description = ccb.content.text("Grabbing another creature and holding them in place with a second appendage."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("GRAB_FILTER")
    :modifier("dodge", "amount", { base = -8 }))

-- -dodge (can't really miss something holding you)
content.add(content.EffectType {
    id = "grabbing_3",
    name = ccb.content.text("Grabbing"),
    description = ccb.content.text("Grabbing another creature and holding them in place with a third appendage."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("GRAB_FILTER")
    :modifier("dodge", "amount", { base = -8 }))

-- -dodge (can't really miss something holding you)
content.add(content.EffectType {
    id = "grabbing_4",
    name = ccb.content.text("Grabbing"),
    description = ccb.content.text("Grabbing another creature and holding them in place with a fourth appendage."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("GRAB_FILTER")
    :modifier("dodge", "amount", { base = -8 }))

-- -dodge (can't really miss something holding you)
content.add(content.EffectType {
    id = "grabbing_5",
    name = ccb.content.text("Grabbing"),
    description = ccb.content.text("Grabbing another creature and holding them in place with a fifth appendage."),
    maximum_intensity = 1,
    show_in_info = true,
}
    :flag("GRAB_FILTER")
    :modifier("dodge", "amount", { base = -8 }))

content.add(content.EffectType {
    id = "lack_sleep",
    name = ccb.content.text("Lacking Sleep"),
    description = ccb.content.text("You haven't slept in a while, and it shows."),
    apply_message = ccb.content.text("You are too physically tired to function well."),
    rating = "bad",
}
    :modifier("speed", "amount", { base = -5 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -2 })
    :miss_message(ccb.content.text("You don't have energy to fight."), 1))

content.add(content.EffectType {
    id = "lying_down",
    apply_message = ccb.content.text("You lie down to go to sleep…"),
    rating = "neutral",
    maximum_duration_turns = 3000,
})

content.add(content.EffectType {
    id = "sleep",
    apply_message = ccb.content.text("You fall asleep."),
    remove_message = ccb.content.text("You wake up."),
    rating = "neutral",
    maximum_intensity = 24,
})

content.add(content.EffectType {
    id = "narcosis",
    blood_analysis_description = ccb.content.text("Narcosis"),
})

content.add(content.EffectType {
    id = "under_operation",
    name = ccb.content.text("Under Operation"),
    description = ccb.content.text("You are being operated on.  Try to stay still."),
})

content.add(content.EffectType {
    id = "alarm_clock",
})

content.add(content.EffectType {
    id = "slept_through_alarm",
})

content.add(content.EffectType {
    id = "robofac_surveillance",
    maximum_duration_turns = 1209600,
})

content.add(content.EffectType {
    id = "playing_instrument",
    name = ccb.content.text("Playing an Instrument"),
    description = ccb.content.text("You're playing an instrument.\nFocusing on playing music distracts you, slowing you down."),
    rating = "neutral",
    maximum_duration_turns = 2,
    maximum_intensity = 100,
}
    :modifier("speed", "amount", { base = -1, per_intensity = -1 }))

-- On roof of a vehicle, aiming a turret
content.add(content.EffectType {
    id = "on_roof",
})

content.add(content.EffectType {
    id = "corroding",
    name = ccb.content.text("Corroding"),
    description = ccb.content.text("You're covered in acid!"),
    apply_message = ccb.content.text("You're covered in acid!"),
    rating = "bad",
    maximum_duration_turns = 30,
    maximum_intensity = 5,
    intensity_duration_turns = 5,
    show_in_info = true,
}
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 1, per_intensity = 1 })
    :modifier("hurt", "chance_denominator", { base = 10 }))

content.add(content.EffectType {
    id = "zapped",
    name = ccb.content.text("Zapped"),
    description = ccb.content.text("You've been zapped with electricity and are barely able to move!"),
    apply_message = ccb.content.text("You're zapped!"),
    rating = "bad",
    maximum_duration_turns = 2,
    duration_add_percent = 20,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -1000 })
    :modifier("dexterity", "amount", { base = -100 })
    :limb_score("manip", { multiplier = 0.8, per_intensity = -0.05 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("block", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("breathing", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.75, per_intensity = -0.05 })
    :limb_score("swim", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "electrocuted",
    name = ccb.content.text("Electrocuted"),
    description = ccb.content.text("You're being shocked with electricity to the point of serious harm!"),
    apply_message = ccb.content.text("You're being electrocuted!"),
    rating = "bad",
    duration_add_percent = 20,
    pain_sizing = true,
    hurt_sizing = true,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_PSIONICS")
    :modifier("speed", "amount", { base = -1000 })
    :modifier("dexterity", "amount", { base = -100 })
    :modifier("hurt", "amount", { base = 15 })
    :modifier("hurt", "minimum", { base = 2, resisted_base = 1 })
    :limb_score("manip", { multiplier = 0.8, per_intensity = -0.05 })
    :limb_score("lift", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("block", { multiplier = 0.7, per_intensity = -0.1 })
    :limb_score("breathing", { multiplier = 0.8, per_intensity = -0.1 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("balance", { multiplier = 0.75, per_intensity = -0.05 })
    :limb_score("swim", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "hypocalcemia",
    name = ccb.content.text("Hypocalcemia"),
    description = ccb.content.text("A lack of calcium in your diet will make your bones progressively weaker."),
    apply_message = ccb.content.text("Your bones are becoming more brittle."),
    remove_message = ccb.content.text("Your bones regain their usual strength."),
    blood_analysis_description = ccb.content.text("Hypocalcemia"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Weak bones"))
    :name(ccb.content.text("Brittle bones"))
    :decay_message(ccb.content.text("Your calcium deficiency is nearly resolved."), "good")
    :decay_message(ccb.content.text("Your bones become stronger as your calcium deficiency improves."), "good")
    :enchantment("INLINE_ENCH_hypocalcemia_0")
    :modifier("strength", "amount", { base = -1, per_intensity = -1 })
    :modifier("speed", "amount", { base = -5, per_intensity = -10 })
    :modifier("health_modifier", "minimum", { base = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -50 })
    :modifier("health_modifier", "chance_numerator", { base = 900, per_intensity = -200 })
    :modifier("dexterity", "amount", { per_intensity = -0.5 }))

content.add(content.EffectType {
    id = "anemia",
    name = ccb.content.text("Early Iron Deficiency"),
    description = ccb.content.text("A lack of iron in your diet has hampered the efficiency and regeneration of your red blood cells."),
    apply_message = ccb.content.text("You begin feeling increasingly tired and listless."),
    remove_message = ccb.content.text("You are no longer in risk of becoming anemic."),
    blood_analysis_description = ccb.content.text("Anemia"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Iron Deficiency"))
    :name(ccb.content.text("Acute Iron Deficiency"))
    :description(ccb.content.text("Prolonged lack of iron in your diet has compromised the efficiency and regeneration of your red blood cells."))
    :description(ccb.content.text("Severe lack of iron in your diet results in your red blood cells dying faster then they are regenerating."))
    :decay_message(ccb.content.text("Your iron deficiency is nearly resolved."), "good")
    :decay_message(ccb.content.text("Your feel stronger as your iron deficiency starts to improve."), "good")
    :modifier("strength", "amount", { base = -1, per_intensity = -2 })
    :modifier("stamina", "minimum", { base = -100 })
    :modifier("stamina", "maximum", { base = -200, per_intensity = -500 })
    :modifier("stamina", "chance_numerator", { base = 900, per_intensity = -300 })
    :modifier("sleepiness", "minimum", { base = 10 })
    :modifier("sleepiness", "maximum", { base = 20, per_intensity = 20 })
    :modifier("sleepiness", "chance_numerator", { base = 900, per_intensity = -300 })
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -50 })
    :modifier("health_modifier", "chance_numerator", { base = 900, per_intensity = -200 }))

content.add(content.EffectType {
    id = "redcells_anemia",
    name = ccb.content.text("Early Anemia"),
    description = ccb.content.text("Loss of red blood cells results in progressively worsening anemia."),
    apply_message = ccb.content.text("You begin feeling increasingly tired and listless."),
    remove_message = ccb.content.text("You no longer feel anemic."),
    blood_analysis_description = ccb.content.text("Anemia"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Anemia"))
    :name(ccb.content.text("Acute Anemia"))
    :decay_message(ccb.content.text("Your anemia is nearly resolved."), "good")
    :decay_message(ccb.content.text("Your feel stronger as your anemia starts to improve."), "good")
    :modifier("strength", "amount", { base = -1, per_intensity = -2 })
    :modifier("stamina", "minimum", { base = -100 })
    :modifier("stamina", "maximum", { base = -200, per_intensity = -500 })
    :modifier("stamina", "chance_numerator", { base = 900, per_intensity = -300 })
    :modifier("sleepiness", "minimum", { base = 10 })
    :modifier("sleepiness", "maximum", { base = 20, per_intensity = 20 })
    :modifier("sleepiness", "chance_numerator", { base = 900, per_intensity = -300 })
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -50 })
    :modifier("health_modifier", "chance_numerator", { base = 900, per_intensity = -200 }))

content.add(content.EffectType {
    id = "scurvy",
    name = ccb.content.text("Early Scurvy"),
    description = ccb.content.text("A lack of vitamin C in your diet will result in progressively worse symptoms of scurvy."),
    apply_message = ccb.content.text("You start to develop symptoms of scurvy."),
    remove_message = ccb.content.text("Your scurvy has resolved."),
    blood_analysis_description = ccb.content.text("Scurvy"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Scurvy"))
    :name(ccb.content.text("Bad Scurvy"))
    :decay_message(ccb.content.text("Your vitamin C deficiency is starting to resolve."), "good")
    :decay_message(ccb.content.text("Your scurvy lessens as your Vitamin C deficiency improves."), "good")
    :modifier("pain", "maximum_value", { base = 35 })
    :modifier("pain", "chance_numerator", { base = 9000, per_intensity = -150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 5 })
    :modifier("sleepiness", "chance_numerator", { base = 900, per_intensity = -200 })
    :modifier("sleepiness", "maximum_value", { base = 500, resisted_base = 200 })
    :modifier("sleepiness", "minimum", { base = 10 })
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health_modifier", "minimum_value", { per_intensity = -100 })
    :modifier("health_modifier", "chance_numerator", { base = 900, per_intensity = -300 })
    :modifier("strength", "amount", { per_intensity = -0.5 })
    :modifier("speed", "amount", { per_intensity = -2 }))

content.add(content.EffectType {
    id = "betablock",
    name = ccb.content.text("Beta blocker"),
    description = ccb.content.text("You are under the influence of a beta blocker.  This controls your heart rate, decreasing the influence of stressful events such as pain on it.  However, it also lowers blood pressure and induces sleepiness."),
    blood_analysis_description = ccb.content.text("Beta Blocker"),
    maximum_intensity = 3,
    rating = "neutral",
}
    :modifier("blood_pressure", "tick", { base = 250 })
    :modifier("blood_pressure", "minimum", { base = -2, per_intensity = -1 })
    :modifier("blood_pressure", "minimum_value", { base = -200, per_intensity = -100 })
    :modifier("sleepiness", "minimum", { base = 4, per_intensity = 2 })
    :modifier("sleepiness", "chance_numerator", { base = 500 })
    :modifier("sleepiness", "maximum_value", { base = 200, per_intensity = 50 }))

content.add(content.EffectType {
    id = "hypervitaminosis",
    name = ccb.content.text("Hypervitaminosis"),
    description = ccb.content.text("An excess of vitamins has badly affected your metabolism."),
    apply_message = ccb.content.text("Your metabolism becomes unstable."),
    remove_message = ccb.content.text("Your metabolism becomes more stable."),
    blood_analysis_description = ccb.content.text("Hypervitaminosis"),
    rating = "bad",
})

content.add(content.EffectType {
    id = "toxin_buildup",
    name = "",
    description = "",
    maximum_intensity = 3,
}
    :name(ccb.content.text("Concerning symptoms"))
    :name(ccb.content.text("Unnerving symptoms"))
    :description(ccb.content.text("Your muscles keep twitching strangely."))
    :description(ccb.content.text("Your nervous system is malfunctioning, almost like it's being torn apart from the inside."))
    :modifier("health_modifier", "minimum", { base = -1, per_intensity = -5 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 5 })
    :modifier("health_modifier", "tick", { base = 1800 }))

-- Gives Status warnings of danger levels only.  Significant chance that death occurs well before or after this scale suggests.  As Pkill is vitaminized move opiates to this scale for effects.
content.add(content.EffectType {
    id = "opiate_eff",
    name = ccb.content.text("Mild Opiate Euphoria"),
    description = ccb.content.text("Mild euphoric feelings from the Opiates you've taken."),
    blood_analysis_description = ccb.content.text("Sample contains opiate based painkillers."),
    maximum_intensity = 6,
}
    :name(ccb.content.text("Moderate Opiate Euphoria"))
    :name(ccb.content.text("Significant Opiate Euphoria"))
    :name(ccb.content.text("Opiate Intoxication"))
    :name(ccb.content.text("Opiate Debilitation"))
    :name(ccb.content.text("Death"))
    :description(ccb.content.text("Moderate euphoria, likely sedative effects."))
    :description(ccb.content.text("Significant euphoria, heavy sedative effects."))
    :description(ccb.content.text("Some incapacitation, sedation, nausea, numbness."))
    :description(ccb.content.text("Significant chance of death, incapable of many tasks, narcolepsy."))
    :description(ccb.content.text("Terminal Dosage achieved.")))

-- Mood debuff is handled separately by bad_food_mood_debuff EoC.
content.add(content.EffectType {
    id = "bad_food_ennui",
    name = ccb.content.text("Gross Food"),
    description = ccb.content.text("The food you eat is disgusting."),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Demoralizing Food"))
    :name(ccb.content.text("Depressing Food"))
    :description(ccb.content.text("Eating nothing but disgusting rations is starting to get you down."))
    :description(ccb.content.text("Sure, you survived, but what kind of survival is this, eating these disgusting rations day in and day out?")))

content.add(content.EffectType {
    id = "hypovolemia",
    name = ccb.content.text("Mild Hypovolemic Shock"),
    description = ccb.content.text("You've lost some blood and look somewhat pale."),
    apply_message = ccb.content.text("You have lost a lot of blood, and your condition worsens."),
    remove_message = ccb.content.text("You are no longer in shock."),
    maximum_intensity = 4,
    rating = "bad",
}
    :name(ccb.content.text("Moderate Hypovolemic Shock"))
    :name(ccb.content.text("Advanced Hypovolemic Shock"))
    :name(ccb.content.text("Severe Hypovolemic Shock"))
    :description(ccb.content.text("You've lost a large amount of blood, and you're not feeling well."))
    :description(ccb.content.text("You've lost an awful lot of blood, and your condition is severe.  Seek medical attention."))
    :description(ccb.content.text("You've lost tremendous amount of blood, and you're standing on death's door.  Saline infusion might save you."))
    :decay_message(ccb.content.text("Your blood volume increases, and you feel better; but still, you look pale."), "good")
    :decay_message(ccb.content.text("You feel stronger as your blood volume starts to improve."), "good")
    :decay_message(ccb.content.text("You're not dying from lack of blood, but you're not out of the woods yet."), "good")
    :modifier("strength", "amount", { per_intensity = -1 })
    :modifier("perception", "amount", { per_intensity = -1 })
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :modifier("intelligence", "amount", { per_intensity = -1 })
    :modifier("speed", "amount", { per_intensity = -10 }))

content.add(content.EffectType {
    id = "cough_suppress",
})

content.add(content.EffectType {
    id = "haslight",
    name = ccb.content.text("Lit Up"),
    description = ccb.content.text("You are carrying a light and can't hide well."),
    maximum_duration_turns = 1,
    rating = "bad",
})

-- Duration is 10 days, but the actual time taken is probabilistic.
content.add(content.EffectType {
    id = "mending",
    name = ccb.content.text("Started Recovery"),
    description = ccb.content.text("This damaged limb is slowly regaining its functions."),
    maximum_duration_turns = 864000,
    intensity_duration_turns = 216000,
    maximum_intensity = 3,
    rating = "good",
}
    :name(ccb.content.text("Recovering"))
    :name(ccb.content.text("Mostly Recovered"))
    :immune_bodypart_flag("BIONIC_LIMB"))

-- This sounds weird. We need <bp_affected> tag or something
content.add(content.EffectType {
    id = "disabled",
    name = ccb.content.text("Disabled", "physically"),
    description = ccb.content.text("This limb is damaged beyond use and may require a splint or some other intervention to recover."),
    apply_message = ccb.content.text("Your limb breaks!"),
    remove_message = ccb.content.text("The broken limb has mended."),
    maximum_duration_turns = 2,
    rating = "bad",
})

content.add(content.EffectType {
    id = "pkill",
    name = ccb.content.text("Painkillers"),
    description = ccb.content.text("You are under the influence of analgesic substances to relieve pain, but they may numb you a bit."),
    blood_analysis_description = ccb.content.text("Painkiller"),
    maximum_intensity = 30,
    intensity_duration_turns = 10,
    rating = "good",
}
    :modifier("speed", "amount", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "happy",
    name = ccb.content.text("Happy"),
    description = ccb.content.text("Life is good."),
    maximum_intensity = 25,
    intensity_duration_turns = 10,
}
    :name(ccb.content.text("Happy"))
    :name(ccb.content.text("Happy"))
    :name(ccb.content.text("Happy"))
    :name(ccb.content.text("Happy"))
    :name(ccb.content.text("Joyful"))
    :name(ccb.content.text("Joyful"))
    :name(ccb.content.text("Joyful"))
    :name(ccb.content.text("Joyful"))
    :name(ccb.content.text("Joyful"))
    :name(ccb.content.text("Elated"))
    :description(ccb.content.text("Life is good."))
    :description(ccb.content.text("Life is good."))
    :description(ccb.content.text("Life is good."))
    :description(ccb.content.text("Life is good."))
    :description(ccb.content.text("Oh what a day!  What a lovely day!"))
    :description(ccb.content.text("Oh what a day!  What a lovely day!"))
    :description(ccb.content.text("Oh what a day!  What a lovely day!"))
    :description(ccb.content.text("Oh what a day!  What a lovely day!"))
    :description(ccb.content.text("Oh what a day!  What a lovely day!"))
    :description(ccb.content.text("I'm on top of the world, baby!"))
    :modifier("speed", "amount", { per_intensity = 0.42 })
    :modifier("strength", "amount", { per_intensity = 0.06 })
    :modifier("dexterity", "amount", { per_intensity = 0.05 })
    :modifier("intelligence", "amount", { per_intensity = 0.084 })
    :modifier("perception", "amount", { per_intensity = 0.1 }))

content.add(content.EffectType {
    id = "sad",
    name = ccb.content.text("Unhappy"),
    description = ccb.content.text("You are not content with your life."),
    maximum_intensity = 1000,
    intensity_duration_turns = 10,
}
    :name(ccb.content.text("Unhappy"))
    :name(ccb.content.text("Unhappy"))
    :name(ccb.content.text("Unhappy"))
    :name(ccb.content.text("Unhappy"))
    :name(ccb.content.text("Sad"))
    :name(ccb.content.text("Sad"))
    :name(ccb.content.text("Sad"))
    :name(ccb.content.text("Sad"))
    :name(ccb.content.text("Sad"))
    :name(ccb.content.text("Depressed"))
    :name(ccb.content.text("Depressed"))
    :description(ccb.content.text("You are not content with your life."))
    :description(ccb.content.text("You are not content with your life."))
    :description(ccb.content.text("You are not content with your life."))
    :description(ccb.content.text("You are not content with your life."))
    :description(ccb.content.text("This is not what you planned for your life."))
    :description(ccb.content.text("This is not what you planned for your life."))
    :description(ccb.content.text("This is not what you planned for your life."))
    :description(ccb.content.text("This is not what you planned for your life."))
    :description(ccb.content.text("This is not what you planned for your life."))
    :description(ccb.content.text("You wonder what's the point of fighting?"))
    :description(ccb.content.text("When will all your suffering end?"))
    :modifier("speed", "amount", { per_intensity = -0.42 })
    :modifier("strength", "amount", { per_intensity = -0.06 })
    :modifier("dexterity", "amount", { per_intensity = -0.05 })
    :modifier("intelligence", "amount", { per_intensity = -0.084 })
    :modifier("perception", "amount", { per_intensity = -0.1 })
    :miss_message(ccb.content.text("You dejectedly consider the pointlessness of it all."), 1))

-- No description. It's intended that exact reason should be unknown to player, encourages use of radiation detection equipment
content.add(content.EffectType {
    id = "irradiated",
    name = ccb.content.text("Weakness"),
    blood_analysis_description = ccb.content.text("Irradiated"),
    maximum_intensity = 2000,
    show_intensity = false,
    intensity_duration_turns = 10,
}
    :modifier("speed", "amount", { per_intensity = -0.2 })
    :modifier("strength", "amount", { per_intensity = -0.125 })
    :modifier("dexterity", "amount", { per_intensity = -0.09 })
    :modifier("intelligence", "amount", { per_intensity = -0.1 })
    :modifier("perception", "amount", { per_intensity = -0.083 }))

content.add(content.EffectType {
    id = "stim",
    name = ccb.content.text("Stimulants"),
    description = ccb.content.text("You're very jittery and pumped up, probably from some stimulants."),
    blood_analysis_description = ccb.content.text("Stimulants"),
    maximum_intensity = 1000,
    intensity_duration_turns = 1,
}
    :modifier("speed", "amount", { per_intensity = 0.08 })
    :modifier("perception", "amount", { per_intensity = 0.04 }))

content.add(content.EffectType {
    id = "depressants",
    name = ccb.content.text("Depressants"),
    description = ccb.content.text("You are under the influence of depressants, and in a bit of a daze."),
    blood_analysis_description = ccb.content.text("Depressants"),
    maximum_intensity = 1000,
    intensity_duration_turns = 1,
}
    :modifier("speed", "amount", { per_intensity = -0.1 })
    :modifier("dexterity", "amount", { per_intensity = -0.05 })
    :miss_message(ccb.content.text("You feel woozy."), 1))

content.add(content.EffectType {
    id = "stim_overdose",
    name = ccb.content.text("Stimulant Overdose"),
    description = ccb.content.text("You can't sit still as you feel your heart pounding out of your chest.  You probably overdosed on those stims."),
    blood_analysis_description = ccb.content.text("Stimulants"),
    maximum_intensity = 1000,
    intensity_duration_turns = 1,
}
    :modifier("dexterity", "amount", { base = -0.88 })
    :modifier("perception", "amount", { base = -0.25, per_intensity = -0.071 })
    :modifier("speed", "amount", { per_intensity = -0.25 })
    :miss_message(ccb.content.text("You shake with the excess stimulation."), 1))

content.add(content.EffectType {
    id = "weak_antibiotic_visible",
    name = ccb.content.text("Took Weak Antibiotic"),
    description = ccb.content.text("You consumed mild antibiotic some time ago to fight off infection.\nIf you don't recover you may want to take another dose, but beware overdosage."),
    maximum_duration_turns = 54000,
    duration_add_percent = 35,
})

content.add(content.EffectType {
    id = "antibiotic_visible",
    name = ccb.content.text("Took Antibiotic"),
    description = ccb.content.text("You consumed antibiotic some time ago to fight off infection.\nIf you don't recover you may want to take another dose, but beware overdosage."),
    maximum_duration_turns = 54000,
    duration_add_percent = 25,
})

content.add(content.EffectType {
    id = "strong_antibiotic_visible",
    name = ccb.content.text("Took Strong Antibiotic"),
    description = ccb.content.text("You consumed prescription-grade antibiotic some time ago to fight off infection.\nIf you don't recover you may want to take another dose, but beware overdosage."),
    maximum_duration_turns = 54000,
    duration_add_percent = 25,
})

content.add(content.EffectType {
    id = "weak_antibiotic",
    blood_analysis_description = ccb.content.text("Antibiotics"),
    rating = "good",
    maximum_duration_turns = 43200,
    duration_add_percent = 25,
})

content.add(content.EffectType {
    id = "antibiotic",
    blood_analysis_description = ccb.content.text("Antibiotics"),
    rating = "good",
    maximum_duration_turns = 43200,
    duration_add_percent = 25,
})

content.add(content.EffectType {
    id = "strong_antibiotic",
    blood_analysis_description = ccb.content.text("Antibiotics"),
    rating = "good",
    maximum_duration_turns = 43200,
    duration_add_percent = 25,
})

content.add(content.EffectType {
    id = "panacea",
    name = ccb.content.text("Panacea"),
    description = ccb.content.text("You feel incredible!  You could take on the world!"),
    maximum_duration_turns = 10,
}
    :modifier("speed", "amount", { base = 20 })
    :modifier("strength", "amount", { base = 2 })
    :modifier("dexterity", "amount", { base = 2 })
    :modifier("intelligence", "amount", { base = 2 })
    :modifier("perception", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "tummy_tablet",
    name = ccb.content.text("Soothed Stomach"),
    description = ccb.content.text("You are under the effects of a stomach soother."),
    intensity_add_value = 1,
    maximum_intensity = 3,
    maximum_duration_turns = 14400,
    duration_add_percent = 70,
}
    :modifier("vomiting", "tick", { base = 60, per_intensity = 120 }))

content.add(content.EffectType {
    id = "antifungal",
    name = ccb.content.text("Antifungals"),
    description = ccb.content.text("You are under the effects of an antifungal medicine or chemicals."),
    blood_analysis_description = ccb.content.text("Antifungals"),
    rating = "good",
    maximum_duration_turns = 28800,
    duration_add_percent = 50,
})

-- This effect is a dummy effect for disabling certain things for a few turns after an electromagnetic pulse and does nothing on its own
content.add(content.EffectType {
    id = "emp",
    name = ccb.content.text("Discharge"),
    description = ccb.content.text("You've been recently affected by an electromagnetic pulse."),
    maximum_duration_turns = 30,
})

-- not given to players by default
content.add(content.EffectType {
    id = "supercharged",
    name = ccb.content.text("Supercharged"),
    description = ccb.content.text("You've been struck by lightning, and feel… different."),
}
    :modifier("speed", "amount", { base = 50 }))

content.add(content.EffectType {
    id = "pd_str_bad",
    name = ccb.content.text("Muscle Vanishment"),
    description = ccb.content.text("You feel as if your muscles are not quite there."),
    maximum_intensity = 2,
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :name(ccb.content.text("Muscle Disappearance"))
    :description(ccb.content.text("You feel as if your muscles are not in your body."))
    :modifier("strength", "amount", { base = -1, per_intensity = -2 })
    :miss_message(ccb.content.text("Your lack of strength stops you!"), 1))

content.add(content.EffectType {
    id = "pd_dex_bad",
    name = ccb.content.text("Weak Grasp"),
    description = ccb.content.text("You seem to have problems touching things."),
    maximum_intensity = 2,
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :name(ccb.content.text("Inexistent Grasp"))
    :description(ccb.content.text("You feel as if your hands just pass through matter."))
    :modifier("dexterity", "amount", { base = -1, per_intensity = -2 })
    :miss_message(ccb.content.text("Your attacks don't seem to touch your enemies!"), 1))

content.add(content.EffectType {
    id = "pd_per_bad",
    name = ccb.content.text("Distorted Vision"),
    description = ccb.content.text("You have problems distinguishing shapes and colors."),
    maximum_intensity = 2,
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :name(ccb.content.text("Otherworldly Vision"))
    :description(ccb.content.text("You seem to see slightly different realities every time you blink."))
    :modifier("perception", "amount", { base = -1, per_intensity = -2 })
    :miss_message(ccb.content.text("You can't distinguish up from down!"), 1))

content.add(content.EffectType {
    id = "pd_int_bad",
    name = ccb.content.text("Wandering Mind"),
    description = ccb.content.text("Your thoughts seem to wander around on their own."),
    maximum_intensity = 2,
    rating = "bad",
    intensity_duration_turns = 3000,
}
    :name(ccb.content.text("Foreign Mind"))
    :description(ccb.content.text("Foreign thoughts seem to invade your mind."))
    :flag("NO_PSIONICS")
    :modifier("intelligence", "amount", { base = -1, per_intensity = -2 })
    :miss_message(ccb.content.text("You suddenly think you shouldn't do that!"), 1))

content.add(content.EffectType {
    id = "pd_rejection",
    name = ccb.content.text("World Rejection"),
    description = ccb.content.text("Faint sparks surround your every move, your body aches more with every passing second."),
    remove_message = ccb.content.text("The world is no longer trying to eject you from this plane of existence, for now."),
    maximum_intensity = 2,
    rating = "bad",
    intensity_duration_turns = 420,
}
    :name(ccb.content.text("Dimensional Rejection"))
    :description(ccb.content.text("Sparks swarm around you, your body hurts and even the air seems to reject your existence."))
    :decay_message(ccb.content.text("The rejection you feel from all around you has become a little easier to bear."), "mixed")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("hurt", "minimum", { per_intensity = 1 })
    :modifier("hurt", "chance_numerator", { per_intensity = 25 })
    :modifier("cough", "chance_numerator", { per_intensity = 30 }))

content.add(content.EffectType {
    id = "pd_strengthened_reality",
    name = ccb.content.text("World's Acceptance"),
    description = ccb.content.text("The world around you seems calmer with your presence and actions."),
    apply_message = ccb.content.text("Your eyes open to a whole new world!"),
    remove_message = ccb.content.text("You start to feel rejected by the world again."),
    maximum_intensity = 4,
    rating = "good",
    intensity_duration_turns = 259200,
}
    :name(ccb.content.text("World's Embracement"))
    :name(ccb.content.text("Dimensional Foothold"))
    :name(ccb.content.text("Dimensional Assimilation"))
    :description(ccb.content.text("The world around you seems to regard you as one of their own, your body is a little easier to move now."))
    :description(ccb.content.text("You can more easily exert your will around you, this dimension is, if not welcoming you, obeying you a little.  You have managed to secure a foothold in this reality."))
    :description(ccb.content.text("The very fabric of reality is blending in with your body, your will is greatly easier to exert around you and your body is trying to permanently assimilate with this world, it just needs a little push…"))
    :decay_message(ccb.content.text("The world no longer embraces you as its child.  At least it still tolerates your presence."), "mixed")
    :decay_message(ccb.content.text("You have lost your foothold and can no longer command the world around you, the world sees you now as only an unruly child."), "mixed")
    :decay_message(ccb.content.text("You can no longer bend the world to your will.  You have failed in blending in with this reality and have now only a foothold left."), "mixed")
    :modifier("speed", "amount", { base = 2, per_intensity = 3 })
    :modifier("dodge", "amount", { per_intensity = 0.7 })
    :miss_message(ccb.content.text("Did the world just oppose you?"), 1)
    :miss_message(ccb.content.text("For a moment you felt a great hostility all around you."), 1)
    :miss_message(ccb.content.text("Did your enemy just vanish for a moment?"), 2)
    :miss_message(ccb.content.text("You felt weird for a moment."), 3)
    :miss_message(ccb.content.text("Was that a spark?"), 5)
    :miss_message(ccb.content.text("Your grip suddenly failed you."), 6)
    :miss_message(ccb.content.text("Something just flashed in front of your eyes."), 8)
    :miss_message(ccb.content.text("Why did the hit go that way?"), 15)
    :miss_message(ccb.content.text("You could swear that you hit it!"), 25))

content.add(content.EffectType {
    id = "migo_atmosphere",
    name = ccb.content.text("Stinking Air"),
    description = ccb.content.text("The air in here smells like vinegar and mold."),
    apply_message = ccb.content.text("The air in here smells like vinegar and mold, and hurts your lungs a bit."),
    maximum_intensity = 5,
    intensity_duration_turns = 5,
    maximum_duration_turns = 30,
    rating = "bad",
    harmful_cough = false,
    show_in_info = true,
}
    :name(ccb.content.text("Disorienting Air"))
    :name(ccb.content.text("Disorienting Air"))
    :name(ccb.content.text("Smothering Air"))
    :name(ccb.content.text("Smothering Air"))
    :description(ccb.content.text("The air in here smells like vinegar and mold.  It makes you feel soft-headed and confused."))
    :description(ccb.content.text("The air in here smells like vinegar and mold.  It makes you feel soft-headed and confused."))
    :description(ccb.content.text("The air in here smells like vinegar and mold.  It is closing in and smothering you, making it impossible to think clearly."))
    :description(ccb.content.text("The air in here smells like vinegar and mold.  It is closing in and smothering you, making it impossible to think clearly."))
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("cough", "chance_numerator", { base = -1002, per_intensity = 501 })
    :modifier("strength", "amount", { per_intensity = -0.25 })
    :modifier("perception", "amount", { per_intensity = -0.5 })
    :modifier("dexterity", "amount", { per_intensity = -0.25 })
    :modifier("intelligence", "amount", { per_intensity = -0.75 })
    :modifier("speed", "amount", { per_intensity = -10 })
    :modifier("vomiting", "chance_numerator", { per_intensity = 10 })
    :miss_message(ccb.content.text("You feel groggy in this sweltering, foul air."), 2))

content.add(content.EffectType {
    id = "fetid_goop",
    name = ccb.content.text("Covered in Fetid Goop"),
    description = ccb.content.text("The feeling of the goop slowly sliding on your skin revulses you and the smell makes you gag."),
    apply_message = ccb.content.text("You're disgusted by the goop."),
    rating = "bad",
    show_in_info = true,
}
    :modifier("strength", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("vomiting", "chance_numerator", { base = 100 }))

content.add(content.EffectType {
    id = "has_og_comm_freq",
})

content.add(content.EffectType {
    id = "has_prospectus",
})

content.add(content.EffectType {
    id = "disrupted_sleep",
})

content.add(content.EffectType {
    id = "nightmares",
    maximum_duration_turns = 259200,
})

content.add(content.EffectType {
    id = "incorporeal",
    name = ccb.content.text("Incorporeal"),
    description = ccb.content.text("You lack substance, as if you aren't quite fully here."),
}
    :removes_effect("grabbed")
    :removes_effect("bleed"))

-- Used for translocation via teleporter_list as a way to avoid fall damage by teleporting Z levels
content.add(content.EffectType {
    id = "ignore_fall_damage",
}
    :flag("FEATHER_FALL"))

content.add(content.EffectType {
    id = "weary_0",
})

content.add(content.EffectType {
    id = "weary_1",
    name = ccb.content.text("Lightly Weary"),
    description = ccb.content.text("You've been pretty active for a while; operating at the highest levels of activity will be impaired.\nThe following move penalties are applied for the following activity levels:\nExtreme: 1.25x"),
})

content.add(content.EffectType {
    id = "weary_2",
    name = ccb.content.text("Moderately Weary"),
    description = ccb.content.text("You've been quite active for a while; operating at higher levels of activity will be impaired.\nThe following move penalties are applied for the following activity levels:\nExtreme: 1.67x, Active: 1.33x"),
})

content.add(content.EffectType {
    id = "weary_3",
    name = ccb.content.text("Weary"),
    description = ccb.content.text("You've been very active for a while, and need to slow down for a bit.\nThe following move penalties are applied for the following activity levels:\nExtreme: 2.5x, Active: 2x, Brisk: 1.5x"),
})

content.add(content.EffectType {
    id = "weary_4",
    name = ccb.content.text("Very Weary"),
    description = ccb.content.text("You've been extremely active for a while, and need to slow down.\nThe following move penalties are applied for the following activity levels:\nExtreme: 5x, Active: 4x, Brisk: 3x, Moderate: 2x"),
})

content.add(content.EffectType {
    id = "weary_5",
    name = ccb.content.text("Extremely Weary"),
    description = ccb.content.text("You've been extremely active for a while, and can't take much more activity.\nThe following move penalties are applied for the following activity levels:\nExtreme: 10x, Active: 8x, Brisk: 6x, Moderate: 4x, Light: 2x"),
})

content.add(content.EffectType {
    id = "weary_6",
    name = ccb.content.text("Extremely Weary"),
    description = ccb.content.text("You've been extremely active for a while, and really need to get some rest.\nThe following move penalties are applied for the following activity levels:\nExtreme: 10x, Active: 8x, Brisk: 6x, Moderate: 4x, Light: 2x"),
})

content.add(content.EffectType {
    id = "weary_7",
    name = ccb.content.text("Extremely Weary"),
    description = ccb.content.text("You've been extremely active for a while; it's time to stop.\nThe following move penalties are applied for the following activity levels:\nExtreme: 10x, Active: 8x, Brisk: 6x, Moderate: 4x, Light: 2x"),
}
    :flag("NO_PSIONICS"))

content.add(content.EffectType {
    id = "weary_8",
    name = ccb.content.text("Extremely Weary"),
    description = ccb.content.text("You've been extremely active for a while, and can no longer keep pushing.\nThe following move penalties are applied for the following activity levels:\nExtreme: 10x, Active: 8x, Brisk: 6x, Moderate: 4x, Light: 2x"),
}
    :flag("NO_PSIONICS"))

content.add(content.EffectType {
    id = "hunger_full",
    name = ccb.content.text("Full"),
    description = ccb.content.text("You feel quite full, and a bit sluggish."),
    apply_message = ccb.content.text("You feel quite full, and a bit sluggish."),
    rating = "bad",
}
    :modifier("speed", "amount", { base = -2 })
    :modifier("sleepiness", "amount", { base = 1 }))

content.add(content.EffectType {
    id = "hunger_engorged",
    name = ccb.content.text("Engorged"),
    description = ccb.content.text("Your stomach is full to bursting.  This was a mistake."),
    apply_message = ccb.content.text("Your stomach is full to bursting.  This was a mistake."),
    rating = "bad",
}
    :modifier("speed", "amount", { base = -10 })
    :modifier("sleepiness", "amount", { base = 2 })
    :modifier("vomiting", "chance_numerator", { base = 500 })
    :modifier("vomiting", "tick", { base = 10 })
    :modifier("pain", "amount", { base = 3 }))

content.add(content.EffectType {
    id = "hunger_satisfied",
})

content.add(content.EffectType {
    id = "hunger_hungry",
})

content.add(content.EffectType {
    id = "hunger_very_hungry",
})

content.add(content.EffectType {
    id = "hunger_near_starving",
})

content.add(content.EffectType {
    id = "hunger_starving",
})

content.add(content.EffectType {
    id = "hunger_famished",
})

content.add(content.EffectType {
    id = "hunger_blank",
})

content.add(content.EffectType {
    id = "weakened_inertia",
    name = ccb.content.text("Weakened Inertia"),
    description = ccb.content.text("Your body moves strangely easily, as if it weighed less."),
    apply_message = ccb.content.text("Your inertia itself is damaged, but the outcome seems suspiciously beneficial."),
    remove_message = ccb.content.text("Reality reasserts itself and your inertia returns to normal."),
    rating = "good",
    show_intensity = false,
}
    :modifier("dexterity", "amount", { base = 6 }))

content.add(content.EffectType {
    id = "hallucination_attacks",
    rating = "bad",
    maximum_duration_turns = 864000,
    show_in_info = false,
})

content.add(content.EffectType {
    id = "strengthened_inertia",
    name = ccb.content.text("Weakened Inertia"),
    description = ccb.content.text("Your body is strangely difficult to move, as if it weighted more."),
    apply_message = ccb.content.text("Your inertia itself is damaged, but hopefully it's not permanent yet."),
    remove_message = ccb.content.text("Reality reasserts itself and your inertia returns to normal."),
    rating = "bad",
    show_intensity = false,
}
    :modifier("dexterity", "amount", { base = -6 }))

content.add(content.EffectType {
    id = "warped_viewpoint",
    name = ccb.content.text("Warped Viewpoint"),
    description = ccb.content.text("Space is warped around you such that you can see a wider arc and as if everything was closer."),
    apply_message = ccb.content.text("Space around you is damaged but in the process your can see more and more easily than before."),
    remove_message = ccb.content.text("Reality reasserts itself and your perspective returns to normal."),
    rating = "good",
    show_intensity = false,
}
    :modifier("perception", "amount", { base = 6 }))

content.add(content.EffectType {
    id = "narrow_viewpoint",
    name = ccb.content.text("Narrowed Viewpoint"),
    description = ccb.content.text("Space is warped around you such that you can see less and as if everything was farther away."),
    apply_message = ccb.content.text("Space around you is damaged narrowing your perspective."),
    remove_message = ccb.content.text("Reality reasserts itself and your perspective returns to normal."),
    rating = "bad",
    show_intensity = false,
}
    :modifier("perception", "amount", { base = -6 }))

content.add(content.EffectType {
    id = "weakened_gravity",
    name = ccb.content.text("Weakened Gravity"),
    description = ccb.content.text("Something is wrong with local spacetime and everything near you seems to weigh less."),
    apply_message = ccb.content.text("Space around you is damaged and everything near you seems to weigh less."),
    remove_message = ccb.content.text("Reality reasserts itself and your gravity returns to normal."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_weakened_gravity_0"))

content.add(content.EffectType {
    id = "strengthened_gravity",
    name = ccb.content.text("Strengthened Gravity"),
    description = ccb.content.text("Something is wrong with local spacetime and everything near you seems to weigh more."),
    apply_message = ccb.content.text("Space around you is damaged and everything near you seems to weigh more."),
    remove_message = ccb.content.text("Reality reasserts itself and your gravity returns to normal."),
    rating = "bad",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_strengthened_gravity_0"))

content.add(content.EffectType {
    id = "slowed_time",
    name = ccb.content.text("Slowed Time"),
    description = ccb.content.text("Something is wrong with local spacetime and everything around seems to move faster than you."),
    apply_message = ccb.content.text("Time around you is damaged and everything near you seems to move faster."),
    remove_message = ccb.content.text("Reality reasserts itself and your time returns to normal."),
    rating = "bad",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_slowed_time_0"))

content.add(content.EffectType {
    id = "nvg_green",
    name = ccb.content.text("Night Vision Goggles (Green)"),
    description = ccb.content.text("Your night vision goggles give a green tint to the world."),
})

content.add(content.EffectType {
    id = "glowing_gas",
    name = ccb.content.text("Glowing Gas", "inhaled"),
    description = ccb.content.text("You've inhaled a lungful of glowing nether parasite spores.  Thankfully, they don't seem adapted to the human physiology."),
    apply_message = ccb.content.text("You inhale a lungful of the glowing gas, and you have an urge to violently cough."),
    rating = "bad",
    harmful_cough = true,
    maximum_duration_turns = 600,
    show_in_info = true,
}
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("cough", "chance_numerator", { base = 10 })
    :miss_message(ccb.content.text("Your lungs burn from the glowing gas."), 1))

content.add(content.EffectType {
    id = "glowing_gas_cover",
    name = ccb.content.text("Glowing"),
    description = ccb.content.text("You are covered in glowing nether spores!"),
    apply_message = ccb.content.text("The glowing spores settle on you!"),
    rating = "bad",
})

content.add(content.EffectType {
    id = "molting",
    name = ccb.content.text("Molting"),
    description = ccb.content.text("You feel a strong urge to hide somewhere safe."),
    apply_message = ccb.content.text("Your chitin plating itches against your body."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 1 })
    :modifier("pain", "maximum_value", { base = 15 })
    :limb_score("reaction", { multiplier = 0.95 })
    :limb_score("manip", { multiplier = 0.95 }))

content.add(content.EffectType {
    id = "molting_imminent",
    name = ccb.content.text("Imminent Molting"),
    description = ccb.content.text("Seek shelter, you will be helpless when it begins."),
    apply_message = ccb.content.text("You can hardly move in your tightening exoskeleton, and you feel a strong impulse to hunker down somewhere safe."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("perception", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -3 })
    :modifier("strength", "amount", { base = -3 })
    :modifier("speed", "amount", { base = -30 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 1 })
    :modifier("pain", "maximum_value", { base = 35 })
    :limb_score("reaction", { multiplier = 0.75 })
    :limb_score("manip", { multiplier = 0.75 }))

content.add(content.EffectType {
    id = "VITRIFYING",
    name = ccb.content.text("Among Glass"),
    description = ccb.content.text("It is very peaceful here."),
    rating = "good",
    maximum_intensity = 7,
}
    :enchantment("INLINE_ENCH_VITRIFYING_0"))

content.add(content.EffectType {
    id = "hay_fever",
    name = ccb.content.text("Hay Fever"),
    description = ccb.content.text("Your eyes are itchy and you've got a runny nose."),
    rating = "bad",
    show_in_info = true,
}
    :resist_effect("took_flumed")
    :resist_effect("took_antihistamine")
    :modifier("perception", "amount", { base = -2 })
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("stamina", "minimum", { base = -50 })
    :modifier("stamina", "maximum", { base = -150 })
    :modifier("stamina", "chance_numerator", { base = 300 }))

content.add(content.EffectType {
    id = "star_vampire_blood_drank",
    name = ccb.content.text("Drank blood"),
    description = ccb.content.text("The star vampire has drunk blood and is now visible."),
    rating = "good",
    show_in_info = true,
}
    :flag("SUPPRESS_INVISIBILITY"))

content.add(content.EffectType {
    id = "ink_gland_ink",
    name = ccb.content.text("Depleted ink"),
    description = ccb.content.text("Your ink glands are empty.  Given some time and hydration they will recharge."),
    show_intensity = true,
    maximum_intensity = 4,
    rating = "neutral",
}
    :name(ccb.content.text("Deflated ink glands"))
    :name(ccb.content.text("Inky glands"))
    :name(ccb.content.text("Bulged ink glands"))
    :description(ccb.content.text("Your ink glands are almost empty.  Given some time and hydration they will recharge."))
    :description(ccb.content.text("Your ink glands have some ink inside.  Given some time and hydration, more ink will be generated."))
    :description(ccb.content.text("Your ink glands are bulged and full.  No more ink is being created.")))

content.add(content.EffectType {
    id = "cramped_space",
    name = ccb.content.text("Cramped Space"),
    description = ccb.content.text("Your movements are restricted by the surroundings."),
    apply_message = ccb.content.text("Your movements are restricted by the surroundings."),
    remove_message = ccb.content.text("You are able to move freely again."),
    rating = "bad",
    show_in_info = true,
}
    :resist_effect("incorporeal")
    :resist_trait("BENDY1")
    :resist_trait("BENDY2")
    :resist_trait("BENDY3")
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("strength", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -20 })
    :miss_message(ccb.content.text("You don't have any room to move!"), 1))

content.add(content.EffectType {
    id = "gliding",
    name = ccb.content.text("Gliding"),
    description = ccb.content.text("You are gliding through the air."),
    rating = "good",
}
    :flag("GLIDING"))

content.add(content.EffectType {
    id = "slow_descent",
    name = ccb.content.text("Slow Descent"),
    description = ccb.content.text("You are descending at a safe speed."),
    show_in_info = false,
    maximum_duration_turns = 1,
}
    :flag("FEATHER_FALL"))

content.add(content.EffectType {
    id = "mute",
    name = ccb.content.text("Mute"),
    description = ccb.content.text("You can't talk."),
    show_in_info = true,
}
    :flag("MUTE"))

content.add(content.EffectType {
    id = "social_satisfied",
    name = ccb.content.text("Good Company"),
    description = ccb.content.text("It feels good to spend time around others."),
    maximum_duration_turns = 21600,
    maximum_intensity = 1,
    rating = "good",
})

content.add(content.EffectType {
    id = "social_dissatisfied",
    name = ccb.content.text("Lonely"),
    description = ccb.content.text("You feel a little lonely."),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Very Lonely"))
    :name(ccb.content.text("All Alone"))
    :description(ccb.content.text("You could really use a friend right now."))
    :description(ccb.content.text("What's the point of surviving if you're all alone?")))

content.add(content.EffectType {
    id = "asocial_satisfied",
    name = ccb.content.text("Alone"),
    description = ccb.content.text("Being on your own makes you feel good."),
    maximum_intensity = 1,
    maximum_duration_turns = 21600,
    rating = "good",
})

content.add(content.EffectType {
    id = "asocial_dissatisfied",
    name = ccb.content.text("Irritable"),
    description = ccb.content.text("Being around others has left you feeling drained."),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Annoyed"))
    :name(ccb.content.text("Crowded"))
    :description(ccb.content.text("OK, that's enough social time.  You'd really rather be alone now."))
    :description(ccb.content.text("Your nerves are frayed from all this socializing.  You need some alone time to recharge.")))

-- Allows fully-quadrupedal mutants to run and crouch on all fours.  For annoying reasons, this is handled via enchantments.
content.add(content.EffectType {
    id = "quadruped_full",
    name = "",
})

-- Allows quadrupedal mutants with front paws only to crouch-walk slightly faster than normal.  For annoying reasons, this is handled via enchantments.
content.add(content.EffectType {
    id = "quadruped_half",
    name = "",
})

content.add(content.EffectType {
    id = "natural_stance",
    name = ccb.content.text("Natural Stance"),
    description = ccb.content.text("You are positioned to take advantage of your mutated anatomy, and will receive no penalties for crouching in melee combat.  Wielding a weapon will cause you to lose this effect."),
    rating = "good",
})

content.add(content.EffectType {
    id = "magic_channeling",
    name = ccb.content.text("Channeling"),
    description = ccb.content.text("You are channeling supernatural powers."),
    show_intensity = true,
    maximum_duration_turns = 60,
    maximum_intensity = 1000,
    intensity_add_value = 1,
    rating = "neutral",
})

content.add(content.EffectType {
    id = "subaquatic_sonar",
    name = ccb.content.text("Subaquatic SONAR"),
    description = ccb.content.text("Every few seconds, an ultrasonic pulse is broadcast from your location.  If you're underwater and your hearing is good enough, you may be able to navigate by the pings that come back."),
})

-- yes it's actually called that.  It is also the strongest anti-clotting factor known to science.  It inhibits the synthesis of thrombin, so most earth animals/mutants should be affected, except maybe bugs.
content.add(content.EffectType {
    id = "anticoagulant_draculin",
    blood_analysis_description = ccb.content.text("Draculin"),
    maximum_intensity = 3,
    maximum_duration_turns = 1200,
    rating = "bad",
}
    :immune_character_flag("DRACULIN_IMMUNE")
    :on_hit_effect_duration("bleed", 2.0, false))

-- Used to display the winning screen upon winning like a winner.
content.add(content.EffectType {
    id = "a_winner_is_u",
    name = ccb.content.text("Winning!"),
})

-- Used to display the special end screen if you died on the Hub 01 surgical table.
content.add(content.EffectType {
    id = "a_turncoat_to_the_end",
    name = ccb.content.text("Turncoat or fool?"),
})

-- Horrible hack to apply vision flag. Set in C++ basecamp::start_crafting()
content.add(content.EffectType {
    id = "HACK_camp_vision_for_npc",
    name = "",
    description = "",
    rating = "good",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("CRAFT_IN_DARKNESS")
    :flag("READ_IN_DARKNESS")
    :limb_score("night_vis", { multiplier = 10 }))

-- This and the other effects with similar ids are used to set the range of creatures with the MIND_SEEING flag.
content.add(content.EffectType {
    id = "eff_mind_seeing_bonus_5",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "eff_mind_seeing_bonus_10",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "eff_mind_seeing_bonus_20",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "eff_mind_seeing_bonus_30",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "aimed_60mm",
    name = "",
    description = "",
    maximum_duration_turns = 180,
})

content.add(content.EffectType {
    id = "triffid_fiber_indigestion",
    name = ccb.content.text("Uneasy stomach"),
    description = ccb.content.text("Your stomach constantly feels like it's full, even when you haven't eaten in awhile."),
    apply_message = ccb.content.text("Your stomach starts to feel strange and bloated."),
    remove_message = ccb.content.text("Your stomach feels normal again."),
    maximum_intensity = 4,
    rating = "bad",
}
    :name(ccb.content.text("Bloated stomach"))
    :name(ccb.content.text("Strained stomach"))
    :name(ccb.content.text("Overloaded stomach"))
    :decay_message(ccb.content.text("Your gut feels less bloated."), "good")
    :decay_message(ccb.content.text("You feel the strain in your stomach lessen."), "good")
    :enchantment("INLINE_ENCH_triffid_fiber_indigestion_0")
    :enchantment("INLINE_ENCH_triffid_fiber_indigestion_1")
    :modifier("vomiting", "chance_numerator", { base = 6000, per_intensity = -300 })
    :modifier("pain", "minimum", { per_intensity = 1 })
    :modifier("pain", "maximum_value", { per_intensity = 4 }))

content.add(content.EffectType {
    id = "sunscreen",
    name = ccb.content.text("Sunscreen"),
    description = ccb.content.text("You applied sunscreen and should be protected from the sun rays for about two hours."),
    remove_message = ccb.content.text("Your sunscreen has worn off."),
})

-- Tracker effect, used for the zombie summoner to increase its summon range
content.add(content.EffectType {
    id = "effect_zombie_summoner_increase_power",
    name = "",
    description = "",
    maximum_intensity = 100,
    intensity_add_value = 1,
})

content.add(content.EffectType {
    id = "effect_nether_shadow_unnatural_chill",
    name = ccb.content.text("Unnatural Chill"),
    description = ccb.content.text("You are chilled to the bone."),
    remove_message = ccb.content.text("The chill in your bones finally fades away."),
    rating = "bad",
    maximum_intensity = 100,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_nether_shadow_unnatural_chill_0"))

content.add(content.EffectType {
    id = "effect_shocker_zombie_charge_up",
    name = ccb.content.text("Crackling"),
    description = ccb.content.text("Sparks occasionally crackle across the monster's skin."),
    rating = "good",
    maximum_intensity = 5,
    intensity_add_value = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_shocker_zombie_charge_up_0"))

content.add(content.EffectType {
    id = "effect_shocker_zombie_charge_up_removal",
    name = "",
    description = "",
}
    :removes_effect("effect_shocker_zombie_charge_up"))

content.add(content.EffectType {
    id = "effect_polyp_out_of_phase",
    name = ccb.content.text("Out of Phase"),
    description = ccb.content.text("You are not entirely present in baseline reality."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_polyp_out_of_phase_0"))

content.add(content.EffectType {
    id = "effect_hound_of_tindalos_slobber",
    name = ccb.content.text("Hound Ichor"),
    description = ccb.content.text("Your %s is stained with bluish ichor."),
    remove_message = ccb.content.text("The bluish ichor boils away into nothingness."),
    rating = "bad",
    show_in_info = true,
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :enchantment("INLINE_ENCH_effect_hound_of_tindalos_slobber_0"))

content.add(content.EffectType {
    id = "effect_hunting_horror_poison",
    name = ccb.content.text("Poisoned"),
    description = ccb.content.text("You have been poisoned!"),
    blood_analysis_description = ccb.content.text("Unknown Contaminant"),
    rating = "bad",
    show_in_info = true,
}
    :flag("SUNBURN")
    :flag("SUNBURN_SUPERNATURAL")
    :enchantment("INLINE_ENCH_effect_hunting_horror_poison_0")
    :miss_message(ccb.content.text("You feel bad inside."), 2))

content.add(content.EffectType {
    id = "effect_hunting_horror_poison_light_sensitive",
    name = ccb.content.text("Uncomfortable"),
    description = ccb.content.text("The light is making you itchy and painful."),
    apply_message = ccb.content.text("Your skin itches as the light falls on you."),
    remove_message = ccb.content.text("The itching fades as the light does."),
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 20 })
    :modifier("pain", "maximum_value", { base = 30 })
    :modifier("pain", "tick", { base = 30 })
    :limb_score("balance", { multiplier = 0.9 })
    :limb_score("reaction", { multiplier = 0.9 })
    :limb_score("vision", { multiplier = 0.8 }))

-- Separate id because there's no reason Poison Resistance would help you against alien toxins.
content.add(content.EffectType {
    id = "alienfoodpoison",
    name = ccb.content.text("Food Poisoning"),
    description = ccb.content.text("Your stomach is extremely upset, and you are quite nauseated."),
    apply_message = ccb.content.text("Your stomach is seized with cramps!"),
    rating = "bad",
}
    :modifier("perception", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("strength", "amount", { base = -3, resisted_base = -1 })
    :modifier("speed", "amount", { base = -20 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "chance_numerator", { base = 300, resisted_base = 900 })
    :modifier("vomiting", "chance_numerator", { base = 600, resisted_base = 1200 })
    :miss_message(ccb.content.text("Your stomach bothers you."), 1))

-- Hidden effect, provides the limb score penalty from Slit Nostrils
content.add(content.EffectType {
    id = "effect_slit_nostrils_breathing_penalty",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("breathing", { multiplier = 0.9 }))

-- Hidden effect, provides the limb score penalty from Claws
content.add(content.EffectType {
    id = "effect_claw_manipulation_penalty",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0.95 }))

-- Hidden effect, provides the limb score penalty from Stainless Claws
content.add(content.EffectType {
    id = "effect_claw_st_manipulation_penalty",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0.9 }))

-- Hidden effect, provides the limb score penalty from Stubby Fingers
content.add(content.EffectType {
    id = "effect_shorter_fingers_manipulation_penalty",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0.95 }))

-- Hidden effect, provides the muscle vehicle boost from active insect wings
content.add(content.EffectType {
    id = "effect_insect_wings_muscle_veh_boost",
    name = "",
    description = "",
}
    :flag("MUSCLE_VEH_BOOST"))

-- Hidden effect, provides the limb score penalty from Little or Dextrous Paws when you haven't practiced
content.add(content.EffectType {
    id = "effect_dextrous_paws_no_practice_manipulation_penalty",
    name = ccb.content.text("Clumsy Fingers"),
    description = ccb.content.text("You're still getting used to these new paws.  Maybe you need some practice."),
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0.75 }))

-- Applied to monsters after they first establish line-of-sight to the avatar.
content.add(content.EffectType {
    id = "monster_locked_on",
    name = "",
    description = "",
    maximum_duration_turns = 120,
})

-- Hidden effect, used for cooldown manipulations
content.add(content.EffectType {
    id = "effect_monster_no_double_cast",
    name = "",
    description = "",
    maximum_intensity = 100,
})

content.add(content.EffectType {
    id = "nauseating_smell",
    name = ccb.content.text("Nauseating Stench"),
    description = ccb.content.text("Something smells unbelievably foul."),
    apply_message = ccb.content.text("You are assaulted by one of the most vile smells you've ever smelled."),
    remove_message = ccb.content.text("The last traces of the foul stench leave your nostrils."),
    rating = "bad",
    maximum_duration_turns = 120,
}
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("perception", "amount", { base = -1 })
    :modifier("cough", "chance_numerator", { base = 3 })
    :modifier("vomiting", "chance_numerator", { base = 15 })
    :modifier("vomiting", "tick", { base = 10 }))

content.add(content.EffectType {
    id = "nl_phase_goo",
    name = ccb.content.text("Out of phase"),
    description = ccb.content.text("Your body is partially out of phase with reality.  You move much more slowly, but you might be able to phase through some obstacles with ease."),
    apply_message = ccb.content.text("You're coated in out-of-phase goo!"),
    remove_message = ccb.content.text("Your body returns to its normal phase."),
    rating = "bad",
    maximum_intensity = 1,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_nl_phase_goo_0"))

-- A nitrogen-rich atmosphere with trace amounts of Bromine, Phosgene, and Nitrogen dioxide.  Insidious killer.
content.add(content.EffectType {
    id = "effect_scarlet_atmopshere",
    name = ccb.content.text("Scarlet Atmosphere"),
    description = ccb.content.text("You've been breathing in an alien atmosphere.  Breathing is difficult."),
    remove_message = ccb.content.text("Your head clears."),
    blood_analysis_description = ccb.content.text("HNO3, HNO2, HBr, HBrO"),
    rating = "bad",
    maximum_intensity = 125,
    maximum_effective_intensity = 100,
    maximum_duration_turns = 18000,
    intensity_duration_turns = 144,
    duration_add_percent = 500,
    harmful_cough = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :immune_character_flag("INHALED_TOXIN_IMMUNE")
    :modifier("stamina", "amount", { base = -200, per_intensity = -2 })
    :modifier("stamina", "minimum", { base = -100, per_intensity = -1 })
    :modifier("stamina", "chance_numerator", { base = 10 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 300 })
    :modifier("cough", "chance_numerator", { base = 150 })
    :modifier("hurt", "minimum", { base = 1, per_intensity = 0.0125 })
    :modifier("hurt", "chance_numerator", { base = 450 })
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.8 }))

-- A nitrogen-rich atmosphere of the scarlet sea makes this water midly acidic, with trace amounts of dissolved Bromide.
content.add(content.EffectType {
    id = "effect_scarlet_water",
    name = ccb.content.text("Drank Acrid Water"),
    description = ccb.content.text("That yellowish water isn't sitting right with you."),
    remove_message = ccb.content.text("The acrid taste in your mouth subsides, and your head clears."),
    blood_analysis_description = ccb.content.text("Bromide"),
    rating = "bad",
    maximum_intensity = 5,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_trait("POISRESIST")
    :modifier("perception", "amount", { base = -1, per_intensity = -0.5 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = -0.5 })
    :modifier("strength", "amount", { base = -1, per_intensity = -0.5 })
    :modifier("speed", "amount", { base = -20 })
    :modifier("health", "minimum", { base = -2, resisted_base = -1 })
    :modifier("health", "chance_numerator", { base = 300, resisted_base = 900 })
    :modifier("hurt", "minimum", { base = 1, per_intensity = 3 })
    :modifier("hurt", "chance_numerator", { base = 450, resisted_base = 1350 })
    :modifier("vomiting", "chance_numerator", { base = 2400, resisted_base = 7200 })
    :modifier("vomiting", "tick", { base = 1200, per_intensity = -225 })
    :miss_message(ccb.content.text("Your guts feel awful."), 1)
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "scarlet_storm_lungs",
    name = ccb.content.text("Strange Lung Irritation"),
    description = ccb.content.text("You've been breathing strange mist and fog, and it doesn't feel quite right."),
    remove_message = ccb.content.text("You suddenly feel like you can breath again."),
    blood_analysis_description = ccb.content.text("Trace: HNO3, HNO2, HBr, HBrO"),
    maximum_intensity = 125,
    maximum_effective_intensity = 100,
    maximum_duration_turns = 18000,
    intensity_duration_turns = 144,
    duration_add_percent = 500,
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("stamina", "amount", { base = -50 })
    :modifier("stamina", "minimum", { base = -25 })
    :modifier("stamina", "chance_numerator", { base = 75 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 2000 })
    :modifier("cough", "chance_numerator", { base = 150 })
    :modifier("hurt", "chance_numerator", { base = 2000 })
    :modifier("hurt", "minimum", { base = 1 })
    :limb_score("breathing", { resisted_multiplier = 1, per_intensity = -0.005 }))

-- Hidden effect, keeps you from falling in the portal dungeon briefly and also prevents infinite trap teleporting
content.add(content.EffectType {
    id = "effect_temporary_levitation",
    name = "",
    description = "",
}
    :flag("LEVITATION"))

-- Hidden effect, prevents infinite trap teleporting in the portal dungeon
content.add(content.EffectType {
    id = "effect_portal_dungeon_multi_trigger_limiter",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "dulled_senses",
    name = ccb.content.text("Dulled senses"),
    description = ccb.content.text("The world feels muffled and far away.  Your perception is reduced."),
    rating = "bad",
    maximum_intensity = 2,
    intensity_duration_turns = 300,
    show_in_info = true,
}
    :name(ccb.content.text("Numbing world"))
    :description(ccb.content.text("Everything feels distant and muted, as if behind thick glass.  Your perception is greatly reduced."))
    :modifier("perception", "amount", { per_intensity = -1 }))

content.add(content.EffectType {
    id = "heightened_senses",
    name = ccb.content.text("Heightened senses"),
    description = ccb.content.text("Every sensation feels crisp and clear.  Your perception is enhanced."),
    rating = "good",
    maximum_intensity = 2,
    intensity_duration_turns = 300,
    show_in_info = true,
}
    :name(ccb.content.text("Vivid world"))
    :description(ccb.content.text("Every sensation burns vivid and sharp, almost overwhelming.  Your perception is greatly enhanced."))
    :modifier("perception", "amount", { per_intensity = 1 }))

-- Hidden effect, sets manip to 0 so you drop what you're holding
content.add(content.EffectType {
    id = "effect_zero_manip",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0 }))

content.add(content.EffectType {
    id = "effect_mon_feral_serum_user_armus",
    name = "",
    description = "",
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_mon_feral_serum_user_armus_0"))

-- Hardcoded effect to track a pc as berserk. Applied and checked in C++ only.
content.add(content.EffectType {
    id = "berserk",
    name = ccb.content.text("RAGE"),
    description = ccb.content.text("Uncontrollably raging.  You cannot flee from hostiles."),
})

content.upsert_effect_type(content.EffectType {
    id = "no_power_tank_treads",
    name = ccb.content.text("Low Power (Bionic Treads)"),
    description = ccb.content.text("You're low on power.  Your bionic treads are operating in emergency mode and have limited function."),
    rating = "bad",
    maximum_duration_turns = 30,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("speed", "amount", { base = -10 })
    :limb_score("block", { multiplier = 0.0 })
    :limb_score("swim", { multiplier = 0.01 })
    :limb_score("move_speed", { multiplier = 0.1 }))

content.add(content.EffectType {
    id = "onfire",
    apply_memorial_log = "Caught on fire.",
    remove_memorial_log = "Put out the fire.",
    name = ccb.content.text("On Fire"),
    description = ccb.content.text("Loss of health - Entire Body\nYour clothing and other equipment may be consumed by the flames."),
    apply_message = ccb.content.text("You're on fire!  Wait in place to attempt to put out the fire."),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 5,
    maximum_duration_turns = 50,
    show_in_info = true,
})

content.upsert_effect_type(content.EffectType {
    id = "blind",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Range of Sight: 0.  You cannot see anything."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("BLIND")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness")
    :limb_score("vision", { multiplier = 0.0 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.upsert_effect_type(content.EffectType {
    id = "mutagen_troglobite",
    name = ccb.content.text("Troglobite Mutation"),
    description = ccb.content.text("You consumed troglobite primer."),
    blood_analysis_description = ccb.content.text("Troglobite Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Troglobite Transformation"))
    :name(ccb.content.text("Troglobite Metamorphosis"))
    :description(ccb.content.text("Down in the dark corners of the new world.  That's where you belong."))
    :description(ccb.content.text("Deep and dark, your bones ache and twist."))
    :resist_trait("THRESH_TROGLOBITE")
    :modifier("hurt", "minimum", { base = 2 })
    :modifier("hurt", "maximum", { base = 3 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 2 })
    :modifier("perception", "amount", { per_intensity = -2.5 })
    :modifier("dexterity", "amount", { per_intensity = 1 }))

content.add(content.EffectType {
    id = "smoke_eyes",
    name = ccb.content.text("Little Eye Irritation"),
    description = ccb.content.text("Your eyes are mildly irritated."),
    maximum_duration_turns = 180,
    maximum_intensity = 4,
    intensity_decay_tick = 40,
    show_in_info = true,
}
    :name(ccb.content.text("Minor Eye Irritation"))
    :name(ccb.content.text("Huge Eye Irritation"))
    :name(ccb.content.text("Bad Eye Irritation"))
    :description(ccb.content.text("Your eyes are watering."))
    :description(ccb.content.text("Your eyes sting badly and tears stream from them continuously."))
    :description(ccb.content.text("You can barely see anything due to your massive eye irritation and the flood of tears streaming from them."))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_effect("steroid_eye")
    :resist_optional_effect("PAINRESIST")
    :modifier("perception", "amount", { base = -1, per_intensity = -1 })
    :modifier("pain", "amount", { base = 2, per_intensity = 2, resisted_per_intensity = 1 })
    :miss_message(ccb.content.text("Your eyes sting and tear from the irritation."), 1)
    :apply_message(ccb.content.text("Your eyes are mildly irritated."), "bad")
    :apply_message(ccb.content.text("Your eyes are watering."), "bad")
    :apply_message(ccb.content.text("Your eyes sting badly and tears stream from them continuously."), "bad")
    :apply_message(ccb.content.text("You can barely see anything due to your massive eye irritation and the flood of tears streaming from them."), "bad")
    :limb_score("vision", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.2, resisted_per_intensity = -0.15 })
    :limb_score("night_vis", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.2, resisted_per_intensity = -0.15 }))

-- Applying this to monsters will make them invisible unless they are adjacent to the player.
content.upsert_effect_type(content.EffectType {
    id = "invisibility",
    name = ccb.content.text("Invisible"),
    description = ccb.content.text("You are invisible."),
}
    :flag("INVISIBLE"))

content.add(content.EffectType {
    id = "bite",
    apply_memorial_log = "Received a deep bite wound.",
    remove_memorial_log = "Recovered from a bite wound.",
    name = ccb.content.text("Bite"),
    description = ccb.content.text("You have a nasty bite wound."),
    apply_message = ccb.content.text("The bite wound feels really deep…"),
    main_parts_only = true,
    rating = "bad",
    intensity_duration_turns = 1800,
    maximum_intensity = 2,
}
    :name(ccb.content.text("Painful Bite"))
    :immune_bodypart_flag("BIONIC_LIMB")
    :resist_trait("INFRESIST")
    :modifier("dexterity", "amount", { per_intensity = -1 })
    :modifier("pain", "chance_denominator", { per_intensity = 200 })
    :modifier("pain", "chance_numerator", { per_intensity = 2, resisted_per_intensity = 1 })
    :modifier("pain", "minimum", { per_intensity = 1 })
    :modifier("pain", "maximum_value", { per_intensity = 10, resisted_per_intensity = 5 }))

-- Stamina regen stops completely at int 3, but no stamina loss from then on
content.add(content.EffectType {
    id = "infected",
    apply_memorial_log = "Contracted an infection.",
    remove_memorial_log = "Recovered from an infection… this time.",
    name = ccb.content.text("Infected"),
    description = ccb.content.text("You have an infected wound."),
    apply_message = ccb.content.text("Your wound feels infected."),
    blood_analysis_description = ccb.content.text("Bacterial Infection"),
    main_parts_only = true,
    rating = "bad",
    intensity_duration_turns = 28800,
    maximum_intensity = 3,
}
    :name(ccb.content.text("Badly Infected"))
    :name(ccb.content.text("Pus Filled"))
    :resist_trait("INFRESIST")
    :modifier("strength", "amount", { base = -2, per_intensity = -1, resisted_per_intensity = -0.5 })
    :modifier("dexterity", "amount", { base = -3, per_intensity = -1, resisted_per_intensity = -0.5 })
    :modifier("intelligence", "amount", { base = -2, per_intensity = -3, resisted_per_intensity = -1 })
    :modifier("vomiting", "chance_numerator", { base = 900, per_intensity = -400, resisted_base = 1200 })
    :modifier("vomiting", "tick", { base = 180 })
    :modifier("thirst", "minimum", { base = 2 })
    :modifier("thirst", "chance_numerator", { base = 10, resisted_base = 100 })
    :modifier("thirst", "tick", { base = 30 })
    :modifier("speed", "amount", { base = -10, per_intensity = -10, resisted_per_intensity = -5 })
    :modifier("stamina", "minimum", { base = -8, per_intensity = -6, resisted_base = -4, resisted_per_intensity = -4 })
    :modifier("stamina", "maximum", { base = -50, per_intensity = 15, resisted_base = -20, resisted_per_intensity = 4 })
    :modifier("stamina", "chance_numerator", { base = 3, per_intensity = -1, resisted_base = 10, resisted_per_intensity = -2.5 })
    :modifier("sleepiness", "minimum", { base = 2 })
    :modifier("sleepiness", "maximum", { base = 10, resisted_base = 5 })
    :modifier("sleepiness", "chance_numerator", { base = 110, per_intensity = -50 })
    :modifier("sleepiness", "maximum_value", { base = 700, resisted_base = 250 })
    :modifier("healing", "amount", { base = 0.01, resisted_base = 1 })
    :modifier("sleepiness", "tick", { per_intensity = 0.5 }))

content.add(content.EffectType {
    id = "fungus",
    speed_name = ccb.content.text("Itchy skin"),
    apply_memorial_log = "Contracted a fungal infection.",
    remove_memorial_log = "Cured the fungal infection.",
    remove_message = ccb.content.text("The itching in your skin fades away."),
    blood_analysis_description = ccb.content.text("Fungal Infection"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 21600,
    maximum_duration_turns = 64800,
}
    :resist_effect("antifungal")
    :resist_trait("POISRESIST")
    :modifier("speed", "amount", { base = -10 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :miss_message(ccb.content.text("You feel sick inside."), 1))

content.upsert_effect_type(content.EffectType {
    id = "visuals",
    name = ccb.content.text("Hallucinating"),
    description = ccb.content.text("You can't trust everything that you see."),
    blood_analysis_description = ccb.content.text("Hallucinations"),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -4 })
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.2 }))

-- intensity 1 - one of two lungs is collapsed; intensity 2 - both lungs are collapsed
content.add(content.EffectType {
    id = "lung_collapse",
    name = ccb.content.text("Lung Collapse"),
    description = ccb.content.text("You have difficulties breathing!"),
    rating = "bad",
    maximum_intensity = 2,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_lung_collapse_0")
    :modifier("hurt", "amount", { base = 1 })
    :modifier("hurt", "tick", { base = 4 })
    :death_chance({ numerator = 0, denominator = 1 })
    :death_chance({ numerator = 1, denominator = 120 }))

content.upsert_effect_type(content.EffectType {
    id = "hallu",
    blood_analysis_description = ccb.content.text("Hallucinations"),
    maximum_duration_turns = 21600,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "pre_common_cold",
    apply_memorial_log = "Started getting sick.",
    name = ccb.content.text("Getting Sick"),
    description = ccb.content.text("You are coming down with some kind of sickness.  It's too early to tell how bad it's going to be, but it might be a good idea to find a safe place to rest."),
    apply_message = ccb.content.text("You feel a sickness coming on…"),
    rating = "bad",
}
    :immune_character_flag("NO_DISEASE")
    :resist_effect("took_flumed")
    :enchantment("INLINE_ENCH_pre_common_cold_0")
    :modifier("thirst", "tick", { base = 3600 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("cough", "chance_numerator", { base = 600 }))

-- For player, indistinguishable from pre_cold, but separate here to allow for separate resistances from flu shot/antibodies.
content.add(content.EffectType {
    id = "pre_flu",
    apply_memorial_log = "Started getting sick.",
    name = ccb.content.text("Getting Sick"),
    description = ccb.content.text("You are coming down with some kind of sickness.  It's too early to tell how bad it's going to be, but it might be a good idea to find a safe place to rest."),
    apply_message = ccb.content.text("You feel a sickness coming on…"),
    rating = "bad",
}
    :immune_character_flag("NO_DISEASE")
    :resist_effect("took_flumed")
    :enchantment("INLINE_ENCH_pre_flu_0")
    :modifier("thirst", "tick", { base = 3600 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("strength", "amount", { base = -1 })
    :modifier("cough", "chance_numerator", { base = 600 }))

content.add(content.EffectType {
    id = "common_cold",
    apply_memorial_log = "Caught a cold.",
    remove_memorial_log = "Got over the cold.",
    name = ccb.content.text("Common Cold"),
    description = ccb.content.text("You have contracted the 'Common Cold'.  Symptoms can be alleviated by medication (cough syrup)."),
    apply_message = ccb.content.text("You feel a cold coming on…"),
    blood_analysis_description = ccb.content.text("Viral Infection"),
    rating = "bad",
}
    :immune_character_flag("NO_DISEASE")
    :resist_effect("took_flumed")
    :enchantment("INLINE_ENCH_common_cold_0")
    :modifier("thirst", "tick", { base = 1800 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("strength", "amount", { base = -3, resisted_base = -1 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -2, resisted_base = -1 })
    :modifier("cough", "chance_numerator", { base = 300 })
    :miss_message(ccb.content.text("You're too stuffed up to fight effectively."), 1))

content.add(content.EffectType {
    id = "flu",
    apply_memorial_log = "Caught the flu.",
    remove_memorial_log = "Got over the flu.",
    name = ccb.content.text("Influenza"),
    description = ccb.content.text("You have contracted flu, or more technically speaking, the 'Influenza'.  Symptoms can be alleviated by medication (cough syrup)."),
    apply_message = ccb.content.text("You feel a flu coming on…"),
    blood_analysis_description = ccb.content.text("Viral Infection"),
    rating = "bad",
}
    :immune_character_flag("NO_DISEASE")
    :resist_effect("took_flumed")
    :enchantment("INLINE_ENCH_flu_0")
    :modifier("thirst", "tick", { base = 1800 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("strength", "amount", { base = -4, resisted_base = -2 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("perception", "amount", { base = -1 })
    :modifier("intelligence", "amount", { base = -2, resisted_base = -1 })
    :modifier("pain", "maximum_value", { base = 15 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("cough", "chance_numerator", { base = 300 })
    :modifier("vomiting", "chance_numerator", { base = 3600, resisted_base = 7200 })
    :miss_message(ccb.content.text("You're too stuffed up to fight effectively."), 1))

content.add(content.EffectType {
    id = "took_antihistamine",
    name = ccb.content.text("Took Antihistamine Drugs"),
    description = ccb.content.text("You have taken an antihistamine drug recently."),
    blood_analysis_description = ccb.content.text("Antihistamines"),
    rating = "good",
})

content.add(content.EffectType {
    id = "drunk",
    death_message = ccb.content.text("Your breathing grows weaker and weaker, and then you are gone."),
    name = ccb.content.text("Buzzed"),
    description = ccb.content.text("You had some alcohol.  You feel warm inside."),
    apply_message = ccb.content.text("You feel lightheaded."),
    blood_analysis_description = ccb.content.text("Alcohol"),
    maximum_intensity = 5,
}
    :name(ccb.content.text("Tipsy"))
    :name(ccb.content.text("Drunk"))
    :name(ccb.content.text("Wasted"))
    :name(ccb.content.text("Dead Drunk"))
    :description(ccb.content.text("You had some alcohol.  Party on!"))
    :description(ccb.content.text("You had lots of alcohol.  Now you're feeling it."))
    :description(ccb.content.text("You had too much alcohol.  It's the end of the world, what do you care?"))
    :description(ccb.content.text("You had so much alcohol that you're probably not going to remember this."))
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("vomiting", "chance_numerator", { base = -20, per_intensity = 17 })
    :modifier("vomiting", "chance_denominator", { base = 1000 })
    :modifier("vomiting", "tick", { base = 180, per_intensity = -30 })
    :modifier("sleep", "tick", { base = 45 })
    :modifier("sleep", "chance_numerator", { base = -1003, per_intensity = 501 })
    :modifier("sleep", "minimum", { base = 15000 })
    :modifier("sleep", "maximum", { base = 21000 })
    :modifier("painkiller", "amount", { base = 1 })
    :modifier("painkiller", "maximum_value", { base = 1, per_intensity = 5 })
    :modifier("painkiller", "minimum", { base = 1 })
    :modifier("painkiller", "tick", { base = 45, per_intensity = -5 })
    :modifier("thirst", "minimum", { base = 1 })
    :modifier("thirst", "maximum", { base = 2 })
    :modifier("thirst", "tick", { base = 1000, per_intensity = -100 })
    :modifier("sensitivity", "amount", { base = -1, per_intensity = -1 })
    :modifier("sensitivity", "chance_numerator", { base = 300 })
    :modifier("sensitivity", "minimum_value", { base = 70, per_intensity = -5 })
    :modifier("strength", "amount", { base = 0.5, per_intensity = 0.5 })
    :modifier("speed", "amount", { per_intensity = -2 })
    :modifier("perception", "amount", { per_intensity = -0.5 })
    :modifier("dexterity", "amount", { per_intensity = -0.5 })
    :modifier("intelligence", "amount", { per_intensity = -0.75 })
    :miss_message(ccb.content.text("You feel woozy."), 1)
    :limb_score("manip", { multiplier = 0.9, per_intensity = -0.1 })
    :limb_score("block", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("vision", { multiplier = 1.0, per_intensity = -0.05 })
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.2 })
    :limb_score("move_speed", { multiplier = 1.0, per_intensity = -0.02 })
    :limb_score("balance", { multiplier = 0.9, per_intensity = -0.2 })
    :limb_score("footing", { multiplier = 1.0, per_intensity = -0.15 })
    :limb_score("swim", { multiplier = 1.0, per_intensity = -0.2 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = 1, denominator = 25000 }))

content.add(content.EffectType {
    id = "rat_bite_fever",
    name = ccb.content.text("Puckered Scratches"),
    apply_message = ccb.content.text("Your skin starts burning around some of your scratches.  Some aspirin might relieve the effects."),
    remove_message = ccb.content.text("The fever breaks."),
    blood_analysis_description = ccb.content.text("Streptobacillus moniliformis Infection"),
    rating = "bad",
}
    :immune_bodypart_flag("BIONIC_LIMB")
    :immune_bodypart_flag("NON_FLESH_LIMB")
    :resist_optional_effect("aspirin")
    :modifier("stamina", "minimum", { base = -50 })
    :modifier("stamina", "maximum", { base = -100 })
    :modifier("stamina", "chance_numerator", { base = 300 })
    :modifier("intelligence", "amount", { base = -1 })
    :modifier("sleepiness", "minimum", { base = 5 })
    :modifier("sleepiness", "maximum", { base = 10 })
    :modifier("sleepiness", "chance_numerator", { base = 500 }))

-- Internal bleeding
content.add(content.EffectType {
    id = "mutation_internal_damage",
    apply_memorial_log = "Had a mutation botched due to their installed bionics.",
    name = ccb.content.text("Botched Mutation"),
    description = ccb.content.text("Your changing body did not cope well with your bionics."),
    maximum_intensity = 3,
    intensity_decay_tick = 25200,
    intensity_decay_removes = true,
    show_intensity = false,
    main_parts_only = true,
}
    :name(ccb.content.text("Botched Mutation"))
    :name(ccb.content.text("Destroyed Bionic"))
    :modifier("pain", "minimum", { base = 1, per_intensity = 1 })
    :modifier("pain", "maximum", { base = 2, per_intensity = 4 })
    :modifier("pain", "chance_numerator", { base = 24, per_intensity = -8 })
    :modifier("pain", "tick", { base = 36, per_intensity = -15 })
    :modifier("hurt", "maximum", { base = 1 })
    :modifier("hurt", "chance_numerator", { base = 24, per_intensity = -8 })
    :modifier("hurt", "tick", { base = 40, per_intensity = 40 })
    :vitamin("redcells", {
        rates = { { minimum = -2, maximum = -5 }, { minimum = -2, maximum = -5 }, { minimum = -4, maximum = -8 } },
        tick_turns = { 30, 30, 15 },
    })
    :vitamin("blood", {
        rates = { { minimum = -2, maximum = -5 }, { minimum = -2, maximum = -5 }, { minimum = -4, maximum = -8 } },
        tick_turns = { 30, 30, 15 },
    })
    :apply_message(ccb.content.text("Your twisting flesh strains against the bionics invading your body."), "bad")
    :apply_message(ccb.content.text("Your twisting flesh strains against the bionics invading your body."), "bad")
    :apply_message(ccb.content.text("Your twisting flesh strains against the bionics invading your body."), "bad"))

-- Hidden effect, tracks how long you've been in the portal storm dungeon
content.add(content.EffectType {
    id = "effect_portal_storm_dungeon_time_tracker",
    name = "",
    description = "",
    intensity_decay_step = 1,
    intensity_decay_tick = 120,
})

content.add(content.EffectType {
    id = "star_vampire_blood_drink_feral",
    name = ccb.content.text("Exsanguination"),
    description = ccb.content.text("The monster is drinking your blood, you vile feral!"),
    rating = "bad",
    maximum_intensity = 1,
    show_in_info = true,
}
    :resist_trait("BLEED_IMMUNE")
    :death_chance({ numerator = 1, denominator = 20 }))
