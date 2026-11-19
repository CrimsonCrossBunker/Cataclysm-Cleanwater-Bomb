local ccb = require("ccb")

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
