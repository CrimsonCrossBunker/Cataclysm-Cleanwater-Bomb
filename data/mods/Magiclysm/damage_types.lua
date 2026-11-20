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
