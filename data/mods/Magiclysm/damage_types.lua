local ccb = require("ccb")
local content = ccb.content

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "poison",
    name = ccb.content.text("poison", { context = "damage_type" }),
    magic_color = "green",
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:immune_character_flag("POISON_IMMUNE")
definition:immune_monster_flag("POISONPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "light",
    name = ccb.content.text("light", { context = "damage_type" }),
    magic_color = "yellow",
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:derived("heat", 2)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "necrotic",
    name = ccb.content.text("necrotic", { context = "damage_type" }),
    magic_color = "black_green",
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:immune_monster_flag("TIMELESS")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "sonic",
    name = ccb.content.text("sonic", { context = "damage_type" }),
    magic_color = "h_white",
    bash_conversion_factor = 0.4,
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:derived("bash", 0.4)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "psionic",
    name = ccb.content.text("psionic", { context = "damage_type" }),
    magic_color = "pink",
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:immune_character_flag("PSIONIC_IMMUNE")
definition:immune_monster_flag("PSIONICPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "gravity",
    name = ccb.content.text("gravity", { context = "damage_type" }),
    magic_color = "white_magenta",
    bash_conversion_factor = 0.8,
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
content.add(definition)
end
do
local definition = content.DamageType {
    id = "nether",
    name = ccb.content.text("nether", { context = "damage_type" }),
    magic_color = "i_pink",
    melee_only = false,
    physical = false,
    monster_difficulty = true,
    material_required = false,
}
definition:immune_character_flag("NETHER_IMMUNE")
definition:immune_monster_flag("NETHERPROOF")
content.add(definition)
end
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "poison",
    display = "basic",
    verb = ccb.content.text("poisoning"),
}
definition:section("bionic", 850, true)
definition:section("protection", 550, true)
definition:section("pet_protection", 850, true)
definition:section("melee", 850, true)
definition:section("ablative", 850, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "light",
    display = "basic",
    verb = ccb.content.text("light"),
}
definition:section("bionic", 710, true)
definition:section("protection", 910, true)
definition:section("pet_protection", 610, true)
definition:section("melee", 710, true)
definition:section("ablative", 710, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "necrotic",
    display = "basic",
    verb = ccb.content.text("necrotizing"),
}
definition:section("bionic", 890, true)
definition:section("protection", 590, true)
definition:section("pet_protection", 890, true)
definition:section("melee", 890, true)
definition:section("ablative", 890, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "sonic",
    display = "basic",
    verb = ccb.content.text("sonic"),
}
definition:section("bionic", 990, true)
definition:section("protection", 690, true)
definition:section("pet_protection", 990, true)
definition:section("melee", 990, true)
definition:section("ablative", 990, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "psionic",
    display = "basic",
    verb = ccb.content.text("psionic"),
}
definition:section("bionic", 1000, true)
definition:section("protection", 700, true)
definition:section("pet_protection", 1000, true)
definition:section("melee", 1000, true)
definition:section("ablative", 1000, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "gravity",
    display = "basic",
    verb = ccb.content.text("gravity"),
}
definition:section("bionic", 1100, true)
definition:section("protection", 800, true)
definition:section("pet_protection", 1100, true)
definition:section("melee", 1100, true)
definition:section("ablative", 1100, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "nether",
    display = "basic",
    verb = ccb.content.text("nether"),
}
definition:section("bionic", 1200, true)
definition:section("protection", 800, true)
definition:section("pet_protection", 1200, true)
definition:section("melee", 1200, true)
definition:section("ablative", 1200, true)
content.add(definition)
end
