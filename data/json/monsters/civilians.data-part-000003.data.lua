local ccb = require("ccb")

-- Range starts from 0 to get some shots out
ccb.content.define_monster {
    id = "mon_civilian_zombiegunner",
    name = ccb.content.plural_text("armed fighter", "armed fighters"),
    description = ccb.content.text("Handgun in hand, this person is determined to make a last stand against the horde."),
    copy_from = "mon_civilian_panic",
    chat_topics = { "TALK_CIVILIAN_GUNNER" },
    difficulty_adjustment = 3,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    melee_skill = 2,
    melee_dice = 2,
    melee_sides = 3,
    starting_ammo = { ["9mm"] = 10 },
    attacks = {
        {
            cooldown = 10,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "civilian_glock19",
                ammo = "9mm",
                skills = { { id = "gun", level = 2 }, { id = "pistol", level = 3 } },
                dexterity = 8,
                perception = 10,
                ranges = { { minimum = 0, maximum = 14, mode = "DEFAULT" } },
                lock_player = false,
                description = ccb.content.text("The gunman fires their sidearm!"),
            },
            when = "monster_attack_armed",
        },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "default_zombie_death_drops", probability = 100 },
                { item = "glock_19", probability = 100, charges = { 0, 6 } },
            },
        },
    },
}
