local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "id_science",
        copy_from = "card_plastic_abstract",
        color = "blue",
        name = ccb.content.plural_text("science ID card", "science ID cards"),
        description = ccb.content.text("An ID card that once belonged to a scientist.  The reverse side describes the protocol for using it; this could grant access at one control panel, if you can find one."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        category = "keys",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("SCIENCE_CARD")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_military",
        copy_from = "card_plastic_abstract",
        color = "green",
        name = ccb.content.plural_text("military ID card", "military ID cards"),
        description = ccb.content.text("An ID card that once belonged to a military officer.  The reverse side describes the protocol for using it; this could grant access at one control panel, if you can find one."),
        price_cents = 120000,
        price_postapoc_cents = 500,
        category = "keys",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("MILITARY_CARD")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_industrial",
        looks_like = "id_science",
        copy_from = "card_plastic_abstract",
        color = "green",
        name = ccb.content.plural_text("industrial ID card", "industrial ID cards"),
        description = ccb.content.text("An ID card that once belonged to a high-level technician.  The reverse side describes the protocol for using it; this could grant access at one control panel, if you can find one."),
        price_cents = 120000,
        price_postapoc_cents = 100,
        category = "keys",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("INDUSTRIAL_CARD")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_artisan_member",
        looks_like = "id_science",
        copy_from = "card_plastic_abstract",
        color = "green",
        name = ccb.content.plural_text("co-op badge", "co-op badges"),
        description = ccb.content.text("A manually-encoded badge giving you access to the artisans' workshop.  It even has your name written on the back."),
        price_cents = 120000,
        price_postapoc_cents = 100,
        category = "keys",
    }
    item:clear_flags()
    item:flag("COOP_CARD")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_visitor_1",
        copy_from = "card_plastic_abstract",
        color = "blue",
        name = ccb.content.plural_text("visitor's pass", "visitor's passes"),
        description = ccb.content.text("A visitor's pass to some sort of facility.  The reverse side describes the protocol for using it; this could grant access at a card reader, if you can find one.  It also lists the addresses of nearby facilities; activate it to add their locations to your map."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        category = "keys",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 300,
        message = ccb.content.text("You add the facilities to your map."),
        terrains = {
            { id = "lab_res_8_SWD_ground" },
            { id = "lab_res_8_SED_ground" },
            { id = "lab_res_8_SWU_ground" },
            { id = "lab_res_8_SEU_ground" },
            { id = "lab_CORE_2x1_SED_ground" },
            { id = "lab_CORE_2x1_SWD_ground" },
            { id = "lab_CORE_2x1_NED_ground" },
            { id = "lab_CORE_2x1_NWD_ground" },
            { id = "lab_CORE_2x1_WC_ground" },
            { id = "lab_CORE_2x1_EC_ground" },
            { id = "lab_security_z0" },
            { id = "lab_security_z0N" },
            { id = "lab_security_z0S" },
            { id = "lab_surface_parking", match = "PREFIX" },
        },
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("SCIENCE_CARD_VISITOR")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_maintenance_green",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Maintenance: green zone badge", "Maintenance: green zone badges"),
        description = ccb.content.text("An employee badge for a maintenance worker.  The reverse side describes the protocol for using it; this could grant access at green zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MAINTENANCE_GREEN")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_maintenance_yellow",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Maintenance: ocher zone badge", "Maintenance: ocher zone badges"),
        description = ccb.content.text("An employee badge for a maintenance worker.  The reverse side describes the protocol for using it; this could grant access at ocher zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MAINTENANCE_YELLOW")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_maintenance_blue",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Maintenance: blue zone badge", "Maintenance: blue zone badges"),
        description = ccb.content.text("An employee badge for a maintenance worker.  The reverse side describes the protocol for using it; this could grant access at blue zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MAINTENANCE_BLUE")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_transport_1",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("transport freight employee badge", "transport freight employee badges"),
        description = ccb.content.text("An employee badge for a freight hauler.  The reverse side describes the protocol for using it; this could grant access at transport freight card readers.  It also lists the addresses of nearby facilities; activate it to add their locations to your map."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_TRANSPORT_1")
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:clear_use_actions()
    item:reveal_map {
        radius = 300,
        message = ccb.content.text("You add the facilities to your map."),
        terrains = {
            { id = "lab_res_8_SWD_ground" },
            { id = "lab_res_8_SED_ground" },
            { id = "lab_res_8_SWU_ground" },
            { id = "lab_res_8_SEU_ground" },
            { id = "lab_CORE_2x1_SED_ground" },
            { id = "lab_CORE_2x1_SWD_ground" },
            { id = "lab_CORE_2x1_NED_ground" },
            { id = "lab_CORE_2x1_NWD_ground" },
            { id = "lab_CORE_2x1_WC_ground" },
            { id = "lab_CORE_2x1_EC_ground" },
            { id = "lab_security_z0" },
            { id = "lab_security_z0N" },
            { id = "lab_security_z0S" },
            { id = "lab_surface_parking", match = "PREFIX" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_security_yellow",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Security: yellow zone badge", "Security: yellow zone badges"),
        description = ccb.content.text("An employee badge for a security officer.  The reverse side describes the protocol for using it; this could grant access at yellow zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_SECURITY_YELLOW")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_security_magenta",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Security: magenta zone badge", "Security: magenta zone badges"),
        description = ccb.content.text("An employee badge for a security officer.  The reverse side describes the protocol for using it; this could grant access at magenta zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_SECURITY_MAGENTA")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_security_black",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Security: black zone badge", "Security: black zone badges"),
        description = ccb.content.text("An employee badge for a security officer.  The reverse side describes the protocol for using it; this could grant access at black zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_SECURITY_BLACK")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_mutagen_green",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Researcher: light green zone badge", "Researcher: light green zone badges"),
        description = ccb.content.text("An employee badge for a research scientist.  The reverse side describes the protocol for using it; this could grant access at light green zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MUTAGEN_GREEN")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_mutagen_pink",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Researcher: pink zone badge", "Researcher: pink zone badges"),
        description = ccb.content.text("An employee badge for a research scientist.  The reverse side describes the protocol for using it; this could grant access at pink zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MUTAGEN_PINK")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_mutagen_cyan",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Researcher: cyan zone badge", "Researcher: cyan zone badges"),
        description = ccb.content.text("An employee badge for a research scientist.  The reverse side describes the protocol for using it; this could grant access at cyan zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MUTAGEN_CYAN")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_science_medical_red",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Doctor: red zone badge", "Doctor: red zone badges"),
        description = ccb.content.text("An employee badge for a medical doctor.  The reverse side describes the protocol for using it; this could grant access at red zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MEDICAL_RED")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    -- Given by Hub 01's director, intentionally works everywhere.
    local item = content.Item {
        id = "id_science_mu",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("System supervisor: slate zone badge", "System supervisor: slate zone badges"),
        description = ccb.content.text("An employee badge for a system's supervisor.  The reverse side describes the protocol for using it; this could grant access through white zone card readers."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_MU_UNIVERSAL")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("LIXA ID badge", "LIXA ID badges"),
        description = ccb.content.text("An ID badge for the LIXA facility, with a photo of an awkwardly smiling scientist on the front.  Instructions on the back explain that this will grant you access to the LIXA experiment floor."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_2",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("defaced LIXA ID badge", "defaced LIXA ID badges"),
        description = ccb.content.text("An ID badge for the LIXA facility, with a photo of an awkwardly smiling scientist on the front.  It is heavily scratched, and there is a line on the back in black marker."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("LIXA_SCIENCE_CARD_2")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_najma",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("LIXA ID badge: Dr. Najma Saed", "LIXA ID badges: Dr. Najma Saed"),
        description = ccb.content.text("An ID badge for the LIXA facility.  The photo is of a pleasantly smiling woman in a hijab."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("LIXA_SCIENCE_CARD_2")
    item:flag("LIXA_SCIENCE_CARD_3")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_jason",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("LIXA ID badge: Dr. Jason Mitchell", "LIXA ID badges: Dr. Jason Mitchell"),
        description = ccb.content.text("An ID badge for the LIXA facility.  The photo is of a confidently smiling young man."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("LIXA_SCIENCE_CARD_2")
    item:flag("LIXA_SCIENCE_CARD_3")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_kai_mei",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("LIXA ID badge: Dr. Kai-Mei Luo", "LIXA ID badges: Dr. Kai-Mei Luo"),
        description = ccb.content.text("An ID badge for the LIXA facility.  The photo is of an awkwardly smiling woman, who blinked during the picture."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("LIXA_SCIENCE_CARD_2")
    item:flag("LIXA_SCIENCE_CARD_3")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_rich",
        symbol = ",",
        looks_like = "id_science",
        name = ccb.content.plural_text("LIXA ID badge: Dr. Richard Raimes", "LIXA ID badges: Dr. Richard Raimes"),
        description = ccb.content.text("An ID badge for the LIXA facility.  The photo is of a gently smiling older man, with kind eyes."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("LIXA_SCIENCE_CARD_2")
    item:flag("LIXA_SCIENCE_CARD_3")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "id_LIXA_mil",
        symbol = ",",
        looks_like = "id_LIXA_mil",
        name = ccb.content.plural_text("LIXA military police badge", "LIXA military police badges"),
        description = ccb.content.text("An id card bearing the name, rank, and serial number of a soldier stationed at LIXA."),
        price_postapoc_cents = 250,
        mass_milligrams = 3000,
        volume_ml = 5,
        category = "keys",
    }
    item:clear_flags()
    item:flag("LIXA_MILITARY_CARD")
    item:flag("LIXA_SCIENCE_CARD")
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("HINT_THE_LOCATION")
    item:flag("CREDIT_CARD_SHAPED")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "warehouse_rebooter",
        color = "blue",
        symbol = "%",
        name = ccb.content.plural_text("Exodii comm rebooter", "Exodii comm rebooters"),
        description = ccb.content.text("A small rectangular device that Rubik gave you.  It is meant to be plugged in a locator antenna to reactivate it."),
        price_cents = 0,
        volume_ml = 250,
        mass_milligrams = 500000,
        price_postapoc_cents = 0,
        category = "keys",
    }
    item:material("plastic", 1)
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_anduril_ar",
        copy_from = "card_plastic_abstract",
        color = "blue",
        name = ccb.content.plural_text("Anduril Industries ID card", "Anduril Industries ID cards"),
        description = ccb.content.text("An ID card for an Anduril Industries software engineer."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        category = "keys",
    }
    item:clear_flags()
    item:flag("ANDURIL_AR_CARD")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "id_exodii_string_dimension",
        copy_from = "card_plastic_abstract",
        color = "yellow",
        name = ccb.content.plural_text("strange plastic key", "strange plastic keys"),
        description = ccb.content.text("A thick plastic key with an archaic-looking, angled bit."),
        price_cents = 0,
        price_postapoc_cents = 0,
        category = "keys",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("EXODII_STRING_DIMENSION_CARD")
    content.add(item)
end
