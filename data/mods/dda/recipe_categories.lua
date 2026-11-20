local ccb = require("ccb")
local content = ccb.content

-- Native recipe categories
do
local definition = content.RecipeCategory {
    id = "CC_*",
    hidden = false,
    practice = false,
    building = false,
    wildcard = true,
}
definition:subcategory("CSC_*_FAVORITE")
definition:subcategory("CSC_*_RECENT")
definition:subcategory("CSC_*_HIDDEN")
definition:subcategory("CSC_*_NESTED")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_WEAPON",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_WEAPON_BASHING")
definition:subcategory("CSC_WEAPON_CUTTING")
definition:subcategory("CSC_WEAPON_PIERCING")
definition:subcategory("CSC_WEAPON_UNARMED")
definition:subcategory("CSC_WEAPON_RANGED")
definition:subcategory("CSC_WEAPON_EXPLOSIVE")
definition:subcategory("CSC_WEAPON_MODS")
definition:subcategory("CSC_WEAPON_MAGAZINES")
definition:subcategory("CSC_WEAPON_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_AMMO",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_AMMO_PISTOL")
definition:subcategory("CSC_AMMO_RIFLE")
definition:subcategory("CSC_AMMO_SHOT")
definition:subcategory("CSC_AMMO_GRENADES")
definition:subcategory("CSC_AMMO_ARROWS")
definition:subcategory("CSC_AMMO_COMPONENTS")
definition:subcategory("CSC_AMMO_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_FOOD",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_FOOD_DRINKS")
definition:subcategory("CSC_FOOD_DRY")
definition:subcategory("CSC_FOOD_MEAT")
definition:subcategory("CSC_FOOD_VEGGI")
definition:subcategory("CSC_FOOD_SNACK")
definition:subcategory("CSC_FOOD_BREAD")
definition:subcategory("CSC_FOOD_PASTA")
definition:subcategory("CSC_FOOD_BREW")
definition:subcategory("CSC_FOOD_SEEDS")
definition:subcategory("CSC_FOOD_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_CHEM",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_CHEM_DRUGS")
definition:subcategory("CSC_CHEM_FUEL")
definition:subcategory("CSC_CHEM_MUTAGEN")
definition:subcategory("CSC_CHEM_CHEMICALS")
definition:subcategory("CSC_CHEM_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_ELECTRONIC",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_ELECTRONIC_TOOLS")
definition:subcategory("CSC_ELECTRONIC_PARTS")
definition:subcategory("CSC_ELECTRONIC_LIGHTING")
definition:subcategory("CSC_ELECTRONIC_COMPONENTS")
definition:subcategory("CSC_ELECTRONIC_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_ARMOR",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_ARMOR_STORAGE")
definition:subcategory("CSC_ARMOR_SUIT")
definition:subcategory("CSC_ARMOR_HEAD")
definition:subcategory("CSC_ARMOR_TORSO")
definition:subcategory("CSC_ARMOR_ARMS")
definition:subcategory("CSC_ARMOR_HANDS")
definition:subcategory("CSC_ARMOR_LEGS")
definition:subcategory("CSC_ARMOR_FEET")
definition:subcategory("CSC_ARMOR_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_APPLIANCE",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_APPLIANCE_LIGHTING")
definition:subcategory("CSC_APPLIANCE_UTILITY")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_CAMP",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_CAMP_BASIC")
definition:subcategory("CSC_CAMP_EXPANSIONS")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_OTHER",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_OTHER_TOOLS")
definition:subcategory("CSC_OTHER_MEDICAL")
definition:subcategory("CSC_OTHER_CONTAINERS")
definition:subcategory("CSC_OTHER_MATERIALS")
definition:subcategory("CSC_OTHER_PARTS")
definition:subcategory("CSC_OTHER_TRAPS")
definition:subcategory("CSC_OTHER_VEHICLE")
definition:subcategory("CSC_OTHER_OTHER")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_ANIMALS",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_ANIMALS_BOVINE ARMOR")
definition:subcategory("CSC_ANIMALS_CANINE ARMOR")
definition:subcategory("CSC_ANIMALS_EQUINE ARMOR")
definition:subcategory("CSC_ANIMALS_EQUINE STORAGE")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_MUSIC",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_MUSIC_STRING")
definition:subcategory("CSC_MUSIC_WIND")
definition:subcategory("CSC_MUSIC_PERCUSSION")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_BUILDING",
    hidden = true,
    practice = false,
    building = true,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_BUILDING_BASES")
definition:subcategory("CSC_BUILDING_EXPANSIONS")
content.add(definition)
end
do
local definition = content.RecipeCategory {
    id = "CC_PRACTICE",
    hidden = false,
    practice = true,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_PRACTICE_SCIENCE")
definition:subcategory("CSC_PRACTICE_ELECTRONICS")
definition:subcategory("CSC_PRACTICE_FABRICATION")
definition:subcategory("CSC_PRACTICE_FOOD")
definition:subcategory("CSC_PRACTICE_SURVIVAL")
definition:subcategory("CSC_PRACTICE_TAILORING")
definition:subcategory("CSC_PRACTICE_ATHLETICS")
definition:subcategory("CSC_PRACTICE_COMPUTERS")
definition:subcategory("CSC_PRACTICE_DEVICES")
definition:subcategory("CSC_PRACTICE_HEALTH")
definition:subcategory("CSC_PRACTICE_MECHANICS")
definition:subcategory("CSC_PRACTICE_SOCIAL")
definition:subcategory("CSC_PRACTICE_MELEE")
definition:subcategory("CSC_PRACTICE_RANGED")
content.add(definition)
end
