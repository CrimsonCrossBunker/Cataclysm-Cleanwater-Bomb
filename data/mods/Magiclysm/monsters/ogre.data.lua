local ccb = require("ccb")

-- Two heads give it better vision but lower morale (heads disagree about when to run) and much better psionic armor.
ccb.content.define_monster {
    id = "mon_ogre_twoheaded",
    copy_from = "mon_ogre",
    name = ccb.content.plural_text("ettin", "ettins"),
    description = ccb.content.text("An enormous, clay-colored beast known for living in swamps and eating passersby.  This one has two heads, both moving independently and gazing around at their surroundings."),
    color = "brown",
    vision_day = 80,
    vision_night = 10,
    morale = 50,
    flags = {
        "SEES", "HEARS", "HAS_MIND", "WARM", "EATS", "BASHES", "PUSH_MON", "PUSH_VEH", "FILTHY",
        "PATH_AVOID_DANGER", "STUN_IMMUNE",
    },
    pathing = { avoid_traps = true, avoid_dangerous_fields = true },
    armor = { bash = 5, cut = 2, stab = 2, psionic = 50 },
}

ccb.content.define_monster {
    id = "mon_ogre_spider",
    copy_from = "mon_ogre",
    name = ccb.content.plural_text("ettercap", "ettercaps"),
    description = ccb.content.text("A hideous monstrosity, like a spider in the shape of a man.  Its dark purple skin is half-covered in chitin, long claws extend from its hands and feet, and eight eyes peer out from a distorted humanlike face."),
    color = "light_green",
    speed = 110,
    morale = 50,
    melee_skill = 4,
    melee_dice = 1,
    dodge = 4,
    melee_sides = 6,
    attacks = {
        {
            cooldown = 10,
            damage = { { type = "stab", amount = 10, penetration = 10 } },
            effects = { { id = "venom_weaken", chance = 25, duration = { 3600, 36000 } } },
            kind = "bite",
        },
        {
            id = "scratch",
            cooldown = 2,
            damage = { { type = "cut", amount = 15, penetration = 5 } },
        },
        { id = "grab", cooldown = 15 },
        { id = "mutant_spinneret", cooldown = 3 },
        { reference = "EAT_FOOD", cooldown = 120 },
    },
    fear_triggers = { "FIRE", "HURT" },
    flags = { "SEES", "HEARS", "HAS_MIND", "WARM", "EATS", "BASHES", "FILTHY", "PATH_AVOID_DANGER" },
    armor = { bash = 5, cut = 8, stab = 8, poison = 35 },
    inheritance = { scale = { hp = 0.5, mass = 0.6, volume = 0.6 } },
}

-- Third arm allows for grab_2 and scratching even while grabbing
ccb.content.define_monster {
    id = "mon_ogre_giant",
    copy_from = "mon_ogre",
    name = ccb.content.plural_text("athach", "athach"),
    description = ccb.content.text("A gigantic, ogre-like monster, nearly half again as tall as an ogre.  Two huge tusks jut forth from a mouth twisted into a snarl, and a third arm protrudes from the center of its chest."),
    color = "red_green",
    speed = 130,
    morale = 100,
    grab_strength = 100,
    attacks = {
        {
            id = "bite_humanoid",
            cooldown = 10,
            damage = { { type = "stab", amount = 40, penetration = 15 } },
            effects = { { id = "badpoison", chance = 50, duration = { 3600, 36000 } } },
        },
        { id = "grab", cooldown = 15 },
        { id = "grab_2", cooldown = 15 },
        {
            id = "scratch",
            cooldown = 3,
            damage = { { type = "cut", amount = 32, penetration = 6 } },
        },
        { id = "smash", throw_strength = 70 },
        { reference = "EAT_FOOD", cooldown = 120 },
    },
    flags = {
        "SEES", "HEARS", "HAS_MIND", "WARM", "EATS", "BASHES", "PUSH_MON", "PUSH_VEH", "FILTHY",
        "PATH_AVOID_DANGER",
    },
    inheritance = { scale = { hp = 2, mass = 2, volume = 2 } },
}
