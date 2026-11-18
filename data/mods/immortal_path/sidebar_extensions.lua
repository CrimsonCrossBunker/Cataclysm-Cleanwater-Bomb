local content = require("ccb").content

for _, sidebar in ipairs {
    "legacy_classic_sidebar",
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
    "legacy_labels_sidebar",
} do
    content.extend_sidebar(sidebar, {
        "immortal_path_qi_desc_layout",
        "immortal_path_qi_num_layout",
        "immortal_path_qi_power_layout",
        "immortal_path_qi_graph_layout",
    })
end
