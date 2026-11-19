local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_vortex",
    name = ccb.content.plural_text("vortex", "vortexes"),
    description = ccb.content.text("A twisting spot in the air, with some kind of morphing mass at its center."),
    default_faction = "vortex",
    species = { "UNKNOWN" },
    difficulty_adjustment = 2,
    volume = "30000 ml",
    mass = "40750 g",
    hp = 20,
    speed = 120,
    materials = { "powder" },
    symbol = "V",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_damage = { { type = "cut", amount = 0 } },
    harvest = "exempt",
    flags = {
        "HEARS", "GOODHEARING", "STUMBLES", "BIOLOGICALPROOF", "NOHEAD", "HARDTOSHOOT", "FLIES",
        "PLASTIC", "NO_BREATHE", "NOGIB",
    },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}

ccb.content.define_monster {
    id = "mon_shifting_mass",
    name = ccb.content.plural_text("shifting mass", "shifting masses"),
    description = ccb.content.text("An animate blotch of conflicting symmetries, erratically hovering through the air.  It's not even real enough to hold a stable shape, and its entire form is constantly in flux.  You can see through it - not as if it were transparent, but as if it isn't quite fully here."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "1000 ml",
    mass = "0 g",
    hp = 10,
    speed = 110,
    symbol = "Q",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 2,
    attacks = {
        {
            spell = { id = "shifting_mass_attack", min_level = 1 },
            cooldown = 1,
            casting_message = ccb.content.text("The shifting mass passes through you as if you were an illusion, and a slight wave of fatigue washes over you."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "BIOLOGICALPROOF", "HEARS" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_impossible_shape",
    name = ccb.content.plural_text("impossible shape", "impossible shapes"),
    description = ccb.content.text("A twisted shape floating in midair; its angles don't seem to quite add up - it hurts to look at.  Is it inanimate?  Alive?  Something else?  You can't make heads or tails of it at all, but you can see through it - not as if it were transparent, but as if it isn't quite fully here."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    speed = 90,
    hp = 30,
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "impossible_shape_attack", min_level = 1 },
            cooldown = 5,
            casting_message = ccb.content.text("You get a very clear view of the impossible shape."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "BIOLOGICALPROOF", "RANGED_ATTACKER", "IMMOBILE" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_absence",
    name = ccb.content.plural_text("absence", "absences"),
    description = ccb.content.text("Every sense you have claims this space to be empty, but your mind is not fooled.  There is an emptiness here that is far from natural or safe."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 150,
    speed = 40,
    symbol = "O",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "absence_capture_attack", min_level = 1 },
            cooldown = 10,
            casting_message = ccb.content.text("The absence intensifies."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "BIOLOGICALPROOF", "RANGED_ATTACKER", "IMMOBILE" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s returns to normal levels of empty."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_giant_appendage",
    name = ccb.content.plural_text("giant appendage", "giant appendages"),
    description = ccb.content.text("A gigantic, probing appendage blindly feeling the area around it.  All of your senses scream at you that it's the size of a truck, and yet it only takes up about as much space in the world as you do.  It seems to be jutting through a portal, suggesting that it's merely a smaller extension of something much larger."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 1000000000,
    speed = 90,
    symbol = "A",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    melee_skill = 6,
    melee_dice = 5,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 14 } },
    families = { "prof_wp_netherium_abomination" },
    weakpoint_sets = { "wps_netherium_abomination" },
    flags = { "FLIES", "NO_BREATHE", "BIOLOGICALPROOF", "STUMBLES" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s is pulled back through the closing portal."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_flatlander",
    name = ccb.content.plural_text("flatlander", "flatlanders"),
    description = ccb.content.text("An oblong figure floating parallel with the ground, some feet in the air like a piece of paper - Its far thinner than one as well, to the point it would be invisible if looked at with the right angle."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 30,
    speed = 100,
    symbol = "|",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "flatlander_attack", min_level = 1 },
            cooldown = 10,
            casting_message = ccb.content.text("Standing close to the %s, your body is violently dragged down to the second dimension.  You're there for only an instant but the experience is enough to send you reeling."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "BIOLOGICALPROOF", "SEES", "HEARS", "RANGED_ATTACKER" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("Your memory can't decide whether the %s was even there in the first place."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_memory",
    name = ccb.content.plural_text("memory", "memories"),
    description = ccb.content.text("The silhouette of a human body, reaching towards you like it needs help.  It has no eyes, but you can still feel it staring through you."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 25,
    speed = 100,
    symbol = "O",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    grab_strength = 20,
    attacks = { { id = "grab", cooldown = 2 }, { reference = "PARROT", cooldown = 4 } },
    flags = { "NO_BREATHE", "HAS_MIND", "GRABS", "BIOLOGICALPROOF", "PUSH_MON", "GROUP_BASH" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s begins to cry as it disappears."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_swarm_structure",
    name = ccb.content.plural_text("swarm structure", "swarm structures"),
    description = ccb.content.text("Your mind can't decide if this is a vast structure, or an endless swarm of tiny flying sharp things.  The only thing you know for sure is that it is far too large to fit in the space it occupies."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 80,
    speed = 80,
    symbol = "S",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    attacks = {
        {
            spell = { id = "mon_swarm_structure_attack", min_level = 1 },
            cooldown = 6,
            casting_message = ccb.content.text("The integrity of spacetime is violated."),
            kind = "spell",
        },
    },
    flags = { "IMMOBILE", "NO_BREATHE", "BIOLOGICALPROOF", "SEES", "HEARS", "RANGED_ATTACKER" },
    armor = { bash = 5, cut = 5, bullet = 5 },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("Your memory can't decide whether the %s was even there in the first place."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_twisting_blade",
    name = ccb.content.plural_text("twisting blade", "twisting blades"),
    description = ccb.content.text("You are uncertain whether this dwarfs you or you dwarf it.  Its exact shape and number of dimensions is constantly changing, but it is always sharp enough to cut a moment in half."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 30,
    speed = 60,
    symbol = "B",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "mon_twisting_blade_attack", min_level = 1 },
            cooldown = 1,
            casting_message = ccb.content.text("You are cut in ways worse than physical."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "BIOLOGICALPROOF", "SEES", "HEARS", "RANGED_ATTACKER" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("Your memory can't decide whether the %s was even there in the first place."),
        },
    },
}

-- No NETHER or it will run away at low HP
ccb.content.define_monster {
    id = "mon_archunk_weak",
    name = ccb.content.plural_text("chunk of unknown material", "chunks of unknown material"),
    description = ccb.content.text("This formless, pitch-black mass wriggles on the ground as it reshapes itself before your eyes.  It slowly drags itself towards you with many tendrils of varied sizes.  As it gets closer to you, its wriggling intensifies as if it reacted to you."),
    default_faction = "nether_player_hate",
    species = { "HORROR" },
    volume = "62500 ml",
    mass = "11110 g",
    hp = 225,
    symbol = "H",
    color = "light_gray",
    aggression = 100,
    morale = 100,
    anger_triggers = { "HURT" },
    speed = 75,
    bleed_rate = 0,
    attacks = {
        { id = "tentacle", cooldown = 2 },
        {
            spell = { id = "create_noise", hit_self = true },
            cooldown = 20,
            casting_message = ccb.content.text("The chunk twists and tears itself as it reacts to your presence!"),
            kind = "spell",
        },
    },
    flags = {
        "COLDPROOF",
        "SEES",
        "HEARS",
        "BIOLOGICALPROOF",
        "NO_BREATHE",
        "STUN_IMMUNE",
        "NOHEAD",
        "ACIDPROOF",
    },
    armor = { bash = 20, cut = 20, stab = 20, heat = 20, bullet = 20, electric = 20 },
    death = {
        drops = "ps_artifact_weak",
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The material stabilizes and reforms itself into a small chunk of unknown composition."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_archunk_medium",
    copy_from = "mon_archunk_weak",
    name = ccb.content.plural_text("pulsating chunk of unknown material", "pulsating chunks of unknown material"),
    description = ccb.content.text("This formless, pitch-black mass wriggles and pulses on the ground as it reshapes itself before your eyes.  It slowly drags itself towards you with many tendrils of varied sizes.  As it gets closer to you, its pulsing intensifies as if it reacted to you."),
    symbol = "H",
    hp = 315,
    color = "dark_gray",
    armor = { bash = 25, cut = 25, stab = 25, heat = 25, bullet = 25, electric = 25 },
    death = { drops = "ps_artifact_medium" },
}

ccb.content.define_monster {
    id = "mon_archunk_strong",
    copy_from = "mon_archunk_weak",
    name = ccb.content.plural_text("resonating chunk of unknown material", "resonating chunks of unknown material"),
    description = ccb.content.text("This formless, pitch-black mass wriggles violently and noisily on the ground as it reshapes itself before your eyes.  It slowly drags itself towards you with many tendrils of varied sizes sparkling with electricity.  As it gets closer to you, its wriggling intensifies and its sparks grow brighter as if it reacted to you."),
    symbol = "H",
    hp = 445,
    color = "dark_gray",
    emissions = { { id = "emit_shock_cloud", delay = "1 s" } },
    armor = { bash = 30, cut = 30, stab = 30, heat = 30, bullet = 30, electric = 30 },
    death = { drops = "ps_artifact_strong" },
}

ccb.content.define_monster {
    id = "mon_pale_reflection",
    name = ccb.content.plural_text("pale reflection", "pale reflections"),
    description = ccb.content.text("This looks nothing like you.  It's barely real.  So why does your mind keep mistaking it for you?"),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 35,
    speed = 80,
    symbol = "O",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 10 } },
    attacks = {
        {
            casting_message = ccb.content.text("You can feel the %s."),
            spell = { id = "mon_reflection_attack", min_level = 1, hit_self = false },
            cooldown = 5,
            kind = "spell",
        },
    },
    flags = {
        "SEES", "HEARS", "HAS_MIND", "BIOLOGICALPROOF", "NO_BREATHE", "PUSH_MON", "ALWAYS_VISIBLE",
        "ALWAYS_SEES_YOU",
    },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s vanishes but you can still feel it."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_twisted_reflection",
    name = ccb.content.plural_text("twisted reflection", "twisted reflections"),
    speed = 90,
    description = ccb.content.text("This looks almost nothing like you.  Its form isn't even stable.  So why does your mind keep mistaking it for you?"),
    copy_from = "mon_pale_reflection",
}

ccb.content.define_monster {
    id = "mon_dark_reflection",
    name = ccb.content.plural_text("dark reflection", "dark reflections"),
    speed = 100,
    description = ccb.content.text("This only looks a little like you.  It's obviously not you.  So why does your mind keep mistaking it for you?"),
    copy_from = "mon_pale_reflection",
}

ccb.content.define_monster {
    id = "mon_better_half",
    name = ccb.content.plural_text("better half", "better halves"),
    speed = 110,
    description = ccb.content.text("This doesn't look like you.  It looks like what you've dreamed you could be.  Why does your mind keep mistaking you for a bad copy of it?"),
    copy_from = "mon_pale_reflection",
}

ccb.content.define_monster {
    id = "mon_XEDRA_officer",
    description = ccb.content.text("A figure in a high-tech suit, their outline contorted as though you were viewing them through a prism.  Their movements are strained but determined, pushing through apparent pain with feverish resolve, dead-set on reaching their target."),
    name = ccb.content.plural_text("mercenary officer", "mercenary officers"),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    speed = 95,
    color = "red_cyan",
    melee_skill = 7,
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "electric", amount = 4 } },
    luminance = 4,
    defense = { id = "ZAPBACK", chance = 75 },
    hp = 150,
    flags = {
        "SEES",
        "HEARS",
        "SMELLS",
        "HAS_MIND",
        "WARM",
        "BASHES",
        "GROUP_BASH",
        "POISON",
        "ACIDPROOF",
        "NO_BREATHE",
    },
    upgrade = false,
    bleed_rate = 0,
    vision_night = 40,
    attacks = {
        {
            spell = { id = "spell_conjure_memories" },
            cooldown = 30,
            casting_message = ccb.content.text("The creature screams \"SOMEONE HELP ME, ANYONE!\"."),
            kind = "spell",
        },
        { id = "bio_op_takedown", cooldown = 20 },
    },
    armor = { electric = 3, bash = 30, cut = 30, bullet = 40 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet", "wps_humanoid_gasmask" },
            families = { "prof_wp_syn_armored" },
            flags = { "NOT_HALLUCINATION" },
        },
    },
    death = {
        drops = "xedra_officer_set",
        outcome = { spell = { id = "mon_XEDRA_officer_banish", hit_self = true } },
    },
}

ccb.content.define_monster {
    id = "mon_XEDRA_soldier",
    description = ccb.content.text("A figure in combat gear, distorted and shattered like broken glass.  They thrash around as they move, an expression of shock and anguish frozen on their face."),
    name = ccb.content.plural_text("mercenary ghost", "mercenary ghosts"),
    copy_from = "mon_zombie_soldier_blackops_1",
    inheritance = { add = { flags = { "NOT_HALLUCINATION" } } },
    death = {
        outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The soldier fades away to nothing.") },
    },
}

ccb.content.define_monster {
    id = "mon_tainted_shadow",
    name = ccb.content.plural_text("tainted shadow", "tainted shadows"),
    description = ccb.content.text("Your shadow is host to something alien."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 35,
    speed = 100,
    symbol = "H",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 10 } },
    flags = { "SEES", "HEARS", "BIOLOGICALPROOF", "NO_BREATHE" },
    death = {
        outcome = {
            spell = { id = "mon_tainted_shadow_revive", hit_self = true },
            corpse = "NO_CORPSE",
            message = ccb.content.text("Your shadow seemingly becomes normal again."),
        },
    },
}

-- it must be spooky, but god im bad in this stuff
ccb.content.define_monster {
    id = "mon_hallucinator",
    name = ccb.content.plural_text("person", "persons"),
    description = ccb.content.text("A common human.  It looks exactly like a human looks.  You can see them.  They can see you.  You know they know you can see them.  They know you know you can see them.  They move towards you."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 100000000,
    speed = 25,
    symbol = "@",
    color = "white",
    aggression = 100,
    morale = 100,
    vision_day = 60,
    vision_night = 60,
    pathing = { max_distance = 60, open_doors = true },
    flags = {
        "NO_BREATHE", "SEES", "HEARS", "ACIDPROOF", "CAN_OPEN_DOORS", "FIREPROOF", "BIOLOGICALPROOF",
        "LOUDMOVES", "SLUDGEPROOF", "SMELLS", "STUN_IMMUNE", "WEBWALK", "ALL_SEEING", "ALWAYS_VISIBLE",
    },
    attacks = {
        {
            cooldown = 0,
            spell = { id = "hallucinator_touch" },
            casting_message = ccb.content.text("You feel something was destroyed inside you."),
            kind = "spell",
        },
    },
    emissions = { { id = "emit_clairvoyant", delay = "1 s" } },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s just disappeared.") } },
}

ccb.content.define_monster {
    id = "mon_guilt",
    name = ccb.content.plural_text("guilt", "guilts"),
    description = ccb.content.text("An animate blotch of conflicting shapes, when you look at or think of this, memories of your wrongdoings rise to the surface."),
    copy_from = "mon_shifting_mass",
    attacks = {
        {
            spell = { id = "guilt_attack", min_level = 1 },
            cooldown = 1,
            casting_message = ccb.content.text("The guilt makes no physical movement and yet you feel the force of its assault.  Everything feels heavier."),
            kind = "spell",
        },
    },
    flags = {
        "SEES",
        "HEARS",
        "NO_BREATHE",
        "BIOLOGICALPROOF",
        "PUSH_MON",
        "ALWAYS_VISIBLE",
        "ALWAYS_SEES_YOU",
    },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_sloth",
    name = ccb.content.plural_text("sloth", "sloths"),
    description = ccb.content.text("An animate blotch of conflicting shapes, when you look at or think of this, a desire to stop moving rises."),
    copy_from = "mon_shifting_mass",
    attacks = {
        {
            spell = { id = "sloth_attack", min_level = 1 },
            cooldown = 1,
            casting_message = ccb.content.text("The sloth does nothing, and you feel time itself aiding your desire to do nothing."),
            kind = "spell",
        },
    },
    flags = {
        "SEES",
        "HEARS",
        "NO_BREATHE",
        "BIOLOGICALPROOF",
        "PUSH_MON",
        "ALWAYS_VISIBLE",
        "ALWAYS_SEES_YOU",
    },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_hanging_roper",
    name = ccb.content.plural_text("hanging roper", "hanging ropers"),
    description = ccb.content.text("What looks to be a loose mass of worm-like appendages reveals a solid body beneath, a great maw of rows of serrated fangs taking up most of the body.  It is either very lethargic or stalking prey, sitting in place without much obvious motion."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 200,
    speed = 150,
    symbol = "v",
    color = "pink",
    aggression = 100,
    morale = 100,
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 12,
    melee_damage = { { type = "stab", amount = 6 } },
    grab_strength = 30,
    attacks = {
        { id = "ranged_pull", cooldown = 3 },
        { id = "grab", cooldown = 4 },
        { cooldown = 2, kind = "bite" },
    },
    families = { "prof_wp_netherium_abomination" },
    weakpoint_sets = { "wps_netherium_abomination" },
    harvest = "mutant_mammal_leather",
    reproduction = { offspring = { monster = "mon_carrion_grub" }, count = 1, interval = 330 },
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE", "FRIEND_ATTACKED" },
    flags = { "SEES", "SMELLS", "HEARS", "WARM", "IMMOBILE", "ANIMAL" },
}

ccb.content.define_monster {
    id = "mon_carrion_grub",
    name = ccb.content.plural_text("carrion grub", "carrion grubs"),
    description = ccb.content.text("A wriggling brown grub of unnatural origin, slithering along the ground and unnaturally pulsating.  As it moves along, it chews through any available flesh with surprising speed."),
    copy_from = "mon_larva_abstract",
    default_faction = "nether",
    body_type = "snake",
    volume = "30 L",
    mass = "40750 g",
    hp = 20,
    speed = 15,
    symbol = "v",
    color = "brown",
    aggression = -10,
    morale = 10,
    melee_skill = 2,
    melee_dice = 1,
    upgrade = { grow_at_age = 30, monster = "mon_hanging_roper" },
    families = { "prof_wp_netherium_abomination" },
    weakpoint_sets = { "wps_netherium_abomination" },
    harvest = "mutant_animal_large_noskin",
    flags = { "SMELLS" },
}

ccb.content.define_monster {
    id = "mon_nether_spearfisher",
    name = ccb.content.plural_text("spearfisher", "spearfishers"),
    description = ccb.content.text("A strange quadrupedal creature with long, lanky limbs and a gaping maw.  A long sharp spike protrudes from its back, which occasionally launches from its joint to stab prey before slinking back in."),
    default_faction = "spearfisher",
    body_type = "dog",
    volume = "45 L",
    mass = "60758 g",
    hp = 40,
    speed = 100,
    symbol = "<",
    color = "pink",
    aggression = 10,
    morale = 10,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "stab", amount = 8 } },
    anger_triggers = { "FRIEND_ATTACKED" },
    families = { "prof_wp_netherium_abomination" },
    weakpoint_sets = { "wps_netherium_abomination" },
    harvest = "mutant_animal_large_noskin",
    flags = { "SMELLS", "SEES", "HEARS", "ANIMAL", "WARM" },
}

ccb.content.define_monster {
    id = "mon_nether_leech",
    name = ccb.content.plural_text("strange leech", "strange leeches"),
    description = ccb.content.text("A very wet, snake-like creature which you estimate to be five feet long, covered in slime and slithering about.  Occasionally, it will attach itself to the flesh around it and begins to suck."),
    copy_from = "mon_larva_abstract",
    default_faction = "nether",
    body_type = "snake",
    volume = "72 L",
    mass = "90 kg",
    hp = 100,
    speed = 100,
    symbol = "s",
    color = "pink",
    aggression = 30,
    morale = 10,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 8,
    attacks = {
        {
            cooldown = 4,
            accuracy = 5,
            damage = {
                { type = "stab", amount = 15, armor_multiplier = 0.3 },
                { type = "bash", amount = 5, armor_multiplier = 0.3 },
            },
            kind = "bite",
        },
    },
    families = { "prof_wp_netherium_abomination" },
    weakpoint_sets = { "wps_netherium_abomination" },
    harvest = "mutant_animal_large_noskin",
    reproduction = { offspring = { monster = "mon_nether_leech" }, count = 1, interval = 330 },
    flags = { "SMELLS" },
}
