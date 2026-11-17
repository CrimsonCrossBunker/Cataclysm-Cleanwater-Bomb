local content = require("ccb").content

-- requirements.json

content.merge_requirement(
    content.Requirement { id = "eggs_bird" },
    content.Requirement {}
        :component_any {
            { id = "egg_rhea", count = 1 },
            { id = "egg_seriema", count = 1 },
            { id = "egg_guan", count = 1 },
            { id = "egg_curassow", count = 1 },
            { id = "egg_toucan", count = 3 },
            { id = "egg_macaw", count = 3 },
            { id = "egg_chachalaca", count = 3 },
            { id = "egg_parrot", count = 6 },
            { id = "egg_great_kiskadee", count = 6 },
            { id = "egg_tinamou", count = 6 },
            { id = "egg_rufous_hornero", count = 20 },
            { id = "egg_finch_saffron", count = 20 },
        }
)
