local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_FIRE_IMMUNE",
    name = ccb.content.text("Inured to Flame"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_SKIN_3" },
    secondary_prerequisites = { "SALAMANDER_NO_SMOKE_DAMAGE" },
    description = ccb.content.text("A creature born and bred of fire, the Salamander is utterly immune to heat and flame of any kind.  However, they will take additional damage from cold."),
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_FIRE_IMMUNE_0" },
    flags = { "HEAT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLY_IN_FIRE_SPELL",
    name = ccb.content.text("Burning Ascension"),
    points = 6,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to hurl themselves skyward while standing in a fire."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_fire_fly = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_MANA_BONUS",
    name = ccb.content.text("Mana Bonfire"),
    points = 8,
    description = ccb.content.text("The Salamander is a font of mana, like a well-fueled bonfire.  25% extra mana."),
    prerequisites = { "SALAMANDER_INT_BONUS" },
    replacements = { "SALAMANDER_FAST_CAST" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_MANA_BONUS_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FAST_CAST",
    name = ccb.content.text("Crackling Mana Bonfire"),
    points = 10,
    description = ccb.content.text("The Salamander's mana surges within them, ready to burst out at the slightly opportunity.  25% extra mana and -15% spell casting speed."),
    prerequisites = { "SALAMANDER_INT_BONUS" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_FAST_CAST_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_WINGS",
    name = ccb.content.text("On Wings of Flame"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("With an act of will, you can extend wings of flame from your back.  These aetherial wings are not hindered by clothing or armor, but also do not have enough substance to allow you to fly.  However, they can break a fall or be used in combat."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = "3 s",
    activation_message = ccb.content.text("Flaming wings extend from your back!"),
    enchantments = { "ench_salamander_wings_flame" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_WINGS_ON",
    name = ccb.content.text("On Wings of Flame (active)"),
    points = 7,
    visibility = 10,
    ugliness = 0,
    description = ccb.content.text("You are extending wings of aetherial flame from your back.  You can attack enemies with them and will not take damage from falls."),
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    valid = false,
    enchantments = { "ench_salamander_wings_flame" },
    transform = {
        target = "SALAMANDER_SUMMON_WINGS",
        message = ccb.content.text("The wings on your back gutter and die."),
        active = false,
        moves = 50,
    },
}

ccb.content.define_mutation {
    id = "SALAMANDER_PREVENT_DEATH",
    name = ccb.content.text("In Flames, Reborn Like the Phoenix"),
    points = 12,
    description = ccb.content.text("Like the bird of legend, the Salamander can recreate themselves from the heat and smoke of a fire.  If their body takes fatal damage while standing in a fire, their fae spirit will use those flames to renew themselves.  This can generally occur no more often than once every 14 days, though there is a small chance it can occur more often."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    secondary_prerequisites = { "SALAMANDER_SMOKE_FORM" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLAME_IMMUNITY_ALLY",
    name = ccb.content.text("Anointed with Incandescence"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to make an ally immune to heat and flame."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_ally_flame_immune_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EXPLOSION_AND_HEAL",
    name = ccb.content.text("The Phoenix's Last Cry"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability create a massive explosion of flames around themselves and draw on its energy to increase their healing rate."),
    prerequisites = { "SALAMANDER_PREVENT_DEATH" },
    secondary_prerequisites = { "SALAMANDER_SUMMON_FIREBIRD" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_explosion_and_heal_spell = 1 },
}
