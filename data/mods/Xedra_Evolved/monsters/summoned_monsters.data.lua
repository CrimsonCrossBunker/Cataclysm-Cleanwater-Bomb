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

-- armor penetration here represents that you'll literally surrounded by thorns
ccb.content.define_monster {
    id = "mon_spring_changeling_bashing_vine",
    looks_like = "mon_tanglevine",
    name = ccb.content.plural_text("tanglevine", "tanglevines"),
    description = ccb.content.text("A thick mass of animated vine, lashing back and forth at anything that comes within reach.  Long thorns grow from its sides."),
    species = { "PLANT", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    default_faction = "changeling",
    volume = "92500 ml",
    mass = "120 kg",
    hp = 60,
    speed = 80,
    materials = { "veggy" },
    symbol = "V",
    color = "green",
    aggression = 60,
    morale = 200,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 1,
    grab_strength = 70,
    vision_day = 10,
    vision_night = 10,
    bleed_rate = 0,
    regenerates = 1,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 3,
            range = 4,
            damage = { { type = "stab", amount = 2 } },
            grab_settings = { exclusive = true, pull_chance = 100, pull_weight_ratio = 1 },
            avatar_hit = ccb.content.text_without_extraction("%1$s lashes out and curls around your %2$s!"),
            npc_hit = ccb.content.text_without_extraction("%1$s lashes out and curls around <npcname>'s %2$s!"),
            avatar_miss = ccb.content.text_without_extraction("%s lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%1$s lashes out at your %2$s!"),
            npc_no_damage = ccb.content.text_without_extraction("%1$s lashes out and curls around <npcname>'s %2$s!"),
        },
        {
            id = "thorn_squeeze",
            cooldown = 3,
            move_cost = 100,
            damage = { { type = "stab", amount = 6, penetration = 30 } },
            avatar_hit = ccb.content.text("%1$s squeezes and its thorns dig into your %2$s!"),
            npc_hit = ccb.content.text("%1$s squeezes <npcname>!"),
            avatar_miss = ccb.content.text("%1$s tries to squeeze you, but you fight back!"),
            npc_miss = ccb.content.text("%1$s tries to squeeze <npcname>, but they fight back!"),
            avatar_no_damage = ccb.content.text("%1$s squeezes your %2$s, but fails to penetrate your armor."),
            npc_no_damage = ccb.content.text("%1$s squeezes <npcname>, but fails to penetrate their armor."),
            kind = "melee",
            when = "allow_jabberwock_bite_jabberwock_1",
        },
    },
    dodge = 4,
    flags = { "HEARS", "GOODHEARING", "IMMOBILE", "NOHEAD", "HARDTOSHOOT", "GRABS", "PLASTIC" },
    armor = { bash = 18, stab = 10, electric = 3, bullet = 22 },
    death = {
        outcome = {
            message = ccb.content.text("The %s rots into nothingness in moments."),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_solar_spirit_triffid_summon",
    copy_from = "mon_solar_spirit",
    looks_like = "mon_solar_spirit",
    default_faction = "triffid",
    aggression = 15,
    species = { "NATURE_SPIRIT", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_vinebeast_summon",
    copy_from = "mon_vinebeast",
    species = { "PLANT", "SUMMONED_CREATURE" },
    death = {
        outcome = {
            message = ccb.content.text("The %s rots into nothingness in moments."),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_shadow_summon",
    copy_from = "mon_shadow",
    species = { "NETHER", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = { remove = { attacks = { "DISAPPEAR" } } },
}

ccb.content.define_monster {
    id = "mon_xe_kreck_summoned",
    copy_from = "mon_kreck",
    species = { "NETHER", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
}

ccb.content.define_monster { id = "mon_shifter_non_player", copy_from = "mon_shifter", default_faction = "nightmares" }

ccb.content.define_monster { id = "mon_shifter_feral", copy_from = "mon_shifter", default_faction = "zombie" }

ccb.content.define_monster { id = "mon_ophanim_non_player", copy_from = "mon_ophanim", default_faction = "nightmares" }

ccb.content.define_monster { id = "mon_duplicator_non_player", copy_from = "mon_duplicator", default_faction = "nightmares" }
