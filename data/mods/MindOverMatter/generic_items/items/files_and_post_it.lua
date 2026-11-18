local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "lab_file_private_correspondence",
        name = ccb.content.plural_text("private note", "private notes"),
        category = "books",
        description = ccb.content.text("Some paper with what looks to be private communication on it.  The writer would be very annoyed at you for reading this if they weren't almost-certainly shambling around looking for brains."),
        snippet_category = "lab_file_phavian_private",
        mass_milligrams = 3000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 6,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_biokinesis_item",
        name = ccb.content.plural_text("report (BURNT NOVEMBER)", "copies of report (BURNT NOVEMBER)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"BURNT NOVEMBER\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_biokinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_clairsentience_item",
        name = ccb.content.plural_text("report (NOBLE HORIZON)", "copies of report (NOBLE HORIZON)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"NOBLE HORIZON\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_clairsentience",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_electrokinesis_item",
        name = ccb.content.plural_text("report (RUBY LOOP)", "copies of report (RUBY LOOP)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"RUBY LOOP\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_electrokinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_photokinesis_item",
        name = ccb.content.plural_text("report (CRYPTIC FORGE)", "copies of report (CRYPTIC FORGE)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"CRYPTIC FORGE\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_photokinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_pyrokinesis_item",
        name = ccb.content.plural_text("report (COPPER PRIME)", "copies of report (COPPER PRIME)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"COPPER PRIME\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_pyrokinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_telekinesis_item",
        name = ccb.content.plural_text("report (JUNIPER GOLD)", "copies of report (JUNIPER GOLD)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"JUNIPER GOLD\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_telekinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_telepathy_item",
        name = ccb.content.plural_text("report (GRAY DAWN)", "copies of report (GRAY DAWN)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"GRAY DAWN\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_telepathy",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_teleportation_item",
        name = ccb.content.plural_text("report (LOST RAIN)", "copies of report (LOST RAIN)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"LOST RAIN\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_teleportation",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_vitakinesis_item",
        name = ccb.content.plural_text("report (SMOKE USHER)", "copies of report (SMOKE USHER)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with the heading \"SMOKE USHER\".  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_vitakinesis",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_matrix_research_item",
        name = ccb.content.plural_text("report (matrix technology)", "copies of report (matrix technology)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports.  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_matrix_research",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_OS647_P_item",
        name = ccb.content.plural_text("OS647-P Proposal Response", "copies of OS647-P Proposal Response"),
        category = "books",
        description = ccb.content.text("A note written on official XEDRA letterhead."),
        snippet_category = "lab_file_OS647_P",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_QD944_P_item",
        name = ccb.content.plural_text("QD944-P Progress Update", "copies of QD944-P Progress Update"),
        category = "books",
        description = ccb.content.text("A note written on official XEDRA letterhead."),
        snippet_category = "lab_file_QD944_P",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_IG882_P_item",
        name = ccb.content.plural_text("IG882-P Report", "copies of IG882-P Report"),
        category = "books",
        description = ccb.content.text("A note written on official XEDRA letterhead."),
        snippet_category = "lab_file_IG882_P",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_phavian_memo_item",
        name = ccb.content.plural_text("Project PHAVIAN memo", "copies of Project PHAVIAN memo"),
        category = "books",
        description = ccb.content.text("A note written on official XEDRA letterhead."),
        snippet_category = "lab_file_phavian_memo",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_obsidian_ring_item",
        name = ccb.content.plural_text("report (OBSIDIAN RING)", "copies of report (OBSIDIAN RING)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with a large \"Project OBSIDIAN RING\" on the front.  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_obsidian_ring",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_shadow_urge_item",
        name = ccb.content.plural_text("report (SHADOW URGE)", "copies of report (SHADOW URGE)"),
        category = "books",
        description = ccb.content.text("A folder full of what appear to be transcripts of experimental results or reports, with a large \"Project SHADOW URGE\" on the front.  Most of it is rather trivial, but certain passages catch your eye…"),
        snippet_category = "lab_file_shadow_urge",
        mass_milligrams = 15000,
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        volume_ml = 50,
        copy_from = "file",
        looks_like = "file",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_visitor_phavian",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("visitor's pass", "visitor's passes"),
        copy_from = "card_plastic_abstract",
        description = ccb.content.text("A visitor's pass to some sort of facility.  The reverse side describes the protocol for using it; this could grant one-time access at a card reader, if you can find one.  It also lists the addresses of nearby facilities; activate it to add their locations to your map.  There is a prominent symbol stamped on it with the word \"PHAVIAN\" underneath."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        mass_milligrams = 5000,
        volume_ml = 5,
        longest_side_mm = 84,
        melee_to_hit = -3,
        category = "keys",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("SCIENCE_CARD_VISITOR")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:material("plastic", 1)
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add the facilities to your map."),
        terrains = {
            { id = "psi_phavian_lab", match = "PREFIX" },
            { id = "phavan_office_skyscraper_lab", match = "PREFIX" },
            { id = "office_cubical_phavian" },
            { id = "office_cubical_phavian_basement" },
            { id = "phavian_hospital_basement_nw" },
            { id = "phavian_hospital_basement_ne" },
            { id = "phavian_hospital_basement_sw" },
            { id = "phavian_hospital_basement_se" },
        },
    }
    content.add(item)
end
