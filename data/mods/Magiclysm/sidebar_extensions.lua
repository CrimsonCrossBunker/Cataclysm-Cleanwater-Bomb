local content = require("ccb").content

for _, sidebar in ipairs {
    "legacy_classic_sidebar",
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
    "legacy_labels_sidebar",
    "structured_sidebar",
} do
    content.extend_sidebar(sidebar, { "current_max_mana_nums_layout", "mana_graph_layout", "mana_pool_layout" })
end

content.extend_sidebar("spacebar", { "spacebar_mana_numbers_block", "spacebar_mana_bar_block" })
