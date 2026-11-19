local ccb = require("ccb")

ccb.content.define_harvest {
    id = "dissect_raptor_sample_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "raptor_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_raptor_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "raptor_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_raptor_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "raptor_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_raptor_sample_huge",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "raptor_sample_huge", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_tyrant_sample_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "tyrant_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_tyrant_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "tyrant_sample_small", category = "mutagen_group" } },
}

-- mon_zombie_hulk_death_drops is used as it includes rags and such, which is likely due to how damaged clothing would be if it was eaten by a dino
ccb.content.define_harvest {
    id = "dissect_tyrant_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "tyrant_sample_large", category = "mutagen_group" },
        { output = "mon_zombie_hulk_death_drops", category = "bionic_group" },
        { output = "science", category = "bionic_group" },
        { output = "corpses", category = "bionic_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_tyrant_sample_huge",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "tyrant_sample_huge", category = "mutagen_group" },
        { output = "mon_zombie_hulk_death_drops", category = "bionic_group" },
        { output = "science", category = "bionic_group" },
        { output = "corpses", category = "bionic_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_stego_sample_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "stego_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_stego_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "stego_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_stego_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "stego_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_stego_sample_huge",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "stego_sample_huge", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_horns_sample_single",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "horns_sample_single", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_horns_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "horns_sample_small", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_horns_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "horns_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_horns_sample_huge",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = { { output = "horns_sample_huge", category = "mutagen_group" } },
}

-- mon_zombie_hulk_death_drops is used as it includes rags and such, which is likely due to how damaged clothing would be if it was eaten by a dino
ccb.content.define_harvest {
    id = "dissect_dino_large_pred",
    message = ccb.content.text("Slicing carefully into the dinosaur, you discover stomach contents that may be useful"),
    drops = {
        { output = "mon_zombie_hulk_death_drops", category = "bionic_group", faults = {} },
        { output = "science", category = "bionic_group", faults = {} },
        { output = "corpses", category = "bionic_group", faults = {} },
    },
}

ccb.content.define_harvest {
    id = "dissect_mosasaurus_large",
    message = ccb.content.text("Slicing carefully into the mosasaurus body, you discover stomach contents and biological samples that may be useful"),
    drops = {
        { output = "mon_zombie_hulk_death_drops", category = "bionic_group", faults = {} },
        { output = "science", category = "bionic_group", faults = {} },
        { output = "corpses", category = "bionic_group", faults = {} },
        { output = "lizard_sample_huge", category = "mutagen_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_plesiosaurus",
    message = ccb.content.text("Slicing carefully into the scaly plesiosaurus body, you discover biological samples that may be useful"),
    drops = { { output = "lizard_sample_large", category = "mutagen_group" } },
}

ccb.content.define_harvest {
    id = "dissect_CBM_DINO",
    message = ccb.content.text("Slicing carefully into this technologically enhanced dinosaur, you discover items that may be useful"),
    drops = {
        {
            output = "bio_power_storage_mkII",
            category = "bionic",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "Zomborg_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_CBM_raptor",
    message = ccb.content.text("Slicing carefully into this technologically enhanced dinosaur, you discover items that may be useful, and some potentially interesting samples"),
    drops = {
        {
            output = "bio_power_storage_mkII",
            category = "bionic",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "Zomborg_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        { output = "raptor_sample_single", category = "mutagen_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_CBM_tyrannosaurid",
    message = ccb.content.text("Slicing carefully into this technologically enhanced dinosaur, you discover items that may be useful, and some potentially interesting samples"),
    drops = {
        {
            output = "bio_power_storage_mkII",
            category = "bionic",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "Zomborg_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        { output = "tyrant_sample_large", category = "mutagen_group" },
    },
}
