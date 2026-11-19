local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_hedge_armored_warrior_mace",
    copy_from = "mon_feral_armored_mace",
    name = ccb.content.plural_text("armored warrior with mace", "armored warriors with maces"),
    looks_like = "mon_feral_armored_mace",
    description = ccb.content.text("Clad in ancient armor and with a mace in hand, this warrior was summoned by magic to defend you."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = { remove = { attacks = { "BROWSE", "EAT_FOOD", "PARROT" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_hedge_armored_warrior_axe",
    copy_from = "mon_feral_armored_battleaxe",
    name = ccb.content.plural_text("armored warrior with axe", "armored warriors with axes"),
    looks_like = "mon_feral_armored_battleaxe",
    description = ccb.content.text("Clad in ancient armor and with a battleaxe in hand, this warrior was summoned by magic to defend you."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = { remove = { attacks = { "BROWSE", "EAT_FOOD", "PARROT" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_hedge_armed_warrior_spear",
    copy_from = "mon_feral_sapien_spear",
    name = ccb.content.plural_text("warrior with spear", "warriors with spears"),
    looks_like = "mon_feral_sapien_spear",
    description = ccb.content.text("Clad in leather armor and with a spear in hand, this warrior was summoned by magic to defend you."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = { remove = { attacks = { "PARROT_AT_DANGER" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_hedge_armed_warrior_sword",
    copy_from = "mon_feral_fancy_rapier",
    name = ccb.content.plural_text("warrior with sword", "warriors with sword"),
    looks_like = "mon_feral_fancy_rapier",
    description = ccb.content.text("Clad in leather armor and with a sword in hand, this warrior was summoned by magic to defend you."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = {
        add = { armor = { bash = 9, cut = 14, acid = 4, bullet = 18 } },
        remove = { attacks = { "BROWSE", "EAT_FOOD", "PARROT" } },
    },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_samhain_ghost_mace",
    copy_from = "mon_feral_armored_mace",
    name = ccb.content.plural_text("shadowy warrior", "shadowy warriors"),
    looks_like = "mon_memory",
    description = ccb.content.text("A shadowy figure, only barely visible as more than a mist, but the silhouette of armor and weapons are obvious."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    melee_skill = 5,
    speed = 95,
    vision_night = 15,
    inheritance = { add = { flags = { "SUNDEATH" } }, remove = { attacks = { "BROWSE", "EAT_FOOD", "PARROT" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_samhain_ghost_axe",
    copy_from = "mon_feral_armored_battleaxe",
    name = ccb.content.plural_text("shadowy warrior", "shadowy warriors"),
    looks_like = "mon_memory",
    description = ccb.content.text("A shadowy figure, only barely visible as more than a mist, but the silhouette of armor and weapons are obvious."),
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    melee_skill = 5,
    speed = 95,
    vision_night = 15,
    inheritance = { add = { flags = { "SUNDEATH" } }, remove = { attacks = { "BROWSE", "EAT_FOOD", "PARROT" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_samhain_ghost_spear",
    copy_from = "mon_feral_sapien_spear",
    name = ccb.content.plural_text("shadowy warrior", "shadowy warriors"),
    description = ccb.content.text("A shadowy figure, only barely visible as more than a mist, but the silhouette of armor and weapons are obvious."),
    looks_like = "mon_memory",
    default_faction = "player",
    species = { "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    melee_skill = 5,
    speed = 95,
    vision_night = 15,
    armor = { bash = 20, cut = 20, stab = 15, bullet = 12 },
    inheritance = { add = { flags = { "SUNDEATH" } }, remove = { attacks = { "PARROT_AT_DANGER" } } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_fetch_daffodil_warrior_player",
    copy_from = "mon_fetch_daffodil_warrior",
    looks_like = "mon_fetch_daffodil_warrior",
    default_faction = "player",
    species = { "CHANGELING", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
}
