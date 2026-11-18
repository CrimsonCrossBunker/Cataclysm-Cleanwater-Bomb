local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "software_useless",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("misc software", "misc software"),
        description = ccb.content.text("A miscellaneous piece of hobby software.  Probably useless."),
        price_cents = 300,
        price_postapoc_cents = 0,
        electronic_size_kb = 64000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_hacking",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("hackPRO", "hackPRO"),
        description = ccb.content.text("A piece of hacking software."),
        price_cents = 800,
        price_postapoc_cents = 50,
        electronic_size_kb = 128000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_medical",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("MediSoft", "MediSoft"),
        description = ccb.content.text("A piece of medical software."),
        price_cents = 600,
        price_postapoc_cents = 0,
        electronic_size_kb = 128000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_math",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("MatheMAX", "MatheMAX"),
        description = ccb.content.text("A piece of mathematical software."),
        price_cents = 500,
        price_postapoc_cents = 0,
        electronic_size_kb = 64000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_blood_data",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("infection data", "infection data"),
        description = ccb.content.text("Medical data on zombie blood."),
        price_cents = 200,
        price_postapoc_cents = 0,
        electronic_size_kb = 16000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_lab_data",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("lab data", "lab data"),
        description = ccb.content.text("Research archives from a government laboratory."),
        price_cents = 200,
        price_postapoc_cents = 0,
        electronic_size_kb = 16000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_encryption_codes",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("encryption codes", "encryption codes"),
        description = ccb.content.text("There are numerous security keys with dates for potential future access to encrypted archived data."),
        price_cents = 200,
        price_postapoc_cents = 0,
        electronic_size_kb = 1000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_archived_data",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("archive data", "archive data"),
        description = ccb.content.text("Extremely compressed research data, observation and experiment statistics.  The only pattern you manage to recognize is an increase in the amount of report closer to the Cataclysm, but also a reduction in the number of facilities still submitting reports."),
        price_cents = 200,
        price_postapoc_cents = 0,
        electronic_size_kb = 64000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "train_data",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("laboratory shipping records", "laboratory shipping records"),
        description = ccb.content.text("Records of logistical data on subterranean train routes and schedules."),
        price_cents = 200,
        price_postapoc_cents = 0,
        electronic_size_kb = 64000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "software_electronics_reference",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("integrated circuit datasheet archives", "misc software"),
        description = ccb.content.text("Huge archives of numerous IC circuit datasheets from several major manufacturers.  Probably valuable to the right person, as it would be hard to salvage and reuse these components without them."),
        price_cents = 40000,
        price_postapoc_cents = 0,
        electronic_size_kb = 12000000,
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "abstract_efile_copiable",
        abstract = true,
        copy_from = "abstract_efile",
        symbol = "o",
        name = content.plural_text("abstract copiable electronic file", "abstract copiable electronic files"),
        description = content.text("abstract copiable electronic file"),
        electronic_size_kb = 1,
    }
    item:clear_flags()
    item:flag("E_COPIABLE")
    item:flag("E_STORABLE")
    item:flag("IRREMOVABLE")
    item:flag("NO_DROP")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end

do
    -- insert into e-device to make browsing take longer
    local item = content.Item {
        id = "efile_junk",
        copy_from = "abstract_efile_exclusive",
        symbol = "o",
        name = ccb.content.plural_text("junk file", "junk files"),
        description = ccb.content.text("A useless piece of electronic data."),
        electronic_size_kb = 1,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "efile_photos",
        copy_from = "abstract_efile_exclusive_copiable",
        symbol = "o",
        name = ccb.content.plural_text("photo gallery", "photo galleries"),
        description = ccb.content.text("A varied collection of detailed photos.  Any collections of this kind will be added to this one."),
        electronic_size_kb = 4000,
    }
    item:clear_use_actions()
    item:native_use("VIEW_PHOTOS")
    item:clear_flags()
    item:flag("E_COPIABLE")
    item:flag("E_FILE_COLLECTION")
    item:flag("E_STORABLE_EXCLUSIVE")
    item:flag("IRREMOVABLE")
    item:flag("NO_DROP")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end
