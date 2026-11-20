local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "arvore_growing_wood_walls_floor",
    name = ccb.content.text_without_extraction("The Forest Offers Shelter (Floor)"),
    description = ccb.content.text_without_extraction("The floor part of the Forest Offers Shelter spell.  It's a bug if you have it directly."),
    flags = { "SILENT" },
    valid_targets = { "ground" },
    skill = "gramarye",
    max_level = 20,
    difficulty = 6,
    effect = "ter_transform",
    effect_data = "ter_arvore_wood_floor",
    shape = "blast",
    min_range = 1,
    max_range = 4,
    range_increment = 0.25,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "arvore_growing_wood_walls_branch",
    name = ccb.content.text_without_extraction("The Forest Offers Shelter (Branches)"),
    description = ccb.content.text_without_extraction("The branches part of the Forest Offers Shelter spell.  It's a bug if you have it directly."),
    flags = { "SILENT" },
    valid_targets = { "ground" },
    skill = "gramarye",
    max_level = 20,
    difficulty = 6,
    effect = "ter_transform",
    effect_data = "ter_arvore_wood_branches",
    shape = "blast",
    min_range = 1,
    max_range = 4,
    range_increment = 0.25,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "arvore_growing_wood_walls_door",
    name = ccb.content.text_without_extraction("The Forest Offers Shelter (Door)"),
    description = ccb.content.text_without_extraction("The doors part of the Forest Offers Shelter spell.  It's a bug if you have it directly."),
    flags = { "SILENT" },
    valid_targets = { "ground" },
    skill = "gramarye",
    max_level = 20,
    difficulty = 6,
    effect = "ter_transform",
    effect_data = "ter_arvore_wood_door",
    shape = "blast",
    min_range = 1,
    max_range = 4,
    range_increment = 0.25,
}
