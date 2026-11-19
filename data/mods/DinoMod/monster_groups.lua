local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

-- These groups are called by the exhibit, zoo, and science basements, and NPC missions
content.add(content.MonsterGroup { id = "GROUP_DINOSAUR", load_mode = "append" }
    :group("GROUP_WILDERNESS_FOREST_DINO", 250, 1, 1, 1)
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 150, 1, 1, 1)
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 150, 1, 1, 1)
    :group("GROUP_DINOSAUR_PREDATOR_STREAM", 150, 1, 1, 1)
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 150, 1, 1, 1)
    :group("GROUP_DINOSAUR_CAVE", 150, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_SOUTH_AMERICA", load_mode = "append" }
    :monster("mon_eoraptor", 20, 0, 1, 2)
    :monster("mon_giganotosaurus", 10, 40, 1, 2)
    :monster("mon_amargasaurus", 5, 25, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ASIA", load_mode = "append" }
    :monster("mon_qianzhousaurus", 200, 40, 1, 2)
    :monster("mon_therizinosaurus", 200, 30, 1, 2)
    :monster("mon_velociraptor", 200, 10, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_EUROPE", load_mode = "append" }
    :monster("mon_compsognathus", 100, 40, 1, 2)
    :monster("mon_iguanodon", 100, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_HARMLESS", load_mode = "append" }
    :monster("mon_compsognathus", 100, 1, 1, 2)
    :monster("mon_nedcolbertia", 50, 1, 1, 2)
    :monster("mon_gallimimus", 50, 1, 1, 2)
    :monster("mon_struthiomimus", 50, 1, 1, 2)
    :monster("mon_ornithomimus", 50, 1, 1, 2)
    :monster("mon_albertonykus", 20, 1, 1, 2)
    :monster("mon_eoraptor", 20, 1, 1, 2)
    :monster("mon_sarahsaurus", 20, 1, 1, 2)
    :monster("mon_anchisaurus", 20, 1, 1, 2)
    :monster("mon_scutellosaurus", 20, 1, 1, 2)
    :monster("mon_gargoyleosaurus", 20, 1, 1, 2)
    :monster("mon_dyoplosaurus", 20, 1, 1, 2)
    :monster("mon_tenontosaurus", 100, 1, 1, 2)
    :monster("mon_dryosaurus", 100, 1, 1, 2)
    :monster("mon_camptosaurus", 100, 1, 1, 2)
    :monster("mon_eolambia", 100, 1, 1, 2)
    :monster("mon_stegoceras", 20, 1, 1, 2)
    :monster("mon_pachycephalosaurus", 25, 1, 1, 2)
    :monster("mon_aquilops", 25, 1, 1, 2)
    :monster("mon_nanosaurus", 20, 1, 1, 2)
    :monster("mon_leptoceratops", 3, 1, 4, 8)
    :monster("mon_zuniceratops", 3, 1, 4, 8)
    :monster("mon_fona", 20, 1, 1, 2)
    :monster("mon_oryctodromeus", 20, 1, 1, 2)
    :monster("mon_thescelosaurus", 20, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_DANGEROUS", load_mode = "append" }
    :monster("mon_tawa", 200, 5, 1, 2)
    :monster("mon_coelophysis", 200, 5, 1, 2)
    :monster("mon_dilophosaurus", 150, 10, 1, 2)
    :monster("mon_ceratosaurus", 100, 30, 1, 2)
    :monster("mon_allosaurus", 200, 30, 1, 2)
    :monster("mon_dryptosaurus", 200, 30, 1, 2)
    :monster("mon_nanotyrannus", 200, 30, 1, 2)
    :monster("mon_anzu", 100, 30, 1, 2)
    :monster("mon_saurornitholestes", 150, 10, 2, 4)
    :monster("mon_velociraptor", 150, 10, 1, 2)
    :monster("mon_deinonychus", 150, 15, 1, 2)
    :monster("mon_utahraptor", 100, 30, 1, 2)
    :monster("mon_dromaeosaurus", 150, 10, 1, 2)
    :monster("mon_stenonychosaurus", 5, 30, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_HARMLESS_HATCHLING", load_mode = "append" }
    :monster("mon_compsognathus_hatchling", 20, 0, 1, 2)
    :monster("mon_nedcolbertia_hatchling", 10, 0, 1, 2)
    :monster("mon_gallimimus_hatchling", 10, 0, 1, 2)
    :monster("mon_struthiomimus_hatchling", 10, 0, 1, 2)
    :monster("mon_ornithomimus_hatchling", 10, 0, 1, 2)
    :monster("mon_albertonykus_hatchling", 10, 0, 1, 2)
    :monster("mon_falcarius_hatchling", 5, 25, 1, 2)
    :monster("mon_nothronychus_hatchling", 5, 25, 1, 2)
    :monster("mon_eoraptor_hatchling", 10, 0, 1, 2)
    :monster("mon_sarahsaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_anchisaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_issi_hatchling", 10, 25, 1, 2)
    :monster("mon_moabosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_haplocanthosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_amargasaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_apatosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_brontosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_diplodocus_hatchling", 10, 20, 1, 2)
    :monster("mon_barosaurus_hatchling", 10, 20, 1, 2)
    :monster("mon_camarasaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_brachiosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_astrodon_hatchling", 10, 25, 1, 2)
    :monster("mon_alamosaurus_hatchling", 10, 25, 1, 2)
    :monster("mon_scutellosaurus_hatchling", 10, 0, 1, 2)
    :monster("mon_stegosaurus_hatchling", 10, 20, 1, 2)
    :monster("mon_hesperosaurus_hatchling", 10, 20, 1, 2)
    :monster("mon_gastonia_hatchling", 10, 1, 1, 2)
    :monster("mon_gargoyleosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_sauropelta_hatchling", 10, 1, 1, 2)
    :monster("mon_nodosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_panoplosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_edmontonia_hatchling", 10, 1, 1, 2)
    :monster("mon_zuul_hatchling", 10, 1, 1, 2)
    :monster("mon_dyoplosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_ankylosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_euoplocephalus_hatchling", 10, 1, 1, 2)
    :monster("mon_scolosaurus_hatchling", 10, 1, 1, 2)
    :monster("mon_tenontosaurus_hatchling", 10, 0, 1, 2)
    :monster("mon_dryosaurus_hatchling", 10, 0, 1, 2)
    :monster("mon_camptosaurus_hatchling", 10, 0, 1, 2)
    :monster("mon_eolambia_hatchling", 20, 10, 1, 2)
    :monster("mon_hadrosaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_maiasaura_hatchling", 20, 10, 1, 2)
    :monster("mon_gryposaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_prosaurolophus_hatchling", 20, 10, 1, 2)
    :monster("mon_saurolophus_hatchling", 20, 10, 1, 2)
    :monster("mon_edmontosaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_parasaurolophus_hatchling", 20, 10, 1, 2)
    :monster("mon_lambeosaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_corythosaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_hypacrosaurus_hatchling", 20, 10, 1, 2)
    :monster("mon_stegoceras_hatchling", 10, 0, 1, 2)
    :monster("mon_pachycephalosaurus_hatchling", 10, 0, 1, 2)
    :monster("mon_aquilops_hatchling", 10, 0, 1, 2)
    :monster("mon_leptoceratops_hatchling", 3, 10, 1, 2)
    :monster("mon_zuniceratops_hatchling", 3, 10, 1, 2)
    :monster("mon_lokiceratops_hatchling", 3, 10, 1, 2)
    :monster("mon_styracosaurus_hatchling", 3, 10, 1, 2)
    :monster("mon_centrosaurus_hatchling", 3, 10, 1, 2)
    :monster("mon_einiosaurus_hatchling", 3, 10, 1, 2)
    :monster("mon_centrosaurus_hatchling", 3, 10, 1, 2)
    :monster("mon_achelousaurus_hatchling", 10, 30, 1, 2)
    :monster("mon_pachyrhinosaurus_hatchling", 10, 30, 1, 2)
    :monster("mon_chasmosaurus_hatchling", 3, 10, 1, 2)
    :monster("mon_pentaceratops_hatchling", 10, 30, 1, 2)
    :monster("mon_torosaurus_hatchling", 10, 30, 1, 2)
    :monster("mon_triceratops_hatchling", 10, 30, 1, 2)
    :monster("mon_nanosaurus_hatchling", 20, 0, 1, 2)
    :monster("mon_fona_hatchling", 10, 30, 1, 2)
    :monster("mon_oryctodromeus_hatchling", 10, 30, 1, 2)
    :monster("mon_thescelosaurus_hatchling", 20, 0, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_DANGEROUS_HATCHLING", load_mode = "append" }
    :monster("mon_tawa_hatchling", 4, 5, 1, 2)
    :monster("mon_coelophysis_hatchling", 4, 5, 1, 2)
    :monster("mon_dilophosaurus_hatchling", 15, 10, 1, 2)
    :monster("mon_ceratosaurus_hatchling", 1, 30, 1, 2)
    :monster("mon_spinosaurus_hatchling", 1, 40, 1, 2)
    :monster("mon_torvosaurus_hatchling", 4, 30, 1, 2)
    :monster("mon_allosaurus_hatchling", 8, 30, 1, 2)
    :monster("mon_acrocanthosaurus_hatchling", 8, 40, 1, 2)
    :monster("mon_siats_hatchling", 8, 40, 1, 2)
    :monster("mon_dryptosaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_nanotyrannus_hatchling", 4, 35, 1, 2)
    :monster("mon_appalachiosaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_gorgosaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_albertosaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_nanuqsaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_daspletosaurus_hatchling", 4, 35, 1, 2)
    :monster("mon_tyrannosaurus_hatchling", 8, 40, 1, 2)
    :monster("mon_anzu_hatchling", 15, 10, 1, 2)
    :monster("mon_saurornitholestes_hatchling", 15, 10, 1, 2)
    :monster("mon_velociraptor_hatchling", 15, 10, 1, 2)
    :monster("mon_deinonychus_hatchling", 10, 15, 1, 2)
    :monster("mon_utahraptor_hatchling", 5, 30, 1, 1)
    :monster("mon_dromaeosaurus_hatchling", 15, 10, 1, 2)
    :monster("mon_stenonychosaurus_hatchling", 5, 30, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_HARMLESS_JUVENILE", load_mode = "append" }
    :monster("mon_nedcolbertia_juvenile", 50, 0, 1, 2)
    :monster("mon_gallimimus_juvenile", 50, 0, 1, 2)
    :monster("mon_struthiomimus_juvenile", 50, 0, 1, 2)
    :monster("mon_ornithomimus_juvenile", 50, 0, 1, 2)
    :monster("mon_sarahsaurus_juvenile", 50, 0, 1, 2)
    :monster("mon_anchisaurus_juvenile", 50, 0, 1, 2)
    :monster("mon_stegosaurus_juvenile", 10, 20, 1, 2)
    :monster("mon_hesperosaurus_juvenile", 10, 20, 1, 2)
    :monster("mon_gastonia_juvenile", 10, 1, 1, 2)
    :monster("mon_gargoyleosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_sauropelta_juvenile", 10, 1, 1, 2)
    :monster("mon_nodosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_panoplosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_edmontonia_juvenile", 10, 1, 1, 2)
    :monster("mon_zuul_juvenile", 10, 1, 1, 2)
    :monster("mon_dyoplosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_ankylosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_euoplocephalus_juvenile", 10, 1, 1, 2)
    :monster("mon_scolosaurus_juvenile", 10, 1, 1, 2)
    :monster("mon_tenontosaurus_juvenile", 50, 0, 1, 2)
    :monster("mon_camptosaurus_juvenile", 50, 0, 1, 2)
    :monster("mon_eolambia_juvenile", 20, 10, 1, 2)
    :monster("mon_hadrosaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_maiasaura_juvenile", 20, 10, 1, 2)
    :monster("mon_gryposaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_prosaurolophus_juvenile", 20, 10, 1, 2)
    :monster("mon_saurolophus_juvenile", 20, 10, 1, 2)
    :monster("mon_edmontosaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_parasaurolophus_juvenile", 20, 10, 1, 2)
    :monster("mon_lambeosaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_corythosaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_hypacrosaurus_juvenile", 20, 10, 1, 2)
    :monster("mon_pachycephalosaurus_juvenile", 25, 0, 1, 2)
    :monster("mon_leptoceratops_juvenile", 3, 10, 1, 2)
    :monster("mon_zuniceratops_juvenile", 3, 10, 1, 2)
    :monster("mon_thescelosaurus_juvenile", 20, 0, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_DANGEROUS_JUVENILE", load_mode = "append" }
    :monster("mon_dilophosaurus_juvenile", 15, 10, 1, 2)
    :monster("mon_ceratosaurus_juvenile", 1, 30, 1, 2)
    :monster("mon_spinosaurus_juvenile", 1, 40, 1, 2)
    :monster("mon_torvosaurus_juvenile", 4, 30, 1, 2)
    :monster("mon_allosaurus_juvenile", 8, 30, 1, 2)
    :monster("mon_dryptosaurus_juvenile", 5, 15, 1, 2)
    :monster("mon_nanotyrannus_juvenile", 5, 15, 1, 2)
    :monster("mon_anzu_juvenile", 5, 15, 1, 2)
    :monster("mon_deinonychus_juvenile", 10, 15, 1, 2)
    :monster("mon_utahraptor_juvenile", 5, 30, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_MEGA_HERBIVORE", load_mode = "append" }
    :monster("mon_issi", 5, 25, 1, 2)
    :monster("mon_moabosaurus", 5, 25, 1, 2)
    :monster("mon_haplocanthosaurus", 5, 25, 1, 2)
    :monster("mon_amargasaurus", 5, 25, 1, 2)
    :monster("mon_apatosaurus", 5, 25, 1, 2)
    :monster("mon_brontosaurus", 5, 25, 1, 2)
    :monster("mon_diplodocus", 10, 20, 1, 2)
    :monster("mon_barosaurus", 10, 20, 1, 2)
    :monster("mon_camarasaurus", 5, 25, 1, 2)
    :monster("mon_brachiosaurus", 5, 25, 1, 2)
    :monster("mon_astrodon", 5, 25, 1, 2)
    :monster("mon_alamosaurus", 5, 25, 1, 2)
    :monster("mon_stegosaurus", 5, 20, 1, 2)
    :monster("mon_hesperosaurus", 5, 20, 1, 2)
    :monster("mon_gastonia", 5, 20, 1, 2)
    :monster("mon_sauropelta", 5, 20, 1, 2)
    :monster("mon_nodosaurus", 5, 20, 1, 2)
    :monster("mon_panoplosaurus", 5, 20, 1, 2)
    :monster("mon_edmontonia", 5, 20, 1, 2)
    :monster("mon_zuul", 5, 20, 1, 2)
    :monster("mon_ankylosaurus", 5, 20, 1, 2)
    :monster("mon_euoplocephalus", 5, 20, 1, 2)
    :monster("mon_scolosaurus", 5, 20, 1, 2)
    :monster("mon_hadrosaurus", 3, 10, 1, 2)
    :monster("mon_maiasaura", 20, 10, 1, 2)
    :monster("mon_gryposaurus", 20, 10, 1, 2)
    :monster("mon_prosaurolophus", 20, 10, 1, 2)
    :monster("mon_saurolophus", 20, 10, 1, 2)
    :monster("mon_edmontosaurus", 20, 10, 1, 2)
    :monster("mon_parasaurolophus", 3, 10, 1, 2)
    :monster("mon_lambeosaurus", 20, 10, 1, 2)
    :monster("mon_corythosaurus", 20, 10, 1, 2)
    :monster("mon_hypacrosaurus", 20, 10, 1, 2)
    :monster("mon_lokiceratops", 3, 30, 1, 2)
    :monster("mon_styracosaurus", 3, 30, 1, 2)
    :monster("mon_centrosaurus", 3, 30, 1, 2)
    :monster("mon_einiosaurus", 3, 30, 1, 2)
    :monster("mon_achelousaurus", 3, 30, 1, 2)
    :monster("mon_pachyrhinosaurus", 3, 30, 1, 2)
    :monster("mon_chasmosaurus", 3, 30, 1, 2)
    :monster("mon_pentaceratops", 3, 30, 1, 2)
    :monster("mon_torosaurus", 3, 30, 1, 2)
    :monster("mon_triceratops", 3, 30, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_MEGA_CARNIVORE", load_mode = "append" }
    :monster("mon_spinosaurus", 50, 40, 1, 1)
    :monster("mon_torvosaurus", 50, 40, 1, 1)
    :monster("mon_acrocanthosaurus", 150, 40, 1, 1)
    :monster("mon_siats", 200, 40, 1, 1)
    :monster("mon_appalachiosaurus", 200, 35, 1, 1)
    :monster("mon_gorgosaurus", 200, 35, 1, 1)
    :monster("mon_albertosaurus", 200, 35, 1, 1)
    :monster("mon_nanuqsaurus", 200, 35, 1, 1)
    :monster("mon_daspletosaurus", 200, 35, 1, 1)
    :monster("mon_tyrannosaurus", 200, 40, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_FLY", load_mode = "append" }
    :monster("mon_dimorphodon", 10, 0, 2, 4)
    :monster("mon_pteranodon", 935, 0, 1, 1)
    :monster("mon_pteranodon", 50, 0, 2, 4)
    :monster("mon_quetzalcoatlus", 5, 0, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_SWIM", load_mode = "append" }
    :monster("mon_mosasaurus", 4, 60, 1, 1)
    :monster("mon_spinosaurus", 4, 40, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_PREDATOR_STREAM", load_mode = "append" }
    :monster("mon_tawa", 1, 1, 4, 8)
    :monster("mon_coelophysis", 1, 1, 4, 8)
    :monster("mon_ceratosaurus", 1, 30, 1, 1)
    :monster("mon_torvosaurus", 1, 30, 1, 1)
    :monster("mon_allosaurus", 2, 30, 1, 1)
    :monster("mon_acrocanthosaurus", 2, 40, 1, 1)
    :monster("mon_siats", 2, 40, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_PREDATOR_SWAMP", load_mode = "append" }
    :monster("mon_dryptosaurus", 1, 35, 1, 1)
    :monster("mon_nanotyrannus", 1, 35, 1, 1)
    :monster("mon_appalachiosaurus", 1, 35, 1, 1)
    :monster("mon_gorgosaurus", 1, 35, 1, 1)
    :monster("mon_albertosaurus", 1, 35, 1, 1)
    :monster("mon_nanuqsaurus", 1, 35, 1, 1)
    :monster("mon_daspletosaurus", 1, 35, 1, 1)
    :monster("mon_tyrannosaurus", 2, 40, 1, 1)
    :monster("mon_falcarius", 3, 30, 1, 2)
    :monster("mon_nothronychus", 3, 30, 1, 2)
    :monster("mon_anzu", 1, 30, 1, 2)
    :monster("mon_deinonychus", 1, 15, 2, 3)
    :monster("mon_utahraptor", 3, 30, 1, 1)
    :monster("mon_dromaeosaurus", 1, 15, 2, 4)
    :monster("mon_stenonychosaurus", 5, 30, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZREDATOR_STREAM", load_mode = "append" }
    :monster("mon_zeratosaurus", 1, 35, 1, 1)
    :monster("mon_zorvosaurus", 1, 35, 1, 1)
    :monster("mon_zallosaurus", 1, 35, 1, 1)
    :monster("mon_zacrocanthosaurus", 1, 45, 1, 1)
    :monster("mon_ziats", 1, 45, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZREDATOR_SWAMP", load_mode = "append" }
    :monster("mon_zryptosaurus", 1, 35, 1, 1)
    :monster("mon_zappalachiosaurus", 1, 35, 1, 1)
    :monster("mon_zorgosaurus", 1, 35, 1, 1)
    :monster("mon_zalbertosaurus", 1, 35, 1, 1)
    :monster("mon_zanuqsaurus", 1, 35, 1, 1)
    :monster("mon_zaspletosaurus", 1, 35, 1, 1)
    :monster("mon_zyrannosaurus", 1, 80, 1, 1)
    :monster("mon_zalcarius", 1, 30, 1, 2)
    :monster("mon_zothronychus", 1, 30, 1, 2)
    :monster("mon_zanzu", 1, 30, 1, 2)
    :monster("mon_zeinonychus", 1, 30, 2, 3)
    :monster("mon_zutahraptor", 1, 30, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_SAUROPODS_WILDERNESS", load_mode = "append" }
    :monster("mon_sarahsaurus", 10, 10, 4, 12)
    :monster("mon_anchisaurus", 10, 10, 4, 12)
    :monster("mon_issi", 10, 10, 4, 12)
    :monster("mon_moabosaurus", 10, 10, 4, 12)
    :monster("mon_haplocanthosaurus", 10, 10, 4, 12)
    :monster("mon_apatosaurus", 10, 20, 4, 12)
    :monster("mon_brontosaurus", 10, 20, 4, 12)
    :monster("mon_diplodocus", 10, 20, 4, 12)
    :monster("mon_barosaurus", 10, 20, 4, 12)
    :monster("mon_camarasaurus", 10, 25, 4, 12)
    :monster("mon_brachiosaurus", 10, 25, 4, 12)
    :monster("mon_astrodon", 10, 25, 4, 12)
    :monster("mon_alamosaurus", 10, 25, 4, 12))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZAUROPODS_WILDERNESS", load_mode = "append" }
    :monster("mon_zarahsaurus", 2, 30, 4, 12)
    :monster("mon_zanchisaurus", 2, 30, 4, 12)
    :monster("mon_zissi", 2, 30, 4, 12)
    :monster("mon_zaplocanthosaurus", 2, 30, 4, 12)
    :monster("mon_zapatosaurus", 2, 30, 4, 12)
    :monster("mon_zrontosaurus", 2, 30, 4, 12)
    :monster("mon_ziplodocus", 2, 25, 4, 12)
    :monster("mon_zarosaurus", 2, 25, 4, 12)
    :monster("mon_zamarasaurus", 2, 30, 4, 12)
    :monster("mon_zrachiosaurus", 2, 30, 4, 12)
    :monster("mon_zalamosaurus", 2, 30, 4, 12))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_HADROSAURS_WILDERNESS", load_mode = "append" }
    :monster("mon_tenontosaurus", 20, 1, 4, 12)
    :monster("mon_dryosaurus", 20, 1, 4, 12)
    :monster("mon_camptosaurus", 20, 1, 4, 12)
    :monster("mon_eolambia", 20, 1, 4, 12)
    :monster("mon_hadrosaurus", 20, 1, 4, 12)
    :monster("mon_maiasaura", 20, 1, 4, 12)
    :monster("mon_gryposaurus", 20, 1, 4, 12)
    :monster("mon_prosaurolophus", 20, 1, 4, 12)
    :monster("mon_saurolophus", 20, 1, 4, 12)
    :monster("mon_edmontosaurus", 20, 1, 4, 12)
    :monster("mon_parasaurolophus", 20, 1, 4, 12)
    :monster("mon_lambeosaurus", 20, 1, 4, 12)
    :monster("mon_corythosaurus", 20, 1, 4, 12)
    :monster("mon_hypacrosaurus", 20, 1, 4, 12))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZADROSAURS_WILDERNESS", load_mode = "append" }
    :monster("mon_zamptosaurus", 5, 10, 4, 12)
    :monster("mon_zeolambia", 5, 20, 4, 12)
    :monster("mon_zadrosaurus", 5, 20, 4, 12)
    :monster("mon_zaiasaura", 5, 20, 4, 12)
    :monster("mon_zryposaurus", 5, 20, 4, 12)
    :monster("mon_zrosaurolophus", 5, 20, 4, 12)
    :monster("mon_zaurolophus", 5, 20, 4, 12)
    :monster("mon_zedmontosaurus", 5, 20, 4, 12)
    :monster("mon_zarasaurolophus", 5, 20, 4, 12)
    :monster("mon_zambeosaurus", 5, 20, 4, 12)
    :monster("mon_zorythosaurus", 5, 20, 4, 12)
    :monster("mon_zypacrosaurus", 5, 20, 4, 12))

content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_CAVE", load_mode = "append", is_animal = true }
    :monster("mon_compsognathus", 400, 1, 4, 12)
    :monster("mon_albertonykus", 200, 1, 1, 2, { conditions = { "WINTER" } })
    :monster("mon_saurornitholestes", 150, 1, 2, 4, { conditions = { "DAY" } })
    :monster("mon_stenonychosaurus", 150, 1, 1, 2, { conditions = { "DAY" } })
    :monster("mon_fona", 150, 1, 1, 2)
    :monster("mon_oryctodromeus", 150, 1, 1, 2)
    :monster("mon_dimorphodon", 500, 1, 2, 4, { conditions = { "NIGHT", "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_DINO", load_mode = "append" }
    :monster("mon_zilophosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorvosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zallosaurus_fungus", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zacrocanthosaurus_fungus", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_ziats_fungus", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zryptosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanotyrannus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zappalachiosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorgosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalbertosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanuqsaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaspletosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyrannosaurus_fungus", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zedcolbertia_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zallimimus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztruthiomimus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zornithomimus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalcarius_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zothronychus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanzu_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeinonychus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zutahraptor_fungus", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zarahsaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanchisaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zissi_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zoabosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaplocanthosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamargasaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zapatosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrontosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ziplodocus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zarosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamarasaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrachiosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalamosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztegosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zesperosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zastonia_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zargoyleosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zauropelta_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zodosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanoplosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontonia_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuul_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyoplosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zankylosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zuoplocephalus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zcolosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zenontosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zryosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamptosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeolambia_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zadrosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaiasaura_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zryposaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrosaurolophus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaurolophus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zarasaurolophus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zambeosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorythosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zypacrosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachycephalosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeptoceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuniceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zokiceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztyracosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zentrosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeiniosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachelousaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachyrhinosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zasmosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zentaceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosmoceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zriceratops_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zona_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zescelosaurus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zteranodon_fungus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zuetzalcoatlus_fungus", 1, 1, 1, 1, { starts = duration(12, "day") }))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_TOWER", load_mode = "append" }
    :group("GROUP_FUNGI_DINO", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_FLOWERS", load_mode = "append" }
    :group("GROUP_FUNGI_DINO", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_Exodii_Stowaway", load_mode = "append" }
    :group("GROUP_BIO_DINO_HERB", 200, 1, 1, 1)
    :group("GROUP_BIO_DINO_PRED", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DINOLAB", load_mode = "append" }
    :group("GROUP_BIO_DINO_HERB", 300, 1, 1, 1)
    :group("GROUP_BIO_DINO_PRED", 300, 1, 1, 1)
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_CYBORG", load_mode = "append" }
    :group("GROUP_BIO_DINO_PRED", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BIO_DINO_PRED", load_mode = "append" }
    :monster("mon_spinosaurus", 100, 20, 1, 1, { starts = duration(12, "day"), ends = duration(112, "day") })
    :monster("mon_zpinosaurus", 25, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zpinosaurus", 25, 30, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zpinosaurus", 25, 30, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zpinosaurus", 25, 30, 1, 1, { starts = duration(360, "day") })
    :monster("mon_qianzhousaurus", 100, 0, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zianzhousaurus", 25, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zianzhousaurus", 25, 10, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zianzhousaurus", 25, 10, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zianzhousaurus", 25, 10, 1, 1, { starts = duration(360, "day") })
    :monster("mon_tyrannosaurus_bio_op", 100, 20, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(112, "day"),
    })
    :monster("mon_zyrannosaurus_bio_op", 25, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyrannosaurus_bio_op", 25, 30, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zyrannosaurus_bio_op", 25, 30, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zyrannosaurus_bio_op", 25, 30, 2, 3, { starts = duration(360, "day") })
    :monster("mon_compsognathus", 100, 10, 2, 3, { ends = duration(112, "day") })
    :monster("mon_compsognathus_bio_op", 100, 10, 2, 3)
    :monster("mon_albertonykus_bio_op", 100, 10, 2, 3)
    :monster("mon_saurornitholestes_bio_op", 100, 10, 2, 3)
    :monster("mon_velociraptor", 100, 10, 2, 3)
    :monster("mon_velociraptor_bio_op", 100, 10, 2, 3)
    :monster("mon_deino_bio_op", 100, 20, 2, 3, { ends = duration(112, "day") })
    :monster("mon_zeinonychus_bio_op", 25, 30, 2, 3, { starts = duration(12, "day") })
    :monster("mon_zeinonychus_bio_op", 25, 30, 2, 3, { starts = duration(28, "day") })
    :monster("mon_zeinonychus_bio_op", 25, 30, 2, 3, { starts = duration(112, "day") })
    :monster("mon_zeinonychus_bio_op", 25, 30, 2, 3, { starts = duration(360, "day") })
    :monster("mon_dromaeosaurus_bio_op", 100, 10, 2, 3)
    :monster("mon_stenonychosaurus_bio_op", 100, 20, 1, 2, { ends = duration(112, "day") })
    :monster("mon_eoraptor", 100, 20, 1, 2)
    :monster("mon_eoraptor_bio_op", 100, 20, 1, 2)
    :monster("mon_dimorphodon_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") }))

content.add(content.MonsterGroup { id = "GROUP_BIO_DINO_HERB", load_mode = "append" }
    :monster("mon_nedcolbertia_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zedcolbertia_bio_op", 25, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedcolbertia_bio_op", 25, 20, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zedcolbertia_bio_op", 25, 20, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zedcolbertia_bio_op", 25, 20, 1, 1, { starts = duration(360, "day") })
    :monster("mon_gallimimus_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zallimimus_bio_op", 25, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zallimimus_bio_op", 25, 20, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zallimimus_bio_op", 25, 20, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zallimimus_bio_op", 25, 20, 1, 1, { starts = duration(360, "day") })
    :monster("mon_struthiomimus_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_ztruthiomimus_bio_op", 25, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztruthiomimus_bio_op", 25, 20, 1, 1, { starts = duration(28, "day") })
    :monster("mon_ztruthiomimus_bio_op", 25, 20, 1, 1, { starts = duration(112, "day") })
    :monster("mon_ztruthiomimus_bio_op", 25, 20, 1, 1, { starts = duration(360, "day") })
    :monster("mon_ornithomimus_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zornithomimus_bio_op", 25, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zornithomimus_bio_op", 25, 20, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zornithomimus_bio_op", 25, 20, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zornithomimus_bio_op", 25, 20, 1, 1, { starts = duration(360, "day") })
    :monster("mon_amargasaurus", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_amargasaurus_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zamargasaurus_bio_op", 25, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamargasaurus_bio_op", 25, 10, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zamargasaurus_bio_op", 25, 10, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zamargasaurus_bio_op", 25, 10, 1, 1, { starts = duration(360, "day") })
    :monster("mon_dryosaurus_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_stegoceras_bio_op", 100, 20, 1, 1, { ends = duration(112, "day") })
    :monster("mon_pachycephalosaurus_bio_op", 100, 20, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zachycephalosaurus_bio_op", 25, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachycephalosaurus_bio_op", 25, 20, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zachycephalosaurus_bio_op", 25, 20, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zachycephalosaurus_bio_op", 25, 20, 1, 1, { starts = duration(360, "day") })
    :monster("mon_aquilops_bio_op", 100, 10, 1, 1, { ends = duration(112, "day") })
    :monster("mon_trice_bio_op", 100, 20, 1, 1, { ends = duration(112, "day") })
    :monster("mon_zriceratops_bio_op", 25, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zriceratops_bio_op", 25, 40, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zriceratops_bio_op", 25, 40, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zriceratops_bio_op", 25, 40, 1, 1, { starts = duration(360, "day") })
    :monster("mon_nanosaurus_bio_op", 100, 20, 1, 1, { ends = duration(112, "day") })
    :monster("mon_oryctodromeus_bio_op", 100, 20, 1, 1, { ends = duration(112, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SUBWAY", load_mode = "append" }
    :group("GROUP_SEWER_DINO", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SUBWAY_CITY", load_mode = "append" }
    :group("GROUP_SEWER_ZINO", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SUBWAY_LAB", load_mode = "append" }
    :group("GROUP_BIO_DINO_HERB", 100, 1, 1, 1)
    :group("GROUP_BIO_DINO_PRED", 100, 1, 1, 1)
    :group("GROUP_SEWER_DINO", 100, 1, 1, 1)
    :group("GROUP_SEWER_ZINO", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SAFE", load_mode = "append", is_safe = true }
    :monster("mon_nedcolbertia", 50, 1, 4, 8)
    :monster("mon_gallimimus", 50, 1, 4, 8)
    :monster("mon_struthiomimus", 50, 1, 4, 8)
    :monster("mon_ornithomimus", 50, 1, 4, 8)
    :monster("mon_albertonykus", 50, 1, 1, 2)
    :monster("mon_dryosaurus", 20, 1, 2, 4)
    :monster("mon_scutellosaurus", 20, 1, 2, 4)
    :monster("mon_aquilops", 20, 1, 1, 2)
    :monster("mon_nanosaurus", 20, 1, 4, 12)
    :monster("mon_fona", 20, 1, 1, 2)
    :monster("mon_oryctodromeus", 20, 1, 1, 2)
    :monster("mon_dimorphodon", 50, 1, 2, 4))

content.add(content.MonsterGroup { id = "DUMP_ANIMALS", load_mode = "append" }
    :monster("mon_compsognathus", 100, 1, 1, 1)
    :monster("mon_anzu", 50, 1, 1, 1)
    :monster("mon_saurornitholestes", 50, 1, 1, 1)
    :monster("mon_dimorphodon", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PEST", load_mode = "append", is_animal = true }
    :monster("mon_compsognathus", 50, 1, 1, 1)
    :monster("mon_saurornitholestes", 50, 1, 1, 1)
    :monster("mon_nanosaurus", 50, 1, 1, 1)
    :monster("mon_dimorphodon", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SEWER", load_mode = "append", is_animal = true }
    :group("GROUP_SEWER_DINO", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SEWER_DINO", load_mode = "append" }
    :monster("mon_tawa", 100, 5, 4, 8)
    :monster("mon_coelophysis", 100, 5, 4, 8)
    :monster("mon_dilophosaurus", 10, 10, 1, 2)
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(112, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(360, "day") })
    :monster("mon_ceratosaurus", 10, 30, 1, 1)
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(360, "day") })
    :monster("mon_compsognathus", 300, 1, 4, 12)
    :monster("mon_deinonychus", 100, 15, 2, 3)
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(12, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(28, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(112, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(360, "day") })
    :monster("mon_dromaeosaurus", 150, 10, 2, 4)
    :monster("mon_stenonychosaurus", 150, 10, 1, 2)
    :monster("mon_eoraptor", 200, 1, 4, 12)
    :monster("mon_fona", 200, 1, 1, 2)
    :monster("mon_oryctodromeus", 200, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_SEWER_ZINO", load_mode = "append" }
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(112, "day") })
    :monster("mon_zilophosaurus", 2, 10, 1, 2, { starts = duration(360, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zeratosaurus", 2, 35, 1, 1, { starts = duration(360, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(12, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(28, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(112, "day") })
    :monster("mon_zeinonychus", 25, 30, 2, 3, { starts = duration(360, "day") }))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- No heavier than 21 kg.
-- This group always has a chance of being the result, regardless of mission type.
content.add(content.MonsterGroup { id = "GROUP_CAMP_HUNTING", load_mode = "append" }
    :monster("mon_coelophysis", 3, 1, 1, 1)
    :monster("mon_dromaeosaurus", 3, 1, 1, 1))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- No heavier than 10 kg.
-- This group can only be picked from when the trapping mission is used, in addition to GROUP_CAMP_HUNTING.
content.add(content.MonsterGroup { id = "GROUP_CAMP_TRAPPING", load_mode = "append" }
    :monster("mon_tawa", 3, 1, 1, 1)
    :monster("mon_albertonykus", 20, 1, 1, 1)
    :monster("mon_saurornitholestes", 5, 1, 1, 1)
    :monster("mon_scutellosaurus", 20, 1, 1, 1)
    :monster("mon_aquilops", 12, 1, 1, 1)
    :monster("mon_nanosaurus", 20, 1, 1, 1)
    :monster("mon_dimorphodon", 5, 1, 1, 1))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- No heavier than 400 kg.
-- This group can only be picked from when the hunt large animals mission is used, in addition to GROUP_CAMP_HUNTING.
content.add(content.MonsterGroup { id = "GROUP_CAMP_HUNTING_LARGE", load_mode = "append" }
    :monster("mon_dilophosaurus", 3, 1, 1, 1)
    :monster("mon_ornithomimus", 20, 1, 1, 1)
    :monster("mon_falcarius", 5, 1, 1, 1)
    :monster("mon_anzu", 5, 1, 1, 1)
    :monster("mon_deinonychus", 3, 1, 1, 1)
    :monster("mon_stenonychosaurus", 3, 1, 1, 1)
    :monster("mon_sarahsaurus", 4, 1, 1, 1)
    :monster("mon_anchisaurus", 4, 1, 1, 1)
    :monster("mon_dryosaurus", 10, 1, 1, 1)
    :monster("mon_stegoceras", 12, 1, 1, 1)
    :monster("mon_leptoceratops", 12, 1, 1, 1)
    :monster("mon_zuniceratops", 12, 1, 1, 1)
    :monster("mon_fona", 3, 1, 1, 1)
    :monster("mon_oryctodromeus", 3, 1, 1, 1)
    :monster("mon_thescelosaurus", 3, 1, 1, 1)
    :monster("mon_pteranodon", 3, 1, 1, 1)
    :monster("mon_quetzalcoatlus", 3, 1, 1, 1))

-- North American dinos not theropods at least 50 kg and not largest
content.add(content.MonsterGroup { id = "GROUP_EGG_DINO", load_mode = "append" }
    :monster("mon_sarahsaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_anchisaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_issi_hatchling", 5, 1, 1, 1)
    :monster("mon_stegosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_gastonia_hatchling", 5, 1, 1, 1)
    :monster("mon_gargoyleosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_sauropelta_hatchling", 5, 1, 1, 1)
    :monster("mon_nodosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_panoplosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_edmontonia_hatchling", 5, 1, 1, 1)
    :monster("mon_zuul_hatchling", 5, 1, 1, 1)
    :monster("mon_dyoplosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_ankylosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_euoplocephalus_hatchling", 5, 1, 1, 1)
    :monster("mon_scolosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_tenontosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_camptosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_eolambia_hatchling", 20, 1, 1, 1)
    :monster("mon_hadrosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_maiasaura_hatchling", 20, 1, 1, 1)
    :monster("mon_gryposaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_prosaurolophus_hatchling", 20, 1, 1, 1)
    :monster("mon_saurolophus_hatchling", 20, 1, 1, 1)
    :monster("mon_edmontosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_parasaurolophus_hatchling", 20, 1, 1, 1)
    :monster("mon_lambeosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_corythosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_hypacrosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_pachycephalosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_leptoceratops_hatchling", 3, 1, 1, 1)
    :monster("mon_zuniceratops_hatchling", 3, 1, 1, 1)
    :monster("mon_lokiceratops_hatchling", 3, 1, 1, 1)
    :monster("mon_styracosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_centrosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_einiosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_achelousaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_pachyrhinosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_chasmosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_pentaceratops_hatchling", 3, 1, 1, 1)
    :monster("mon_torosaurus_hatchling", 3, 1, 1, 1)
    :monster("mon_triceratops_hatchling", 3, 1, 1, 1)
    :monster("mon_fona_hatchling", 3, 1, 1, 1)
    :monster("mon_thescelosaurus_hatchling", 3, 1, 1, 1))

-- North American dinos not theropods smaller than 50 kg
content.add(content.MonsterGroup { id = "GROUP_EGG_DINO_SMALL", load_mode = "append" }
    :monster("mon_scutellosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_dryosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_stegoceras_hatchling", 5, 1, 1, 1)
    :monster("mon_aquilops_hatchling", 5, 1, 1, 1)
    :monster("mon_nanosaurus_hatchling", 5, 1, 1, 1)
    :monster("mon_oryctodromeus_hatchling", 5, 1, 1, 1))

-- North American dinos not theropods largest
content.add(content.MonsterGroup { id = "GROUP_EGG_DINO_LARGE", load_mode = "append" }
    :monster("mon_moabosaurus_hatchling", 10, 1, 1, 1)
    :monster("mon_haplocanthosaurus_hatchling", 10, 1, 1, 1)
    :monster("mon_amargasaurus_hatchling", 10, 1, 1, 1)
    :monster("mon_apatosaurus_hatchling", 10, 1, 1, 1)
    :monster("mon_brontosaurus_hatchling", 10, 1, 1, 1)
    :monster("mon_diplodocus_hatchling", 20, 1, 1, 1)
    :monster("mon_barosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_camarasaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_brachiosaurus_hatchling", 20, 1, 1, 1)
    :monster("mon_astrodon_hatchling", 20, 1, 1, 1)
    :monster("mon_alamosaurus_hatchling", 20, 1, 1, 1))

-- North American theropod dinos at least 50 kg and not largest
content.add(content.MonsterGroup { id = "GROUP_EGG_THEROPOD", load_mode = "append" }
    :monster("mon_dilophosaurus_hatchling", 1, 1, 1, 1)
    :monster("mon_ceratosaurus_hatchling", 1, 1, 1, 1)
    :monster("mon_torvosaurus_hatchling", 1, 1, 1, 1)
    :monster("mon_allosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_acrocanthosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_siats_hatchling", 8, 1, 1, 1)
    :monster("mon_dryptosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_nanotyrannus_hatchling", 8, 1, 1, 1)
    :monster("mon_appalachiosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_gorgosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_albertosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_nanuqsaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_daspletosaurus_hatchling", 8, 1, 1, 1)
    :monster("mon_nedcolbertia_hatchling", 20, 1, 1, 1)
    :monster("mon_gallimimus_hatchling", 20, 1, 1, 1)
    :monster("mon_struthiomimus_hatchling", 20, 1, 1, 1)
    :monster("mon_ornithomimus_hatchling", 20, 1, 1, 1)
    :monster("mon_falcarius_hatchling", 10, 1, 1, 1)
    :monster("mon_nothronychus_hatchling", 10, 1, 1, 1)
    :monster("mon_anzu_hatchling", 10, 1, 1, 1)
    :monster("mon_deinonychus_hatchling", 10, 1, 1, 1)
    :monster("mon_utahraptor_hatchling", 5, 1, 1, 1))

-- North American theropod dinos smaller than 50 kg
content.add(content.MonsterGroup { id = "GROUP_EGG_THEROPOD_SMALL", load_mode = "append" }
    :monster("mon_compsognathus_hatchling", 20, 1, 1, 1)
    :monster("mon_albertonykus_hatchling", 20, 1, 1, 1)
    :monster("mon_saurornitholestes_hatchling", 15, 1, 1, 1)
    :monster("mon_dromaeosaurus_hatchling", 15, 1, 1, 1)
    :monster("mon_stenonychosaurus_hatchling", 10, 1, 1, 1))

-- North American theropod dinos largest
content.add(content.MonsterGroup { id = "GROUP_EGG_THEROPOD_LARGE", load_mode = "append" }
    :monster("mon_spinosaurus_hatchling", 1, 1, 1, 1)
    :monster("mon_tyrannosaurus_hatchling", 8, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_SNAKE", load_mode = "append" }
    :monster("mon_dimorphodon_hatchling", 2, 1, 1, 1)
    :monster("mon_pteranodon_hatchling", 1, 1, 1, 1)
    :monster("mon_quetzalcoatlus_hatchling", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :group("GROUP_WILDERNESS_FOREST_DINO", 150, 1, 1, 1)
    :group("GROUP_WILDERNESS_FOREST_SAUROPODS", 15, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_WILDERNESS_FOREST_DINO", load_mode = "append", is_animal = true }
    :monster("mon_nedcolbertia", 5, 1, 4, 8)
    :monster("mon_gallimimus", 5, 1, 4, 8)
    :monster("mon_struthiomimus", 5, 1, 4, 8)
    :monster("mon_ornithomimus", 5, 1, 4, 8)
    :monster("mon_albertonykus", 20, 1, 1, 2)
    :monster("mon_falcarius", 5, 1, 1, 2)
    :monster("mon_scutellosaurus", 10, 1, 2, 4)
    :monster("mon_stegosaurus", 10, 1, 2, 4)
    :monster("mon_hesperosaurus", 10, 1, 2, 4)
    :monster("mon_gastonia", 10, 1, 1, 1)
    :monster("mon_gargoyleosaurus", 10, 1, 1, 1)
    :monster("mon_sauropelta", 10, 1, 1, 1)
    :monster("mon_nodosaurus", 10, 1, 1, 1)
    :monster("mon_panoplosaurus", 10, 1, 1, 1)
    :monster("mon_edmontonia", 10, 1, 1, 1)
    :monster("mon_zuul", 10, 1, 1, 1)
    :monster("mon_dyoplosaurus", 10, 1, 1, 1)
    :monster("mon_ankylosaurus", 10, 1, 1, 1)
    :monster("mon_euoplocephalus", 10, 1, 1, 1)
    :monster("mon_scolosaurus", 10, 1, 1, 1)
    :monster("mon_stegoceras", 3, 1, 4, 8)
    :monster("mon_pachycephalosaurus", 3, 1, 4, 8)
    :monster("mon_aquilops", 3, 1, 4, 8)
    :monster("mon_leptoceratops", 3, 1, 4, 8)
    :monster("mon_zuniceratops", 3, 1, 4, 8)
    :monster("mon_lokiceratops", 3, 1, 4, 8)
    :monster("mon_styracosaurus", 3, 20, 4, 8)
    :monster("mon_centrosaurus", 3, 20, 4, 8)
    :monster("mon_einiosaurus", 3, 20, 4, 8)
    :monster("mon_achelousaurus", 3, 20, 4, 8)
    :monster("mon_pachyrhinosaurus", 3, 20, 4, 8)
    :monster("mon_chasmosaurus", 3, 25, 4, 8)
    :monster("mon_pentaceratops", 3, 25, 4, 8)
    :monster("mon_kosmoceratops", 3, 25, 4, 8)
    :monster("mon_torosaurus", 3, 25, 4, 8)
    :monster("mon_triceratops", 3, 30, 4, 8)
    :monster("mon_nanosaurus", 5, 1, 4, 8)
    :monster("mon_fona", 5, 1, 1, 2)
    :monster("mon_thescelosaurus", 10, 1, 2, 4))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_SAUROPODS",
    load_mode = "append",
    is_animal = true,
}
    :monster("mon_sarahsaurus", 1, 1, 4, 12)
    :monster("mon_anchisaurus", 1, 1, 4, 12)
    :monster("mon_issi", 1, 1, 4, 12)
    :monster("mon_moabosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_haplocanthosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_apatosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_brontosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_diplodocus_juvenile", 1, 1, 4, 12)
    :monster("mon_barosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_camarasaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_brachiosaurus_juvenile", 1, 1, 4, 12)
    :monster("mon_astrodon_juvenile", 1, 1, 4, 12)
    :monster("mon_alamosaurus_juvenile", 1, 1, 4, 12))

content.add(content.MonsterGroup { id = "GROUP_RIVER", load_mode = "append" }
    :monster("mon_pteranodon", 25, 20, 2, 4)
    :monster("mon_quetzalcoatlus", 4, 30, 1, 2)
    :monster("mon_mosasaurus", 1, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_shonisaurus", 1, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_plesiosaurus", 1, 25, 1, 2)
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_STREAM", load_mode = "append" }
    :group("GROUP_DINOSAUR_PREDATOR_STREAM", 10, 1, 1, 1, { starts = duration(12, "day") })
    :group("GROUP_DINOSAUR_PREDATOR_STREAM", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(28, "day"),
    })
    :group("GROUP_DINOSAUR_PREDATOR_STREAM", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(112, "day"),
    })
    :group("GROUP_DINOSAUR_PREDATOR_STREAM", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(360, "day"),
    })
    :group("GROUP_DINOSAUR_ZREDATOR_STREAM", 25, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_DINOSAUR_ZREDATOR_STREAM", 25, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_DINOSAUR_ZREDATOR_STREAM", 25, 1, 1, 1, { starts = duration(360, "day") })
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 25, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 25, 1, 1, 1, {
        ends = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 25, 1, 1, 1, {
        ends = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 25, 1, 1, 1, {
        ends = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_DINOSAUR_SAUROPODS_WILDERNESS", 25, 1, 1, 1, {
        ends = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_DINOSAUR_ZAUROPODS_WILDERNESS", 25, 1, 1, 1, { starts = duration(12, "day") })
    :group("GROUP_DINOSAUR_ZAUROPODS_WILDERNESS", 25, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_DINOSAUR_ZAUROPODS_WILDERNESS", 25, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_DINOSAUR_ZAUROPODS_WILDERNESS", 25, 1, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_OCEAN_SHORE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_mosasaurus", 2, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_shonisaurus", 1, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_plesiosaurus", 4, 25, 1, 2)
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_OCEAN_DEEP",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_mosasaurus", 2, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zosasaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_shonisaurus", 1, 25, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zonisaurus", 1, 25, 1, 1, { starts = duration(360, "day") })
    :monster("mon_plesiosaurus", 4, 25, 1, 2)
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zlesiosaurus", 1, 25, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append" }
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 20, 1, 1, 1, { starts = duration(12, "day") })
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(28, "day"),
    })
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(112, "day"),
    })
    :group("GROUP_DINOSAUR_PREDATOR_SWAMP", 20, 1, 1, 1, {
        starts = duration(12, "day"),
        ends = duration(360, "day"),
    })
    :group("GROUP_DINOSAUR_ZREDATOR_SWAMP", 25, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_DINOSAUR_ZREDATOR_SWAMP", 25, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_DINOSAUR_ZREDATOR_SWAMP", 25, 1, 1, 1, { starts = duration(360, "day") })
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 25, 1, 1, 1)
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 25, 1, 1, 1, { ends = duration(12, "day") })
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 25, 1, 1, 1, { ends = duration(28, "day") })
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 25, 1, 1, 1, { ends = duration(112, "day") })
    :group("GROUP_DINOSAUR_HADROSAURS_WILDERNESS", 25, 1, 1, 1, { ends = duration(360, "day") })
    :group("GROUP_DINOSAUR_ZADROSAURS_WILDERNESS", 25, 1, 1, 1, { starts = duration(12, "day") })
    :group("GROUP_DINOSAUR_ZADROSAURS_WILDERNESS", 25, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_DINOSAUR_ZADROSAURS_WILDERNESS", 25, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_DINOSAUR_ZADROSAURS_WILDERNESS", 25, 1, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PARK_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_dimorphodon", 50, 0, 2, 4, { conditions = { "DAY" } }))

content.add(content.MonsterGroup { id = "GROUP_POND_BIRD", load_mode = "append", is_animal = true }
    :monster("mon_dimorphodon", 50, 0, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append", is_animal = true }
    :group("GROUP_DINOSAUR_CAVE", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_albertonykus", 25, 1, 1, 2, { conditions = { "DUSK", "DAY", "DAWN" } })
    :monster("mon_dimorphodon", 25, 1, 2, 4, { conditions = { "DUSK", "DAY", "DAWN" } })
    :monster("mon_pteranodon", 25, 20, 2, 4, { conditions = { "DUSK", "DAY", "DAWN" } })
    :monster("mon_quetzalcoatlus", 25, 30, 1, 2, { conditions = { "DUSK", "DAY", "DAWN" } }))

-- Random North American dino zombie list
content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZOMBIE", load_mode = "append" }
    :monster("mon_zilophosaurus", 10, 20, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus", 10, 60, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zpinosaurus", 10, 90, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zorvosaurus", 10, 90, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zallosaurus", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zacrocanthosaurus", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_ziats", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zryptosaurus", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanotyrannus", 40, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zappalachiosaurus", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorgosaurus", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalbertosaurus", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanuqsaurus", 4, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaspletosaurus", 4, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyrannosaurus", 80, 80, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zedcolbertia", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zallimimus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_ztruthiomimus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zornithomimus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zalcarius", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zothronychus", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanzu", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeinonychus", 30, 30, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zutahraptor", 50, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zarahsaurus", 5, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanchisaurus", 5, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zissi", 5, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zoabosaurus", 5, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaplocanthosaurus", 5, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamargasaurus", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zapatosaurus", 50, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrontosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ziplodocus", 100, 40, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zarosaurus", 100, 40, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zamarasaurus", 200, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrachiosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zastrodon", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalamosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztegosaurus", 50, 40, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zesperosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zastonia", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zargoyleosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zauropelta", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zodosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanoplosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontonia", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuul", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyoplosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zankylosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zuoplocephalus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zcolosaurus", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zenontosaurus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zryosaurus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zamptosaurus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zeolambia", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zadrosaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaiasaura", 200, 20, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zryposaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrosaurolophus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaurolophus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontosaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zarasaurolophus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zambeosaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorythosaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zypacrosaurus", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachycephalosaurus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zeptoceratops", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuniceratops", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zokiceratops", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztyracosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zentrosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeiniosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachelousaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachyrhinosaurus", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zasmosaurus", 10, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zentaceratops", 10, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosmoceratops", 3, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorosaurus", 10, 50, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zriceratops", 30, 60, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zona", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zescelosaurus", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zteranodon", 50, 1, 1, 2, { starts = duration(12, "day") }))

-- Random North American scorched dino zombie list
content.add(content.MonsterGroup { id = "GROUP_DINOSAUR_ZOMBIE_SCORCHED", load_mode = "append" }
    :monster("mon_zilophosaurus_scorched", 10, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus_scorched", 10, 60, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zpinosaurus_scorched", 10, 90, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zorvosaurus_scorched", 10, 90, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zallosaurus_scorched", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zacrocanthosaurus_scorched", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_ziats_scorched", 80, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zryptosaurus_scorched", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanotyrannus_scorched", 40, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zappalachiosaurus_scorched", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorgosaurus_scorched", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalbertosaurus_scorched", 40, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanuqsaurus_scorched", 4, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaspletosaurus_scorched", 4, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyrannosaurus_scorched", 80, 80, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zedcolbertia_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zallimimus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_ztruthiomimus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zornithomimus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zalcarius_scorched", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zothronychus_scorched", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanzu_scorched", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeinonychus_scorched", 30, 30, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zutahraptor_scorched", 50, 60, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zarahsaurus_scorched", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanchisaurus_scorched", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zissi_scorched", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zoabosaurus_scorched", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaplocanthosaurus_scorched", 5, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zapatosaurus_scorched", 50, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrontosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ziplodocus_scorched", 100, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zarosaurus_scorched", 100, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zamarasaurus_scorched", 200, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrachiosaurus_scorched", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zastrodon_scorched", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zalamosaurus_scorched", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztegosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zesperosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zastonia_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zargoyleosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zauropelta_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zodosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanoplosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontonia_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuul_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zyoplosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zankylosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zuoplocephalus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zcolosaurus_scorched", 50, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zenontosaurus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zryosaurus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zamptosaurus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zeolambia_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zadrosaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaiasaura_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zryposaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zrosaurolophus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zaurolophus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zedmontosaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zarasaurolophus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zambeosaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorythosaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zypacrosaurus_scorched", 200, 20, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zachycephalosaurus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zachyrhinosaurus_scorched", 10, 40, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zentaceratops_scorched", 10, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zosmoceratops_scorched", 3, 70, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zorosaurus_scorched", 10, 50, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zriceratops_scorched", 30, 60, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zona_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zescelosaurus_scorched", 200, 1, 1, 2, { starts = duration(12, "day") })
    :monster("mon_zteranodon_scorched", 50, 1, 1, 2, { starts = duration(12, "day") }))

content.add(content.MonsterGroup { id = "GROUP_zilophosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_silophosaurus", 400, 1, 1, 1)
    :monster("mon_zilophosaurus_shady", 150, 1, 1, 1)
    :monster("mon_zilophosaurus_brute", 250, 1, 1, 1)
    :monster("mon_zilophosaurus_acid", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zeratosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_seratosaurus", 400, 1, 1, 1)
    :monster("mon_zeratosaurus_shady", 150, 1, 1, 1)
    :monster("mon_zeratosaurus_brute", 250, 1, 1, 1)
    :monster("mon_zeratosaurus_acid", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zpinosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_skinosaurus", 400, 1, 1, 1)
    :monster("mon_zpinosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zpinosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zorvosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sorvosaurus", 400, 1, 1, 1)
    :monster("mon_zorvosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zorvosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zallosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sallosaurus", 400, 1, 1, 1)
    :monster("mon_zallosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zallosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zacrocanthosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sacrocanthosaurus", 400, 1, 1, 1)
    :monster("mon_zacrocanthosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zacrocanthosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ziganotosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_siganotosaurus", 400, 1, 1, 1)
    :monster("mon_ziganotosaurus_shady", 300, 1, 1, 1)
    :monster("mon_ziganotosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ziats_UPGRADE", load_mode = "append" }
    :monster("mon_skiats", 400, 1, 1, 1)
    :monster("mon_ziats_shady", 300, 1, 1, 1)
    :monster("mon_ziats_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zryptosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sryptosaurus", 400, 1, 1, 1)
    :monster("mon_zryptosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zryptosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zanotyrannus_UPGRADE", load_mode = "append" }
    :monster("mon_sanotyrannus", 400, 1, 1, 1)
    :monster("mon_zanotyrannus_shady", 300, 1, 1, 1)
    :monster("mon_zanotyrannus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zappalachiosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sappalachiosaurus", 400, 1, 1, 1)
    :monster("mon_zappalachiosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zappalachiosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zorgosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sorgosaurus", 400, 1, 1, 1)
    :monster("mon_zorgosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zorgosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zalbertosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_salbertosaurus", 400, 1, 1, 1)
    :monster("mon_zalbertosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zalbertosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zianzhousaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sianzhousaurus", 400, 1, 1, 1)
    :monster("mon_zianzhousaurus_shady", 300, 1, 1, 1)
    :monster("mon_zianzhousaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zanuqsaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sanuqsaurus", 400, 1, 1, 1)
    :monster("mon_zanuqsaurus_shady", 300, 1, 1, 1)
    :monster("mon_zanuqsaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zaspletosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_saspletosaurus", 400, 1, 1, 1)
    :monster("mon_zaspletosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zaspletosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zyrannosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_syrannosaurus", 400, 1, 1, 1)
    :monster("mon_zyrannosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zyrannosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zedcolbertia_UPGRADE", load_mode = "append" }
    :monster("mon_sedcolbertia", 400, 1, 1, 1)
    :monster("mon_zedcolbertia_shady", 300, 1, 1, 1)
    :monster("mon_zedcolbertia_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zallimimus_UPGRADE", load_mode = "append" }
    :monster("mon_sallimimus", 400, 1, 1, 1)
    :monster("mon_zallimimus_shady", 300, 1, 1, 1)
    :monster("mon_zallimimus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ztruthiomimus_UPGRADE", load_mode = "append" }
    :monster("mon_sktruthiomimus", 400, 1, 1, 1)
    :monster("mon_ztruthiomimus_shady", 300, 1, 1, 1)
    :monster("mon_ztruthiomimus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zornithomimus_UPGRADE", load_mode = "append" }
    :monster("mon_sornithomimus", 400, 1, 1, 1)
    :monster("mon_zornithomimus_shady", 300, 1, 1, 1)
    :monster("mon_zornithomimus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zalcarius_UPGRADE", load_mode = "append" }
    :monster("mon_salcarius", 400, 1, 1, 1)
    :monster("mon_zalcarius_shady", 300, 1, 1, 1)
    :monster("mon_zalcarius_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zerizinosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_serizinosaurus", 400, 1, 1, 1)
    :monster("mon_zerizinosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zerizinosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zothronychus_UPGRADE", load_mode = "append" }
    :monster("mon_sothronychus", 400, 1, 1, 1)
    :monster("mon_zothronychus_shady", 300, 1, 1, 1)
    :monster("mon_zothronychus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zanzu_UPGRADE", load_mode = "append" }
    :monster("mon_sanzu", 400, 1, 1, 1)
    :monster("mon_zanzu_shady", 300, 1, 1, 1)
    :monster("mon_zanzu_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zeinonychus_UPGRADE", load_mode = "append" }
    :monster("mon_seinonychus", 400, 1, 1, 1)
    :monster("mon_zeinonychus_shady", 300, 1, 1, 1)
    :monster("mon_zeinonychus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zutahraptor_UPGRADE", load_mode = "append" }
    :monster("mon_sutahraptor", 400, 1, 1, 1)
    :monster("mon_zutahraptor_shady", 300, 1, 1, 1)
    :monster("mon_zutahraptor_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zarahsaurus_UPGRADE", load_mode = "append" }
    :monster("mon_skarahsaurus", 600, 1, 1, 1)
    :monster("mon_zarahsaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zanchisaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sanchisaurus", 600, 1, 1, 1)
    :monster("mon_zanchisaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zissi_UPGRADE", load_mode = "append" }
    :monster("mon_sissi", 600, 1, 1, 1)
    :monster("mon_zissi_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zoabosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_soabosaurus", 600, 1, 1, 1)
    :monster("mon_zoabosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zaplocanthosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_saplocanthosaurus", 600, 1, 1, 1)
    :monster("mon_zaplocanthosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zamargasaurus_UPGRADE", load_mode = "append" }
    :monster("mon_samargasaurus", 600, 1, 1, 1)
    :monster("mon_zamargasaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zapatosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sapatosaurus", 600, 1, 1, 1)
    :monster("mon_zapatosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zrontosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_srontosaurus", 600, 1, 1, 1)
    :monster("mon_zrontosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ziplodocus_UPGRADE", load_mode = "append" }
    :monster("mon_siplodocus", 600, 1, 1, 1)
    :monster("mon_ziplodocus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zarosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sarosaurus", 600, 1, 1, 1)
    :monster("mon_zarosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zamarasaurus_UPGRADE", load_mode = "append" }
    :monster("mon_samarasaurus", 600, 1, 1, 1)
    :monster("mon_zamarasaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zrachiosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_srachiosaurus", 600, 1, 1, 1)
    :monster("mon_zrachiosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zastrodon_UPGRADE", load_mode = "append" }
    :monster("mon_sastrodon", 600, 1, 1, 1)
    :monster("mon_zastrodon_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zalamosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_salamosaurus", 600, 1, 1, 1)
    :monster("mon_zalamosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ztegosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sktegosaurus", 600, 1, 1, 1)
    :monster("mon_ztegosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zesperosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sesperosaurus", 600, 1, 1, 1)
    :monster("mon_zesperosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zastonia_UPGRADE", load_mode = "append" }
    :monster("mon_sastonia", 600, 1, 1, 1)
    :monster("mon_zastonia_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zargoyleosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sargoyleosaurus", 600, 1, 1, 1)
    :monster("mon_zargoyleosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zauropelta_UPGRADE", load_mode = "append" }
    :monster("mon_skauropelta", 600, 1, 1, 1)
    :monster("mon_zauropelta_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zodosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sodosaurus", 600, 1, 1, 1)
    :monster("mon_zodosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zanoplosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sanoplosaurus", 600, 1, 1, 1)
    :monster("mon_zanoplosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zedmontonia_UPGRADE", load_mode = "append" }
    :monster("mon_sedmontonia", 600, 1, 1, 1)
    :monster("mon_zedmontonia_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zzuul_UPGRADE", load_mode = "append" }
    :monster("mon_suul", 600, 1, 1, 1)
    :monster("mon_zzuul_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zyoplosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_syoplosaurus", 600, 1, 1, 1)
    :monster("mon_zyoplosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zankylosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sankylosaurus", 400, 1, 1, 1)
    :monster("mon_zankylosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zankylosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zuoplocephalus_UPGRADE", load_mode = "append" }
    :monster("mon_suoplocephalus", 600, 1, 1, 1)
    :monster("mon_zuoplocephalus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zcolosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_skcolosaurus", 600, 1, 1, 1)
    :monster("mon_zcolosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zenontosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_senontosaurus", 600, 1, 1, 1)
    :monster("mon_zenontosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zryosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sryosaurus", 600, 1, 1, 1)
    :monster("mon_zryosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zamptosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_samptosaurus", 600, 1, 1, 1)
    :monster("mon_zamptosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ziguanodon_UPGRADE", load_mode = "append" }
    :monster("mon_siguanodon", 600, 1, 1, 1)
    :monster("mon_ziguanodon_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zeolambia_UPGRADE", load_mode = "append" }
    :monster("mon_seolambia", 600, 1, 1, 1)
    :monster("mon_zeolambia_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zadrosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sadrosaurus", 600, 1, 1, 1)
    :monster("mon_zadrosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zaiasaura_UPGRADE", load_mode = "append" }
    :monster("mon_saiasaura", 600, 1, 1, 1)
    :monster("mon_zaiasaura_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zryposaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sryposaurus", 600, 1, 1, 1)
    :monster("mon_zryposaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zrosaurolophus_UPGRADE", load_mode = "append" }
    :monster("mon_srosaurolophus", 600, 1, 1, 1)
    :monster("mon_zrosaurolophus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zaurolophus_UPGRADE", load_mode = "append" }
    :monster("mon_skaurolophus", 600, 1, 1, 1)
    :monster("mon_zaurolophus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zedmontosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sedmontosaurus", 600, 1, 1, 1)
    :monster("mon_zedmontosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zarasaurolophus_UPGRADE", load_mode = "append" }
    :monster("mon_sarasaurolophus", 600, 1, 1, 1)
    :monster("mon_zarasaurolophus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zambeosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sambeosaurus", 600, 1, 1, 1)
    :monster("mon_zambeosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zorythosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sorythosaurus", 600, 1, 1, 1)
    :monster("mon_zorythosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zypacrosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sypacrosaurus", 600, 1, 1, 1)
    :monster("mon_zypacrosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zachycephalosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sachycephalosaurus", 600, 1, 1, 1)
    :monster("mon_zachycephalosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zeptoceratops_UPGRADE", load_mode = "append" }
    :monster("mon_septoceratops", 600, 1, 1, 1)
    :monster("mon_zeptoceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zzuniceratops_UPGRADE", load_mode = "append" }
    :monster("mon_suniceratops", 600, 1, 1, 1)
    :monster("mon_zzuniceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zokiceratops_UPGRADE", load_mode = "append" }
    :monster("mon_sokiceratops", 600, 1, 1, 1)
    :monster("mon_zokiceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ztyracosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sktyracosaurus", 600, 1, 1, 1)
    :monster("mon_ztyracosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zentrosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sentrosaurus", 600, 1, 1, 1)
    :monster("mon_zentrosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zeiniosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_seiniosaurus", 600, 1, 1, 1)
    :monster("mon_zeiniosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zachelousaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sachelousaurus", 600, 1, 1, 1)
    :monster("mon_zachelousaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zachyrhinosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sachyrhinosaurus", 600, 1, 1, 1)
    :monster("mon_zachyrhinosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zasmosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sasmosaurus", 600, 1, 1, 1)
    :monster("mon_zasmosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zentaceratops_UPGRADE", load_mode = "append" }
    :monster("mon_sentaceratops", 600, 1, 1, 1)
    :monster("mon_zentaceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zosmoceratops_UPGRADE", load_mode = "append" }
    :monster("mon_sosmoceratops", 600, 1, 1, 1)
    :monster("mon_zosmoceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zorosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sorosaurus", 600, 1, 1, 1)
    :monster("mon_zorosaurus_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zriceratops_UPGRADE", load_mode = "append" }
    :monster("mon_sriceratops", 600, 1, 1, 1)
    :monster("mon_zriceratops_brute", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zona_UPGRADE", load_mode = "append" }
    :monster("mon_sona", 400, 1, 1, 1)
    :monster("mon_zona_shady", 300, 1, 1, 1)
    :monster("mon_zona_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zescelosaurus_UPGRADE", load_mode = "append" }
    :monster("mon_sescelosaurus", 400, 1, 1, 1)
    :monster("mon_zescelosaurus_shady", 300, 1, 1, 1)
    :monster("mon_zescelosaurus_brute", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zallosaurus_BRUTE", load_mode = "append" }
    :monster("mon_zallosaurus_hulk", 400, 1, 1, 1)
    :monster("mon_zallosaurus_truck", 300, 1, 1, 1)
    :monster("mon_zallosaurus_nightstalker", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zyrannosaurus_BRUTE", load_mode = "append" }
    :monster("mon_zyrannosaurus_hulk", 400, 1, 1, 1)
    :monster("mon_zyrannosaurus_truck", 300, 1, 1, 1)
    :monster("mon_zyrannosaurus_nightstalker", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zapatosaurus_BRUTE", load_mode = "append" }
    :monster("mon_zapatosaurus_hulk", 600, 1, 1, 1)
    :monster("mon_zapatosaurus_tank", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zankylosaurus_BRUTE", load_mode = "append" }
    :monster("mon_zankylosaurus_hulk", 400, 1, 1, 1)
    :monster("mon_zankylosaurus_tank", 300, 1, 1, 1)
    :monster("mon_zankylosaurus_nightstalker", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_zriceratops_BRUTE", load_mode = "append" }
    :monster("mon_zriceratops_hulk", 600, 1, 1, 1)
    :monster("mon_zriceratops_tank", 400, 1, 1, 1))

-- Only dinos that can fit through a standard door frame should be here
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_zilophosaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeratosaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zallimimus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_ztruthiomimus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zornithomimus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanzu", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanotyrannus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeinonychus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zutahraptor", 1, 1, 1, 1, { starts = duration(24, "day") })
    :monster("mon_zarahsaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zanchisaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zargoyleosaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zauropelta", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuul", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zenontosaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zryosaurus", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zeptoceratops", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zzuniceratops", 1, 1, 1, 1, { starts = duration(12, "day") })
    :monster("mon_zescelosaurus", 1, 1, 1, 1, { starts = duration(12, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ZOMBIE", load_mode = "append" }
    :monster("mon_zteranodon", 20, 1, 4, 6, { starts = duration(12, "day") })
    :monster("mon_zteranodon", 20, 1, 4, 6, { starts = duration(24, "day") })
    :monster("mon_zuetzalcoatlus", 20, 1, 2, 4, { starts = duration(12, "day") })
    :monster("mon_zuetzalcoatlus", 20, 1, 2, 4, { starts = duration(24, "day") }))
