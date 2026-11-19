local ccb = require("ccb")

ccb.content.define_profession {
    id = "shaman",
    copy_from = "shaman",
    name = "Healer",
}

ccb.content.define_profession {
    id = "recruit",
    copy_from = "recruit",
    name = "Novice Tribal Warrior",
}

ccb.content.define_profession {
    id = "paraclesian_ierde",
    copy_from = "paraclesian_ierde",
    traits = { "IERDE", "IERDE_STONE_MEDITATIONS", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_arvore",
    copy_from = "paraclesian_arvore",
    traits = { "ARVORE", "ARVORE_SEED_BEARER", "ILLITERATE" },
    skills = { { level = 3, id = "gramarye" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_undine",
    copy_from = "paraclesian_undine",
    traits = { "UNDINE", "ILLITERATE" },
    proficiencies = { "prof_parkour" },
    skills = { { level = 3, id = "deduction" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_salamander",
    copy_from = "paraclesian_salamander",
    traits = { "SALAMANDER", "PYROMANIA", "DEFT", "ILLITERATE" },
    skills = { { level = 3, id = "gramarye" }, { level = 1, id = "unarmed" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_homullus",
    copy_from = "paraclesian_homullus",
    traits = { "HOMULLUS", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" }, { level = 3, id = "speech" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_sylph",
    copy_from = "paraclesian_sylph",
    traits = { "SYLPH", "LIGHTSTEP", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" }, { level = 3, id = "dodge" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_ierde_naked_afraid",
    copy_from = "paraclesian_ierde_naked_afraid",
    traits = { "IERDE", "IERDE_STONE_MEDITATIONS", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_arvore_naked_afraid",
    copy_from = "paraclesian_arvore_naked_afraid",
    traits = { "ARVORE", "ARVORE_SEED_BEARER", "ILLITERATE" },
    skills = { { level = 3, id = "gramarye" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_undine_naked_afraid",
    copy_from = "paraclesian_undine_naked_afraid",
    traits = { "UNDINE", "ILLITERATE" },
    proficiencies = { "prof_parkour" },
    skills = { { level = 3, id = "deduction" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_salamander_naked_afraid",
    copy_from = "paraclesian_salamander_naked_afraid",
    traits = { "SALAMANDER", "PYROMANIA", "DEFT", "ILLITERATE" },
    skills = { { level = 3, id = "gramarye" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_homullus_naked_afraid",
    copy_from = "paraclesian_homullus_naked_afraid",
    traits = { "HOMULLUS", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" }, { level = 3, id = "speech" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}

ccb.content.define_profession {
    id = "paraclesian_sylph_naked_afraid",
    copy_from = "paraclesian_sylph_naked_afraid",
    traits = { "SYLPH", "LIGHTSTEP", "ILLITERATE" },
    skills = { { level = 3, id = "deduction" }, { level = 3, id = "dodge" } },
    hobbies = { "PARACLESIAN_FAKE_HOBBY" },
    allow_npc = false,
}
