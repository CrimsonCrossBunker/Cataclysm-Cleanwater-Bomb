local ccb = require("ccb")

-- zombie goblins are basically blind during the day
ccb.content.define_monster {
    id = "mon_zombie_goblin",
    name = ccb.content.plural_text("zombie goblin", "zombie goblins"),
    copy_from = "mon_zombie",
    description = ccb.content.text("With bared teeth and black eyes filled with rage, this formerly-living goblin is now a walking nightmare.  While small, unlike the human zombies it was born with teeth and claws."),
    body_type = "human",
    species = { "ZOMBIE", "GOBLIN" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_child_body" },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5, attack_upper = false },
        {
            id = "scratch",
            attack_upper = false,
            cooldown = 4,
            damage = { { type = "cut", amount = 8 } },
            when = "monster_attack_intact_arms",
        },
    },
    vision_day = 3,
    vision_night = 15,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_GOBLIN_UPGRADE" },
    inheritance = { scale = { hp = 0.5, speed = 1.05, volume = 0.5, mass = 0.5 } },
    death = { drops = "feral_goblin_death_drops" },
}
