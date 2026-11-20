local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_mass_grave_dino",
    name = ccb.content.text("Mass Grave"),
    description = ccb.content.text("A mass grave."),
    generator_method = "update_mapgen",
    generator_id = "mx_mass_grave_dino",
    z_levels = { 0, 0 },
    symbol = "X",
    color = "yellow",
    autonote_visibility = "details",
}
definition:flag("MAN_MADE")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_pred_abandoned",
    name = ccb.content.text("abandoned predator nest"),
    description = ccb.content.text("An abandoned predator nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_pred_abandoned",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_achelousaurus",
    name = ccb.content.text("achelousaurus nest"),
    description = ccb.content.text("An achelousaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_achelousaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_acrocanthosaurus",
    name = ccb.content.text("acrocanthosaurus nest"),
    description = ccb.content.text("An acrocanthosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_acrocanthosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_albertosaurus",
    name = ccb.content.text("albertosaurus nest"),
    description = ccb.content.text("An albertosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_albertosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_allosaurus",
    name = ccb.content.text("allosaurus nest"),
    description = ccb.content.text("An allosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_allosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_anchisaurus",
    name = ccb.content.text("anchisaurus nest"),
    description = ccb.content.text("An anchisaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_anchisaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_ankylosaurus",
    name = ccb.content.text("ankylosaurus nest"),
    description = ccb.content.text("An ankylosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_ankylosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_appalachiosaurus",
    name = ccb.content.text("appalachiosaurus nest"),
    description = ccb.content.text("An appalachiosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_appalachiosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_aquilops",
    name = ccb.content.text("aquilops nest"),
    description = ccb.content.text("An aquilops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_aquilops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_camptosaurus",
    name = ccb.content.text("camptosaurus nest"),
    description = ccb.content.text("A camptosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_camptosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_centrosaurus",
    name = ccb.content.text("centrosaurus nest"),
    description = ccb.content.text("A centrosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_centrosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_ceratosaurus",
    name = ccb.content.text("ceratosaurus nest"),
    description = ccb.content.text("A ceratosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_ceratosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_chasmosaurus",
    name = ccb.content.text("chasmosaurus nest"),
    description = ccb.content.text("A chasmosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_chasmosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_coelophysis",
    name = ccb.content.text("coelophysis nest"),
    description = ccb.content.text("A coelophysis nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_coelophysis",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_corythosaurus",
    name = ccb.content.text("corythosaurus nest"),
    description = ccb.content.text("A corythosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_corythosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_daspletosaurus",
    name = ccb.content.text("daspletosaurus nest"),
    description = ccb.content.text("A daspletosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_daspletosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_deinonychus",
    name = ccb.content.text("deinonychus nest"),
    description = ccb.content.text("A deinonychus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_deinonychus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dilophosaurus",
    name = ccb.content.text("dilophosaurus nest"),
    description = ccb.content.text("A dilophosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dilophosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dromaeosaurus",
    name = ccb.content.text("dromaeosaurus nest"),
    description = ccb.content.text("A dromaeosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dromaeosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dryosaurus",
    name = ccb.content.text("dryosaurus nest"),
    description = ccb.content.text("A dryosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dryosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dryptosaurus",
    name = ccb.content.text("dryptosaurus nest"),
    description = ccb.content.text("A dryptosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dryptosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dyoplosaurus",
    name = ccb.content.text("dyoplosaurus nest"),
    description = ccb.content.text("A dyoplosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dyoplosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_edmontonia",
    name = ccb.content.text("edmontonia nest"),
    description = ccb.content.text("An edmontonia nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_edmontonia",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_edmontosaurus",
    name = ccb.content.text("edmontosaurus nest"),
    description = ccb.content.text("An edmontosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_edmontosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_einiosaurus",
    name = ccb.content.text("einiosaurus nest"),
    description = ccb.content.text("An einiosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_einiosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_eolambia",
    name = ccb.content.text("eolambia nest"),
    description = ccb.content.text("An eolambia nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_eolambia",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_euoplocephalus",
    name = ccb.content.text("euoplocephalus nest"),
    description = ccb.content.text("An euoplocephalus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_euoplocephalus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_falcarius",
    name = ccb.content.text("falcarius nest"),
    description = ccb.content.text("A falcarius nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_falcarius",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_gallimimus",
    name = ccb.content.text("gallimimus nest"),
    description = ccb.content.text("A gallimimus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_gallimimus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_gargoyleosaurus",
    name = ccb.content.text("gargoyleosaurus nest"),
    description = ccb.content.text("A gargoyleosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_gargoyleosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_gastonia",
    name = ccb.content.text("gastonia nest"),
    description = ccb.content.text("A gastonia nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_gastonia",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_gorgosaurus",
    name = ccb.content.text("gorgosaurus nest"),
    description = ccb.content.text("A gorgosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_gorgosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_gryposaurus",
    name = ccb.content.text("gryposaurus nest"),
    description = ccb.content.text("A gryposaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_gryposaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_hadrosaurus",
    name = ccb.content.text("hadrosaurus nest"),
    description = ccb.content.text("A hadrosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_hadrosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_hesperosaurus",
    name = ccb.content.text("hesperosaurus nest"),
    description = ccb.content.text("A hesperosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_hesperosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_hypacrosaurus",
    name = ccb.content.text("hypacrosaurus nest"),
    description = ccb.content.text("A hypacrosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_hypacrosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_issi",
    name = ccb.content.text("issi nest"),
    description = ccb.content.text("An issi nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_issi",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_kosmoceratops",
    name = ccb.content.text("kosmoceratops nest"),
    description = ccb.content.text("A kosmoceratops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_kosmoceratops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_lambeosaurus",
    name = ccb.content.text("lambeosaurus nest"),
    description = ccb.content.text("A lambeosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_lambeosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_lokiceratops",
    name = ccb.content.text("lokiceratops nest"),
    description = ccb.content.text("A lokiceratops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_lokiceratops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_maiasaura",
    name = ccb.content.text("maiasaura nest"),
    description = ccb.content.text("A maiasaura nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_maiasaura",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nanosaurus",
    name = ccb.content.text("nanosaurus nest"),
    description = ccb.content.text("A nanosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nanosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nanotyrannus",
    name = ccb.content.text("nanotyrannus nest"),
    description = ccb.content.text("A nanotyrannus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nanotyrannus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nanuqsaurus",
    name = ccb.content.text("nanuqsaurus nest"),
    description = ccb.content.text("A nanuqsaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nanuqsaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nedcolbertia",
    name = ccb.content.text("nedcolbertia nest"),
    description = ccb.content.text("A nedcolbertia nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nedcolbertia",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nodosaurus",
    name = ccb.content.text("nodosaurus nest"),
    description = ccb.content.text("A nodosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nodosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_nothronychus",
    name = ccb.content.text("nothronychus nest"),
    description = ccb.content.text("A nothronychus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_nothronychus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_ornithomimus",
    name = ccb.content.text("ornithomimus nest"),
    description = ccb.content.text("An ornithomimus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_ornithomimus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_pachycephalosaurus",
    name = ccb.content.text("pachycephalosaurus nest"),
    description = ccb.content.text("A pachycephalosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_pachycephalosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_pachyrhinosaurus",
    name = ccb.content.text("pachyrhinosaurus nest"),
    description = ccb.content.text("A pachyrhinosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_pachyrhinosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_panoplosaurus",
    name = ccb.content.text("panoplosaurus nest"),
    description = ccb.content.text("A panoplosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_panoplosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_parasaurolophus",
    name = ccb.content.text("parasaurolophus nest"),
    description = ccb.content.text("A parasaurolophus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_parasaurolophus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_pentaceratops",
    name = ccb.content.text("pentaceratops nest"),
    description = ccb.content.text("A pentaceratops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_pentaceratops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_prosaurolophus",
    name = ccb.content.text("prosaurolophus nest"),
    description = ccb.content.text("A prosaurolophus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_prosaurolophus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_sarahsaurus",
    name = ccb.content.text("sarahsaurus nest"),
    description = ccb.content.text("A sarahsaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_sarahsaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_saurolophus",
    name = ccb.content.text("saurolophus nest"),
    description = ccb.content.text("A saurolophus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_saurolophus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_sauropelta",
    name = ccb.content.text("sauropelta nest"),
    description = ccb.content.text("A sauropelta nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_sauropelta",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_saurornitholestes",
    name = ccb.content.text("saurornitholestes nest"),
    description = ccb.content.text("A saurornitholestes nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_saurornitholestes",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_scolosaurus",
    name = ccb.content.text("scolosaurus nest"),
    description = ccb.content.text("A scolosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_scolosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_scutellosaurus",
    name = ccb.content.text("scutellosaurus nest"),
    description = ccb.content.text("A scutellosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_scutellosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_siats",
    name = ccb.content.text("siats nest"),
    description = ccb.content.text("A siats nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_siats",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_stegoceras",
    name = ccb.content.text("stegoceras nest"),
    description = ccb.content.text("A stegoceras nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_stegoceras",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_stegosaurus",
    name = ccb.content.text("stegosaurus nest"),
    description = ccb.content.text("A stegosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_stegosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_stenonychosaurus",
    name = ccb.content.text("stenonychosaurus nest"),
    description = ccb.content.text("A stenonychosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_stenonychosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_struthiomimus",
    name = ccb.content.text("struthiomimus nest"),
    description = ccb.content.text("A struthiomimus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_struthiomimus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_styracosaurus",
    name = ccb.content.text("styracosaurus nest"),
    description = ccb.content.text("A styracosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_styracosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_tawa",
    name = ccb.content.text("tawa nest"),
    description = ccb.content.text("A tawa nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_tawa",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_tenontosaurus",
    name = ccb.content.text("tenontosaurus nest"),
    description = ccb.content.text("A tenontosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_tenontosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_thescelosaurus",
    name = ccb.content.text("thescelosaurus nest"),
    description = ccb.content.text("A thescelosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_thescelosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_torosaurus",
    name = ccb.content.text("torosaurus nest"),
    description = ccb.content.text("A torosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_torosaurus",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_torvosaurus",
    name = ccb.content.text("torvosaurus nest"),
    description = ccb.content.text("A torvosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_torvosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_triceratops",
    name = ccb.content.text("triceratops nest"),
    description = ccb.content.text("A triceratops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_triceratops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_tyrannosaurus",
    name = ccb.content.text("tyrannosaurus nest"),
    description = ccb.content.text("A tyrannosaurus nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_tyrannosaurus",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_utahraptor",
    name = ccb.content.text("utahraptor nest"),
    description = ccb.content.text("A utahraptor nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_utahraptor",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_velociraptor",
    name = ccb.content.text("velociraptor nest"),
    description = ccb.content.text("A velociraptor nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_velociraptor",
    symbol = "D",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_zuniceratops",
    name = ccb.content.text("zuniceratops nest"),
    description = ccb.content.text("A zuniceratops nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_zuniceratops",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_zuul",
    name = ccb.content.text("zuul nest"),
    description = ccb.content.text("A zuul nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_zuul",
    symbol = "D",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_portal_dino_south_america",
    name = ccb.content.text("Portal"),
    description = ccb.content.text("Portal is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_portal_dino_south_america",
    z_levels = { -5, 5 },
    symbol = "P",
    color = "magenta",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_portal_dino_asia",
    name = ccb.content.text("Portal"),
    description = ccb.content.text("Portal is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_portal_dino_asia",
    z_levels = { -5, 5 },
    symbol = "P",
    color = "magenta",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_portal_dino_europe",
    name = ccb.content.text("Portal"),
    description = ccb.content.text("Portal is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_portal_dino_europe",
    z_levels = { -5, 5 },
    symbol = "P",
    color = "magenta",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
