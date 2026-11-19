local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_hallucinator",
    copy_from = "mon_hallucinator",
    species = { "NETHER_EMANATION", "PSI_NULL" },
}

ccb.content.define_monster {
    id = "mon_hunting_horror",
    copy_from = "mon_hunting_horror",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shadow",
    copy_from = "mon_shadow",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -40 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_shadow_snake",
    copy_from = "mon_shadow_snake",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -40 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_darkman",
    copy_from = "mon_darkman",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -80 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lieutenant_shadow",
    copy_from = "mon_lieutenant_shadow",
    inheritance = { add = { armor = { psi_photokinetic_damage = -80 } } },
}

ccb.content.define_monster { id = "mon_thing", copy_from = "mon_thing", inheritance = { add = { flags = { "TEEP_IMMUNE" } } } }

ccb.content.define_monster { id = "mon_yugg", copy_from = "mon_yugg", inheritance = { add = { flags = { "TEEP_IMMUNE" } } } }

ccb.content.define_monster {
    id = "mon_vortex",
    copy_from = "mon_vortex",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_archunk_weak",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_hanging_roper",
    copy_from = "mon_hanging_roper",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_carrion_grub",
    copy_from = "mon_carrion_grub",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_spearfisher",
    copy_from = "mon_nether_spearfisher",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_leech",
    copy_from = "mon_nether_leech",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_fish",
    copy_from = "mon_nether_fish",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_tower",
    copy_from = "mon_fungaloid_tower",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_queen",
    copy_from = "mon_fungaloid_queen",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_seeder",
    copy_from = "mon_fungaloid_seeder",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wall",
    copy_from = "mon_fungal_wall",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungal_hedgerow",
    copy_from = "mon_fungal_hedgerow",
    inheritance = { add = { armor = { psi_telepathic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_blossom",
    copy_from = "mon_fungal_blossom",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_tendril",
    copy_from = "mon_fungal_tendril",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid",
    copy_from = "mon_fungaloid",
    inheritance = { add = { armor = { psi_telepathic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_young",
    copy_from = "mon_fungaloid_young",
    inheritance = { add = { armor = { psi_telepathic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_shambler",
    copy_from = "mon_fungaloid_shambler",
    inheritance = { add = { armor = { psi_telepathic_damage = 30 } } },
}

ccb.content.define_monster {
    id = "mon_ant_fungus",
    copy_from = "mon_ant_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungus",
    copy_from = "mon_zombie_child_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus",
    copy_from = "mon_zombie_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 6 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_raptor",
    copy_from = "mon_fungal_raptor",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_fungus",
    copy_from = "mon_boomer_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 3 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wretch",
    copy_from = "mon_fungal_wretch",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_spider_fungus",
    copy_from = "mon_spider_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungus",
    copy_from = "mon_skeleton_hulk_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 50 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungus",
    copy_from = "mon_skeleton_brute_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungus",
    copy_from = "mon_skeleton_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_fungus",
    copy_from = "mon_zombie_gasbag_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 1 } } },
}

ccb.content.define_monster {
    id = "mon_feral_cop_fungal_infected",
    copy_from = "mon_feral_cop_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_infected",
    copy_from = "mon_feral_human_axe_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_corpse",
    copy_from = "mon_feral_human_axe_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_infected",
    copy_from = "mon_feral_human_pipe_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_corpse",
    copy_from = "mon_feral_human_pipe_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_infected",
    copy_from = "mon_feral_human_crowbar_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_corpse",
    copy_from = "mon_feral_human_crowbar_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go",
    copy_from = "mon_mi_go",
    inheritance = { add = { armor = { psi_telepathic_damage = 25 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_scout",
    copy_from = "mon_mi_go_scout",
    inheritance = { add = { armor = { psi_telepathic_damage = 25 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_guard",
    copy_from = "mon_mi_go_guard",
    inheritance = { add = { armor = { psi_telepathic_damage = 70 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_slaver",
    copy_from = "mon_mi_go_slaver",
    inheritance = { add = { armor = { psi_telepathic_damage = 35 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_surgeon",
    copy_from = "mon_mi_go_surgeon",
    inheritance = { add = { armor = { psi_telepathic_damage = 32 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_myrmidon",
    copy_from = "mon_mi_go_myrmidon",
    inheritance = { add = { armor = { psi_telepathic_damage = 120 } } },
}

ccb.content.define_monster {
    id = "mon_cow",
    copy_from = "mon_cow",
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_COW_MUTANT_BABIES" },
        count = 1,
        interval = 343,
    },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_1",
    copy_from = "mon_eigenspectre_1",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_2",
    copy_from = "mon_eigenspectre_2",
    species = { "NETHER_EMANATION" },
    inheritance = {
        add = { flags = { "PHOTOKIN_MONSTER_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } },
    },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_3",
    copy_from = "mon_eigenspectre_3",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_3_echo",
    copy_from = "mon_eigenspectre_3_echo",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_4",
    copy_from = "mon_eigenspectre_4",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_living_vector",
    copy_from = "mon_living_vector",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    copy_from = "mon_feral_human_crowbar",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe",
    copy_from = "mon_feral_human_pipe",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe",
    copy_from = "mon_feral_human_axe",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_tool",
    copy_from = "mon_feral_human_tool",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_cop",
    copy_from = "mon_feral_cop",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_survivalist",
    copy_from = "mon_feral_survivalist",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_militia",
    copy_from = "mon_feral_militia",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_knife",
    copy_from = "mon_feral_prepper_knife",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_mace",
    copy_from = "mon_feral_prepper_mace",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_jackboot",
    copy_from = "mon_feral_jackboot",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_soldier",
    copy_from = "mon_feral_soldier",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_sapien_spear",
    copy_from = "mon_feral_sapien_spear",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE_HIGHER_ODDS" },
}
