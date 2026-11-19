local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_garden",
    name = ccb.content.plural_text("garden zombie", "garden zombies"),
    description = ccb.content.text("A zombie wearing some kind of gardening or botanic attire and is smeared full of vines, thorns, pollen and sap.  The triffids have it controlled somehow but its purpose remains unclear."),
    copy_from = "mon_beekeeper",
    default_faction = "triffid",
    harvest = "zombie_thorny",
    species = { "ZOMBIE", "PLANT" },
    materials = { "veggy" },
    symbol = "Z",
    color = "light_green",
    attack_effects = { { id = "paralyzepoison", duration = 33 } },
    attacks = {
        {
            spell = { id = "pollen_breath", min_level = 1 },
            cooldown = 15,
            casting_message = ccb.content.text("The zombie spews a cloud of pollen!"),
            kind = "spell",
        },
    },
    upgrade = { half_life = 80, monster_group = "GROUP_GARDEN_ZOMBIE_UPGRADE" },
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "BASHES", "GROUP_BASH", "POISON", "NO_BREATHE",
        "REVIVES", "PUSH_MON", "FILTHY", "PARALYZEVENOM",
    },
    death = { drops = "mon_zombie_thorny_death_drops" },
}

-- default zombie children clothing (always), additional items from child_items (sometimes)
ccb.content.define_monster {
    id = "mon_zombie_seedling",
    name = ccb.content.plural_text("garden child", "garden children"),
    description = ccb.content.text("This child zombie seems to have been adopted by plants.  It has several thorny vines and sprouts covering its head and body."),
    default_faction = "triffid",
    body_type = "human",
    species = { "ZOMBIE", "PLANT" },
    volume = "30000 ml",
    mass = "40750 g",
    hp = 40,
    speed = 65,
    materials = { "veggy" },
    symbol = "z",
    color = "light_green",
    aggression = 60,
    morale = 100,
    melee_skill = 2,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 2,
    vision_day = 30,
    vision_night = 3,
    harvest = "zombie_thorny",
    attacks = { { id = "scratch", attack_upper = false, cooldown = 15 } },
    burn_into = "mon_zombie_child_scorched",
    fungalize_into = "mon_zombie_child_fungus",
    upgrade = { half_life = 80, monster = "mon_zombie_flowerchild" },
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "BASHES", "POISON", "NO_BREATHE", "REVIVES",
        "FILTHY", "PARALYZEVENOM", "GUILT_CHILD",
    },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_children_clothes", weight = 100 },
                { id = "child_items", weight = 65 },
            },
        },
        outcome = { spell = { id = "death_guilt", min_level = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_flowerchild",
    name = ccb.content.plural_text("spriteling", "spritelings"),
    copy_from = "mon_zombie_seedling",
    description = ccb.content.text("An undead child mutated by alien flora.  It has several colorful flowers on its scalp and an unsettling serene expression."),
    attack_effects = { { id = "paralyzepoison", duration = 33 } },
}
