local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_master",
    name = ccb.content.plural_text("zombie master", "zombie masters"),
    description = ccb.content.text("This zombie's features have tightened, its lips pulled back into an unnatural grin, revealing rows of blackened teeth beneath large, piercing eyes.  It stands tall and its movements are fluid and tightly controlled.  A feeling of danger permeates the surrounding air, and the light that falls on it seems somehow harsher and more glaring."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 20,
    hp = 180,
    speed = 90,
    color = "red_cyan",
    scents_tracked = { "sc_human", "sc_fetid" },
    aggression = 5,
    melee_skill = 5,
    melee_sides = 6,
    dodge = 4,
    bleed_rate = 0,
    vision_day = 50,
    vision_night = 5,
    pathing = { max_distance = 10, open_doors = true, avoid_traps = true, avoid_sharp = true },
    attacks = { { reference = "UPGRADE", cooldown = 10 } },
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    upgrade = false,
    armor = { bash = 2, cut = 2, bullet = 2, electric = 3 },
    inheritance = {
        add = {
            flags = {
                "SMELLS",
                "HAS_MIND",
                "CAN_OPEN_DOORS",
                "PRIORITIZE_TARGETS",
                "NO_FUNG_DMG",
                "PATH_AVOID_DANGER",
            },
        },
        remove = { flags = { "STUMBLES" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_necro",
    name = ccb.content.plural_text("zombie necromancer", "zombie necromancers"),
    description = ccb.content.text("A twisted mockery of the human form, emaciated, with jet-black skin and glowing red eyes.  It is somehow painful to look at, awakening fears deep within your psyche, and even the surrounding air seems more sinister, somehow darker and more dangerous."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    difficulty_adjustment = 20,
    hp = 100,
    speed = 100,
    color = "dark_gray",
    scents_tracked = { "sc_human", "sc_fetid" },
    aggression = 5,
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 2,
    bleed_rate = 0,
    vision_day = 50,
    vision_night = 5,
    pathing = { max_distance = 10, open_doors = true, avoid_traps = true, avoid_sharp = true },
    attacks = { { reference = "RESURRECT", cooldown = 0 } },
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    upgrade = false,
    armor = { electric = 2 },
    inheritance = {
        add = {
            flags = {
                "SMELLS",
                "HAS_MIND",
                "CAN_OPEN_DOORS",
                "PRIORITIZE_TARGETS",
                "NO_FUNG_DMG",
                "PATH_AVOID_DANGER",
            },
        },
        remove = { flags = { "STUMBLES" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_necro_boomer",
    name = ccb.content.plural_text("zombie necro-boomer", "zombie necro-boomers"),
    description = ccb.content.text("At first this creature looks like nothing more than a grotesque and oleaginous husk, bloated and punctured by jet-black pustules.  When approached, its glowing red eyes and an aching grin take form; its skin tears and its guts teem with unmatched fecundity, as its gaze inspires fear of nothing less than cosmic, inhuman ecstasy."),
    copy_from = "mon_zombie_necro",
    volume = "108500 ml",
    mass = "120 kg",
    difficulty_adjustment = 25,
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_death_drops", weight = 65 },
                { id = "zed_dust", weight = 100 },
            },
        },
        outcome = {
            spell = { id = "necro_boomer_death", hit_self = true },
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s lets out an unholy screech, and the corpses around it stir."),
        },
    },
}

-- Summoner as in 'to request the presence of' not 'to conjure up by magic'
ccb.content.define_monster {
    id = "mon_zombie_summoner",
    name = ccb.content.plural_text("zombie summoner", "zombie summoners"),
    description = ccb.content.text("This zombie stands straight up and moves with purposeful motions, its gaze sweeping its surrounding as it moves.  As it looks, nearby zombies also turn and look in the same direction for a moment."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    difficulty_adjustment = 20,
    hp = 150,
    speed = 95,
    color = "black_red",
    scents_tracked = { "sc_human", "sc_fetid" },
    aggression = 5,
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 3,
    bleed_rate = 0,
    vision_day = 50,
    vision_night = 5,
    pathing = { max_distance = 10, open_doors = true, avoid_traps = true, avoid_sharp = true },
    attacks = {
        {
            id = "mon_zombie_summoner_summon_hordes",
            spell = { id = "mon_zombie_summoner_summon_hordes_spell", min_level = 1 },
            casting_message = ccb.content.text("%1$s fixes %3$s with a stare."),
            cooldown = 25,
            kind = "spell",
        },
    },
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    upgrade = false,
    armor = { bash = 2, cut = 2, bullet = 2, electric = 3 },
    inheritance = {
        add = {
            flags = {
                "SMELLS",
                "HAS_MIND",
                "CAN_OPEN_DOORS",
                "PRIORITIZE_TARGETS",
                "NO_FUNG_DMG",
                "PATH_AVOID_DANGER",
            },
        },
        remove = { flags = { "STUMBLES" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_runner",
    name = ccb.content.plural_text("zombie runner", "zombie runners"),
    description = ccb.content.text("This recently-risen body moves quickly, darting its head back and forth and gnawing at its hands."),
    copy_from = "mon_zombie_base",
    speed = 105,
    color = "brown_white",
    melee_dice = 4,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid", cooldown = 10 },
        {
            id = "bite_humanoid",
            cooldown = 5,
            damage = { { type = "stab", amount = 10, armor_multiplier = 0.7 } },
        },
    },
    upgrade = { half_life = 140, monster = "mon_zombie_hunter" },
    fungalize_into = "mon_zombie_runner_dusted",
    inheritance = { add = { flags = { "CLUMSY_ATTACKS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_regenerating",
    name = ccb.content.plural_text("regenerating zombie", "regenerating zombies"),
    description = ccb.content.text("A hairless zombie.  Its pale, pinkish flesh appears to be squirming and moving across its body, quickly covering and fixing any wounds that it receives.  Its clothing is riddled with holes, suggesting someone else tried, and failed, to take it down."),
    copy_from = "mon_zombie_base",
    hp = 60,
    speed = 90,
    color = "red_cyan",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_dice = 3,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    regenerates = 12,
    upgrade = { half_life = 140, monster = "mon_zombie_regenerating_hunter" },
    inheritance = { add = { flags = { "SMELLS", "REVIVES_HEALTHY", "NO_NECRO" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_regenerating_hunter",
    name = ccb.content.plural_text("fleshy hunter", "fleshy hunters"),
    description = ccb.content.text("A zombie prowling around on all fours; its exposed muscles churn and snake, unraveling before restitching themselves elsewhere along its red-raw figure."),
    copy_from = "mon_zombie_hunter",
    species = { "ZOMBIE" },
    regenerates = 12,
    color = "red_cyan",
    upgrade = { half_life = 140, monster = "mon_zombie_regenerating_final" },
    inheritance = { add = { move_skills = { climb = 4 }, flags = { "SMELLS", "REVIVES_HEALTHY", "NO_NECRO" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_regenerating_final",
    name = ccb.content.plural_text("regenerating abomination", "regenerating abominations"),
    description = ccb.content.text("This zombie hardly resembles a human anymore - Its skeleton has been repeatedly dismantled and reassembled into a horrid quadrupedal shape, like some sort of mismatched action figure.  Slick, bloodied flesh writhes on its frame with an almost viscous quality, digesting and reconstituting itself in an endless ouroboros of undead flesh."),
    copy_from = "mon_zombie_predator",
    hp = 100,
    regenerates = 12,
    color = "red_cyan",
    attacks = {
        {
            cooldown = 10,
            damage = { { type = "stab", amount = 6, armor_multiplier = 0.2 } },
            kind = "bite",
        },
        {
            id = "stretch_attack",
            cooldown = 10,
            move_cost = 50,
            range = 2,
            damage = { { type = "bash", amount = 7 } },
        },
        { id = "ranged_pull", cooldown = 30, grab_settings = { pull_weight_ratio = 1 } },
        { id = "grab_drag", cooldown = 5 },
        { id = "drag_followup" },
        { id = "longswipe", cooldown = 15 },
    },
    armor = { electric = 1 },
    bleed_rate = 0,
    inheritance = { add = { flags = { "SMELLS", "REVIVES_HEALTHY", "NO_NECRO" } } },
}
