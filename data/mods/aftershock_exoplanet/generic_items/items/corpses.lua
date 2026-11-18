local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_corpse_old",
        copy_from = "corpse",
        name = ccb.content.plural_text("mummified corpse", "mummified corpses"),
        description = ccb.content.text("The corpse of a long-dead colonist.  Near perfectly preserved by the merciless cold."),
        looks_like = "corpse_generic_human",
        volume_ml = 40000,
        mass_milligrams = 52000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_mon_sentinel_lx",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken Sentinel-lx", "broken Sentinels-lx"),
        category = "other",
        description = ccb.content.text("The irreparably broken remains of a Sentinel-lx.  Could be gutted for valuable parts."),
        price_cents = 30000,
        price_postapoc_cents = 1000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_bloodhound_drone",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken bloodhound drone", "broken bloodhound drones"),
        category = "other",
        description = ccb.content.text("This bloodhound won't be chasing anyone anymore.  Could be gutted for parts."),
        price_cents = 1000,
        mass_milligrams = 31520000,
        volume_ml = 15000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_fumigator",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken Croplord 2SPL", "broken Croplords 2SPL"),
        category = "other",
        description = ccb.content.text("A broken Croplord, now wrecked and immobile.  Could be gutted for parts."),
        price_cents = 1000,
        volume_ml = 1750,
        mass_milligrams = 1000000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_laserturret_xray",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken x-ray laser turret", "broken x-ray laser turrets"),
        mass_milligrams = 110000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_commercial_laser_turret",
        looks_like = "bot_rifleturret",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken SOL XII laser turret", "broken SOL XII laser turrets"),
        mass_milligrams = 110000000,
        copy_from = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_migoturret_whately",
        name = ccb.content.plural_text("broken Whately turret", "broken Whately turrets"),
        copy_from = "broken_afs_mon_migoturret",
        looks_like = "broken_afs_mon_migoturret",
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_skitterbot_grab",
        copy_from = "broken_skitterbot",
        looks_like = "broken_skitterbot",
        color = "light_gray",
        name = ccb.content.plural_text("broken grab-bot", "broken grab-bots"),
        description = ccb.content.text("A broken grabber robot, now limp and nonthreatening.  Could be stripped down or re-crafted."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_skitterbot_hunter",
        copy_from = "broken_skitterbot",
        looks_like = "broken_skitterbot",
        color = "light_gray",
        name = ccb.content.plural_text("broken pest hunter", "broken pest hunters"),
        description = ccb.content.text("A broken pest hunter, now harmless and inert.  Could be gutted for parts or re-crafted."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_scavbot_needle",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken Scavbot Skorpion", "broken Scavbot Skorpions"),
        category = "other",
        description = ccb.content.text("A broken Scavbot Skorpion.  Now that its legs lie broken and immobile, the world seems a little less threatening.  Could be gutted for parts."),
        price_cents = 1000,
        volume_ml = 12500,
        mass_milligrams = 10500000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_imaginifer",
        copy_from = "broken_milbot_disarmed",
        looks_like = "broken_milbot_disarmed",
        color = "light_gray",
        name = ccb.content.plural_text("broken Imaginifer", "broken Imaginifers"),
        description = ccb.content.text("A broken military humaniform, shattered and inert.  While it looks nowhere near human, you still feel uneasy - as if it is studying you with its eyes.  Could be stripped for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_milbot_40mm",
        copy_from = "broken_milbot_disarmed",
        looks_like = "broken_milbot_disarmed",
        color = "red",
        name = ccb.content.plural_text("broken Suppressor", "broken Suppressors"),
        description = ccb.content.text("A broken Suppressor, shattered and inert.  Could be stripped for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_eyebot_heater",
        copy_from = "broken_afs_eyebot",
        looks_like = "broken_afs_eyebot",
        color = "pink",
        name = ccb.content.plural_text("broken floating heater", "broken floating heaters"),
        description = ccb.content.text("A broken floating heater, now cold and motionless.  Could be stripped down or re-crafted."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_advbot_disarmed",
        symbol = ",",
        color = "white",
        looks_like = "broken_copbot",
        name = ccb.content.plural_text("broken disarmed advanced robot", "broken disarmed advanced robots"),
        category = "other",
        description = ccb.content.text("A broken advanced robot.  Its internal weapons have been removed.  Could be gutted for parts or crafted into a salvaged robot."),
        price_cents = 30000,
        price_postapoc_cents = 1000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("superalloy", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_advbot_laser",
        copy_from = "broken_advbot_disarmed",
        looks_like = "broken_advbot_disarmed",
        color = "yellow",
        name = ccb.content.plural_text("broken advanced robot", "broken advanced robots"),
        description = ccb.content.text("A broken advanced robot.  This one is armed with an integrated laser-emitter.  Could be stripped for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_wraitheon_irradiant",
        copy_from = "broken_advbot_disarmed",
        looks_like = "broken_advbot_disarmed",
        color = "magenta",
        name = ccb.content.plural_text("broken Irradiant", "broken Irradiants"),
        description = ccb.content.text("The irreparably broken remains of an Irradiant weapons platform.  Its mounted plasma cannon self-destructed when the robot was rendered inoperable, but its remains could still be disassembled for some valuable parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_wraitheon_isohypsa",
        copy_from = "broken_advbot_disarmed",
        looks_like = "broken_advbot_disarmed",
        color = "magenta",
        name = ccb.content.plural_text("broken Isohypsa", "broken Isohypsa"),
        description = ccb.content.text("The broken shell of an Isohypsa drone coordinator.  Most of its sensors and AI units are charred beyond any repair."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_wraitheon_kaburaya",
        copy_from = "broken_advbot_disarmed",
        looks_like = "broken_advbot_disarmed",
        color = "magenta",
        name = ccb.content.plural_text("broken Kabura-ya", "broken Kabura-ya"),
        description = ccb.content.text("A broken Kabura-ya drone.  Could be disassembled for a meager amount of parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_advbot_emp",
        copy_from = "broken_advbot_disarmed",
        looks_like = "broken_advbot_disarmed",
        color = "light_blue",
        name = ccb.content.plural_text("broken advanced robot", "broken advanced robots"),
        description = ccb.content.text("A broken advanced robot.  This one is armed with an integrated EMP projector.  Could be stripped for parts."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_milbot_disarmed",
        symbol = ",",
        color = "green",
        looks_like = "broken_secubot",
        name = ccb.content.plural_text("broken disarmed military bot", "broken disarmed military bots"),
        category = "other",
        description = ccb.content.text("A broken defense robot.  Its internal weapons have been removed.  Could be gutted for parts or crafted into a salvaged robot."),
        price_cents = 30000,
        price_postapoc_cents = 1000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_defbot_disarmed",
        symbol = ",",
        color = "light_gray",
        looks_like = "broken_riotbot",
        name = ccb.content.plural_text("broken disarmed defense bot", "broken disarmed defense bots"),
        category = "other",
        description = ccb.content.text("A broken defense robot.  Its internal weapons have been removed.  Could be gutted for parts or crafted into a salvaged robot."),
        price_cents = 30000,
        price_postapoc_cents = 1000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_eyebot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken eyebot", "broken eyebots"),
        category = "other",
        description = ccb.content.text("A broken eyebot.  Much less threatening now that it won't be calling for backup.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 31520000,
        volume_ml = 15000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_shock_mine",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("spent shock-mine", "spent shock-mines"),
        category = "other",
        description = ccb.content.text("A spent shock-mine, inert and harmless.  Cannot be recharged, but some of its components could be recycled."),
        price_cents = 10000,
        price_postapoc_cents = 10000,
        volume_ml = 1000,
        mass_milligrams = 1200000,
        melee_to_hit = -3,
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_zenit",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken Zenit", "broken Zenits"),
        category = "other",
        description = ccb.content.text("A broken Zenit security drone.  Could be disassembled for robotic components and heavy armor."),
        price_cents = 10000,
        price_postapoc_cents = 10000,
        volume_ml = 60000,
        mass_milligrams = 120000000,
        melee_to_hit = -3,
    }
    item:material("qt_steel", 1)
    item:material("vacuum_carbide", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("RADIOACTIVE")
    item:flag("LEAK_DAM")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_mech_horse",
        name = ccb.content.plural_text("broken STEED", "broken STEEDs"),
        description = ccb.content.text("A broken STEED, it looks beyond repair.  At least the atomic core shielding should be intact."),
        volume_ml = 600000,
        mass_milligrams = 800000000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = "H",
        color = "light_gray",
    }
    item:material("qt_steel", 1)
    item:material("nanoprinted_alloy", 1)
    item:material("kevlar", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_copbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken police bot", "broken police bots"),
        category = "other",
        description = ccb.content.text("A broken police bot.  Much less threatening now that it's quiet and still.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_riotbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken riot control bot", "broken riot control bots"),
        category = "other",
        description = ccb.content.text("A broken riot control bot.  Much less threatening now that it's out of gas.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end
