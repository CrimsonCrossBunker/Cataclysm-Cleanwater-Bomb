local ccb = require("ccb")

-- Werewolf traits should focus on hunting, fighting extradimensional threats, the moon, battle fury, shapeshifting
-- true
ccb.content.define_mutation {
    id = "WEREWOLF_MANA_TRAIT",
    name = ccb.content.text("Werewolf Mana"),
    points = 0,
    description = ccb.content.text("Your mana is calculated differently because you're a werewolf."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_MANA_TRAIT_0" },
}

-- Tier 1 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_SMELL_NEARBY_ENEMIES",
    name = ccb.content.text("Scent the Prey"),
    points = 2,
    description = ccb.content.text("Your sense of smell is heightened even in human form, allowing you to smell nearby enemies.  In war or wolf form, this range is extended."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_SMELL_NEARBY_ENEMIES_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_NO_SCENT",
    name = ccb.content.text("Running through the River"),
    points = 2,
    description = ccb.content.text("As a hunter, you know that catching a scent is the first step to getting the prey's neck between your jaws, so it's best to avoid that first step.  While active, you have no scent at all."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = ccb.content.text("You suppress your scent."),
    active_flags = { "NO_SCENT" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_ILLUMINATE_TARGET",
    name = ccb.content.text("Moon's Cold Glow"),
    points = 2,
    description = ccb.content.text("Moonlight illuminates those under its light, and you can focus that light onto a single target.  The target will glow with a soft silvery light, which grows brighter when out under the moon."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_illuminate_target_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_FRIEND_TO_ANIMALS",
    name = ccb.content.text("Among the Birds and Beasts"),
    points = 2,
    description = ccb.content.text("A werewolf is a hunter and the natural world knows that, even in human form.  However, it is possible to cloak your predator's mien and masquerade as a simple animal, drawing less negative attention.  While active, this trait provides the effects of Animal Kinship."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = ccb.content.text("You submerge your aura into the natural world."),
    active_flags = { "ANIMALEMPATH2" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_SMASH_TERRAIN",
    name = ccb.content.text("Mighty Blow"),
    points = 2,
    description = ccb.content.text("No barrier can stop the hunter truly devoted to seeking their quarry.  You can temporarily enhance your strength for the purposes of smashing through barriers."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_smash_terrain_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CLIMB_IN_WOLF_FORM",
    name = ccb.content.text("Spider Climb"),
    points = 2,
    description = ccb.content.text("You can chase after your prey wherever they travel.  While in wolf form, you can scramble up one-story walls to reach the roof, and you can fall a single story without taking any damage."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_CLIMB_IN_WOLF_FORM_0" },
}

-- Tier 2 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
    name = ccb.content.text("Sense the Outsider"),
    points = 2,
    description = ccb.content.text("The People have long fought the things from Outside and developed a keen sense when one of them is near.  When active, you can sense nearby creatures of the Nether or beings from Under the Hill."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 5,
    activation_message = ccb.content.text("You open your senses to the presence of your prey."),
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}

ccb.content.define_mutation {
    id = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE",
    name = ccb.content.text_without_extraction("Sense the Outsider Active"),
    points = 2,
    description = ccb.content.text_without_extraction("The active trait for Sense the Outsider.  This should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_STUN_MACHINE",
    name = ccb.content.text("Gremlinize"),
    points = 2,
    description = ccb.content.text("You can cause just enough change in a machine to confuse the rigid requirements of its programming, stunning it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_stun_machine_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_EXTRA_WEAKPOINT_HITS",
    name = ccb.content.text("Go for the Throat"),
    points = 3,
    description = ccb.content.text("A successful hunter targets the vulnerable belly, or throat, or ears, they do not simply bite the first thing that comes into their reach.  When unarmed or in war or wolf form, you have a higher chance to hit your enemies' weakpoints."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    enchantments = { "INLINE_ENCH_WEREWOLF_EXTRA_WEAKPOINT_HITS_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_FAR_JUMP",
    name = ccb.content.text("Grasshopper's Leap"),
    points = 2,
    description = ccb.content.text("You can make mighty leaps from a standing start that would normally be impossible.  While in wolf form, you can jump <color_green>even further</color>."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_far_jump_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CAMOUFLAGE_COAT",
    name = ccb.content.text("Shimmerpelt"),
    points = 4,
    description = ccb.content.text("Blend your coat in with the surrounding environment, making it harder for enemies to spot you.  This gift is most effective in wolf form, but still has minor effects in human or war form."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = "",
    enchantments = { "INLINE_ENCH_WEREWOLF_CAMOUFLAGE_COAT_0" },
}

-- Tier 3 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_PARTIAL_SHIFT",
    name = ccb.content.text("Partial Shift"),
    points = 2,
    description = ccb.content.text("Transforming fully is very useful but the real mark of mastery is changing only a part of your body.  This is most useful in human form, but can be used in other forms as well, such as transforming your hands back into human ones for easier manipulation."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
}

ccb.content.define_mutation {
    id = "WEREWOLF_SILVER_CLAWS",
    name = ccb.content.text("Argent Claws"),
    points = 4,
    description = ccb.content.text("While in war form, transform your claws into silver, causing them to do additional damage to creatures of the Nether."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 6,
    activation_message = "",
    on_activate = "werewolf_silver_claws_on",
    on_deactivate = "werewolf_silver_claws_off",
}

ccb.content.define_mutation {
    id = "WEREWOLF_SILVER_CLAWS_ACTIVE",
    name = ccb.content.text_without_extraction("Argent Claws Active"),
    points = 4,
    description = ccb.content.text_without_extraction("The active trait for Argent Claws.  It should not be visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_SILVER_CLAWS_ACTIVE_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_MANA_BONUS_AFTER_KILL",
    name = ccb.content.text("Thrill of the Hunt"),
    points = 4,
    description = ccb.content.text("The wolf must hunt.  When you kill an otherworldly target, such as a triffid, a Nether monster, or one of the Fair Folk, you regain some mana."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "WEREWOLF_STRENGTH_BONUS",
    name = ccb.content.text("Primal Strength"),
    points = 4,
    description = ccb.content.text("A werewolf in their war form is a nightmare of claws and teeth and corded muscles, but in drawing on the might of the ancient hunters you have surpassed even that.  You gain an additional strength bonus while in war form, and may activate this trait to receive that bonus while in human or wolf form as well."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You feel a tension in your muscles."),
    cost = 1,
    cooldown = 5,
    enchantments = { "INLINE_ENCH_WEREWOLF_STRENGTH_BONUS_0", "INLINE_ENCH_WEREWOLF_STRENGTH_BONUS_1" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_BATTLE_FURY",
    name = ccb.content.text("Red-Handed Rage"),
    points = 4,
    description = ccb.content.text("You can enter a focused battle frenzy, suffering less pain and attacking faster while unarmed.  In addition, while in war form you enable two more claw techniques: a powerful knockback that downs your enemy, and a slash that hits multiple targets around you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 2,
    activation_message = ccb.content.text("The edges of your vision turn red."),
    enchantments = { "INLINE_ENCH_WEREWOLF_BATTLE_FURY_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CURE_OUTSIDE_EFFECTS",
    name = "Strike the Inner Outsider",
    points = 4,
    description = ccb.content.text("The People is meant to fight the things from Outside, but sometimes they must fight what is inside their own bodies.  You can focus your mana to try and cure most ailments caused by beings from the Nether, from Under the Hill and from wherever vampires come from.  The amount of mana this requires increases with the amount and severity of your afflictions, and will fail if your mana is insufficient."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    on_activate = "werewolf_cure_outside_effects",
}

-- Tier 4 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_SUPER_FAST_REGENERATION",
    name = ccb.content.text("Gift of Lunar Renewal"),
    points = 8,
    description = ccb.content.text("The moon cycles from new to full and back to new, and it always returns no matter how many cycles pass.  You can draw on that eternal renewal and enhance your natural regeneration to a truly monstrous level, healing grievous wounds in seconds and regrowing lost limbs in less than a minute."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 7,
    cooldown = 1,
    activation_message = ccb.content.text("Your natural regeneration kicks into overdrive."),
    on_process = "werewolf_super_fast_regeneration",
}

ccb.content.define_mutation {
    id = "WEREWOLF_SUMMON_FOG",
    name = ccb.content.text("Hunter's Haze"),
    points = 2,
    description = ccb.content.text("You can cause just enough change in a machine to confuse the rigid requirements of its programming, stunning it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_summon_fog_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_MOON_ARMOR",
    name = ccb.content.text("Lucent Armor"),
    points = 6,
    description = ccb.content.text("Regeneration and battle rage are potent weapons but sometimes the People need more protection.  You can summon up tangible moonlight that will protect you from the fists, claws, and fangs of your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 1,
    activation_message = ccb.content.text("A soft silvery glow springs forth around you."),
    enchantments = { "INLINE_ENCH_WEREWOLF_MOON_ARMOR_0" },
}

-- Tier 5 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
    name = ccb.content.text("Form of the Primal Hunter"),
    points = 10,
    description = ccb.content.text("While in wolf form, you can call on the spirit of the primal wolves of the mythic past and transform into an atavistic creature of nightmare, two meters high at the shoulder, with fur as thick as armor and teeth that can rend steel.  This form also regenerates the same as the war form does."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 3,
    cooldown = 1,
    on_activate = "werewolf_primal_form_on",
    on_process = "werewolf_hybrid_form_healing",
    on_deactivate = "werewolf_primal_form_off",
}

ccb.content.define_mutation {
    id = "WEREWOLF_PRIMAL_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Primal Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a gigantic atavistic wolf.  This provides the actual effects of primal form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_0", "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_1",
        "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_2", "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_3",
    },
    flags = { "MUTE", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    integrated_armor = { "integrated_werewolf_primal_form_fur", "integrated_werewolf_primal_form_fangs" },
    appearance = { id = "mon_direwolf", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CLOSE_TEAR_IN_REALITY",
    name = ccb.content.text("Mending Rent Veils"),
    points = 2,
    description = ccb.content.text("The world is falling apart but that is no reason to cease the hunt.  You can close a tear in reality, if you can get close enough to it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_close_tear_in_reality_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_WALK_THROUGH_WALLS",
    name = ccb.content.text("Ghostwalker"),
    points = 4,
    description = ccb.content.text("You can concentrate for a moment and turn into a spirit form that allows you to walk through walls."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 20,
    cooldown = 1,
    activation_message = ccb.content.text("You concentrate for a moment and sublimate your body into spirit."),
    on_activate = "werewolf_phase_through_walls",
    on_deactivate = "werewolf_stop_phasing",
}

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
