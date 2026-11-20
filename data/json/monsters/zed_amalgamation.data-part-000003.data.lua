local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_amalgamation_corroder",
    copy_from = "mon_amalgamation_abstract_small",
    name = ccb.content.plural_text("caustic amalgamation", "caustic amalgamations"),
    description = ccb.content.text("A gangly creature running on six legs, its form made irregular by the green pustules at the limbs' base, each feeding into a large vein leading to two blackened claws.  What must have been a seventh leg fused with the creature's head forming a jagged proboscis emerging from below its eyes, dripping a caustic liquid."),
    color = "yellow_green",
    body_type = "insect",
    melee_damage = { { type = "cut", amount = 5 }, { type = "acid", amount = 3 } },
    attacks = {
        {
            id = "impale",
            cooldown = 8,
            damage = { { type = "stab", amount = 8 }, { type = "acid", amount = 8 } },
            effects = { { id = "corroding", duration = { 10, 30 }, affect_hit_body_part = true } },
            when = "monster_attack_intact_mandibles",
        },
        { id = "acid_slash" },
        { id = "acid_charge" },
    },
    harvest = "zombie_amalgamation_acid",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ACID_BLOOD" }, weakpoint_sets = { "wps_amalgamation_acid" } },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_jumper",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("leaping amalgamation", "leaping amalgamations"),
    description = ccb.content.text("A four-legged white creature about the size of a human, running with a decidedly feline gait, the three remaining limbs holding an almost-translucent skin membrane outstretched on its side and rear.  Much of its head is taken up by a beak like a raven's, which opens to reveal a set of jagged black teeth."),
    color = "i_blue",
    body_type = "dog",
    mass = "90 kg",
    volume = "90 L",
    hp = 135,
    speed = 100,
    attack_cost = 100,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 5, penetration = 5 } },
    attacks = {
        {
            minimum_target_distance = 2,
            minimum_range = 2,
            move_cost = 50,
            maximum_range = 8,
            allow_no_target = false,
            cooldown = 3,
            kind = "leap",
            when = "allow_dragonfly_giant_grab",
        },
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 8 } },
            infection_chance = 10,
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    dodge = 7,
    inheritance = {
        add = {
            flags = { "HARDTOSHOOT" },
            weakpoint_sets = { "wps_amalgamation_wing", "wps_amalgamation_mandible" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_zapper",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("charged amalgamation", "charged amalgamations"),
    description = ccb.content.text("A short, crablike creature waddling around on six multi-jointed legs, its body dominated by a large glowing organ bulging from between the white armor plates.  A single raised appendage connects to the mass, its tip surrounded by brilliant white sparks."),
    color = "blue",
    speed = 95,
    luminance = 8,
    melee_damage = { { type = "electric", amount = 5 } },
    attacks = {
        {
            id = "shock_blast",
            spell = { id = "shock_blast", hit_self = true, min_level = 1 },
            cooldown = 25,
            casting_message = ccb.content.text("A cloud of electricity explodes from the %s"),
            kind = "spell",
            when = "allow_amalgamation_zapper_shock_blast",
        },
        {
            id = "shock_cone",
            spell = { id = "shock_cone", min_level = 1 },
            casting_message = ccb.content.text("A bolt of electricity arcs from %s!"),
            cooldown = 20,
            kind = "spell",
            when = "allow_amalgamation_zapper_shock_cone",
        },
        { id = "elec_charge", when = "allow_amalgamation_zapper_shock_cone" },
    },
    defense = { id = "ZAPBACK", chance = 100 },
    harvest = "zombie_amalgamation_electric",
    inheritance = {
        add = {
            flags = { "ELECTRIC", "PULP_PRYING" },
            weakpoint_sets = { "wps_amalgamation_armor", "wps_amalgamation_electric" },
        },
    },
    death = { outcome = { spell = { id = "death_shock_blast", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_soldier",
    copy_from = "mon_amalgamation_abstract_med",
    name = ccb.content.plural_text("brutish amalgamation", "brutish amalgamations"),
    description = ccb.content.text("A large, thickly armored creature built not unlike a bear, if a bear had a long, clubbed tail and two short limbs ending in black talons framing a vertical mouth on an otherwise smooth, featureless head.  On second thought, not that much like a bear at all."),
    color = "dark_gray",
    body_type = "dog",
    volume = "200 L",
    mass = "200 kg",
    speed = 100,
    attack_cost = 150,
    melee_skill = 8,
    melee_dice = 4,
    melee_sides = 4,
    grab_strength = 100,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 10,
            move_cost = 120,
            damage = { { type = "cut", amount = 18, penetration = 22 } },
            infection_chance = 10,
            minimum_hit_size = 0,
            when = "monster_attack_intact_mandibles",
        },
        {
            id = "scratch",
            cooldown = 4,
            move_cost = 80,
            damage = { { type = "cut", amount = 12, penetration = 15 } },
            maximum_damage_multiplier = 1.5,
            minimum_hit_size = 4,
        },
        { id = "tail_club" },
        {
            id = "grab_drag",
            cooldown = 15,
            grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 },
        },
        { id = "drag_followup", grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 } },
    },
    dodge = 3,
    vision_night = 8,
    armor = { bash = 20, cut = 25, stab = 30, acid = 12, bullet = 40, electric = 12 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_amalgamation_armor", "wps_amalgamation_mandible", "wps_amalgamation_tail" },
            families = { "prof_wp_nat_armored" },
            flags = { "GRABS", "PULP_PRYING" },
        },
    },
}
