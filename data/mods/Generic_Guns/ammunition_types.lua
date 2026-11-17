local ccb = require("ccb")
local content = ccb.content

-- a combination flintlock and cap and ball type ammo.  Just roll with it.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_black_powder",
    name = ccb.content.text("black powder ammo"),
    default_item = "black_powder_ball",
})

-- ammo smaller than .380ACP
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_pistol_tiny",
    name = ccb.content.text("tiny pistol ammo"),
    default_item = "tiny_pistol_jhp",
})

-- .380 to .357sig
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_pistol",
    name = ccb.content.text("standard pistol ammo"),
    default_item = "pistol_ball",
})

-- .357mag and up.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_pistol_magnum",
    name = ccb.content.text("magnum pistol ammo"),
    default_item = "pistol_magnum_ball",
})

-- any rifle ammo less powerful than .375 H&H.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rifle",
    name = ccb.content.text("rifle ammo"),
    default_item = "rifle_ball",
})

-- any Exodii rifle ammo less powerful than .375 H&H.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rifle_foreign",
    name = ccb.content.text("foreign rifle ammo"),
    default_item = "rifle_ball_foreign",
})

-- specifically for Ree 3.3
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rifle_cannon",
    name = ccb.content.text("foreign cannon ammo"),
    default_item = "rifle_ball_cannon",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_railgun",
    name = ccb.content.text("railgun ammo"),
    default_item = "rifle_rail_ammo",
})

-- ammo from .375 H&H to .50BMG. Migrate anything stronger to as-yet unimplemented light cannon ammo
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rifle_huge",
    name = ccb.content.text("huge rifle ammo"),
    default_item = "rifle_huge_ball",
})

-- 20mm or greater ammo containing explosive material, usually 40mm.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_grenade",
    name = ccb.content.text("grenade ammo"),
    default_item = "grenade_ammo_hedp",
})

-- any rocket, missile, or rocket-like ordnance, like recoilless ammo
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rocket",
    name = ccb.content.text("rocket ammo"),
    default_item = "rocket_hedp",
})

-- small airgun pellets for hunting
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_rifle_pellet",
    name = ccb.content.text("air rifle pellet"),
    default_item = "rifle_pellet_target",
})

-- any ammunition for smoothbore projectiles, typically using wads and plastic hulls.
content.upsert_ammunition_type(content.AmmunitionType {
    id = "ammo_shot",
    name = ccb.content.text("shotgun ammo"),
    default_item = "shot_buck",
})
