local content = require("ccb").content

for _, sidebar in ipairs {
    "legacy_classic_sidebar",
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
    "legacy_labels_sidebar",
    "structured_sidebar",
} do
    content.extend_sidebar(sidebar, { "martial_mastery" })
end
