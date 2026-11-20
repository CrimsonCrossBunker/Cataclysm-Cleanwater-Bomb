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
