local ccb = require("ccb")

-- Named after the American folkloric monster.
-- 25
-- Extended flags are from telepathic suggestion that the hidebehind is not there.
ccb.content.define_monster {
    id = "mon_hidebehind",
    copy_from = "mon_cougar",
    looks_like = "mon_cougar",
    name = ccb.content.plural_text("hidebehind", "hidebehinds"),
    description = ccb.content.text("Even looking directly at this cougar and knowing that it is there, a part of your brain simply refuses to see it.  It flickers in and out of sight in a way that makes your eyes hurt, and if you turn your attention away from it even for a moment, it disappears completely."),
    morale = 80,
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_hidebehind_obscurity_activate",
                    spell = { id = "hidebehind_apply_obscurity_power" },
                    casting_message = "",
                    kind = "spell",
                    cooldown = { 5, 15 },
                    when = "allow_hidebehind_psi_hidebehind_obscurity_activate",
                },
                {
                    id = "psi_hidebehind_apply_mindsight",
                    spell = { id = "hidebehind_apply_mindsight", hit_self = true },
                    cooldown = 1,
                    allow_no_target = true,
                    casting_message = "",
                    kind = "spell",
                    when = "allow_hidebehind_psi_hidebehind_apply_mindsight",
                },
            },
            flags = { "MIND_SEEING" },
        },
    },
}

-- A telekinetic bear
ccb.content.define_monster {
    id = "mon_bandersnatch",
    copy_from = "mon_bear",
    looks_like = "mon_bear",
    name = ccb.content.plural_text("bandersnatch", "bandersnatches"),
    description = ccb.content.text("An American black bear.  A large omnivorous scavenger, it has powerful claws and jaws, and is an effective ambush hunter.  This one is distinguished from its fellows by its intent expression, its lack of caution in your presence, and the fact that it's hovering six inches off the ground."),
    aggression = 0,
    grab_strength = 50,
    fear_triggers = { "SOUND" },
    anger_triggers = { "PLAYER_WEAK", "HURT", "PLAYER_CLOSE", "FRIEND_ATTACKED", "PLAYER_NEAR_BABY" },
    regenerates = 1,
    attacks = {
        { reference = "EAT_FOOD", cooldown = 20 },
        { infection_chance = 44, kind = "bite", cooldown = { 7, 21 } },
        {
            id = "ranged_pull",
            avatar_hit = ccb.content.text_without_extraction("%1$s growls and a powerful forces seizes your %2$s and drags you in!"),
            npc_hit = ccb.content.text_without_extraction("%1$s growls and <npcname> is dragged towards it!"),
            avatar_miss = "",
            npc_miss = "",
            avatar_no_damage = "",
            npc_no_damage = "",
            cooldown = { 7, 21 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_bandersnatch_inertial_barrier",
            spell = { id = "telekinetic_barrier_monster" },
            cooldown = 1,
            casting_message = ccb.content.text("The air around %1$s distorts."),
            kind = "spell",
            when = "allow_bandersnatch_psi_bandersnatch_inertial_barrier",
        },
    },
    inheritance = { add = { flags = { "CLIMBS" }, armor = { psi_telekinetic_damage = 35 } } },
}

ccb.content.define_monster {
    id = "mon_fear_hawk",
    name = ccb.content.plural_text("fear hawk", "fear hawks"),
    description = ccb.content.text("A hawk with striking golden eyes.  Its call seems to pierce deep into your psyche even when it's not directed at you."),
    body_type = "bird",
    default_faction = "fear_hawk",
    categories = { "WILDLIFE" },
    species = { "BIRD" },
    volume = "3000 ml",
    mass = "1500 g",
    hp = 8,
    speed = 110,
    materials = { "flesh" },
    symbol = "v",
    color = "dark_gray",
    aggression = 80,
    morale = 90,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    melee_skill = 2,
    dodge = 3,
    armor = { psi_telekinetic_damage = 15, psi_telepathic_damage = 35 },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_flying", "prof_wp_basic_bird" },
    weakpoint_sets = { "wps_bird_body" },
    harvest = "mutant_bird",
    dissect = "dissect_bird_sample_single",
    fear_triggers = { "PLAYER_CLOSE" },
    attacks = {
        {
            id = "psychic_shriek",
            move_cost = 100,
            range = 3,
            dodgeable = false,
            blockable = false,
            damage = { { type = "psi_telepathic_damage", amount = 10 } },
            avatar_hit = ccb.content.text("%1$s shrieks at you!"),
            npc_hit = ccb.content.text("%1$s shrieks at <npcname>!"),
            avatar_no_damage = ccb.content.text("%1$s's shriek radiates out at you without doing any damage."),
            npc_no_damage = ccb.content.text("%1$s's shriek radiates out at <npcname> without doing any damage."),
            avatar_miss = ccb.content.text("%s's shriek radiates at you, but you dodge!"),
            npc_miss = ccb.content.text("%s's shriek radiates at <npcname>, but they dodge!"),
            kind = "melee",
            cooldown = { 3, 9 },
            when = "monster_attack_psionics_available",
        },
    },
    biosignature = { item = "feces_bird", interval = 8 },
    flags = { "SEES", "HEARS", "SMELLS", "PATH_AVOID_DANGER", "WARM", "FLIES", "HIT_AND_RUN" },
}

ccb.content.define_monster {
    id = "mon_cow_biokinetic",
    copy_from = "mon_cow",
    name = ccb.content.plural_text("cow", "cows"),
    description = ccb.content.text("The domestic cow, a baleful, ruminating farm animal.  She is quite muscular, and would be a great source of milk if domesticated or of meat and leather if slaughtered.  This one moves with an oddly fluid grace."),
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_COW_PRE_HODAG_MUTANT_BABIES" },
        count = 1,
        interval = 343,
    },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_hodag_speed_boost",
                    spell = { id = "biokinetic_speed_boost_monster_01", min_level = 5 },
                    casting_message = ccb.content.text("%1$s moves too quickly for the eye to follow!"),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_hodag_hardened_skin",
                    spell = { id = "biokinetic_hardened_skin_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s's skin takes on a slightly waxen appearance."),
                    kind = "spell",
                    when = "allow_cow_biokinetic_psi_hodag_hardened_skin",
                },
            },
        },
    },
}

-- armor, HP, and speed boost power are from biokinesis
ccb.content.define_monster {
    id = "mon_hodag",
    looks_like = "mon_cow",
    copy_from = "mon_cow",
    name = ccb.content.plural_text("hodag", "hodags"),
    description = ccb.content.text("This is very similar to a cow, though the bone spikes growing from its back and its clawed feet separate it from any cow you've ever seen.  Despite its fearsome armaments, it grazes placidly on grass."),
    symbol = "C",
    color = "yellow",
    aggression = 0,
    morale = 80,
    anger_triggers = { "HURT", "PLAYER_NEAR_BABY", "PLAYER_WEAK" },
    reproduction = { offspring = { monster = "mon_hodag_calf" }, count = 1, interval = 343 },
    armor = { bash = 4, cut = 3, stab = 1, bullet = 4, electric = 1 },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "scratch",
                    move_cost = 140,
                    damage = { { type = "cut", amount = 12, armor_multiplier = 0.75 } },
                    minimum_damage_multiplier = 1.5,
                    maximum_damage_multiplier = 3.5,
                    cooldown = { 1, 4 },
                },
                {
                    id = "stag_smash",
                    minimum_damage_multiplier = 0.8,
                    throw_strength = 70,
                    cooldown = { 7, 22 },
                },
                {
                    id = "psi_hodag_speed_boost",
                    spell = { id = "biokinetic_speed_boost_monster_01", min_level = 5 },
                    casting_message = ccb.content.text("%1$s moves too quickly for the eye to follow!"),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_hodag_hardened_skin",
                    spell = { id = "biokinetic_hardened_skin_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s's skin takes on a slightly waxen appearance."),
                    kind = "spell",
                    when = "allow_cow_biokinetic_psi_hodag_hardened_skin",
                },
                {
                    id = "psi_hodag_heightened_reflexes",
                    spell = { id = "biokinetic_heightened_reflexes_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s begins moving more quickly."),
                    kind = "spell",
                    when = "allow_hodag_psi_hodag_heightened_reflexes",
                },
            },
        },
        scale = { hp = 1.4 },
        offset = { melee_skill = 1, melee_sides = 2 },
    },
}

ccb.content.define_monster {
    id = "mon_hodag_calf",
    copy_from = "mon_cow_calf",
    looks_like = "mon_cow_calf",
    name = ccb.content.plural_text("baby hodag", "baby hodags"),
    description = ccb.content.text("This is very similar to a calf, though the short bone spikes growing from its back and its clawed feet separate it from any calf you've ever seen.  Despite its fearsome armaments, it grazes placidly on grass."),
    symbol = "C",
    color = "light_gray",
    upgrade = { grow_at_age = 180, monster = "mon_hodag" },
    armor = { bash = 4, cut = 3, stab = 1, bullet = 4, electric = 1 },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_hodag_hardened_skin",
                    spell = { id = "biokinetic_hardened_skin_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s's skin takes on a slightly waxen appearance."),
                    kind = "spell",
                    when = "allow_cow_biokinetic_psi_hodag_hardened_skin",
                },
            },
        },
        scale = { hp = 1.4, speed = 1.15 },
        offset = { melee_skill = 1, melee_sides = 2 },
    },
}

ccb.content.define_monster {
    id = "mon_cockatrice",
    name = ccb.content.plural_text("cockatrice", "cockatrices"),
    description = ccb.content.text("This strange mutant bird gains its name from its odd appearance.  Although its features seem to be becoming more reptilian, it doesn't appear dangerous.  However, it looks at you like it understands you in some way."),
    default_faction = "small_animal",
    body_type = "bird",
    categories = { "WILDLIFE" },
    species = { "BIRD" },
    volume = "750 ml",
    mass = "1 kg",
    hp = 20,
    speed = 130,
    materials = { "flesh" },
    symbol = "v",
    color = "red",
    looks_like = "mon_chicken",
    aggression = 0,
    morale = 80,
    melee_skill = 2,
    melee_dice = 2,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 3 } },
    dodge = 6,
    attacks = {
        {
            id = "psi_cockatrice_telepathic_blast",
            spell = { id = "telepathic_fear_blast_monster", min_level = 6 },
            casting_message = ccb.content.text("%1$s stares and lets out a silent cry!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
    },
    anger_triggers = { "HURT", "FRIEND_ATTACKED", "PLAYER_NEAR_BABY" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_flying",
        "prof_wp_basic_bird",
    },
    weakpoint_sets = { "wps_bird_body" },
    harvest = "bird_tiny",
    dissect = "dissect_chimera_sample_small",
    reproduction = { offspring = { egg = "egg_cockatrice" }, count = 3, interval = 10 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    biosignature = { item = "feces_bird", interval = 8 },
    flags = {
        "SEES",
        "HEARS",
        "SMELLS",
        "ANIMAL",
        "PATH_AVOID_DANGER",
        "WARM",
        "FLIES",
        "CORNERED_FIGHTER",
    },
}

ccb.content.define_monster {
    id = "mon_cockatrice_chick",
    copy_from = "mon_generic_chick",
    description = ccb.content.text("A strange tiny chick, it could be from a number of different species if it weren't for the patches of scales between its feathers."),
    name = ccb.content.plural_text("strange chick", "strange chicks"),
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 12, monster = "mon_cockatrice" },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

-- Intentionally unable to be culled when friendly.
ccb.content.define_monster {
    id = "mon_pigeon_passenger",
    copy_from = "mon_bird_flying_base",
    name = ccb.content.plural_text("pigeon passenger", "pigeon passengers"),
    description = ccb.content.text("A gentle, plump, small-billed bird with a third eye, between its bill and forehead.  On the ground, it struts about with a characteristic bobbing of the head.  It is a strong, swift flier thanks to its long wings and powerful flight muscles.  Is it following you?"),
    volume = "1 L",
    mass = "360 g",
    hp = 4,
    speed = 150,
    symbol = "v",
    color = "dark_gray",
    fear_triggers = { "SOUND", "FRIEND_ATTACKED", "FRIEND_DIED", "FIRE", "HURT" },
    biosignature = { item = "feces_bird", interval = 4 },
    attacks = {
        {
            id = "psi_pigeon_telepathic_blast",
            spell = { id = "telepathic_fear_blast_monster", min_level = 2 },
            casting_message = ccb.content.text("%s's third eye opens and it coos!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "pigeon_aura",
            spell = { id = "pigeon_aura", min_level = 4 },
            cooldown = 200,
            kind = "spell",
        },
    },
    reproduction = { offspring = { egg = "egg_pigeon_passenger" }, count = 3, interval = 32 },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    inheritance = {
        add = { flags = { "KEEP_DISTANCE", "HARDTOSHOOT" } },
        remove = { flags = { "CAN_BE_CULLED" } },
    },
}

ccb.content.define_monster {
    id = "mon_pigeon_passenger_chick",
    copy_from = "mon_generic_chick",
    description = ccb.content.text("A tiny darkly-colored chick, it could be from a number of different species if it weren't for the third eye below the center of its forehead."),
    upgrade = { grow_at_age = 10, monster = "mon_pigeon_passenger" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

-- A Nether-affected fox
ccb.content.define_monster {
    id = "mon_psi_gremlin",
    copy_from = "mon_fox_red",
    looks_like = "mon_fox_red",
    name = ccb.content.plural_text("gremlin", "gremlins"),
    description = ccb.content.text("The red fox, an omnivorous canine and largest of the true foxes, it is a wily hunter with a combative, suspicious temperament.  Sparks occasionally crackle over its fur and its body distorts oddly as it moves, covering more ground with each stride than the length of its legs would indicate."),
    attacks = {
        {
            id = "psi_gremlin_power_draining_spell",
            spell = { id = "electrokinetic_power_draining" },
            allow_no_target = true,
            casting_message = ccb.content.text("Sparks flicker over %1$s's fur."),
            kind = "spell",
            cooldown = { 5, 50 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_gremlin_neuro_acceleration",
            spell = { id = "electrokinetic_neuro_acceleration_monster" },
            cooldown = 1,
            casting_message = ccb.content.text("%1$s begins moving more quickly."),
            kind = "spell",
            when = "allow_psi_gremlin_psi_gremlin_neuro_acceleration",
        },
    },
    armor = { electric = 40 },
    defense = { id = "ZAPBACK", chance = 75 },
    inheritance = { offset = { dodge = 1 } },
}

-- I've considered having this be an evolution point for several canid species outside of dogs, such as wolves or coyotes.
ccb.content.define_monster {
    id = "mon_dire_hound",
    name = ccb.content.plural_text("direhound", "direhounds"),
    description = ccb.content.text("This large canid has grown to terrifying proportions, roughly three times the size of some of its brethren.  Its teeth give steak knives a run for their money, and it looks to be the social center of any surrounding dogs."),
    default_faction = "dog",
    body_type = "dog",
    categories = { "WILDLIFE" },
    species = { "MAMMAL" },
    volume = "90000 ml",
    mass = "90 kg",
    hp = 100,
    speed = 150,
    materials = { "flesh" },
    symbol = "W",
    color = "light_gray",
    looks_like = "mon_dog",
    aggression = 0,
    morale = 70,
    melee_skill = 8,
    melee_dice = 3,
    melee_sides = 12,
    melee_damage = { { type = "cut", amount = 12 } },
    dodge = 3,
    bleed_rate = 60,
    vision_day = 50,
    vision_night = 5,
    harvest = "mutant_mammal_large_fur",
    dissect = "dissect_lupine_sample_large",
    reproduction = { offspring = { monster = "mon_dog_pup" }, count = 4, interval = 270 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN", "WINTER" },
    biosignature = { item = "feces_dog", interval = 6 },
    families = { "prof_intro_biology", "prof_physiology" },
    pathing = { max_distance = 10 },
    attacks = {
        {
            id = "psi_direhound_telepathic_network",
            spell = { id = "telepathic_network_monster", min_level = 5 },
            cooldown = 50,
            casting_message = ccb.content.text("The direhound gazes upon its allies, and lets out a howl!"),
            kind = "spell",
            when = "monster_attack_psionics_available",
        },
        {
            cooldown = 5,
            damage = { { type = "stab", amount = 15, penetration = 10 } },
            kind = "bite",
        },
        { reference = "EAT_FOOD", cooldown = 100 },
    },
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    anger_triggers = { "HURT", "FRIEND_ATTACKED", "FRIEND_DIED" },
    zombify_into = "mon_dog_zombie_brute",
    flags = {
        "ANIMAL", "DOGFOOD", "CANPLAY", "CAN_BE_CULLED", "GROUP_MORALE", "HEARS", "PET_MOUNTABLE",
        "HIT_AND_RUN", "KEENNOSE", "PATH_AVOID_DANGER", "SEES", "SMELLS", "SWARMS", "WARM", "EATS",
    },
    armor = { bash = 8, cut = 10, electric = 1 },
}

-- FIXME: For some reason, extending special attacks does not work
ccb.content.define_monster {
    id = "mon_hellhound",
    copy_from = "mon_dog",
    looks_like = "mon_dog",
    name = ccb.content.plural_text("hellhound", "hellhounds"),
    description = ccb.content.text("This once-average Labrador mixed-breed dog has clearly gone feral.  Though it likely still instinctively trusts humans, it's probably far from domestic by now.  The air around it wavers like the haze over summer asphalt."),
    melee_damage = { { type = "cut", amount = 3 }, { type = "heat", amount = 5 } },
    aggression = 4,
    morale = 40,
    emissions = { { id = "emit_hot_air2_blast", delay = "4 s" } },
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_DOG_HELLHOUND_BABIES" },
        count = 4,
        interval = 270,
    },
    attacks = {
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        {
            id = "psi_hellhound_breathe_fire",
            spell = { id = "pyrokin_flamethrower_hellhound_monster", min_level = 5 },
            casting_message = ccb.content.text("%1$s barks out a stream of flame!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
    },
    inheritance = { add = { flags = { "FIREPROOF" }, armor = { heat = 999 } } },
}

ccb.content.define_monster {
    id = "mon_hellhound_pup",
    copy_from = "mon_dog_pup",
    looks_like = "mon_dog_pup",
    name = ccb.content.plural_text("hellpup", "hellpups"),
    description = ccb.content.text("An adorable, defenseless Labrador puppy.  Much safer to tame than an adult dog.  Its breath is very hot."),
    melee_damage = { { type = "cut", amount = 1 }, { type = "heat", amount = 3 } },
    upgrade = { grow_at_age = 42, monster = "mon_hellhound" },
    armor = { heat = 50 },
}

ccb.content.define_monster {
    id = "mon_fear_deer",
    copy_from = "mon_deer",
    looks_like = "mon_deer",
    name = ccb.content.plural_text("king of the wood", "kings of the wood"),
    description = ccb.content.text("The northern woodland white-tailed deer, a quick and strong grazing animal.  Favored prey of coyotes, wolves, and giant spider mutants.  This one has an almost regal aura of calm about it and gazes at the forest around it without fear."),
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_FEAR_DEER_BABIES" },
        count = 1,
        interval = 330,
    },
    tracking_distance = 9,
    aggression = -10,
    anger_triggers = { "PLAYER_NEAR_BABY", "PLAYER_WEAK", "FRIEND_ATTACKED", "FRIEND_DIED" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_fear_deer_terror_attack",
                    spell = { id = "telepathic_fear_blast_monster", min_level = 5 },
                    casting_message = ccb.content.text("%1$s turns its head sideways and looks directly at %3$s."),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_fear_deer_empower_herd",
                    spell = { id = "telepathic_network_monster", min_level = 5 },
                    cooldown = 50,
                    casting_message = ccb.content.text("%1$s raises its head with an air of authority."),
                    kind = "spell",
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "TEEP_IMMUNE", "KEEP_DISTANCE" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_fear_deer_fawn",
    copy_from = "mon_deer_fawn",
    looks_like = "mon_deer_fawn",
    name = ccb.content.plural_text("prince of the wood", "princes of the wood"),
    description = ccb.content.text("A juvenile northern woodland white-tailed deer, a quick and strong grazing animal.  Favored prey of coyotes, wolves, and giant spider mutants.  This one doesn't seem as skittish as most deer are."),
    melee_damage = { { type = "cut", amount = 1 }, { type = "heat", amount = 3 } },
    upgrade = { grow_at_age = 330, monster = "mon_fear_deer" },
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_wild_rabbit_blinker",
    name = ccb.content.plural_text("hopalong", "hopalongs"),
    description = ccb.content.text("A brown-coated cottontail rabbit, with a fluffy white tail.  Its small size and docile nature makes it easy prey for predators, at least the ones that can catch it.  You can't tell which one of the two cottontail species from the region this is.  You can tell there's something different about it, though, when it suddenly vanishes and reappears nearby."),
    copy_from = "mon_rabbit_base",
    looks_like = "mon_rabbit",
    mass = "1200 g",
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_WILD_RABBIT_BLINKER_BABIES" },
        count = 5,
        interval = 28,
    },
    attacks = {
        {
            move_cost = 50,
            allow_no_target = true,
            maximum_range = 6,
            message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
            kind = "leap",
            cooldown = { 1, 3 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_rabbit_blinker_blinking",
            spell = { id = "teleport_blink_monster", min_level = 10 },
            cooldown = 30,
            casting_message = ccb.content.text("%1$s vanishes and reappears elsewhere!"),
            kind = "spell",
            when = "monster_attack_psionics_available",
        },
    },
}

ccb.content.define_monster {
    id = "mon_wild_rabbit_blinker_baby",
    name = ccb.content.plural_text("hopalong kit", "hopalong kits"),
    description = ccb.content.text("A tiny and very cute hopalong kit."),
    copy_from = "mon_rabbit_baby_base",
    looks_like = "mon_rabbit_baby",
    upgrade = { grow_at_age = 23, monster = "mon_wild_rabbit" },
    attacks = {
        {
            move_cost = 50,
            allow_no_target = true,
            maximum_range = 4,
            message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
            kind = "leap",
            cooldown = { 10, 30 },
            when = "monster_attack_psionics_available",
        },
    },
}
