local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "immortal_path_qi_desc",
    style = "text",
    label = ccb.content.text("境界"),
    -- en_us_label: Realm
    -- 按炼气境层数显示未入门或当前层数。
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "uninitiated",
            text = ccb.content.text("未入门"),
            -- en_us_text: Uninitiated
            color = "c_dark_gray",
            when = reading.compare("spell_level", "<", 0, "realm_qi_refining"),
        },
        {
            id = "qi_refining",
            text = ccb.content.text("炼气 <u_val:qi_refining_layer> 层"),
            -- en_us_text: Qi Refining, layer N
            color = "c_light_cyan",
            parse_tags = true,
            when = reading.compare("spell_level", ">=", 0, "realm_qi_refining"),
        },
    },
}

ccb.content.define_widget {
    id = "immortal_path_qi_num",
    style = "number",
    label = ccb.content.text("灵气"),
    -- en_us_label: Qi
    -- 当前灵气与动态上限。
    custom_handler = "sidebar_qi",
    colors = { "c_light_blue", "c_cyan", "c_light_cyan" },
}

ccb.content.define_widget {
    id = "immortal_path_qi_power_num",
    style = "number",
    label = ccb.content.text("灵气强度"),
    -- en_us_label: Qi power
    -- 灵气强度基础值为 100，圆满时约为 196。火弹术等攻击法术以强度除以 100 计算倍率。
    custom_handler = "sidebar_qi_power",
    colors = { "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "immortal_path_qi_graph",
    style = "graph",
    label = ccb.content.text("灵气"),
    -- en_us_label: Qi
    -- 进度条随角色当前的灵气上限缩放。
    custom_handler = "sidebar_qi",
    width = 20,
    symbols = ".oO0",
    fill = "bucket",
    colors = { "c_blue", "c_light_blue", "c_cyan", "c_light_cyan" },
}

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
