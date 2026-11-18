local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mission_science_rep_secure_usb_blank", kind = "collection" }
    group:entry { item = "usb_drive_nano", variables = { browsed = "true" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mission_science_rep_2_secure_usb_download", kind = "collection" }
    group:entry {
        item = "usb_drive_nano",
        variables = { browsed = "true" },
        contents = {
            { item = "software_lab_data" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mission_science_rep_3_secure_usb_download", kind = "collection" }
    group:entry {
        item = "usb_drive_nano",
        variables = { browsed = "true" },
        contents = {
            { item = "software_encryption_codes" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mission_science_rep_4_secure_usb_download", kind = "collection" }
    group:entry {
        item = "usb_drive_nano",
        variables = { browsed = "true" },
        contents = {
            { item = "software_archived_data" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mission_science_rep_5_secure_usb_download", kind = "collection" }
    group:entry {
        item = "usb_drive_nano",
        variables = { browsed = "true" },
        contents = {
            { item = "train_data" },
        },
    }
    content.add(group)
end
