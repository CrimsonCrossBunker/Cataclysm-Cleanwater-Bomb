local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_crawler_pupa_decoy",
    name = ccb.content.plural_text("pupating zombie crawler", "pupating zombie crawlers"),
    description = ccb.content.text("This half of a human corpse is wrapped in sticky black fibers that cover everything from the neck down.  Beneath the wrapping there is a strange rhythmic movement, grotesque to behold."),
    copy_from = "mon_zombie_crawler",
    species = { "ZOMBIE" },
    bleed_rate = 50,
    regenerates = 10,
    harvest = "zombie_pupating",
    armor = { electric = 1, bash = 7, cut = 5, bullet = 5 },
    inheritance = {
        add = { flags = { "SMALLSLUDGETRAIL", "SLUDGEPROOF" } },
        remove = { categories = { "CLASSIC" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_pupa",
    copy_from = "mon_zombie_crawler_pupa_decoy",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "small_raptor_spawn", hit_self = true },
                    cooldown = 50,
                    casting_message = ccb.content.text("%s bursts, and gore-smeared winged beasts climb out of the corpse!"),
                    kind = "spell",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_pupa_decoy",
    name = ccb.content.plural_text("pupating zombie", "pupating zombies"),
    description = ccb.content.text("This human corpse is wrapped in sticky black fibers that cover everything from the neck down.  Beneath the wrapping there is a strange rhythmic movement, grotesque to behold."),
    copy_from = "mon_zombie_fat",
    species = { "ZOMBIE" },
    harvest = "zombie_pupating",
    bleed_rate = 50,
    attacks = { { cooldown = 3, kind = "bite" } },
    regenerates = 10,
    armor = { electric = 2, bash = 8, cut = 6, bullet = 6 },
    inheritance = {
        add = { flags = { "SMALLSLUDGETRAIL", "SLUDGEPROOF" } },
        remove = { categories = { "CLASSIC" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_pupa",
    copy_from = "mon_zombie_pupa_decoy",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "small_raptor_spawn", hit_self = true },
                    cooldown = 50,
                    casting_message = ccb.content.text("%s bursts, and gore-smeared winged beasts climb out of the corpse!"),
                    kind = "spell",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_brute_pupa_decoy",
    name = ccb.content.plural_text("pupating brute", "pupating brutes"),
    description = ccb.content.text("This muscular human corpse is wrapped in sticky black fibers that cover everything from the neck down.  Beneath the wrapping there is a strange rhythmic movement, grotesque to behold."),
    copy_from = "mon_zombie_brute",
    species = { "ZOMBIE" },
    harvest = "zombie_pupating",
    speed = 95,
    regenerates = 10,
    upgrade = { half_life = 168, monster_group = "GROUP_BRUTE_PUPA" },
    inheritance = { add = { flags = { "SMALLSLUDGETRAIL", "SLUDGEPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_brute_pupa",
    copy_from = "mon_brute_pupa_decoy",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "big_raptor_spawn", hit_self = true },
                    cooldown = 50,
                    casting_message = ccb.content.text("%s bursts, and gore-smeared winged beasts climb out of the corpse!"),
                    kind = "spell",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_hulk_pupa_decoy",
    name = ccb.content.plural_text("hive hulk", "hive hulks"),
    description = ccb.content.text("The bloated torso of this gigantic corpse is wrapped in sticky black fibers.  Beneath the wrapping there is a strange rhythmic movement, grotesque to behold."),
    copy_from = "mon_zombie_hulk",
    species = { "ZOMBIE" },
    hp = 300,
    speed = 85,
    color = "white_magenta",
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 7,
    bleed_rate = 100,
    harvest = "zombie_pupating_hulk",
    grab_strength = 35,
    regenerates = 10,
    armor = { bash = 8, cut = 10, bullet = 10, electric = 6 },
    inheritance = { add = { flags = { "SMALLSLUDGETRAIL", "SLUDGEPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_hulk_pupa",
    copy_from = "mon_hulk_pupa_decoy",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "hive_raptor_spawn", hit_self = true },
                    cooldown = 30,
                    casting_message = ccb.content.text("%s opens its mouth, and a gore-smeared winged beast flies out of it!"),
                    kind = "spell",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_pupa_decoy_shady",
    name = ccb.content.plural_text("shady pupating zombie", "shady pupating zombies"),
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of what once may have been a human being, but its edges bulge rhythmically in places that are not anatomically possible for humans."),
    copy_from = "mon_zombie_fat",
    species = { "ZOMBIE" },
    attacks = { { cooldown = 3, kind = "bite" } },
    regenerates = 5,
    bleed_rate = 0,
    vision_day = 8,
    vision_night = 15,
    harvest = "zombie_humanoid_pupating_shadow",
    armor = { electric = 2, bash = 8, cut = 6, bullet = 6 },
    inheritance = {
        add = { flags = { "SMALLSLUDGETRAIL", "SLUDGEPROOF", "NIGHT_INVISIBILITY" } },
        remove = { categories = { "CLASSIC" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_pupa_shady",
    copy_from = "mon_zombie_pupa_decoy_shady",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "shady_raptor_spawn", hit_self = true },
                    cooldown = 50,
                    casting_message = ccb.content.text("%s bursts, and shadowy winged beasts climb out of the corpse!"),
                    kind = "spell",
                },
            },
        },
    },
}
