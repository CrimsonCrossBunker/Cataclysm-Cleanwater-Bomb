local content = require("ccb").content

-- migration.json
content.add(content.ItemMigration { from = { "afs_quilt" }, to = "quilt" })
content.add(content.ItemMigration { from = { "afs_quilt_patchwork" }, to = "quilt_patchwork" })
content.add(content.ItemMigration { from = { "exo_forcefield" }, to = "afs_backpack_shieldgen" })
content.add(content.ItemMigration { from = { "exo_forcefield_bash_cut" }, to = "afs_backpack_shieldgen" })
content.add(content.ItemMigration { from = { "exo_forcefield_ballistic_pierce" }, to = "afs_backpack_shieldgen" })
-- obsoleted from base game as part of https://github.com/CleverRaven/Cataclysm-DDA/pull/70989
content.add(content.ItemMigration { from = { "bio_trickle" }, to = "bio_microgen" })
-- obsoleted from base game as part of https://github.com/CleverRaven/Cataclysm-DDA/pull/70989
content.add(content.ItemMigration { from = { "bio_trickle" }, to = "bio_microgen" })
content.add(content.ItemMigration { from = "bio_forcefield_bash_cut_weak", to = "bio_shield_weak" })
content.add(content.ItemMigration { from = "bio_forcefield_bash_cut_medium", to = "bio_shield_medium" })
content.add(content.ItemMigration { from = "bio_forcefield_bash_cut_heavy", to = "bio_shield_heavy" })
content.add(content.ItemMigration { from = "bio_forcefield_ballistic_weak", to = "bio_shield_weak" })
content.add(content.ItemMigration { from = "bio_forcefield_ballistic_medium", to = "bio_shield_medium" })
content.add(content.ItemMigration { from = "bio_forcefield_ballistic_heavy", to = "bio_shield_heavy" })
content.add(content.ItemMigration { from = { "bot_eyebot" }, to = "afs_bot_eyebot" })
content.add(content.ItemMigration { from = { "broken_eyebot" }, to = "broken_afs_eyebot" })
content.add(content.ItemMigration { from = { "afs_broken_eyebot" }, to = "broken_afs_eyebot" })
content.add(content.ItemMigration { from = { "bot_copbot" }, to = "afs_bot_copbot" })
content.add(content.ItemMigration { from = { "broken_copbot" }, to = "broken_afs_copbot" })
content.add(content.ItemMigration { from = { "afs_broken_copbot" }, to = "broken_afs_copbot" })
content.add(content.ItemMigration { from = { "bot_riotbot" }, to = "afs_bot_riotbot" })
content.add(content.ItemMigration { from = { "broken_riotbot" }, to = "broken_afs_riotbot" })
content.add(content.ItemMigration { from = { "afs_broken_riotbot" }, to = "broken_afs_riotbot" })
content.add(content.ItemMigration { from = "broken_milbot_556", to = "broken_imaginifer" })
content.add(content.ItemMigration { from = "broken_defbot_shot", to = "broken_imaginifer" })
content.add(content.ItemMigration { from = "defbot_shot_chassis", to = "broken_imaginifer" })
content.add(content.ItemMigration { from = "broken_milbot_needle", to = "broken_imaginifer" })
content.add(content.ItemMigration { from = "alien_lard", to = "alien_tallow" })
content.add(content.ItemMigration { from = "frost_human_lard", to = "frost_human_tallow" })

-- items/migration_items.json
-- 5x50 migrations valid until obsolete basedgame 5x50 items are migrated
content.add(content.ItemMigration { from = "5x50dart", to = "afs_5x50dart" })
content.add(content.ItemMigration { from = "5x50heavy", to = "afs_5x50heavy" })
content.add(content.ItemMigration { from = "reloaded_5x50dart", to = "afs_reloaded_5x50dart" })
content.add(content.ItemMigration { from = "needlegun", to = "afs_needlegun" })
content.add(content.ItemMigration { from = "needlepistol", to = "afs_needlepistol" })
content.add(content.ItemMigration { from = "xlballistic_vest_empty", to = "afs_military_vestxl" })
content.add(content.ItemMigration { from = "xlballistic_vest_esapi", to = "afs_military_vestxl" })
content.add(content.ItemMigration { from = "5x50_hull", to = "afs_5x50_hull" })
content.add(content.ItemMigration { from = "5x50_50_mag", to = "afs_5x50_50_mag" })
content.add(content.ItemMigration { from = "5x50_100_mag", to = "afs_5x50_100_mag" })
content.add(content.ItemMigration { from = "bot_laserturret_x-ray", to = "bot_laserturret_xray" })

-- items/obsolete.json
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_cam_spy", to = "afs_motion_sensor" })
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_cam_spy_on", to = "afs_motion_sensor" })
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_magellan_suit_helmet_on", to = "afs_magellan_suit_helmet" })
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_frontier_cryomask_on", to = "afs_frontier_cryomask" })
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_magellan_suit_helmet_on", to = "jerky" })
-- remove after 0.J
content.add(content.ItemMigration { from = "afs_jerky", to = "meat" })
-- remove after 0.J
content.add(content.ItemMigration { from = "AID_AF_bio_trickle", to = "AID_AF_bio_power_storage" })
-- remove after 0.J
content.add(content.ItemMigration { from = "xlleather_belt", to = "leather_belt" })
-- remove after 0.J
content.add(content.ItemMigration { from = "xlpolice_belt", to = "police_belt" })
-- remove after 0.J
content.add(content.ItemMigration { from = "xllegpouch_large", to = "legpouch_large" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_torso_steel", to = "exo_torso_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_torso_steel", to = "exo_torso_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_torso_vcc", to = "exo_torso_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_torso_vcc", to = "exo_torso_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_leg_steel", to = "exo_leg_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_leg_steel", to = "exo_leg_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_leg_vcc", to = "exo_leg_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_leg_vcc", to = "exo_leg_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_helmet_steel", to = "exo_helmet_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_helmet_steel", to = "exo_helmet_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_helmet_vcc", to = "exo_helmet_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_helmet_vcc", to = "exo_helmet_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_arm_steel", to = "exo_arm_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_arm_steel", to = "exo_arm_steel" })
-- remove after 0.K
content.add(content.ItemMigration { from = "destroyed_exo_arm_vcc", to = "exo_arm_vcc" })
-- remove after 0.K
content.add(content.ItemMigration { from = "damaged_exo_arm_vcc", to = "exo_arm_vcc" })

-- migration/migration_items.json
content.add(content.ItemMigration { from = "shot_he", to = "afs_shot_he" })

-- items/gun/migrations.json
content.add(content.ItemMigration { from = { "v29" }, to = "afs_av22" })
content.add(content.ItemMigration { from = { "laser_rifle" }, to = "afs_a7" })
content.add(content.ItemMigration { from = { "emp_gun" }, to = "afs_xm34" })
