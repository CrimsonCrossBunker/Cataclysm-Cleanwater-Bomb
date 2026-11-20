local ccb = require("ccb")
local content = ccb.content

-- Native weapon categories
do
local definition = content.WeaponCategory {
    id = "AUTOMATIC_RIFLES",
    name = ccb.content.text("AUTOMATIC RIFLES"),
}
definition:proficiency("prof_auto_rifles_familiar")
definition:proficiency("prof_auto_rifles_pro")
definition:proficiency("prof_auto_rifles_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "AUTOMATIC_PISTOLS",
    name = ccb.content.text("AUTOMATIC PISTOLS"),
}
definition:proficiency("prof_auto_pistols_familiar")
definition:proficiency("prof_auto_pistols_pro")
definition:proficiency("prof_auto_pistols_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "KNIVES",
    name = ccb.content.text("KNIVES"),
}
definition:proficiency("prof_knives_familiar")
definition:proficiency("prof_knives_pro")
definition:proficiency("prof_knives_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "BATONS",
    name = ccb.content.text("BATONS"),
}
definition:proficiency("prof_batons_familiar")
definition:proficiency("prof_batons_pro")
definition:proficiency("prof_batons_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "FLAILS",
    name = ccb.content.text("FLAILS"),
}
definition:proficiency("prof_flails_familiar")
definition:proficiency("prof_flails_pro")
definition:proficiency("prof_flails_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "MACES",
    name = ccb.content.text("MACES"),
}
definition:proficiency("prof_maces_familiar")
definition:proficiency("prof_maces_pro")
definition:proficiency("prof_maces_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "MEDIUM_SWORDS",
    name = ccb.content.text("MEDIUM SWORDS"),
}
definition:proficiency("prof_medium_swords_familiar")
definition:proficiency("prof_medium_swords_pro")
definition:proficiency("prof_medium_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "LONG_SWORDS",
    name = ccb.content.text("LONG SWORDS"),
}
definition:proficiency("prof_long_swords_familiar")
definition:proficiency("prof_long_swords_pro")
definition:proficiency("prof_long_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "SHORT_SWORDS",
    name = ccb.content.text("SHORT SWORDS"),
}
definition:proficiency("prof_short_swords_familiar")
definition:proficiency("prof_short_swords_pro")
definition:proficiency("prof_short_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "QUARTERSTAVES",
    name = ccb.content.text("QUARTERSTAVES"),
}
definition:proficiency("prof_quarterstaves_familiar")
definition:proficiency("prof_quarterstaves_pro")
definition:proficiency("prof_quarterstaves_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "CLAWS",
    name = ccb.content.text("CLAWS"),
}
definition:proficiency("prof_claws_familiar")
definition:proficiency("prof_claws_pro")
definition:proficiency("prof_claws_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "SHIVS",
    name = ccb.content.text("SHIVS"),
}
definition:proficiency("prof_shivs_familiar")
definition:proficiency("prof_shivs_pro")
definition:proficiency("prof_shivs_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "HOOKING_WEAPONRY",
    name = ccb.content.text("HOOKING WEAPONRY"),
}
definition:proficiency("prof_hooking_familiar")
definition:proficiency("prof_hooking_pro")
definition:proficiency("prof_hooking_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "SPEARS",
    name = ccb.content.text("SPEARS"),
}
definition:proficiency("prof_spears_familiar")
definition:proficiency("prof_spears_pro")
definition:proficiency("prof_spears_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "UNARMED",
    name = ccb.content.text("UNARMED"),
}
definition:proficiency("prof_unarmed_familiar")
definition:proficiency("prof_unarmed_pro")
definition:proficiency("prof_unarmed_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "POLEARMS",
    name = ccb.content.text("POLEARMS"),
}
definition:proficiency("prof_polearms_familiar")
definition:proficiency("prof_polearms_pro")
definition:proficiency("prof_polearms_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "FENCING_WEAPONRY",
    name = ccb.content.text("FENCING WEAPONRY"),
}
definition:proficiency("prof_fencing_weapons_familiar")
definition:proficiency("prof_fencing_weapons_pro")
definition:proficiency("prof_fencing_weapons_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "LONG_THRUSTING_SWORDS",
    name = ccb.content.text("LONG THRUSTING SWORDS"),
}
definition:proficiency("prof_thrusting_swords_familiar")
definition:proficiency("prof_thrusting_swords_pro")
definition:proficiency("prof_thrusting_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "BIONIC_WEAPONRY",
    name = ccb.content.text("BIONIC WEAPONRY"),
}
definition:proficiency("prof_bionics_familiar")
definition:proficiency("prof_bionics_pro")
definition:proficiency("prof_bionics_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "BIONIC_SWORDS",
    name = ccb.content.text("BIONIC SWORDS"),
}
definition:proficiency("prof_bionic_swords_familiar")
definition:proficiency("prof_bionic_swords_pro")
definition:proficiency("prof_bionic_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "GREAT_SWORDS",
    name = ccb.content.text("GREAT SWORDS"),
}
definition:proficiency("prof_great_swords_familiar")
definition:proficiency("prof_great_swords_pro")
definition:proficiency("prof_great_swords_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "GREAT_HAMMERS",
    name = ccb.content.text("GREAT HAMMERS"),
}
definition:proficiency("prof_great_hammers_familiar")
definition:proficiency("prof_great_hammers_pro")
definition:proficiency("prof_great_hammers_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "GREAT_AXES",
    name = ccb.content.text("GREAT AXES"),
}
definition:proficiency("prof_great_axes_familiar")
definition:proficiency("prof_great_axes_pro")
definition:proficiency("prof_great_axes_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "HAND_AXES",
    name = ccb.content.text("HAND AXES"),
}
definition:proficiency("prof_hand_axes_familiar")
definition:proficiency("prof_hand_axes_pro")
definition:proficiency("prof_hand_axes_master")
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "WHIPS",
    name = ccb.content.text("WHIPS"),
}
definition:proficiency("prof_whips_familiar")
definition:proficiency("prof_whips_pro")
definition:proficiency("prof_whips_master")
content.add(definition)
end
