local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ruin_data_0",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("corrupted data", "corrupted data"),
        description = ccb.content.text("Entropy has created a jumbled mess nearly impossible to distinguish from noise.  This is useless."),
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("ruin data archive", "ruin data archive"),
        description = ccb.content.text("A compressed archive of data salvaged from non-particularly remarkable ruins.  Most of the files seem to be personal documents, media, and work-related correspondence.  Nothing of great value, but perhaps useful to a historian or archivist."),
        price_cents = 2500,
        price_postapoc_cents = 2500,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_encrypted",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("encrypted data archive", "encrypted data archive"),
        description = ccb.content.text("An encrypted archive copied from pre-Discontinuity ruins, it's effectively impossible to access and thus worthless.  Eccentrics might claim an ability to gain useful knowledge from these files, but such methods are more related to augury than to computer science."),
        price_cents = 200,
        price_postapoc_cents = 200,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_collapse",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("colony collapse data", "colony collapse data"),
        description = ccb.content.text("Logs and reports that describe the gradual decline of Salus IV after the Discontinuity.  There was no hope of long-term survival here, and the colonists knew it."),
        price_cents = 12000,
        price_postapoc_cents = 12000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_decryption_keys",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("decryption keys", "decryption keys"),
        description = ccb.content.text("A large set of orphaned decryption keys from before the Discontinuity.  A data salvager might buy these in hopes of recovering something of value, but the odds of that are very low."),
        price_cents = 5000,
        price_postapoc_cents = 5000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_space_currents",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("astrocartographic data", "astrocartographic data"),
        description = ccb.content.text("Detailed measurements of gravitational distortion around the Salus system.  Although the data is outdated by several centuries, it remains a useful basis for the extrapolation of current conditions."),
        price_cents = 40000,
        price_postapoc_cents = 40000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_holo",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("lost holo", "lost holo"),
        description = ccb.content.text("The archive contains a preserved copy of a full-immersion holofilm thought to be lost.  It feels unremarkable, but a bounty exists for its recovery."),
        price_cents = 10000,
        price_postapoc_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_geoengineering",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("geoengineering data", "geoengineering data"),
        description = ccb.content.text("A collection of data related to the various geoengineering projects undertaken before the collapse of Salus's IV colony."),
        price_cents = 250000,
        price_postapoc_cents = 250000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruin_data_mercurial_id",
        copy_from = "afs_software_materialized",
        name = ccb.content.plural_text("ancient Mercurial ID codes", "ancient Mercurial ID codes"),
        description = ccb.content.text("A set of ancient identification codes used by Mercurial Genomics.  These belonged to a colonial administrator, and might allow access to the remnants of Salus IV's corporate systems."),
        price_cents = 750000,
        price_postapoc_cents = 750000,
    }
    content.add(item)
end
