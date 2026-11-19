local ccb = require("ccb")

-- Realm
-- 境界文字分区。顶层 layout 需带 label——它是侧边栏排序栏里显示的名字（原版顶层 layout 如 Stats/Movement 皆有 label）。/ Realm descriptor section. Top-level layouts need a label: it's the name shown in the sidebar options/sort menu.
ccb.content.define_widget {
    id = "immortal_path_qi_desc_layout",
    style = "layout",
    arrange = "columns",
    label = ccb.content.text("境界"),
    widgets = { "immortal_path_qi_desc" },
}

-- Qi
-- 灵气数值分区。/ Qi number section.
ccb.content.define_widget {
    id = "immortal_path_qi_num_layout",
    style = "layout",
    arrange = "columns",
    label = ccb.content.text("灵气"),
    widgets = { "immortal_path_qi_num" },
}

-- Qi power
-- 灵气强度数值分区。/ Qi power number section.
ccb.content.define_widget {
    id = "immortal_path_qi_power_layout",
    style = "layout",
    arrange = "columns",
    label = ccb.content.text("灵气强度"),
    widgets = { "immortal_path_qi_power_num" },
}

-- Qi bar
-- 灵气进度条分区。label 用「灵气槽」与数值分区「灵气」区分，避免排序栏出现两个同名「灵气」。/ Qi graph section. Labeled distinctly from the Qi number section so the sort menu doesn't show two identical 'Qi' entries.
ccb.content.define_widget {
    id = "immortal_path_qi_graph_layout",
    style = "layout",
    arrange = "columns",
    label = ccb.content.text("灵气槽"),
    widgets = { "immortal_path_qi_graph" },
}

-- 把灵气分区 extend 进各原版侧边栏预设。/ Extend each vanilla sidebar preset with the qi sections.
ccb.content.define_widget {
    copy_from = "custom_sidebar",
    id = "custom_sidebar",
    extend = {
        widgets = {
            "immortal_path_qi_desc_layout",
            "immortal_path_qi_num_layout",
            "immortal_path_qi_power_layout",
            "immortal_path_qi_graph_layout",
        },
    },
}

ccb.content.define_widget {
    copy_from = "my_labels_sidebar",
    id = "my_labels_sidebar",
    extend = {
        widgets = {
            "immortal_path_qi_desc_layout",
            "immortal_path_qi_num_layout",
            "immortal_path_qi_power_layout",
            "immortal_path_qi_graph_layout",
        },
    },
}

ccb.content.define_widget {
    copy_from = "my_labels_sidebar_cleaner",
    id = "my_labels_sidebar_cleaner",
    extend = {
        widgets = {
            "immortal_path_qi_desc_layout",
            "immortal_path_qi_num_layout",
            "immortal_path_qi_power_layout",
            "immortal_path_qi_graph_layout",
        },
    },
}
