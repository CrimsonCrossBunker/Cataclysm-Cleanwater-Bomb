local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "report_march_lord",
        name = ccb.content.plural_text("Report CO001141", "copies of Report CO001141"),
        description = ccb.content.text("A page from a report."),
        copy_from = "survnote",
        looks_like = "survnote",
        snippet_category = "changeling_march_lord_report",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "report_red_twilight_34",
        name = ccb.content.plural_text("Report Red Twilight 34", "copies of Report Red Twilight 34"),
        description = ccb.content.text("A page from a report."),
        copy_from = "survnote",
        looks_like = "survnote",
        snippet_category = "bloodthorne_druid_vampire_report",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "border_patrol_files",
        name = ccb.content.plural_text("border patrol files", "border patrol files"),
        description = ccb.content.text("A folder filled with pages."),
        copy_from = "survnote",
        looks_like = "survnote",
        snippet_category = "border_patrol_files",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "green_postit_field_agent",
        copy_from = "survnote",
        looks_like = "survnote",
        name = ccb.content.plural_text("green post-it note", "green post-it notes"),
        description = ccb.content.text("A bright post-it note."),
        snippet_category = "desk_postit_field_agent",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "agent_postit_gray",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("gray post-it note", "gray post-it notes"),
        description = ccb.content.text("A bright post-it note."),
        snippet_category = "agent_postit_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "agent_postit_migo",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("pink post-it note", "pink post-it notes"),
        description = ccb.content.text("A bright post-it note."),
        snippet_category = "agent_postit_migo",
    }
    content.add(item)
end
