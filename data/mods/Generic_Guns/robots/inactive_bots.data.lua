local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_antimateriel",
    copy_from = "bot_antimateriel",
    name = ccb.content.plural_text("CROWS II, heavy machinegun", "CROWS II, heavy machinegun"),
    description = ccb.content.text("This is an inactive turret.  Using this item involves loading the unit with the factory-loaded ball heavy machine gun ammunition rounds in your inventory (if you wish to divide your ammunition, set aside whatever ammunition you do NOT want to give the turret) turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully the turret will then identify you as a friendly, and attack all enemies with its heavy machine gun."),
    tool = {},
}

ccb.content.define_item {
    id = "bot_rifleturret",
    copy_from = "bot_rifleturret",
    name = ccb.content.plural_text("inactive CROWS II, light machinegun", "inactive CROWS II, light machinegun"),
    description = ccb.content.text("This is an inactive turret.  Using this item involves loading the unit with the factory-loaded ball rifle ammunition in your inventory (if you wish to divide your ammunition, set aside whatever ammunition you do NOT want to give the turret) turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully the turret will then identify you as a friendly, and attack all enemies with its light machine gun."),
    tool = {},
}

ccb.content.define_item {
    id = "bot_turret",
    copy_from = "bot_turret",
    name = ccb.content.plural_text("inactive turret", "inactive turrets"),
    description = ccb.content.text("This is an inactive turret.  Using this item involves loading the unit with the factory-loaded ball pistol ammunition in your inventory (if you wish to divide your ammunition, set aside whatever ammo you do NOT want to give the turret) turning it on, and placing it on the ground.  If reprogrammed and rewired successfully the turret will then identify you as a friendly, and attack all enemies with its SMG."),
    tool = {},
}

ccb.content.define_item {
    id = "bot_secubot",
    copy_from = "bot_secubot",
    name = ccb.content.plural_text("inactive TALON UGV", "inactive TALON UGVs"),
    description = ccb.content.text("This is an inactive TALON UGV equipped with an assault rifle.  Using this item involves loading the unit with the factory-loaded ball rifle ammo in inventory (if you wish to divide your ammunition, set aside whatever rifle ammo you do NOT want to give the robot) turning it on, and placing it on the ground.  If reprogrammed and rewired successfully the security bot will then identify you as a friendly, roam around or follow you, and attack all enemies with its rifle."),
    tool = {},
}

ccb.content.define_item {
    id = "bot_talon_m202a1",
    copy_from = "bot_talon_m202a1",
    name = ccb.content.plural_text("inactive launcher TALON UGV", "inactive launcher TALON UGVs"),
    description = ccb.content.text("This is an inactive TALON UGV equipped with a six shot grenade launcher.  Using this item involves loading the unit with the HEDP grenade cartridges in your inventory (if you wish to divide your ammunition, set aside whatever grenades you do NOT want to give the robot) turning it on, and placing it on the ground.  If reprogrammed and rewired successfully the UGV will then identify you as a friendly, roam around or follow you, and attack all enemies with its grenade launcher."),
    tool = {},
}
