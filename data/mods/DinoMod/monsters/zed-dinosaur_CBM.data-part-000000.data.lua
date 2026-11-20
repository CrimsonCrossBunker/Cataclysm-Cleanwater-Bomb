local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zpinosaurus_bio_op",
    name = ccb.content.plural_text("spinosaurus zombie bio-operator", "spinosaurus zombie bio-operators"),
    copy_from = "mon_zpinosaurus",
    difficulty_adjustment = 5,
    flags = {
        "NO_BREATHE", "ELECTRIC", "SEES", "SMELLS", "HEARS", "POISON", "STUMBLES", "BASHES", "DESTROYS",
        "NO_BREATHE", "REVIVES", "FILTHY", "WARM", "SWIMS", "INTERIOR_AMMO",
    },
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    vision_night = 50,
    luminance = 1,
    starting_ammo = { battery = 10 },
    attacks = {
        { id = "bio_op_takedown", cooldown = 20 },
        {
            cooldown = 20,
            move_cost = 10,
            kind = "gun",
            gun = {
                weapon = "laser_rifle_dino2",
                skills = { { id = "gun", level = 1 }, { id = "rifle", level = 1 } },
                dexterity = 1,
                ranges = { { minimum = 0, maximum = 30, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                target_moving_vehicles = true,
                laser_lock = false,
                targeting_cost = 1,
                targeting_extension = -1,
                targeting_sound = ccb.content.text("\"TARGET *zZzZzz* ACQUIRED.\""),
                targeting_volume = 70,
                ammo = "battery",
                empty_sound = ccb.content.text("*zZzzz*-TARGET ACQUIRED.  *beeeeeeeeep*.  OUT OF AMMO.-*zZzZ*"),
            },
        },
    },
    description = ccb.content.text("A shiny finned dinosaur corpse covered with bloody armor and crackling bionics.  It shambles quickly as it hunts.  Is that a laser rifle on its head?"),
    defense = { id = "ZAPBACK", chance = 20 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}
