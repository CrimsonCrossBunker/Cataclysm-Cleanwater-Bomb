local content = require("ccb").content

-- requirements/cooking_components.json

content.merge_requirement(
    content.Requirement { id = "eggs_bird" },
    content.Requirement {}
        :component("eggs_dino_small", 1, true)
)

content.merge_requirement(
    content.Requirement { id = "eggs_dino" }
        :component_any {
            { id = "egg_dino", count = 1 },
            { id = "egg_dino_theropod", count = 1 },
            { id = "egg_dilophosaurus", count = 1 },
            { id = "egg_ceratosaurus", count = 1 },
            { id = "egg_torvosaurus", count = 1 },
            { id = "egg_allosaurus", count = 1 },
            { id = "egg_acrocanthosaurus", count = 1 },
            { id = "egg_giganotosaurus", count = 1 },
            { id = "egg_siats", count = 1 },
            { id = "egg_dryptosaurus", count = 1 },
            { id = "egg_nanotyrannus", count = 1 },
            { id = "egg_appalachiosaurus", count = 1 },
            { id = "egg_gorgosaurus", count = 1 },
            { id = "egg_albertosaurus", count = 1 },
            { id = "egg_qianzhousaurus", count = 1 },
            { id = "egg_nanuqsaurus", count = 1 },
            { id = "egg_daspletosaurus", count = 1 },
            { id = "egg_nedcolbertia", count = 1 },
            { id = "egg_gallimimus", count = 1 },
            { id = "egg_struthiomimus", count = 1 },
            { id = "egg_ornithomimus", count = 1 },
            { id = "egg_falcarius", count = 1 },
            { id = "egg_therizinosaurus", count = 1 },
            { id = "egg_nothronychus", count = 1 },
            { id = "egg_anzu", count = 1 },
            { id = "egg_deinonychus", count = 1 },
            { id = "egg_utahraptor", count = 1 },
            { id = "egg_sarahsaurus", count = 1 },
            { id = "egg_anchisaurus", count = 1 },
            { id = "egg_issi", count = 1 },
            { id = "egg_stegosaurus", count = 1 },
            { id = "egg_hesperosaurus", count = 1 },
            { id = "egg_gastonia", count = 1 },
            { id = "egg_gargoyleosaurus", count = 1 },
            { id = "egg_sauropelta", count = 1 },
            { id = "egg_nodosaurus", count = 1 },
            { id = "egg_panoplosaurus", count = 1 },
            { id = "egg_edmontonia", count = 1 },
            { id = "egg_zuul", count = 1 },
            { id = "egg_dyoplosaurus", count = 1 },
            { id = "egg_ankylosaurus", count = 1 },
            { id = "egg_euoplocephalus", count = 1 },
            { id = "egg_scolosaurus", count = 1 },
            { id = "egg_tenontosaurus", count = 1 },
            { id = "egg_camptosaurus", count = 1 },
            { id = "egg_iguanodon", count = 1 },
            { id = "egg_eolambia", count = 1 },
            { id = "egg_hadrosaurus", count = 1 },
            { id = "egg_maiasaura", count = 1 },
            { id = "egg_gryposaurus", count = 1 },
            { id = "egg_prosaurolophus", count = 1 },
            { id = "egg_saurolophus", count = 1 },
            { id = "egg_edmontosaurus", count = 1 },
            { id = "egg_parasaurolophus", count = 1 },
            { id = "egg_lambeosaurus", count = 1 },
            { id = "egg_corythosaurus", count = 1 },
            { id = "egg_hypacrosaurus", count = 1 },
            { id = "egg_pachycephalosaurus", count = 1 },
            { id = "egg_leptoceratops", count = 1 },
            { id = "egg_zuniceratops", count = 1 },
            { id = "egg_lokiceratops", count = 1 },
            { id = "egg_styracosaurus", count = 1 },
            { id = "egg_centrosaurus", count = 1 },
            { id = "egg_einiosaurus", count = 1 },
            { id = "egg_achelousaurus", count = 1 },
            { id = "egg_pachyrhinosaurus", count = 1 },
            { id = "egg_chasmosaurus", count = 1 },
            { id = "egg_pentaceratops", count = 1 },
            { id = "egg_kosmoceratops", count = 1 },
            { id = "egg_torosaurus", count = 1 },
            { id = "egg_triceratops", count = 1 },
            { id = "egg_thescelosaurus", count = 1 },
            { id = "egg_dimorphodon", count = 1 },
            { id = "egg_quetzalcoatlus", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "eggs_dino_small" }
        :component_any {
            { id = "egg_dino_small", count = 1 },
            { id = "egg_dino_theropod_small", count = 1 },
            { id = "egg_tawa", count = 1 },
            { id = "egg_coelophysis", count = 1 },
            { id = "egg_compsognathus", count = 1 },
            { id = "egg_albertonykus", count = 1 },
            { id = "egg_saurornitholestes", count = 1 },
            { id = "egg_velociraptor", count = 1 },
            { id = "egg_dromaeosaurus", count = 1 },
            { id = "egg_stenonychosaurus", count = 1 },
            { id = "egg_eoraptor", count = 1 },
            { id = "egg_scutellosaurus", count = 1 },
            { id = "egg_dryosaurus", count = 1 },
            { id = "egg_stegoceras", count = 1 },
            { id = "egg_aquilops", count = 1 },
            { id = "egg_nanosaurus", count = 1 },
            { id = "egg_fona", count = 1 },
            { id = "egg_oryctodromeus", count = 1 },
            { id = "egg_pteranodon", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "eggs_dino_large" }
        :component_any {
            { id = "egg_dino_large", count = 1 },
            { id = "egg_dino_theropod_large", count = 1 },
            { id = "egg_spinosaurus", count = 1 },
            { id = "egg_tyrannosaurus", count = 1 },
            { id = "egg_haplocanthosaurus", count = 1 },
            { id = "egg_amargasaurus", count = 1 },
            { id = "egg_apatosaurus", count = 1 },
            { id = "egg_brontosaurus", count = 1 },
            { id = "egg_diplodocus", count = 1 },
            { id = "egg_barosaurus", count = 1 },
            { id = "egg_camarasaurus", count = 1 },
            { id = "egg_brachiosaurus", count = 1 },
            { id = "egg_astrodon", count = 1 },
            { id = "egg_alamosaurus", count = 1 },
        }
)

-- requirements/materials.json

-- Materials for use when building out of animal dung
content.merge_requirement(
    content.Requirement { id = "daub_fill" }
        :component_any {
            { id = "material_quicklime", count = 4 },
            { id = "material_limestone", count = 4 },
            { id = "clay_lump", count = 4 },
            { id = "feces_manure", count = 2 },
            { id = "feces_dog", count = 2 },
            { id = "feces_cow", count = 1 },
            { id = "feces_dino", count = 1 },
        }
        :component_any {
            { id = "pebble", count = 10 },
            { id = "material_sand", count = 10 },
        }
)
