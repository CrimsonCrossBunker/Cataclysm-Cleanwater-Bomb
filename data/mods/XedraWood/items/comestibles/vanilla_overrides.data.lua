local ccb = require("ccb")

ccb.content.define_item {
    id = "sandwich_t",
    copy_from = "sandwich_t",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("slob sandwich", "slob sandwiches"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("satyr sandwich", "satyr sandwiches"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("mutant %s", "mutant %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("insect %s", "insect %s"),
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "meat_fried",
    copy_from = "meat_fried",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("fried fool", "fried fool"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("fried familiar", "fried familiar"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("%s, insect", "%s, insect"),
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "jerky",
    copy_from = "jerky",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("jerk jerky", "jerk jerky"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking animal jerky", "talking animal jerky"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster jerky", "monster jerky"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("insect jerky", "insect jerky"),
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "pemmican",
    copy_from = "pemmican",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("insect %s", "insect %s"),
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "pemmican_veggy",
    copy_from = "pemmican_veggy",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("insect %s", "insect %s"),
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "meat_smoked",
    copy_from = "meat_smoked",
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("smoked sucker", "smoked sucker"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("smoked Narnian", "smoked Narnian"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "fae",
            name = ccb.content.plural_text("smoked fae", "smoked fae"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "insect",
            name = ccb.content.plural_text("%s, insect", "%s, insect"),
        },
    },
    comestible = {},
}
