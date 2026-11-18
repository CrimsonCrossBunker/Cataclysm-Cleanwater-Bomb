local content = require("ccb").content

content.extend_sidebar("legacy_classic_sidebar", { "sidebar_nether_attunement_block" })

for _, sidebar in ipairs {
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
} do
    content.extend_sidebar(sidebar, { "sidebar_nether_attunement_block_narrow" })
end

for _, sidebar in ipairs {
    "legacy_labels_sidebar",
    "structured_sidebar",
} do
    content.extend_sidebar(sidebar, { "sidebar_nether_attunement_block" })
end

content.extend_sidebar("spacebar", { "spacebar_nether_attunement_block" })
