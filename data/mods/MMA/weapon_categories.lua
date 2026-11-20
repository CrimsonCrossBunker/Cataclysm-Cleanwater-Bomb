local ccb = require("ccb")
local content = ccb.content

-- Native weapon categories
do
local definition = content.WeaponCategory {
    id = "HYLIAN_IMPROV_WEAPONS",
    name = ccb.content.text("HYLIAN IMPROVISED WEAPONS"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "HYLIAN_MASTER_SWORD",
    name = ccb.content.text("THE MASTER SWORD"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_DESERT_WIND",
    name = ccb.content.text("Exemplar Weapon: Scimitars"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_DIAMOND_MIND",
    name = ccb.content.text("Exemplar Weapon: Rapiers"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_IRON_HEART",
    name = ccb.content.text("Exemplar Weapon: Katana"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_SETTING_SUN",
    name = ccb.content.text("Exemplar Weapon: Xiphe"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_STONE_DRAGON",
    name = ccb.content.text("Exemplar Weapon: Zweihänder"),
}
content.add(definition)
end
do
local definition = content.WeaponCategory {
    id = "EXEMPLAR_WEAPON_TIGER_CLAW",
    name = ccb.content.text("Exemplar Weapon: Kukri"),
}
content.add(definition)
end
