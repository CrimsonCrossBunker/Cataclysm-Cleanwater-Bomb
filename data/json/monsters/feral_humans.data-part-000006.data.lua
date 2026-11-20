local ccb = require("ccb")

-- Much shorter half-life since Noonien both reduces healing and suppresses feelings of hunger
-- all melee damage is decreased by 10% with assumption it is at least `|/` broken
ccb.content.define_monster {
    id = "mon_feral_serum_user_noonien",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("Clad in the remnants of an orange jumpsuit, this feral swings a pipe as they walk.  They hold it in one hand and move it like it's a stick, despite the  fittings on the end that must be increasing its weight."),
    upgrade = { half_life = 90, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    attacks = {
        { id = "smash", throw_strength = 20, cooldown = 25 },
        { id = "bio_op_takedown", cooldown = 15 },
        {
            id = "feral_weapon_pipe_mace",
            cooldown = 1,
            move_cost = 80,
            accuracy = 2,
            damage = { { type = "bash", amount = 18 } },
            avatar_hit = ccb.content.text("%1$s hits your %2$s with a pipe!"),
            npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a pipe!"),
            avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
            npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
            npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
            kind = "melee",
            when = "monster_attack_armed",
        },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    inheritance = { offset = { melee_skill = 2, melee_dice = 1, melee_sides = 2, dodge = 2 } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_super_soldier", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}
