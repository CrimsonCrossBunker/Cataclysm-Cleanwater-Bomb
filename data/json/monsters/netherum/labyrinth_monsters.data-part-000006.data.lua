local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fleshborg_2_3_string_dimension",
    name = ccb.content.plural_text("planar fleshborg", "planar fleshborgs"),
    description = ccb.content.text("A flattened mockery of a cyborg, its form split into two overlapping, paper-thin silhouettes fused at their core.  Smooth metal plates ripple like ripped foil.  Its face is locked in an eternal scream, but it is unnaturally silent, as if it cannot throw its voice into this world."),
    copy_from = "mon_fleshborg_1_1",
    melee_skill = 6,
    dodge = 8,
    melee_dice = 3,
    starting_ammo = { bone_dart = 20 },
    flags = { "SEES", "HEARS", "WARM", "BASHES", "GROUP_BASH", "PUSH_MON", "HARDTOSHOOT", "FLIES" },
    emissions = { { id = "emit_twisting_mass_dust", delay = "1 s" } },
    attacks = {
        {
            cooldown = 10,
            move_cost = 100,
            kind = "gun",
            gun = {
                weapon = "bone_dart_launcher",
                ammo = "bone_dart",
                skills = { { id = "throw", level = 4 } },
                strength = 16,
                lock_player = false,
                ranges = { { minimum = 4, maximum = 7, mode = "DEFAULT" } },
                description = ccb.content.text("The fleshborg launches a glowing dart at you!"),
            },
            when = "monster_attack_intact_arms",
        },
        {
            spell = { id = "flatlander_attack", min_level = 1 },
            cooldown = 10,
            casting_message = ccb.content.text("Standing close to the %s, your body is violently dragged down to the second dimension.  You're there for only an instant but the experience is enough to send you reeling."),
            kind = "spell",
        },
    },
    death = { drops = "mon_fleshborg_2_3_string_dimension_drops" },
}
