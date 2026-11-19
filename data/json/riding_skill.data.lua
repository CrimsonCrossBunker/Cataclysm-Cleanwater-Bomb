local ccb = require("ccb")

ccb.content.define_proficiency_category {
    id = "prof_riding",
    name = ccb.content.text("Mounted Combat (legacy)"),
    description = ccb.content.text("Legacy category retained for compatibility.  Mounted proficiencies are now in Athletics."),
}

ccb.content.define_proficiency {
    id = "prof_mounted_combat",
    category = "prof_athletics",
    name = ccb.content.text("mounted combat"),
    description = ccb.content.text("You can keep an effective fighting posture while controlling a living mount."),
    can_learn = true,
    time_to_learn = "30 m",
}

ccb.content.define_proficiency {
    id = "prof_mounted_archery",
    category = "prof_athletics",
    name = ccb.content.text("mounted shooting"),
    description = ccb.content.text("You compensate for a mount's movement while aiming and firing ranged weapons."),
    can_learn = true,
    time_to_learn = "2 h",
    requires = { "prof_mounted_combat" },
}

ccb.content.define_proficiency {
    id = "prof_mounted_piercing",
    category = "prof_athletics",
    name = ccb.content.text("mounted thrusting"),
    description = ccb.content.text("You align thrusting attacks with the motion and reach of your mount."),
    can_learn = true,
    time_to_learn = "2 h",
    requires = { "prof_mounted_combat" },
}

ccb.content.define_proficiency {
    id = "prof_mounted_cutting",
    category = "prof_athletics",
    name = ccb.content.text("mounted slashing"),
    description = ccb.content.text("You deliver controlled cutting attacks without losing your seat."),
    can_learn = true,
    time_to_learn = "2 h",
    requires = { "prof_mounted_combat" },
}

ccb.content.define_proficiency {
    id = "prof_mounted_bashing",
    category = "prof_athletics",
    name = ccb.content.text("mounted striking"),
    description = ccb.content.text("You use the mount's momentum to deliver balanced blunt strikes."),
    can_learn = true,
    time_to_learn = "2 h",
    requires = { "prof_mounted_combat" },
}
