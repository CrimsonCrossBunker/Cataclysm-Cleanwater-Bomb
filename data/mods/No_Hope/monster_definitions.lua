local content = require("ccb").content

content.add(content.Monster {
    id = "mon_zombie_bio_op",
    name = content.text("zombie bio-operator"),
    description = content.text("This armored soldier zombie appears to have been some sort of special forces agent.  Its malfunctioning equipment sends out occasional showers of sparks."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    hp = 120,
    speed = 95,
    color = "red_cyan",
    melee_skill = 7,
    melee_dice = 3,
    melee_sides = 6,
    luminance = 4,
    defense = { id = "ZAPBACK", chance = 75 },
    death_drops = "mon_zombie_bio_op_death_drops",
    dissect = "dissect_mon_zomborg",
}
    :armor("bash", 10)
    :armor("cut", 18)
    :armor("bullet", 14)
    :armor("electric", 3)
    :melee_damage("electric", 4)
    :attack("bio_op_takedown", 20)
    :flag("ELECTRIC")
    :flag("INFRARED_VISION")
    :weakpoint_set("wps_humanoid_body_armor")
    :weakpoint_set("wps_humanoid_open_helmet")
    :weakpoint_set("wps_humanoid_gasmask")
    :weakpoint_family("prof_wp_syn_armored"))
