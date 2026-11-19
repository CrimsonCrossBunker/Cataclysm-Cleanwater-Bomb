local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_child_scorched",
    name = ccb.content.plural_text("scorched zombie child", "scorched zombie children"),
    description = ccb.content.text("A diminutive humanoid figure, its body ravaged by fire into a blackened, charred shell.  Its leathery flesh has mended in patches, and the tattered clothing is still clinging to its emaciated frame making it clear it once was - and still is - the body of a child."),
    copy_from = "mon_zombie_child_base",
    hp = 30,
    speed = 45,
    color = "i_brown",
    melee_skill = 1,
    bleed_rate = 25,
    vision_day = 10,
    upgrade = { half_life = 112, monster_group = "GROUP_CHILD_ZOMBIE_UPGRADE" },
    armor = { bash = 2, cut = 3, acid = 3, heat = 15, bullet = 2, electric = 3 },
    inheritance = { add = { flags = { "REVIVES_HEALTHY", "NO_NECRO" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_scorched_brute",
    name = ccb.content.plural_text("scorched zombie brute", "scorched zombie brutes"),
    description = ccb.content.text("An oversized charred human form.  The remains of its burnt and blackened musculature are clearly visible between the cracks of the shell formed from its melted skin."),
    copy_from = "mon_zombie_brute",
    hp = 95,
    speed = 85,
    color = "i_brown",
    melee_skill = 3,
    melee_sides = 6,
    grab_strength = 20,
    bleed_rate = 5,
    vision_day = 10,
    armor = { bash = 7, cut = 10, acid = 5, heat = 15, bullet = 7, electric = 3 },
    inheritance = { add = { flags = { "REVIVES_HEALTHY", "NO_NECRO" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_scorched",
    name = ccb.content.plural_text("scorched zombie", "scorched zombies"),
    description = ccb.content.text("A heavily burned zombie that still reeks of charred meat.  Its now leathery flesh has mended into patches, giving it a more armored appearance."),
    copy_from = "mon_zombie_base",
    hp = 60,
    speed = 55,
    color = "i_brown",
    melee_skill = 3,
    bleed_rate = 25,
    vision_day = 10,
    grab_strength = 10,
    armor = { bash = 2, cut = 4, acid = 3, heat = 15, bullet = 2, electric = 3 },
    inheritance = { add = { flags = { "REVIVES_HEALTHY", "NO_NECRO", "CLUMSY_ATTACKS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_scorched_lasher",
    name = ccb.content.plural_text("scorched lasher", "scorched lashers"),
    description = ccb.content.text("A heavily burned corpse with unnaturally long arms dragging behind it as it moves.  The burnt scar tissue covering it gives it a mildly armored appearance."),
    copy_from = "mon_zombie_base",
    hp = 60,
    speed = 50,
    color = "i_brown",
    melee_skill = 2,
    attacks = { { id = "bite_humanoid", cooldown = 5 }, { id = "lash_bash_attack" } },
    bleed_rate = 25,
    vision_day = 10,
    harvest = "zombie_grabber",
    armor = { bash = 2, cut = 4, acid = 3, heat = 15, bullet = 2, electric = 3 },
    inheritance = { add = { flags = { "REVIVES_HEALTHY", "NO_NECRO" } }, remove = { flags = { "GRABS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fiend",
    name = ccb.content.plural_text("fiend", "fiends"),
    description = ccb.content.text("A monstrous burnt vaguely humanoid creature, walking around on its knuckles like a gorilla.  Tattered and blackened strands of muscle fibers dangle all around its body, with patches of fused melded skin and bone visible between.  Its forelimbs end in lengthy skeletal claws."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    volume = "875 L",
    mass = "200 kg",
    hp = 275,
    speed = 125,
    color = "i_brown",
    melee_skill = 5,
    grab_strength = 30,
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid", cooldown = 20, damage = { { type = "cut", amount = 38 } } },
        { id = "stretch_attack", range = 2, damage = { { type = "stab", amount = 25 } } },
    },
    bleed_rate = 0,
    vision_day = 15,
    harvest = "zombie_hulk",
    upgrade = false,
    armor = { bash = 8, cut = 12, acid = 6, heat = 15, bullet = 10, electric = 3 },
    inheritance = {
        add = {
            flags = { "PUSH_VEH", "DESTROYS", "REVIVES_HEALTHY", "NO_NECRO" },
            weakpoint_sets = { "wps_humanoid_head_small" },
            families = { "prof_wp_hulk" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_scorched_rust",
    description = ccb.content.text("A heavily burned zombie that still reeks of charred meat.  Its now leathery flesh has mended into patches, giving it a more armored appearance.  This one appears to have metal fragments sticking out of its body."),
    copy_from = "mon_zombie_scorched",
    harvest = "zombie_rust",
    decay = "zombie_decay_bone_human_skull_rust",
}

ccb.content.define_monster {
    id = "mon_zombie_fiend_rust",
    description = ccb.content.text("An oversized charred human form.  The remains of its burnt and blackened musculature are clearly visible between the cracks of the shell formed from its melted skin.  This one appears to have metal fragments sticking out of its body."),
    copy_from = "mon_zombie_scorched_brute",
    species = { "ZOMBIE" },
    harvest = "zombie_rust",
    decay = "zombie_decay_bone_human_skull_rust",
}
