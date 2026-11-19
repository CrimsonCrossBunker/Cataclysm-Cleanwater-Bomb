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
