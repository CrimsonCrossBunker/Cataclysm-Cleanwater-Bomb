local ccb = require("ccb")

ccb.content.define_widget {
    id = "player_weapon_and_martial_arts_block",
    style = "layout",
    label = ccb.content.text("5_Weapon/Sound block"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "weapon_sound_block" },
}

ccb.content.define_widget {
    id = "weapon_sound_block",
    style = "layout",
    label = ccb.content.text("Weapon/Sound block"),
    width = 42,
    arrange = "rows",
    widgets = { "sound_bar", "wielding_desc", "weapon_style_row" },
}

ccb.content.define_widget {
    id = "weapon_style_row",
    style = "layout",
    label = ccb.content.text("Weapon/Style row"),
    width = 42,
    arrange = "minimum_columns",
    widgets = { "style_desc", "ma_buff_legend" },
}

ccb.content.define_widget {
    id = "sound_bar",
    style = "graph",
    label = ccb.content.text("Sound"),
    width = 15,
    symbols = ".oO",
    fill = "bucket",
    variable = "sound",
    colors = { "c_blue", "c_cyan", "c_light_blue", "c_green", "c_yellow", "c_light_red", "c_red" },
}
