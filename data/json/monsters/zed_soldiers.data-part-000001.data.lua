local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_soldier_acid_1",
    name = ccb.content.plural_text("bilious soldier zombie", "bilious soldier zombies"),
    description = ccb.content.text("This staggering soldier wears a burnt gas mask, now fused to its face.  Through the melted, bile-encrusted ruination of the mask protrudes some sort of hardened, fleshy proboscis, with steaming corrosive fluid leaking from the end."),
    copy_from = "mon_zombie_soldier",
    looks_like = "mon_zombie_soldier",
    difficulty_adjustment = 20,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    inheritance = {
        add = {
            attacks = {
                { reference = "ACID_BARF", cooldown = 10 },
                {
                    cooldown = 15,
                    move_cost = 90,
                    kind = "gun",
                    gun = {
                        weapon = "acid_sniper",
                        skills = { { id = "gun", level = 4 }, { id = "rifle", level = 4 } },
                        dexterity = 8,
                        perception = 8,
                        lock_player = false,
                        target_moving_vehicles = true,
                        description = ccb.content.text("The %s launches a corrosive dart!"),
                        ranges = { { minimum = 2, maximum = 20, mode = "DEFAULT" } },
                    },
                },
            },
            flags = { "ACIDPROOF", "ACID_BLOOD" },
        },
        remove = { categories = { "CLASSIC" } },
        offset = { hp = 20, speed = 10, melee_skill = 1, vision_day = 10 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_acid_2",
    name = ccb.content.plural_text("caustic soldier zombie", "caustic soldier zombies"),
    description = ccb.content.text("This zombie wears what appears to have once been a soldier's uniform and armor, now a series of cracked and melted plates that have fused to its skin and thickened hide.  Its face and arms blister with strange, mutated tubes that pulse and drip with acid."),
    copy_from = "mon_zombie_soldier",
    looks_like = "mon_zombie_soldier",
    difficulty_adjustment = 20,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    upgrade = false,
    inheritance = {
        add = {
            attacks = {
                { reference = "ACID_BARF", cooldown = 5 },
                { id = "slam" },
                {
                    cooldown = 4,
                    move_cost = 50,
                    kind = "gun",
                    gun = {
                        weapon = "acid_spray",
                        skills = { { id = "gun", level = 4 }, { id = "rifle", level = 4 } },
                        dexterity = 8,
                        perception = 8,
                        lock_player = false,
                        target_moving_vehicles = true,
                        description = ccb.content.text("The %s launches a hail of corrosive darts!"),
                        ranges = { { minimum = 2, maximum = 8, mode = "DEFAULT" } },
                    },
                },
            },
            flags = { "ACIDPROOF", "ACID_BLOOD" },
        },
        remove = { categories = { "CLASSIC" } },
        offset = { hp = 40, speed = -10, melee_skill = 2, armor = { bash = 5 } },
    },
}
