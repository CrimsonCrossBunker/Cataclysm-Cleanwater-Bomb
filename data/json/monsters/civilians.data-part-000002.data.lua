local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_civilian_zombiefighter",
    name = ccb.content.plural_text("futile fighter", "futile fighters"),
    description = ccb.content.text("Obviously, this aggravated yet rallied person has lost their wits and tries to fight the undead with just a knife in their hands."),
    copy_from = "mon_civilian_panic",
    chat_topics = { "TALK_CIVILIAN_FIGHTER" },
    difficulty_adjustment = 3,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    melee_skill = 2,
    attacks = { { id = "feral_weapon_knife_combat_low_skill" } },
    melee_dice = 2,
    melee_sides = 3,
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "default_zombie_death_drops", probability = 100 },
                { group = "survivor_knife", probability = 100 },
            },
        },
    },
}
