local content = require("ccb").content

-- recipes/requirements.json

-- Components required for tiny pistol ammo
content.merge_requirement(
    content.Requirement { id = "req_pistol_tiny" }
        :component("pistol_tiny_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for pistol ammo
content.merge_requirement(
    content.Requirement { id = "req_pistol" }
        :component("pistol_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for magnum ammo
content.merge_requirement(
    content.Requirement { id = "req_pistol_magnum" }
        :component("pistol_magnum_casing", 1)
        :component("lgpistol_primer", 1)
)

-- Components required for rifle ammo
content.merge_requirement(
    content.Requirement { id = "req_rifle" }
        :component("rifle_casing", 1)
        :component("smrifle_primer", 1)
)

-- Components required for huge rifle ammo
content.merge_requirement(
    content.Requirement { id = "req_rifle_huge" }
        :component("rifle_huge_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for grenade cartridges
content.merge_requirement(
    content.Requirement { id = "req_grenade" }
        :component("grenade_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for shotgun ammo
content.merge_requirement(
    content.Requirement { id = "req_shot" }
        :component("shot_casing", 1)
        :component("shotgun_primer", 1)
)

-- Components required for barrier/armor penetrators
content.merge_requirement(
    content.Requirement { id = "req_penetrator_rifle" }
        :component("rifle_steel_core", 1)
)

-- Components required for barrier/armor penetrators
content.merge_requirement(
    content.Requirement { id = "req_penetrator_rifle_huge" }
        :component("rifle_huge_steel_core", 1)
)

-- Components required for barrier/armor penetrators
content.merge_requirement(
    content.Requirement { id = "req_penetrator_rifle_alien" }
        :component("rifle_alien_steel_core", 1)
)

-- Components required for junk ammunition
content.merge_requirement(
    content.Requirement { id = "req_junk" }
        :component_any {
            { id = "scrap", count = 1 },
            { id = "nails", count = 5, requirement = true },
            { id = "bb", count = 10 },
            { id = "solder_wire", count = 5 },
            { id = "platinum_small", count = 2 },
            { id = "gold_small", count = 2 },
            { id = "bearing", count = 2 },
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "bismuth", count = 3 },
            { id = "shrapnel", count = 2 },
        }
)
