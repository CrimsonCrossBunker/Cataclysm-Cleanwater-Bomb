local ccb = require("ccb")

ccb.content.define_harvest {
    id = "dissect_renfield_bionic_monster",
    message = ccb.content.text("You search for any salvageable hardware in what's left of this monstrous ghoul."),
    drops = {
        {
            output = "bio_power_storage",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionic_renfield_harvest",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_combat_cyborg",
    message = ccb.content.text("You search for any salvageable hardware in what's left of this monstrous ghoul."),
    drops = {
        {
            output = "bio_power_storage",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "combat_cyborg_harvest",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_mon_zombie_scientist_xe",
    message = ccb.content.text("You cut into the undead scientist, carefully removing layers of tissue."),
    drops = {
        {
            output = "scientist_xe_base_CBM_harvest",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            base_quantity = { 0, 1 },
            skill_quantity = { 0.1, 0.3 },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "scientist_xe_base_CBM_power_harvest",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            base_quantity = { 0, 1 },
            skill_quantity = { 0.1, 0.3 },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_mon_zombie_oa_agent",
    message = ccb.content.text("You search through the remains of the strange soldier, looking for anything of interest."),
    drops = {
        {
            output = "zombie_oa_agent_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 2 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 5,
        },
        {
            output = "Zomborg_CBM_harvest_power",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 2 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 5,
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_ierde_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "ierde_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_ierde_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "ierde_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_undine_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "undine_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_undine_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "undine_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_undine_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "undine_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_arvore_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "arvore_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_arvore_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "arvore_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_arvore_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "arvore_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_arvore_huge",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "arvore_sample_huge", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_salamander_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "salamander_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_salamander_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "salamander_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_homullus_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "homullus_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_sylph_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "sylph_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_sylph_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "sylph_sample_large", category = "mutagen_group" } },
}
