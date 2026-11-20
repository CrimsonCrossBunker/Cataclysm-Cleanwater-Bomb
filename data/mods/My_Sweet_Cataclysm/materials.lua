local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "sugar",
    name = ccb.content.text("Sugar"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 2.03,
    specific_heat_solid = 2.03,
    latent_heat = 57,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:resistance("electric", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 1, 1, 1)
definition:burn(2, false, 0, 1, 1, 2)
definition:burn(3, false, 0, 1, 1, 3)
content.replace(definition)
end
do
local definition = content.Material {
    id = "rock_candy",
    name = ccb.content.text("rock candy"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 20,
    density = 1,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 8)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 1, 1, 1)
definition:burn(2, false, 0, 1, 1, 2)
definition:burn(3, false, 0, 1, 1, 3)
definition:burn_product("sugar", 1)
content.add(definition)
end
