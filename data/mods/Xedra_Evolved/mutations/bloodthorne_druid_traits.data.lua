local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
    name = ccb.content.text("Heartvines"),
    points = 0,
    description = ccb.content.text("After being infused with the power of nature, part of the ritual of the Bloodthorne Druids was the implantation of a symbiotic plant.  You aren't sure where it came from or what its natural habitat is, but now it's a part of you.  You require slightly more food and water than normal to feed it, but have the power to fight back against the blood-drinkers.\n\nVampire blood taken from their dying hearts and stolen power from the wood-elemental fey will both fuel your Heartvines.  Enough of both will allow you to unlock new gifts."),
    purifiable = false,
    valid = false,
    visibility = 2,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_0" },
    species_anger = { THORNBEAST = -100 },
    flags = { "ATTUNEMENT", "TREE_COMMUNION_PLUS", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
}

-- true
ccb.content.define_mutation {
    id = "BLOODTHORNE_SORCERY",
    name = ccb.content.text("Thornwitchery"),
    points = 0,
    description = ccb.content.text("This is the school trait for Bloodthorne Druids.  You shouldn't see it directly."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
    name = ccb.content.text("Heartwhip"),
    points = 2,
    description = ccb.content.text("You can cause a sudden outgrowth of your Heartvine into a living whip-like weapon, ready to scourge the undead."),
    purifiable = false,
    valid = false,
    active = true,
    activation_message = ccb.content.text("A vine erupts from your arm and wraps around your wrist before snugly fitting itself into your hand."),
    activation_setup_only = true,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP_0" },
    on_activate = "bloodthorne_summon_heartwhip",
    on_deactivate = "bloodthorne_unsummon_heartwhip",
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_REGAIN_BLOOD",
    name = ccb.content.text("Woodblood Restoration"),
    points = 2,
    description = ccb.content.text("The first principle of defeating the blood-drinkers is to avoid losing your blood.  While standing on natural foliage, you can use this spell to replenish any lost blood."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_regain_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_STOP_BLEEDING",
    name = ccb.content.text("Thorn-sealed Wounds"),
    points = 2,
    description = ccb.content.text("When bleeding, your heartvines can pull the wound closed and stop it.  This is painful, but will prevent further bleeding.  If there are any vampires or their servants nearby, the heartvines will also lash out at them as they pull the wound closed."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_stop_bleeding_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
    name = ccb.content.text("Sanguinary Sapshield"),
    points = 2,
    description = ccb.content.text("The most insidious threat the blood-drinkers is that their condition is infectious, and so they convert those who would oppose them into their sympathizers.  Your heartvines will definitively prevent this outcome, but you still must defend yourself against the curse.  While in the wild, you can draw on the wild's power to protect yourself."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_prevent_vampirism_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE",
    name = ccb.content.text("Verdant Scourge"),
    points = 2,
    description = ccb.content.text("You can bring the fury of nature to bear on your enemies.  When a target is in thick foliage, you can cause the plants to grow long thorns and pierce them."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_whip_targets_in_nature_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_GAIN_STRENGTH_DEXTERITY_BUFF",
    name = ccb.content.text("Verdurous Prowess"),
    points = 2,
    description = ccb.content.text("The forest spirits gain constant power through their connection to the wild, and while the bloodthorne druids do not have that level of connection they can borrow it for a time.  You may increase your strength, dexterity, and hit points.  This bonus is <color_green>increased in the wilderness</color>."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_gain_strength_dexterity_buff_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
    name = ccb.content.text("Balm of Nature"),
    points = 3,
    description = ccb.content.text("Your heartvines frequently cause you pain on their own, to say nothing of the wounds you suffer fighting the vampires, but now it doesn't seem to affect you as much.  Your strength, dexterity, and speed are penalized less by the pain you feel."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES_0" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
    name = ccb.content.text("In Tune with the Wild"),
    points = 2,
    description = ccb.content.text("Thornwitchery draws its power from the wild places, and while there you grow stronger.  Your mana recovery is increased when in the wilderness away from civilization."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_BONUS_MANA_REGEN_0" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_AURA_OF_VINES",
    name = ccb.content.text("Entanglement of Vines"),
    points = 2,
    description = ccb.content.text("Your heartvines have grown enough that you can extend numerous vines around you.  These vines will retaliate against attackers, defend you, assist you in casting magicks if your hands are full, allow you to descend buildings by grasping handholds, and alert you to nearby dangers."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 3,
    activation_message = ccb.content.text("A multitude of vines burst from your flesh!"),
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT",
    name = ccb.content.text_without_extraction("Entanglement of Vines"),
    points = 2,
    visibility = 10,
    ugliness = 6,
    description = ccb.content.text_without_extraction("The active trait for Entanglement of Vines.  You shouldn't see this."),
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT_0" },
    flags = { "SUBTLE_SPELL", "VINE_RAPPEL" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
    name = ccb.content.text("Drinking Crimson Rain"),
    points = 4,
    description = ccb.content.text("Vampires are known for drinking blood, but plants will drink anything that sinks into the soil.  This spell draws all blood spilled onto the earth in the area around you through the roots to be absorbed by your heartvines, healing you."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_heal_from_spilled_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
    name = ccb.content.text("Thornhound's Beacon"),
    points = 5,
    description = ccb.content.text("The forest spirits will not answer your call but your heartvine will.  When standing on verdant ground, you may animate a twisted mass of thorns to attack your enemies."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_summon_thornwight_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
    name = ccb.content.text("Bramble Ichor"),
    points = 3,
    description = ccb.content.text("The sap that flows through your veins has thickened, and your heartvines do their keep to keep it in your body.  You bleed more slowly."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SLOWER_BLEEDING_0" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
    name = ccb.content.text("Henge of Iron Thorns"),
    points = 6,
    description = ccb.content.text("When one of the blood-drinkers or their servants is on verdant ground, you can cause a massive tangle of thorns to grow and imprison them."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_create_thorn_prison_spell = 1 },
}
