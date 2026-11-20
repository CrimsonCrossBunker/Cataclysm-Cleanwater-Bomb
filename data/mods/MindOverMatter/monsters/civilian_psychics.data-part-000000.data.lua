local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_civilian_biokinetic",
    name = ccb.content.plural_text("bellicose brawler", "bellicose brawlers"),
    description = ccb.content.text("This bloodshot-eyed berserker hurls themselves at the zombie horde.  Despite their crude technique, they are moving faster than you've ever seen a human move, and some of their attacks send the zombies flying."),
    copy_from = "mon_civilian_clairsentient",
    chat_topics = { "TALK_CIVILIAN_FIGHTER" },
    difficulty_adjustment = 10,
    aggressive_to_characters = false,
    symbol = "@",
    color = "pink",
    hp = 85,
    speed = 110,
    aggression = 100,
    morale = 100,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 5,
    vision_day = 10,
    vision_night = 1,
    melee_damage = { { type = "bash", amount = 4 } },
    dodge = 3,
    upgrade = { half_life = 8, monster = "mon_feral_human_bio" },
    attacks = {
        {
            id = "smash",
            attack_upper = true,
            throw_strength = 40,
            cooldown = { 5, 15 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "bio_op_takedown",
            cooldown = 20,
            when = "allow_civilian_biokinetic_bio_op_takedown",
        },
    },
}
