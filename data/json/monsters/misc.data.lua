local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_debug_mon",
    name = ccb.content.text_without_extraction("debug monster"),
    description = ccb.content.text_without_extraction("This monster exists only for testing purposes."),
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 10000,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 1,
    weakpoints = {
        {
            name = ccb.content.text("the knee"),
            armor_multiplier = { bullet = 0.5 },
            armor_penalty = { bullet = 25 },
            coverage = 25,
            id = "the knee",
        },
        {
            name = ccb.content.text("the bugs"),
            armor_multiplier = { bullet = 0.0 },
            armor_penalty = { bullet = 0 },
            coverage = 25,
            id = "the bugs",
        },
    },
    harvest = "exempt",
    regenerates = 50,
    regeneration_modifiers = { onfire = -5, corroding = 5 },
    flags = { "IMMOBILE", "NOT_HALLUCINATION", "FILTHY" },
    armor = { bullet = 100 },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_debug_bullet_sponge",
    copy_from = "pseudo_debug_mon",
    name = ccb.content.text_without_extraction("debug bullet sponge"),
    description = ccb.content.text_without_extraction("This monster exists only for testing purposes"),
    aggression = 0,
    morale = 0,
    regenerates = 5000,
}

-- NO_I18N
-- NO_I18N
-- Basic zombie strength
ccb.content.define_monster {
    id = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("weak debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a basic zombie."),
    looks_like = "mon_thing",
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "300000 g",
    hp = 1,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_skill = 100,
    grab_strength = 20,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 50,
    attacks = { { id = "grab", cooldown = 0, move_cost = 0 } },
    harvest = "exempt",
    regeneration_modifiers = { onfire = -5, corroding = 5 },
    flags = { "IMMOBILE", "SEES", "NOT_HALLUCINATION" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_mid",
    copy_from = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("middle-strength debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a Tier 2 grabbing zombie."),
    grab_strength = 50,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_strong",
    copy_from = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("strong debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a Tier 3 grabbing zombie."),
    grab_strength = 100,
}

-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_head",
    copy_from = "mon_debug_grabber",
    description = ccb.content.text_without_extraction("This grab testing monster has a strange fascination with your head."),
    attacks = {
        {
            id = "grab",
            cooldown = 0,
            move_cost = 0,
            body_part_types = { { id = "head", weight = 3 } },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_weak",
    copy_from = "mon_debug_grabber",
    mass = "100 kg",
    name = ccb.content.text_without_extraction("weak debug puller"),
    description = ccb.content.text_without_extraction("This 100kg monster exists only to test ranged pulls using the base 0.5 pull weight ratio."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 0.5 },
            cooldown = 0,
            move_cost = 0,
        },
    },
    inheritance = { add = { flags = { "ALL_SEEING" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_strong",
    copy_from = "mon_debug_puller_weak",
    name = ccb.content.text_without_extraction("strong debug puller"),
    description = ccb.content.text_without_extraction("This 100kg monster is strong enough to pull 250kg targets."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 2.5 },
            cooldown = 0,
            move_cost = 0,
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_incompetent",
    copy_from = "mon_debug_puller_strong",
    name = ccb.content.text_without_extraction("incompetent debug puller"),
    description = ccb.content.text_without_extraction("This monster exists only to fail pulling its target despite technically being able to.  Truly a cursed existence."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 2.5, pull_chance = 0 },
            cooldown = 0,
            move_cost = 0,
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_dragger",
    copy_from = "mon_debug_grabber",
    mass = "100 kg",
    name = ccb.content.text_without_extraction("debug dragger"),
    description = ccb.content.text_without_extraction("This monster exists to drag you behind it briefly."),
    attacks = {
        {
            id = "grab_drag",
            cooldown = 0,
            move_cost = 0,
            grab_settings = { break_distance = 999, move_cost_multiplier = 0.001 },
        },
        {
            id = "drag_followup",
            move_cost = 0,
            cooldown = 0,
            grab_settings = { break_distance = 999 },
            when = "allow_jabberwock_bite_jabberwock_1",
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_weakpoint_mon",
    name = ccb.content.text_without_extraction("weakpoint monster"),
    description = ccb.content.text_without_extraction("This monster exists only for weakpoint testing purposes."),
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 10000,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 1,
    families = { "prof_debug_weakpoint", { proficiency = "prof_debug_weakpoint_expert", bonus = 100 } },
    weakpoints = {
        {
            name = ccb.content.text("the belly"),
            armor_multiplier = { bullet = 0.5 },
            armor_penalty = { bullet = 25 },
            coverage = 50,
            attack_coverage = { all = 0.5 },
            target_effect = "stunned",
            id = "the belly",
        },
        {
            name = ccb.content.text("impossible to hit"),
            coverage = 100,
            difficulty = { all = 100.0 },
            id = "impossible to hit",
        },
        {
            name = ccb.content.text("the knee"),
            armor_multiplier = { bullet = 0.0 },
            armor_penalty = { bullet = 0 },
            damage_multiplier = { all = 2.0 },
            coverage = 25,
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    permanent = false,
                    intensity = { 0, 0 },
                    damage_percent = { 0, 100 },
                    chance = 50,
                    message = ccb.content.text("The %s is disorientated."),
                },
            },
            id = "the knee",
        },
    },
    harvest = "zombie_humanoid",
    flags = { "IMMOBILE", "NOT_HALLUCINATION", "FILTHY" },
    armor = { bullet = 100 },
}

-- Zombie faction so they don't attack a clear prop
-- ahh! it sees you!
ccb.content.define_monster {
    id = "mon_dragon_dummy",
    name = ccb.content.plural_text("ancient red dragon", "ancient red dragons"),
    description = ccb.content.text("A towering, hulking dragon, with tremendous, curving horns and shining red scales, its glowing maw peeled back in a hateful grimace as its eyes bore into yours."),
    body_type = "dog",
    default_faction = "zombie",
    difficulty_adjustment = 50,
    volume = "875000 ml",
    mass = "4535 g",
    hp = 1,
    materials = { "paper" },
    symbol = "D",
    color = "red",
    luminance = 8,
    aggression = 100,
    morale = 100,
    vision_day = 50,
    vision_night = 50,
    harvest = "exempt",
    flags = { "SEES" },
    death = {
        drops = "mon_dragon_dummy_drops",
        outcome = { message = ccb.content.text("The %s disintegrates!"), corpse = "NO_CORPSE" },
    },
}

-- Zombie faction so they don't attack a clear prop
-- ahh! it sees you!
ccb.content.define_monster {
    id = "mon_poly_special_test",
    name = ccb.content.plural_text("ancient red dragon", "ancient red dragons"),
    description = ccb.content.text("A towering, hulking dragon, with tremendous, curving horns and shining red scales, its glowing maw peeled back in a hateful grimace as its eyes bore into yours."),
    body_type = "dog",
    default_faction = "zombie",
    difficulty_adjustment = 50,
    volume = "875000 ml",
    mass = "4535 g",
    hp = 1,
    materials = { "paper" },
    symbol = "D",
    color = "red",
    luminance = 8,
    aggression = 100,
    morale = 100,
    vision_day = 50,
    vision_night = 50,
    harvest = "exempt",
    attacks = {
        {
            id = "debug_self_poly",
            cooldown = 50,
            kind = "polymorph_special",
            form = "mon_fungaloid",
            keep_speed = true,
            keep_hp = true,
            keep_anger = true,
        },
    },
    flags = { "SEES" },
    death = {
        drops = "mon_dragon_dummy_drops",
        outcome = { message = ccb.content.text("The %s disintegrates!"), corpse = "NO_CORPSE" },
    },
}

ccb.content.define_monster {
    id = "mon_generator",
    name = ccb.content.plural_text("generator", "generators"),
    description = ccb.content.text("Your precious generator, noisily humming away.  Defend it at all costs!"),
    default_faction = "player",
    species = { "UNKNOWN" },
    volume = "108500 ml",
    mass = "120 kg",
    hp = 500,
    speed = 100,
    materials = { "steel" },
    symbol = "4",
    color = "white",
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    attacks = { { reference = "GENERATOR", cooldown = 1 } },
    flags = { "NOHEAD", "ACIDPROOF", "IMMOBILE", "STUN_IMMUNE" },
    armor = { bash = 2, cut = 2, bullet = 2 },
    death = { outcome = { spell = { id = "death_gameover", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_hallu_mom",
    name = ccb.content.plural_text("your mother", "your mothers"),
    description = ccb.content.text("Mom?"),
    default_faction = "factionless",
    body_type = "human",
    species = { "HALLUCINATION" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 5,
    speed = 100,
    materials = { "flesh" },
    symbol = "@",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_skill = 3,
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    attacks = { { reference = "DISAPPEAR", cooldown = 20 } },
    flags = { "SEES", "HEARS", "NO_BREATHE", "SMELLS" },
    death = {
        outcome = {
            message = ccb.content.text("The %s disappears."),
            spell = { id = "death_guilt", min_level = 40 },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_hallu_multicooker",
    name = ccb.content.plural_text("evil multi-cooker", "evil multi-cookers"),
    description = ccb.content.text("The multi-cooker's got a mind of its own!  Look out!"),
    default_faction = "factionless",
    species = { "HALLUCINATION" },
    volume = "30000 ml",
    mass = "40750 g",
    hp = 5,
    speed = 50,
    materials = { "steel" },
    symbol = ";",
    color = "red",
    aggression = 100,
    morale = 100,
    melee_skill = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    attacks = { { reference = "DISAPPEAR", cooldown = 20 } },
    flags = { "SEES", "HEARS", "NO_BREATHE" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_hallu_mannequin",
    name = ccb.content.plural_text("mannequin", "mannequins"),
    description = ccb.content.text("Is this mannequin moving?"),
    default_faction = "factionless",
    species = { "HALLUCINATION" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 5,
    speed = 50,
    materials = { "wood" },
    symbol = "@",
    color = "brown",
    aggression = 100,
    morale = 100,
    melee_skill = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    attacks = { { reference = "DISAPPEAR", cooldown = 20 } },
    flags = { "SEES", "HEARS", "NO_BREATHE" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_hologram",
    name = ccb.content.plural_text("hologram", "holograms"),
    description = ccb.content.text("An image made from light, nearly identical to the real deal."),
    default_faction = "factionless",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 1,
    speed = 130,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 99,
    luminance = 16,
    dodge = 10,
    harvest = "exempt",
    fear_triggers = { "PLAYER_CLOSE" },
    pathing = { max_distance = 30 },
    flags = { "FLIES", "NO_BREATHE", "HARDTOSHOOT", "PET_WONT_FOLLOW" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_halloween_dragon",
    name = ccb.content.plural_text("inflatable dragon", "inflatable dragons"),
    description = ccb.content.text("A giant inflatable dragon for Halloween decorations."),
    looks_like = "mon_dragon_dummy",
    default_faction = "factionless",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 1,
    speed = 150,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 2,
    luminance = 16,
    dodge = 6,
    harvest = "exempt",
    fear_triggers = { "PLAYER_CLOSE" },
    attacks = { { reference = "DISAPPEAR", cooldown = 200 } },
    flags = { "FLIES", "NO_BREATHE", "NOT_HALLUCINATION", "HARDTOSHOOT" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_halloween_ghost",
    name = ccb.content.plural_text("inflatable ghost", "inflatable ghosts"),
    description = ccb.content.text("A human-sized inflatable ghost for Halloween decorations."),
    looks_like = "mon_darkman",
    default_faction = "factionless",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 1,
    speed = 150,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 2,
    luminance = 16,
    dodge = 6,
    harvest = "exempt",
    fear_triggers = { "PLAYER_CLOSE" },
    attacks = { { reference = "DISAPPEAR", cooldown = 200 } },
    flags = { "FLIES", "NO_BREATHE", "NOT_HALLUCINATION", "HARDTOSHOOT" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}
