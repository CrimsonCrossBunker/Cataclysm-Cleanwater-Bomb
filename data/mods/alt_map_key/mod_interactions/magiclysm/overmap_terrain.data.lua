local ccb = require("ccb")
local content = ccb.content

content.patch_overmap_terrain {
    ids = {
        "magiclysm_augmentation_clinic_ground", "magiclysm_augmentation_clinic_top",
        "magiclysm_augmentation_clinic_roof",
    },
    copy_from = "magiclysm_augmentation_clinic_ground",
    symbol = "A",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = {
        "goblin_1A", "goblin_2A", "goblin_3A", "goblin_4A", "goblin_5A", "goblin_1B", "goblin_2B",
        "goblin_3B", "goblin_4B", "goblin_5B", "goblin_1C", "goblin_2C", "goblin_3C", "goblin_4C",
        "goblin_5C", "goblin_1A_roof", "goblin_2A_roof", "goblin_3A_roof", "goblin_4A_roof",
        "goblin_5A_roof", "goblin_1B_roof", "goblin_2B_roof", "goblin_3B_roof", "goblin_4B_roof",
        "goblin_5B_roof", "goblin_1C_roof", "goblin_2C_roof", "goblin_3C_roof", "goblin_4C_roof",
        "goblin_5C_roof",
    },
    copy_from = "goblin_1A",
    symbol = "G",
    color = "red",
}

content.patch_overmap_terrain {
    ids = { "orc_village" },
    copy_from = "orc_village",
    symbol = "G",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "elf_workshop", "elf_workshop_roof" },
    copy_from = "elf_workshop",
    symbol = "E",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_shop" },
    copy_from = "magic_shop",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_shop_2ndfloor" },
    copy_from = "magic_shop_2ndfloor",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_shop_roof" },
    copy_from = "magic_shop_roof",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_cabin" },
    copy_from = "magic_cabin",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "magic_cabin_roof" },
    copy_from = "magic_cabin_roof",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "demon_spider_lair" },
    copy_from = "demon_spider_lair",
    symbol = "D",
    color = "white",
}

content.patch_overmap_terrain {
    ids = { "used_bookstore" },
    copy_from = "used_bookstore",
    symbol = "B",
    color = "white",
}

content.patch_overmap_terrain {
    ids = { "used_bookstore_roof" },
    copy_from = "used_bookstore_roof",
    symbol = "B",
    color = "white",
}

content.patch_overmap_terrain {
    ids = { "magic_basement", "house_technomancer_7", "house_technomancer_8" },
    copy_from = "magic_basement",
    symbol = "B",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = { "house_detatched5_basement" },
    copy_from = "house_detatched5_basement",
    symbol = "B",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "black_dragon_lair_z-0_NW", "black_dragon_lair_z-0_NE", "black_dragon_lair_z-0_SE",
        "black_dragon_lair_z-0_SW",
    },
    copy_from = "black_dragon_lair_z-0_NW",
    symbol = "D",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "ogre_mound" },
    copy_from = "ogre_mound",
    symbol = "O",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "ogre_mound_roof" },
    copy_from = "ogre_mound_roof",
    symbol = "O",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "lake_retreat_ground" },
    copy_from = "lake_retreat_ground",
    symbol = "#",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "lake_retreat_boathouse" },
    copy_from = "lake_retreat_boathouse",
    symbol = "B",
    color = "light_blue",
}

content.patch_overmap_terrain {
    ids = {
        "wizardtower1_ground", "wizardtower1_living", "wizardtower1_golems", "wizardtower1_study",
        "wizardtower1_roof", "wizardtower2_ground", "wizardtower2_stairs1", "wizardtower2_stairs2",
        "wizardtower2_study", "wizardtower2_roof",
    },
    copy_from = "wizardtower1_ground",
    symbol = "W",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "forest_tomb", "forest_tomb_roof", "forest_tomb_bottom" },
    copy_from = "forest_tomb",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "magic_academy_ground" },
    copy_from = "magic_academy_ground",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = {
        "magic_academy_2nd", "magic_academy_3rd", "magic_academy_4th", "magic_academy_5th",
        "magic_academy_6th", "magic_academy_7th", "magic_academy_8th",
    },
    copy_from = "magic_academy_2nd",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_academy_basement" },
    copy_from = "magic_academy_basement",
    symbol = "B",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "magic_academy_roof" },
    copy_from = "magic_academy_roof",
    symbol = "M",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = {
        "attunement_altar_NW", "attunement_altar_NE", "attunement_altar_SW", "attunement_altar_SE",
        "attunement_altar_NW_roof", "attunement_altar_NE_roof", "attunement_altar_SW_roof",
        "attunement_altar_SE_roof",
    },
    copy_from = "attunement_altar_NW",
    symbol = "A",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = {
        "mine_balrog_west", "mine_balrog_central", "mine_balrog_east", "mine_balrog_-1_west",
        "mine_balrog_-1_central", "mine_balrog_-1_east", "mine_balrog_finale_nw", "mine_balrog_finale_n",
        "mine_balrog_finale_ne", "mine_balrog_finale_sw", "mine_balrog_finale_s", "mine_balrog_finale_se",
        "mine_balrog_bottomless_pit", "mine_balrog_lava",
    },
    copy_from = "mine_balrog_west",
    symbol = "M",
    color = "light_gray",
}

content.patch_overmap_terrain {
    ids = { "magic_field_a1", "magic_field_a2", "magic_field_b1", "magic_field_b2" },
    copy_from = "magic_field_a1",
    symbol = ",",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "small_magic_field" },
    copy_from = "small_magic_field",
    symbol = ",",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "standing_teleport_stones" },
    copy_from = "standing_teleport_stones",
    symbol = "S",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "druid_ritual_home_z0", "druid_ritual_home_z1", "druid_ritual_home_z2", "druid_ritual_home_z3" },
    copy_from = "druid_ritual_home_z0",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = {
        "druid_ritual_home_crown_nw", "druid_ritual_home_crown_n", "druid_ritual_home_crown_ne",
        "druid_ritual_home_crown_w", "druid_ritual_home_crown", "druid_ritual_home_crown_e",
        "druid_ritual_home_crown_sw", "druid_ritual_home_crown_s", "druid_ritual_home_crown_se",
    },
    copy_from = "druid_ritual_home_crown_nw",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "last_mage_on_earth_shelter" },
    copy_from = "last_mage_on_earth_shelter",
    symbol = "L",
    color = "red",
}

content.patch_overmap_terrain {
    ids = {
        "forge_x0y0z0", "forge_x1y0z0", "forge_x2y0z0", "forge_x3y0z0", "forge_x0y1z0", "forge_x1y1z0",
        "forge_x2y1z0", "forge_x3y1z0", "forge_x0y2z0", "forge_x1y2z0", "forge_x2y2z0", "forge_x3y2z0",
        "forge_x0y3z0", "forge_x1y3z0", "forge_x2y3z0", "forge_x3y3z0", "forge_x0y0z1", "forge_x1y0z1",
        "forge_x2y0z1", "forge_x3y0z1", "forge_x0y1z1", "forge_x1y1z1", "forge_x2y1z1", "forge_x3y1z1",
        "forge_x0y2z1", "forge_x1y2z1", "forge_x2y2z1", "forge_x3y2z1", "forge_x0y3z1", "forge_x1y3z1",
        "forge_x2y3z1", "forge_x3y3z1", "forge_x0y0z2", "forge_x1y0z2", "forge_x2y0z2", "forge_x3y0z2",
        "forge_x0y1z2", "forge_x1y1z2", "forge_x2y1z2", "forge_x3y1z2", "forge_x0y2z2", "forge_x1y2z2",
        "forge_x2y2z2", "forge_x3y2z2", "forge_x0y3z2", "forge_x1y3z2", "forge_x2y3z2", "forge_x3y3z2",
        "forge_x0y0z3", "forge_x1y0z3", "forge_x2y0z3", "forge_x3y0z3", "forge_x0y1z3", "forge_x1y1z3",
        "forge_x2y1z3", "forge_x3y1z3", "forge_x0y2z3", "forge_x1y2z3", "forge_x2y2z3", "forge_x3y2z3",
        "forge_x0y3z3", "forge_x1y3z3", "forge_x2y3z3", "forge_x3y3z3", "forge_x0y0z4", "forge_x1y0z4",
        "forge_x2y0z4", "forge_x3y0z4", "forge_x0y1z4", "forge_x1y1z4", "forge_x2y1z4", "forge_x3y1z4",
        "forge_x0y2z4", "forge_x1y2z4", "forge_x2y2z4", "forge_x3y2z4", "forge_x0y3z4", "forge_x1y3z4",
        "forge_x2y3z4", "forge_x3y3z4",
    },
    copy_from = "forge_x0y0z0",
    symbol = "F",
    color = "cyan",
}
