local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_dusted",
    name = ccb.content.plural_text("dusted zombie", "dusted zombies"),
    description = ccb.content.text("This shambling corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_base",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fungalize",
    name = ccb.content.plural_text("fungal stalk zombie", "fungal stalk zombies"),
    description = ccb.content.text("This writhing corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_base",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus",
    name = ccb.content.plural_text("fungal zombie", "fungal zombies"),
    description = ccb.content.text("Once alive, then undead, now something else entirely.  Fungal tendrils sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zombie_fungalize",
    bleed_rate = 0,
    upgrade = false,
    inheritance = {
        add = { species = { "FUNGUS" }, attacks = { { reference = "FUNGUS", cooldown = 200 } } },
        scale = { hp = 0.75, speed = 2.2 },
        offset = { melee_sides = 3, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_gasbag_dusted",
    name = ccb.content.plural_text("dusted gasbag zombie", "dusted gasbag zombies"),
    description = ccb.content.text("This grotesquely swollen corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_gasbag",
    default_faction = "zombie_dusted",
    color = "black_yellow",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_gasbag_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_gasbag_fungalize",
    name = ccb.content.plural_text("fungal cherry bomb", "fungal cherry bombs"),
    description = ccb.content.text("This grotesquely swollen corpse has grown a short stalk of gray fungus bursting from the skull.  The overall visual effect is similar to a cherry or upside down lollipop."),
    copy_from = "mon_zombie_gasbag",
    default_faction = "fungus",
    color = "black_yellow",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_gasbag_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_fungus",
    name = ccb.content.plural_text("bloated fungal zombie", "bloated fungal zombies"),
    description = ccb.content.text("With its swollen gray skin overgrown by thick layer of mold, this balloon-like fungal zombie looks like it could violently burst into a cloud of noxious spores at any moment."),
    copy_from = "mon_zombie_gasbag",
    default_faction = "fungus",
    color = "black_yellow",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    emissions = { { id = "emit_fungal_leak", delay = "1 s" } },
    upgrade = false,
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_death_drops", weight = 100 },
                { id = "explode_zed_fungal", weight = 100 },
            },
        },
        outcome = { corpse = "NO_CORPSE", spell = { id = "death_fungalburst", hit_self = true } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker_dusted",
    name = ccb.content.plural_text("dusted smoker zombie", "dusted smoker zombies"),
    description = ccb.content.text("This smoke-shrouded corpse has been heavily dusted with a thick gray powder lighter in color than smoke and ash."),
    copy_from = "mon_zombie_smoker",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_smoker_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker_fungalize",
    name = ccb.content.plural_text("fungal stalk smoker", "fungal stalk smokers"),
    description = ccb.content.text("This smoke-shrouded corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_smoker",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_smoker_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker_fungus",
    name = ccb.content.plural_text("pollinator zombie", "pollinator zombies"),
    description = ccb.content.text("Every breath of this crooked, fungus-ridden zombie emits a fine dust of spores, and it constantly looks like it's emerging from a cloud of mist."),
    copy_from = "mon_zombie_smoker",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    emissions = { { id = "emit_fungal_haze_plume", delay = "1 s" } },
    upgrade = false,
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
    death = {
        outcome = {
            spell = { id = "death_fungus", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_dusted",
    name = ccb.content.plural_text("dusted skeletal zombie", "dusted skeletal zombies"),
    description = ccb.content.text("This moving corpse covered in knobby bone growths has been heavily dusted with a thick gray powder."),
    copy_from = "mon_skeleton",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_skeleton_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungalize",
    name = ccb.content.plural_text("fungal stalk skeleton", "fungal stalk skeletons"),
    description = ccb.content.text("This already horrific moving corpse covered in bony growths has also grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_skeleton",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = { grow_at_age = 1, monster = "mon_skeleton_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungus",
    name = ccb.content.plural_text("fungal skeletal zombie", "fungal skeletal zombies"),
    copy_from = "mon_skeleton",
    description = ccb.content.text("Fungi bloom from the crevices in the twisted bone growths that cover this creature.  Spores linger in the air around it."),
    default_faction = "fungus",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_dusted",
    name = ccb.content.plural_text("dusted skeletal brute", "dusted skeletal brutes"),
    description = ccb.content.text("This moving corpse covered in twisted bone growths has been heavily dusted with a thick gray powder."),
    copy_from = "mon_skeleton_brute",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_skeleton_brute_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungalize",
    name = ccb.content.plural_text("fungalizing bone brute", "fungalizing bone brutes"),
    description = ccb.content.text("This already horrific moving corpse covered in twisted bony growths has also grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_skeleton_brute",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = { grow_at_age = 1, monster = "mon_skeleton_brute_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungus",
    name = ccb.content.plural_text("fungal bone brute", "fungal bone brutes"),
    copy_from = "mon_skeleton_brute",
    description = ccb.content.text("Fungi bloom from the crevices in the twisted bone growths that cover this creature.  Spores linger in the air around it."),
    default_faction = "fungus",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_dusted",
    name = ccb.content.plural_text("dusted skeletal hulk", "dusted skeletal hulks"),
    description = ccb.content.text("This towering creature covered in plated bone has been heavily dusted with a thick gray powder."),
    copy_from = "mon_skeleton_hulk",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_skeleton_hulk_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungalize",
    name = ccb.content.plural_text("fungal stalk juggernaut", "fungal stalk juggernauts"),
    description = ccb.content.text("Layers of plates of bone rise high above, ending in a short stalk of gray fungus bursting from the enormous bulging skull."),
    copy_from = "mon_skeleton_hulk",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = { grow_at_age = 2, monster = "mon_skeleton_hulk_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungus",
    name = ccb.content.plural_text("fungal juggernaut", "fungal juggernauts"),
    description = ccb.content.text("Fungi bloom from the crevices in the ossified plates of this ponderous bone titan, and it seems even its eyes are lost to it.  A dust of spores lands on the ground with every sluggish stomp of its heavy legs."),
    copy_from = "mon_skeleton_hulk",
    default_faction = "fungus",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "moldy_bones",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_child_dusted",
    name = ccb.content.plural_text("dusted zombie child", "dusted zombie children"),
    description = ccb.content.text("This small, stumbling child has been dusted with a thick gray powder.  Something about the way it moves is uncanny."),
    copy_from = "mon_zombie_child_base",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_child_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungalize",
    name = ccb.content.plural_text("fungal stalk child", "fungal stalk children"),
    description = ccb.content.text("This child moves slowly, as though sleepy.  A short stalk of gray fungus has burst from the top of the little head."),
    copy_from = "mon_zombie_child_base",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_child_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungus",
    name = ccb.content.plural_text("fungal child", "fungal children"),
    description = ccb.content.text("It is hard to recognize a human child in this creature.  Disgusting-looking mold covers most of its skin.  Many cracks perforate its body, with small fungal stalks poking through."),
    copy_from = "mon_zombie_child_base",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_boomer_dusted",
    name = ccb.content.plural_text("dusted boomer", "dusted boomers"),
    description = ccb.content.text("This rotund and bloated corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_boomer",
    default_faction = "zombie_dusted",
    color = "light_gray_magenta",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_boomer_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_boomer_fungalize",
    name = ccb.content.plural_text("fungal stalk boomer", "fungal stalk boomers"),
    description = ccb.content.text("This rotund and bloated corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_boomer",
    default_faction = "fungus",
    color = "light_gray_magenta",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    upgrade = { grow_at_age = 1, monster = "mon_boomer_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_boomer_fungus",
    name = ccb.content.plural_text("fungal boomer", "fungal boomers"),
    description = ccb.content.text("A rotund and bloated human body with pasty, fungus-ridden flesh.  Its mouth drips with a frothing gray sludge."),
    copy_from = "mon_boomer",
    default_faction = "fungus",
    color = "light_gray_magenta",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 100 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_death_drops", weight = 100 },
                { id = "explode_zed_fungal", weight = 100 },
            },
        },
        outcome = { corpse = "NO_CORPSE", spell = { id = "death_fungus", hit_self = true } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_wretch_dusted",
    name = ccb.content.plural_text("dusted zombie wretch", "dusted zombie wretches"),
    description = ccb.content.text("This small child lies on the ground shaking gently, dusted with a thick gray powder.  The chest of the child appears to have broken open like a gory flower and there is strange pulsing movement and also unpleasant wet sounds within."),
    copy_from = "mon_zombie_wretch",
    default_faction = "zombie_dusted",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_wretch_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_wretch_fungalize",
    name = ccb.content.plural_text("fungal stalk wretch", "fungal stalk wretches"),
    description = ccb.content.text("This small child lies on the ground smiling serenely, a short stalk of gray fungus bursting triumphantly from the top of the little head.  The chest of the child appears to have broken open like a gory flower and there is strange pulsing movement and also unpleasant wet sounds within."),
    copy_from = "mon_zombie_wretch",
    default_faction = "fungus",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_fungal_wretch" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_fungal_wretch",
    name = ccb.content.plural_text("fungal wretch", "fungal wretches"),
    description = ccb.content.text("This severely deformed child lies on its back, its ribs exposed to the sky.  With its limbs contorted in ways only possible through a lack of bones, the child's ribcage stretches far beyond the boundaries of human biology, appearing akin to a bony hive coated in quivering fungal matter.  Spores occasionally waft from its hollowed interior, and, periodically, you can catch sight of weak movement within the abomination's guts."),
    copy_from = "mon_zombie_wretch",
    default_faction = "fungus",
    color = "pink",
    emissions = { { id = "emit_fungal_leak", delay = "1 s" } },
    bleed_rate = 0,
    vision_day = 4,
    vision_night = 4,
    harvest = "zombie_humanoid_mushroom",
    attacks = {
        {
            spell = { id = "wretch_fungal_raptor_spawn", hit_self = true },
            cooldown = 50,
            casting_message = ccb.content.text("Through a plume of fungal spores, a small beast struggles to take flight from the wretch's abdomen!"),
            kind = "spell",
        },
    },
    upgrade = false,
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_spawn_raptor_dusted",
    name = ccb.content.plural_text("dusted raptor", "dusted raptors"),
    description = ccb.content.text("Heavily dusted with a thick gray powder, this small, winged predator darts through the air on three spongy wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet."),
    copy_from = "mon_spawn_raptor",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_spawn_raptor_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_spawn_raptor_fungalize",
    name = ccb.content.plural_text("fungal stalk raptor", "fungal stalk raptors"),
    description = ccb.content.text("This small, winged predator darts through the air on three spongy wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet, joined by a short stalk of gray fungus reaching upward."),
    copy_from = "mon_spawn_raptor",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_fungal_raptor" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_fungal_raptor",
    name = ccb.content.plural_text("fungal raptor", "fungal raptors"),
    description = ccb.content.text("Infested by a thick crust of fungal growth, this small, winged predator darts through the air on three spongy wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet.  It looks like nothing you've seen on Earth, and yet strangely like it is made of human parts."),
    copy_from = "mon_spawn_raptor",
    default_faction = "fungus",
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = { add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_runner_dusted",
    name = ccb.content.plural_text("dusted zombie runner", "dusted zombie runners"),
    description = ccb.content.text("This recently-risen body has been heavily dusted with a thick gray powder, but still moves quickly."),
    copy_from = "mon_zombie_runner",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_runner_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_runner_fungalize",
    name = ccb.content.plural_text("fungal stalk runner", "fungal stalk runners"),
    description = ccb.content.text("This recently-risen body has grown a short stalk of gray fungus bursting from the skull.  This appears to slow it down in some way."),
    copy_from = "mon_zombie_runner",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_runner_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_runner_fungal",
    name = ccb.content.plural_text("fungal runner", "fungal runners"),
    description = ccb.content.text("Fungal sprouts seem to support the host's broken legs like crude splints.  Even with its eyes shrouded with tiny spores, it darts towards anything that seems to move in a small radius."),
    copy_from = "mon_zombie_runner",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_dusted",
    name = ccb.content.plural_text("dusted decayed zombie", "dusted decayed zombies"),
    description = ccb.content.text("This badly decayed corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_rot",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_rot_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_fungalize",
    name = ccb.content.plural_text("fungal stalk rotter", "fungal stalk rotters"),
    description = ccb.content.text("This badly decayed corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_rot",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_rot_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_fungal",
    name = ccb.content.plural_text("fungal rotter", "fungal rotters"),
    description = ccb.content.text("The rotten skin that flakes from the host's body seems to be covered in tiny blue dots; occasional popping and crackling sounds are heard, like cracking wood.  This corpse can't be discerned as human by the naked eye."),
    copy_from = "mon_zombie_rot",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_tough_dusted",
    name = ccb.content.plural_text("dusted tough zombie", "dusted tough zombies"),
    description = ccb.content.text("This muscular moving corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_tough",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_tough_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_tough_fungalize",
    name = ccb.content.plural_text("fungal stalk bulk", "fungal stalk bulks"),
    description = ccb.content.text("This muscular corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_tough",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_tough_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_tough_fungal",
    name = ccb.content.plural_text("fungal bulk", "fungal bulks"),
    description = ccb.content.text("This terrifying fungal construct seems to have lost all facial features, its face covered in thick fungal sprouts.  Its arms end in jagged points as fungal tendrils burst forth."),
    copy_from = "mon_zombie_tough",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_brute_dusted",
    name = ccb.content.plural_text("dusted brute zombie", "dusted brute zombies"),
    description = ccb.content.text("This zombie's entire body bulges with distended muscles heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_brute",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_brute_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_brute_fungalize",
    name = ccb.content.plural_text("fungal stalk brute", "fungal stalk brutes"),
    description = ccb.content.text("This inhumanly muscular corpse has numerous festering wounds and has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_brute",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_brute_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_brute_fungal",
    name = ccb.content.plural_text("fungal brute", "fungal brutes"),
    description = ccb.content.text("This bulky fungal construct seems to have lost all facial features, its chest and face covered in thick fungal sprouts.  Its arms and legs are grotesquely swollen."),
    copy_from = "mon_zombie_brute",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_hulk_dusted",
    name = ccb.content.plural_text("dusted zombie hulk", "dusted zombie hulks"),
    description = ccb.content.text("This zombie's muscular body has swollen to six times the size of an average person and has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_hulk",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_hulk_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_hulk_fungalize",
    name = ccb.content.plural_text("fungal stalk hulk", "fungal stalk hulks"),
    description = ccb.content.text("This enormous muscular corpse has swollen six times larger and has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_hulk",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 2, monster = "mon_zombie_hulk_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_hulk_fungal",
    name = ccb.content.plural_text("fungal hulk", "fungal hulks"),
    description = ccb.content.text("This inhumanly warped and swollen fungal construct is entirely covered in thick fungal sprouts.  The body shape is still roughly humanoid but the size is too large, about the size of six people combined."),
    copy_from = "mon_zombie_hulk",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_dusted",
    name = ccb.content.plural_text("dusted crawling zombie", "dusted crawling zombies"),
    description = ccb.content.text("This moving corpse with badly damaged legs has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_crawler",
    default_faction = "zombie_dusted",
    color = "light_gray",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_crawler_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_fungalize",
    name = ccb.content.plural_text("fungal stalk crawler", "fungal stalk crawlers"),
    description = ccb.content.text("This moving corpse with badly damaged legs has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_crawler",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_crawler_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_fungal",
    name = ccb.content.plural_text("fungal zombie crawler", "fungal zombie crawlers"),
    description = ccb.content.text("This fungal monster struggles to move as bulbous mushrooms grow from its exposed back.  Its leg seems to be wrapped in sturdy tendrils, and its arms visibly swell and pop gruesomely with each drag along the ground."),
    copy_from = "mon_zombie_crawler",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fat_dusted",
    name = ccb.content.plural_text("dusted fat zombie", "dusted fat zombies"),
    description = ccb.content.text("This heavy moving corpse has been heavily dusted with a thick gray powder."),
    copy_from = "mon_zombie_fat",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_fat_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fat_fungalize",
    name = ccb.content.plural_text("fungal stalk feeder", "fungal stalk feeders"),
    description = ccb.content.text("This heavy corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_fat",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_fat_fungus" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fat_fungus",
    name = ccb.content.plural_text("fungal feeder", "fungal feeders"),
    description = ccb.content.text("Thousands upon thousands of fungal bulbs, sprouts and tendrils jut out from every angle of this walking carcass.  Large patches of yellow pulsating mold seem to be growing in the zombie's fat folds."),
    copy_from = "mon_zombie_fat",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_beekeeper_dusted",
    name = ccb.content.plural_text("dusted scarred zombie", "dusted scarred zombies"),
    description = ccb.content.text("This heavily scarred moving corpse has been covered with a thick gray powder."),
    copy_from = "mon_beekeeper",
    default_faction = "zombie_dusted",
    color = "light_gray",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_beekeeper_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_beekeeper_fungalize",
    name = ccb.content.plural_text("fungalizing scarred zombie", "fungalizing scarred zombies"),
    description = ccb.content.text("This heavily scarred moving corpse has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_beekeeper",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_beekeeper_fungal" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_beekeeper_fungal",
    name = ccb.content.plural_text("scarred fungal zombie", "scarred fungal zombies"),
    description = ccb.content.text("The tough callouses and scar tissue of this unfortunate corpse are the only remaining signs of something once made of flesh; any spot seemingly soft enough has been thoroughly punctured by thick fungal tendrils that have started to creep over this disfigured husk."),
    copy_from = "mon_beekeeper",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_acidic_dusted",
    name = ccb.content.plural_text("dusted acidic zombie", "dusted acidic zombies"),
    description = ccb.content.text("This acrid smelling moving corpse has been covered with a thick gray powder."),
    copy_from = "mon_zombie_acidic",
    default_faction = "zombie_dusted",
    color = "light_gray_yellow",
    vision_day = 10,
    upgrade = { grow_at_age = 1, monster = "mon_zombie_acidic_fungalize" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.6 },
        offset = { melee_skill = -1, melee_dice = -1 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_acidic_fungalize",
    name = ccb.content.plural_text("fungalizing acid zombie", "fungalizing acid zombies"),
    description = ccb.content.text("This sickly looking moving corpse with prominent yellow veins has grown a short stalk of gray fungus bursting from the skull."),
    copy_from = "mon_zombie_acidic",
    default_faction = "fungus",
    color = "light_gray_yellow",
    bleed_rate = 50,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom",
    upgrade = { grow_at_age = 1, monster = "mon_zombie_fungus_acidic" },
    inheritance = {
        add = { species = { "FUNGUS" }, flags = { "NO_FUNG_DMG" } },
        scale = { speed = 0.3 },
        offset = { melee_skill = -1, melee_dice = -1, armor = { bash = 1, electric = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus_acidic",
    name = ccb.content.plural_text("acidic fungal zombie", "acidic fungal zombies"),
    description = ccb.content.text("A grotesque fusion of rot and mycelium, this zombie's flesh is pocked with open sores that lazily drool a strange yellow-green acid.  Pale fungal stalks have burst through its corroded skin, their slimy caps dripping with what seems to be the same fluid.  The air around it is thick with the scent of rot and acrid chemicals."),
    copy_from = "mon_zombie_acidic",
    default_faction = "fungus",
    color = "light_gray_yellow",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_humanoid_mushroom_acid",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_fungal_mound",
    name = ccb.content.plural_text("fungal mound", "fungal mounds"),
    description = ccb.content.text("A pale white pile of fungus, growing over a mass of gore.  The ground below it seems to be actively keeping whatever was left of the corpse 'alive', slowly rebuilding it from the ground up."),
    species = { "FUNGUS" },
    default_faction = "fungus",
    volume = "62500 ml",
    mass = "81500 g",
    hp = 40,
    speed = 100,
    materials = { "veggy" },
    symbol = "B",
    color = "light_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "bash", amount = 2 } },
    dodge = 1,
    weakpoint_sets = { "wps_fungaloid" },
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_fungaloid_basic",
        "prof_wp_fungaloid_advanced",
    },
    vision_day = 2,
    vision_night = 2,
    harvest = "fungaloid",
    attacks = { { reference = "FUNGUS", cooldown = 50 } },
    upgrade = { monster = "mon_fungal_construct", half_life = 2 },
    regenerates = 1,
    flags = { "IMMOBILE", "SEES", "WARM", "POISON", "REVIVES", "NO_BREATHE", "FILTHY", "SWARMS", "NOHEAD" },
    armor = { bash = 3, cut = 6, bullet = 3, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_fungal_construct",
    name = ccb.content.plural_text("fungal construct", "fungal constructs"),
    description = ccb.content.text("A pale white pile of moving fungus, growing over a mass of gore.  The interwoven vines and constricting roots force the pulp beneath to move, even though nothing is set right.  It creaks like a loose floorboard."),
    species = { "FUNGUS" },
    default_faction = "fungus",
    volume = "62500 ml",
    mass = "81500 g",
    hp = 70,
    speed = 50,
    materials = { "veggy" },
    symbol = "B",
    color = "light_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "bash", amount = 2 } },
    dodge = 2,
    weakpoint_sets = { "wps_fungaloid" },
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_fungaloid_basic",
        "prof_wp_fungaloid_advanced",
    },
    vision_day = 10,
    vision_night = 2,
    harvest = "fungaloid",
    attacks = { { reference = "FUNGUS", cooldown = 50 } },
    regenerates = 1,
    flags = { "SEES", "WARM", "POISON", "REVIVES", "NO_BREATHE", "FILTHY", "NOHEAD" },
    armor = { bash = 3, cut = 6, bullet = 3, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_fungal_mound_large",
    name = ccb.content.plural_text("large fungal mound", "large fungal mounds"),
    description = ccb.content.text("A pale white pile of fungus, growing over a large mass of gore.  The ground below it seems to be actively keeping whatever was left of the corpse 'alive', slowly rebuilding into a large mass."),
    copy_from = "mon_fungal_mound",
    hp = 100,
    vision_day = 20,
    vision_night = 5,
    harvest = "fungaloid",
    upgrade = { monster = "mon_fungal_construct_large", half_life = 2 },
    attacks = { { reference = "FUNGUS", cooldown = 45 } },
    regenerates = 2,
    armor = { bash = 4, cut = 8, bullet = 4, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_fungal_construct_large",
    name = ccb.content.plural_text("large fungal construct", "large fungal constructs"),
    description = ccb.content.text("A pale white pile of moving fungus, growing over a large mass of gore.  The interwoven vines and constricting roots force the large pulp beneath to move, even though nothing is set right.  Its own weight seems to grind on the bones keeping it together."),
    copy_from = "mon_fungal_construct",
    hp = 140,
    speed = 60,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "bash", amount = 2 } },
    dodge = 3,
    vision_day = 15,
    vision_night = 5,
    harvest = "fungaloid",
    attacks = { { reference = "FUNGUS", cooldown = 45 } },
    regenerates = 2,
    armor = { bash = 4, cut = 8, bullet = 4, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_fungal_mound_massive",
    name = ccb.content.plural_text("massive fungal mound", "massive fungal mounds"),
    description = ccb.content.text("A pale white pile of fungus, growing over a giant mass of gore.  The ground below it seems to be actively keeping whatever was left of the corpse 'alive', slowly rebuilding it from the ground up."),
    copy_from = "mon_fungal_mound",
    volume = "875 L",
    mass = "1000 kg",
    hp = 200,
    vision_day = 20,
    vision_night = 5,
    harvest = "fungaloid",
    upgrade = { monster = "mon_fungal_construct_massive", half_life = 2 },
    attacks = { { reference = "FUNGUS", cooldown = 40 } },
    regenerates = 3,
    armor = { bash = 5, cut = 10, bullet = 5, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_fungal_construct_massive",
    name = ccb.content.plural_text("massive fungal construct", "massive fungal constructs"),
    description = ccb.content.text("A pale white pile of moving fungus, growing over a giant mass of gore.  The interwoven vines and constricting roots force the pulp beneath to move, even though nothing is set right.  Its form is unnaturally hunched over, but its mass alone makes it a threat nonetheless."),
    copy_from = "mon_fungal_construct",
    volume = "875 L",
    mass = "1000 kg",
    hp = 300,
    speed = 75,
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 5,
    melee_damage = { { type = "bash", amount = 2 } },
    dodge = 3,
    vision_day = 20,
    vision_night = 7,
    harvest = "fungaloid",
    attacks = { { reference = "FUNGUS", cooldown = 40 } },
    regenerates = 3,
    armor = { bash = 5, cut = 10, bullet = 5, electric = 4 },
}

ccb.content.define_monster {
    id = "mon_zombie_dog_fungus",
    name = ccb.content.plural_text("fungal dog", "fungal dogs"),
    description = ccb.content.text("The deformed, animated, and again reanimated corpse of a what looked like the concept of a canine.  It has lost almost all of its dog-like features, except for its constant aggressive growling, and tendency to bite.  It shakes its fur like a wet dog, sending tiny spore clouds everywhere."),
    copy_from = "mon_zombie_dog",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zoose_fungus",
    name = ccb.content.plural_text("antlered fungal horror", "antlered fungal horrors"),
    description = ccb.content.text("This formerly-majestic beast has lost any semblance of what a moose is, aside from its outgrown antlers, now covered in writhing fungal tendrils, seemingly trying to break into the cracking bone.  The animated corpse seems to be in a state of constant disrepair, held together by strange, sticky blue orbs."),
    copy_from = "mon_zoose",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zougar_fungus",
    name = ccb.content.plural_text("fungal pouncer", "fungal pouncers"),
    description = ccb.content.text("This four legged, oversized cat seems to spew spores from its pawpads with each clumsy landing, as if constantly gaining and losing balance in air."),
    copy_from = "mon_zougar",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_fungus",
    name = ccb.content.plural_text("rotten fungal horse", "rotten fungal horses"),
    description = ccb.content.text("This hulking horse-figure seems to re-learn galloping with every step, as large fungi cling and sprout off of its mane.  It travels towards anything moving, even though in the center of each eye lies multiple fungal blooms."),
    copy_from = "mon_zombie_horse",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_ziger_fungus",
    name = ccb.content.plural_text("tiger fungal wight", "tiger fungal wights"),
    description = ccb.content.text("This rotting tiger has lost its stumble, as large fungal bulbs seem to have extended its pawpads thoroughly.  Its head crackles when trying to turn, seemingly stuck facing forward."),
    copy_from = "mon_ziger",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeer_fungus",
    name = ccb.content.plural_text("fungal wight", "fungal wights"),
    description = ccb.content.text("This deer's thick fur is spotted with blue orbs that seem to pop and ooze every few minutes, and its rotten skin seems unable to fall off, held together by thick fungal bedding underneath."),
    copy_from = "mon_zeer",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeindeer_fungus",
    name = ccb.content.plural_text("fungal reindeer", "fungal reindeer"),
    description = ccb.content.text("This bumpy, discolored reindeer resembles a malformed Rudolph, its nose having a faintly glowing red fungal sprout.  It'd look almost comical if it wasn't mutilating bodies with its innate strength."),
    copy_from = "mon_zeindeer",
    default_faction = "fungus",
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    harvest = "zombie_animal_mushroom",
    upgrade = false,
    inheritance = {
        add = {
            species = { "FUNGUS" },
            flags = { "NO_FUNG_DMG" },
            attacks = { { reference = "FUNGUS", cooldown = 200 } },
        },
        scale = { hp = 0.75, speed = 0.55 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 2, electric = 4 } },
    },
}
