local content = require("ccb").content

for _, sidebar in ipairs {
    "legacy_classic_sidebar",
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
    "legacy_labels_sidebar",
    "structured_sidebar",
    "spacebar",
} do
    content.extend_sidebar(sidebar, {
        "xe_current_max_mana_nums_layout",
        "xe_mana_graph_layout",
        "xe_mana_pool_layout",
        "blood_ruach_descriptor",
        "blood_ruach_numbers",
        "blood_ruach_graph",
    })
end
