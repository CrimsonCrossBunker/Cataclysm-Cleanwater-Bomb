local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "AID_AF_abstract",
        abstract = true,
        name = content.plural_text("abstract Autodoc installation data", "abstract Autodoc installation datas"),
        description = ccb.content.text("Precise step-by-step instructions and other required data for installation of a CBM, stored on a data card of proprietary form-factor, designed to be used extensively by an Autodoc, and allowing bionic installation with minimal failure chance.  An integrated security subroutine renders it unusable after a single installation."),
        symbol = "#",
        mass_milligrams = 35000,
        volume_ml = 50,
        price_cents = 20000,
        price_postapoc_cents = 5000,
        looks_like = "data_card",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("BIONIC_INSTALLATION_DATA")
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_alarm",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Alarm System CBM installation data", "Alarm System CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_tattoo_led",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("LED Tattoo CBM installation data", "LED Tattoo CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_power_storage",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Power Storage CBM installation data", "Power Storage CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_power_storage_mkII",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Power Storage CBM Mk. II installation data", "Power Storage CBM Mk. II installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_watch",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Internal Chronometer CBM installation data", "Internal Chronometer CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_syringe",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Intravenous Needletip CBM installation data", "Intravenous Needletip CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_blood_anal",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Blood Analysis CBM installation data", "Blood Analysis CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_flashlight",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Cranial Flashlight CBM installation data", "Cranial Flashlight CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_magnet",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Electromagnetic Unit CBM installation data", "Electromagnetic Unit CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_soporific",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Soporific Induction CBM installation data", "Soporific Induction CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_armor_arms",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Subcutaneous Protective Mesh - Arms CBM installation data", "Subcutaneous Protective Mesh - Arms CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_armor_legs",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Subcutaneous Protective Mesh - Legs CBM installation data", "Subcutaneous Protective Mesh - Legs CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_shotgun",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Shotgun Arm CBM installation data", "Shotgun Arm CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_blood_filter",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Blood Filter CBM installation data", "Blood Filter CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_climate",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Internal Climate Control CBM installation data", "Internal Climate Control CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_geiger",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Integrated Dosimeter CBM installation data", "Integrated Dosimeter CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_heatsink",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Thermal Dissipation CBM installation data", "Thermal Dissipation CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_meteorologist",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Weather Reader CBM installation data", "Weather Reader CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_ups",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Unified Power System CBM installation data", "Unified Power System CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_weight",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Titanium Skeletal Bracing CBM installation data", "Titanium Skeletal Bracing CBM installation data"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "AID_AF_bio_pitch_perfect",
        copy_from = "AID_AF_abstract",
        name = ccb.content.plural_text("Throwing Assist CBM installation data", "Throwing Assist CBM installation data"),
    }
    content.add(item)
end
