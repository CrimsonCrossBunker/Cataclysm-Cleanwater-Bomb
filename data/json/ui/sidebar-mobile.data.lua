local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "t_border",
    width = 1,
    style = "symbol",
    colors = { "c_blue" },
    text = "",
}

-- NO_I18N
ccb.content.define_widget {
    id = "t_label",
    width = 1,
    style = "symbol",
    text = ccb.content.text_without_extraction(" "),
    colors = { "c_dark_gray" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_space",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction(" "),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_sw",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╰"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_nw",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╭"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_se",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╯"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_ne",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("╮"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_sc_cl",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("┴"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_nc_cl",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("┬"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_hc",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("─"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_vc",
    width = 1,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("│"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_div1",
    width = 41,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("═══════╧═══════════════════════╧═════════"),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_div2",
    width = 41,
    copy_from = "t_border",
    text = ccb.content.text_without_extraction("═════════════════════════════════════════"),
}

local function bodypart_widget(id, bodypart, label)
    ccb.content.define_widget {
        id = id,
        width = 3,
        style = "text",
        bodypart = bodypart,
        clauses = {
            {
                id = "healthy",
                text = label,
                color = "c_light_gray",
                when = predicate.negate(predicate.has_effect("speaker", "infected")),
            },
            { id = "infected", text = label, color = "c_green", when = predicate.has_effect("speaker", "infected") },
        },
    }
end

bodypart_widget("l_bp_HD", "head", ccb.content.text("HD:"))
bodypart_widget("l_bp_CT", "torso", ccb.content.text("CT:"))
bodypart_widget("l_bp_LA", "arm_l", ccb.content.text("LA:"))
bodypart_widget("l_bp_RA", "arm_r", ccb.content.text("RA:"))
bodypart_widget("l_bp_LL", "leg_l", ccb.content.text("LL:"))
bodypart_widget("l_bp_RL", "leg_r", ccb.content.text("RL:"))

ccb.content.define_widget {
    id = "t_vert_graph",
    width = 1,
    style = "graph",
    symbols = " ▁▂▃▄▅▆▇█",
    fill = "bucket",
}

ccb.content.define_widget {
    id = "t_horiz_graph",
    width = 5,
    style = "graph",
    symbols = " ▏▎▍▍▌▋▊▉█",
    fill = "bucket",
}

ccb.content.define_widget {
    id = "t_bp_wet_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_wetness",
    colors = { "h_dark_gray", "h_cyan", "h_light_cyan" },
}

ccb.content.define_widget {
    id = "i_bp_HD_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_wet_graph",
    copy_from = "t_bp_wet_graph",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "t_bp_enc_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_encumb",
    symbols = " ▂▄▆▇▇▇██████",
    colors = { "h_dark_gray", "h_yellow", "h_light_red" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "i_splinted_sym",
    width = 1,
    style = "symbol",
    text = ccb.content.text_without_extraction("‡"),
    colors = { "h_white" },
}

ccb.content.define_widget {
    id = "i_bp_HD_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "a_bp_LA_enc_splint",
    width = 1,
    style = "layout",
    arrange = "minimum_columns",
    bodypart = "arm_l",
    clauses = {
        { id = "splinted", when = reading.test("worn_flag", "SPLINT"), widgets = { "i_splinted_sym" } },
        { id = "intact", when = predicate.negate(reading.test("worn_flag", "SPLINT")), widgets = { "i_bp_LA_enc_graph" } },
    },
}

ccb.content.define_widget {
    id = "i_bp_RA_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "a_bp_RA_enc_splint",
    width = 1,
    style = "layout",
    arrange = "minimum_columns",
    bodypart = "arm_r",
    clauses = {
        { id = "splinted", when = reading.test("worn_flag", "SPLINT"), widgets = { "i_splinted_sym" } },
        { id = "intact", when = predicate.negate(reading.test("worn_flag", "SPLINT")), widgets = { "i_bp_RA_enc_graph" } },
    },
}

ccb.content.define_widget {
    id = "i_bp_LL_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "a_bp_LL_enc_splint",
    width = 1,
    style = "layout",
    arrange = "minimum_columns",
    bodypart = "leg_l",
    clauses = {
        { id = "splinted", when = reading.test("worn_flag", "SPLINT"), widgets = { "i_splinted_sym" } },
        { id = "intact", when = predicate.negate(reading.test("worn_flag", "SPLINT")), widgets = { "i_bp_LL_enc_graph" } },
    },
}

ccb.content.define_widget {
    id = "i_bp_RL_enc_graph",
    copy_from = "t_bp_enc_graph",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "a_bp_RL_enc_splint",
    width = 1,
    style = "layout",
    arrange = "minimum_columns",
    bodypart = "leg_r",
    clauses = {
        { id = "splinted", when = reading.test("worn_flag", "SPLINT"), widgets = { "i_splinted_sym" } },
        { id = "intact", when = predicate.negate(reading.test("worn_flag", "SPLINT")), widgets = { "i_bp_RL_enc_graph" } },
    },
}

ccb.content.define_widget {
    id = "t_bp_warmth_graph",
    width = 1,
    copy_from = "t_vert_graph",
    variable = "bp_warmth",
    symbols = "▼∨∙∧▲",
    colors = { "h_light_cyan", "h_cyan", "h_dark_gray", "h_light_red", "h_red" },
}

ccb.content.define_widget {
    id = "i_bp_HD_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_warmth_graph",
    copy_from = "t_bp_warmth_graph",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "t_bp_hp_graph",
    width = 7,
    copy_from = "t_horiz_graph",
    variable = "bp_hp",
    colors = { "h_red", "h_light_red", "h_yellow", "h_light_green", "h_green" },
}

ccb.content.define_widget {
    id = "i_bp_HD_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_hp_graph",
    copy_from = "t_bp_hp_graph",
    bodypart = "leg_r",
}

-- NO_I18N
ccb.content.define_widget {
    id = "t_bp_broken_sym",
    width = 7,
    style = "symbol",
    colors = { "c_white_red" },
    text = ccb.content.text_without_extraction("══╾⠡╼══"),
}

ccb.content.define_widget {
    id = "i_bp_HD_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "head",
    text = ccb.content.text("d e a d"),
}

ccb.content.define_widget {
    id = "i_bp_CT_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "torso",
    text = ccb.content.text("d e a d"),
}

ccb.content.define_widget {
    id = "i_bp_LA_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_broken_sym",
    copy_from = "t_bp_broken_sym",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "t_bp_mending_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "mending", symbol = "+", color = "h_white", when = predicate.has_effect("speaker", "mending") },
        {
            id = "notmending",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "mending")),
        },
    },
}

ccb.content.define_widget {
    id = "i_bp_LA_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_mending_sym",
    copy_from = "t_bp_mending_sym",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "i_stunned_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "stunned", symbol = "õ", color = "h_red", when = predicate.has_effect("speaker", "stunned") },
        { id = "ok", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "stunned")) },
    },
}

ccb.content.define_widget {
    id = "i_hypovolemia_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "stunned", symbol = "♥", color = "h_red", when = predicate.has_effect("speaker", "hypovolemia") },
        { id = "ok", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "hypovolemia")) },
    },
}

ccb.content.define_widget {
    id = "t_bp_status_sym",
    width = 6,
    style = "symbol",
    clauses = {
        {
            id = "1bleeding0",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "bleed", 1)),
        },
        {
            id = "1bleeding1",
            symbol = "│",
            color = "h_light_red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 1), reading.compare("bodypart_effect_intensity", "<", 11, "bleed") },
        },
        {
            id = "1bleeding2",
            symbol = "║",
            color = "h_red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 11), reading.compare("bodypart_effect_intensity", "<", 21, "bleed") },
        },
        { id = "1bleeding3", symbol = "║", color = "c_red_red", when = predicate.has_effect("speaker", "bleed", 21) },
        { id = "2bandaged", symbol = "@", color = "h_white", when = predicate.has_effect("speaker", "bandaged") },
        {
            id = "2intact",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "bandaged")),
        },
        { id = "3bitten", symbol = "⣿", color = "h_red", when = predicate.has_effect("speaker", "bite") },
        { id = "3notbitten", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "bite")) },
        { id = "4disinfected", symbol = "Ọ", color = "h_white", when = predicate.has_effect("speaker", "disinfected") },
        {
            id = "4notdisinfected",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "disinfected")),
        },
        { id = "5blisters", symbol = "∞", color = "h_red", when = predicate.has_effect("speaker", "blisters") },
        {
            id = "5notblisters",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "blisters")),
        },
        { id = "6chafing", symbol = "Ξ", color = "h_red", when = predicate.has_effect("speaker", "chafing") },
        {
            id = "6notchafing",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "chafing")),
        },
    },
}

ccb.content.define_widget {
    id = "i_bp_HD_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "head",
}

ccb.content.define_widget {
    id = "i_bp_CT_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "torso",
}

ccb.content.define_widget {
    id = "i_bp_LA_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "arm_l",
}

ccb.content.define_widget {
    id = "i_bp_RA_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "arm_r",
}

ccb.content.define_widget {
    id = "i_bp_LL_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "leg_l",
}

ccb.content.define_widget {
    id = "i_bp_RL_status_sym",
    copy_from = "t_bp_status_sym",
    bodypart = "leg_r",
}

ccb.content.define_widget {
    id = "a_bp_LA_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "arm_l",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_LA", "l_nc_cl", "i_bp_LA_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_LA", "l_nc_cl", "i_bp_LA_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_HD_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "head",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_HD", "l_nc_cl", "i_bp_HD_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_HD", "l_nc_cl", "i_bp_HD_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_RA_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "arm_r",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_RA", "l_nc_cl", "i_bp_RA_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_RA", "l_nc_cl", "i_bp_RA_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_LL_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "leg_l",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_LL", "l_nc_cl", "i_bp_LL_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_LL", "l_nc_cl", "i_bp_LL_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_CT_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "torso",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_CT", "l_nc_cl", "i_bp_CT_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_CT", "l_nc_cl", "i_bp_CT_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_RL_row1",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    flags = { "W_NO_PADDING" },
    bodypart = "leg_r",
    clauses = {
        {
            id = "broken",
            widgets = { "l_nw", "l_bp_RL", "l_nc_cl", "i_bp_RL_broken_sym", "l_ne" },
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "intact",
            widgets = { "l_nw", "l_bp_RL", "l_nc_cl", "i_bp_RL_hp_graph", "l_ne" },
            when = reading.compare("bodypart_health", ">", 0),
        },
    },
}

ccb.content.define_widget {
    id = "a_bp_HD_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_HD_wet_graph",
        "i_bp_HD_enc_graph",
        "i_bp_HD_warmth_graph",
        "l_sc_cl",
        "i_bp_HD_status_sym",
        "i_stunned_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_CT_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_CT_wet_graph",
        "i_bp_CT_enc_graph",
        "i_bp_CT_warmth_graph",
        "l_sc_cl",
        "i_bp_CT_status_sym",
        "i_hypovolemia_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_LA_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_LA_wet_graph",
        "a_bp_LA_enc_splint",
        "i_bp_LA_warmth_graph",
        "l_sc_cl",
        "i_bp_LA_status_sym",
        "i_bp_LA_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_RA_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_RA_wet_graph",
        "a_bp_RA_enc_splint",
        "i_bp_RA_warmth_graph",
        "l_sc_cl",
        "i_bp_RA_status_sym",
        "i_bp_RA_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_LL_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_LL_wet_graph",
        "a_bp_LL_enc_splint",
        "i_bp_LL_warmth_graph",
        "l_sc_cl",
        "i_bp_LL_status_sym",
        "i_bp_LL_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "a_bp_RL_row2",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "l_sw",
        "i_bp_RL_wet_graph",
        "a_bp_RL_enc_splint",
        "i_bp_RL_warmth_graph",
        "l_sc_cl",
        "i_bp_RL_status_sym",
        "i_bp_RL_mending_sym",
        "l_se",
    },
}

ccb.content.define_widget {
    id = "w_bp_LA_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_LA_row1", "a_bp_LA_row2" },
}

ccb.content.define_widget {
    id = "w_bp_HD_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_HD_row1", "a_bp_HD_row2" },
}

ccb.content.define_widget {
    id = "w_bp_RA_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_RA_row1", "a_bp_RA_row2" },
}

ccb.content.define_widget {
    id = "w_bp_LL_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_LL_row1", "a_bp_LL_row2" },
}

ccb.content.define_widget {
    id = "w_bp_CT_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_CT_row1", "a_bp_CT_row2" },
}

ccb.content.define_widget {
    id = "w_bp_RL_status",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bp_RL_row1", "a_bp_RL_row2" },
}

ccb.content.define_widget {
    id = "a_vert_divider_7",
    width = 1,
    style = "layout",
    arrange = "rows",
    widgets = { "l_space" },
}

ccb.content.define_widget {
    id = "a_vert_divider_bp",
    width = 1,
    style = "layout",
    arrange = "rows",
    widgets = { "l_space", "l_space" },
}

ccb.content.define_widget {
    id = "w_overmap_7x7",
    width = 7,
    height = 7,
    style = "text",
    variable = "overmap_text",
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_moon_phase_left",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction("["),
}

-- NO_I18N
ccb.content.define_widget {
    id = "l_moon_phase_right",
    width = 1,
    copy_from = "t_label",
    text = ccb.content.text_without_extraction("]"),
}

ccb.content.define_widget {
    id = "i_moon_phase_text",
    width = 5,
    style = "symbol",
    clauses = {
        { id = "new_moon", symbol = "⎛   ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 0) },
        { id = "waxing_crescent1", symbol = "⎛  ", color = "c_light_gray", when = reading.compare("moon_phase", "==", 1) },
        { id = "waxing_crescent2", symbol = "▊⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 1) },
        { id = "half_moon1", symbol = "⎛ ▐", color = "c_light_gray", when = reading.compare("moon_phase", "==", 2) },
        { id = "half_moon2", symbol = "⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 2) },
        { id = "waxing_gibbous1", symbol = "⎛", color = "c_light_gray", when = reading.compare("moon_phase", "==", 3) },
        { id = "waxing_gibbous2", symbol = "▎⢁⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 4) },
        { id = "full_moon", symbol = "⎛⡐⢁⡡⎞", color = "c_black_white", when = reading.compare("moon_phase", "==", 4) },
        { id = "waning_gibbous1", symbol = "⎛⡐⢁", color = "c_black_white", when = reading.compare("moon_phase", "==", 5) },
        { id = "waning_gibbous2", symbol = "▎⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 5) },
        { id = "half_moon1", symbol = "⎛⡐", color = "c_black_white", when = reading.compare("moon_phase", "==", 6) },
        { id = "half_moon2", symbol = "▌ ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 6) },
        { id = "waning_crescent1", symbol = "⎛", color = "c_black_white", when = reading.compare("moon_phase", "==", 7) },
        { id = "waning_crescent2", symbol = "▎  ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 7) },
        { id = "dark_moon", symbol = "⎛   ⎞", color = "c_light_gray", when = reading.compare("moon_phase", "==", 8) },
    },
}

ccb.content.define_widget {
    id = "w_moon_phase",
    width = 7,
    style = "layout",
    arrange = "minimum_columns",
    clauses = {
        { id = "hide", when = predicate.conversation_state("daylight"), widgets = { "l_space" } },
        {
            id = "show",
            when = predicate.negate(predicate.conversation_state("daylight")),
            widgets = { "l_moon_phase_left", "i_moon_phase_text", "l_moon_phase_right" },
        },
    },
}

ccb.content.define_widget {
    id = "l_date",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Date:"),
}

ccb.content.define_widget {
    id = "l_time",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Time:"),
}

ccb.content.define_widget {
    id = "l_place",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Place:"),
}

ccb.content.define_widget {
    id = "l_sky",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("  Sky:"),
}

ccb.content.define_widget {
    id = "l_wind",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Wind:"),
}

ccb.content.define_widget {
    id = "l_light",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Light:"),
}

ccb.content.define_widget {
    id = "l_sound",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text("Sound:"),
}

ccb.content.define_widget {
    id = "l_temp",
    width = 6,
    copy_from = "t_label",
    text = ccb.content.text(" Temp:"),
}

ccb.content.define_widget {
    id = "i_place_text",
    width = 23,
    style = "text",
    variable = "place_text",
    colors = { "c_white" },
}

ccb.content.define_widget {
    id = "i_light_sym",
    width = 5,
    style = "text",
    clauses = {
        { id = "bright", text = "☼☼☼☼☼", color = "c_white", when = reading.compare("fine_detail_vision_mod", "<=", 1) },
        { id = "cloudy", text = "☼☼☼☼", color = "c_yellow", when = reading.compare("fine_detail_vision_mod", "==", 2) },
        { id = "shady", text = "☼☼☼", color = "c_light_gray", when = reading.compare("fine_detail_vision_mod", "==", 3) },
        { id = "dark", text = "☼☼", color = "c_dark_gray", when = reading.compare("fine_detail_vision_mod", "==", 4) },
        { id = "very dark", text = "☼", color = "c_dark_gray", when = reading.compare("fine_detail_vision_mod", ">=", 5) },
    },
}

ccb.content.define_widget {
    id = "i_sound_graph",
    width = 5,
    style = "graph",
    fill = "bucket",
    symbols = " ▎▍▌▊▉▉███",
    variable = "sound",
    colors = { "c_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "w_date",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_date", "date_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_time",
    width = 15,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_time", "sundial_time_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_time_moon",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_time", "l_space", "w_moon_phase" },
}

ccb.content.define_widget {
    id = "w_place",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "i_place_text" },
}

ccb.content.define_widget {
    id = "w_sky",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_sky", "weather_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_wind",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wind", "wind_desc_no_label" },
}

ccb.content.define_widget {
    id = "w_light_sound",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_light", "i_light_sym", "l_space", "l_sound", "i_sound_graph" },
}

ccb.content.define_widget {
    id = "w_temp",
    width = 23,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_temp", "env_temp_desc_no_label" },
}

ccb.content.define_widget {
    id = "a_surrounding",
    width = 23,
    style = "layout",
    arrange = "rows",
    widgets = { "w_place", "w_date", "w_time_moon", "w_sky", "w_wind", "w_light_sound", "w_temp" },
}

ccb.content.define_widget {
    id = "l_str",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("S:", "label_strength"),
}

ccb.content.define_widget {
    id = "l_dex",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("D:", "label_dexterity"),
}

ccb.content.define_widget {
    id = "l_int",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("I:", "label_intelligence"),
}

ccb.content.define_widget {
    id = "l_per",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("P:", "label_perception"),
}

ccb.content.define_widget {
    id = "t_stat",
    width = 2,
    text_align = "right",
    style = "number",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_cyan", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "i_str_num",
    copy_from = "t_stat",
    variable = "stat_str",
}

ccb.content.define_widget {
    id = "i_dex_num",
    copy_from = "t_stat",
    variable = "stat_dex",
}

ccb.content.define_widget {
    id = "i_int_num",
    copy_from = "t_stat",
    variable = "stat_int",
}

ccb.content.define_widget {
    id = "i_per_num",
    copy_from = "t_stat",
    variable = "stat_per",
}

ccb.content.define_widget {
    id = "l_bpower",
    width = 3,
    copy_from = "t_label",
    text = ccb.content.text("BP:"),
}

ccb.content.define_widget {
    id = "i_bpower",
    width = 5,
    -- TODO: change to nice 5 section indicator, something is wrong
    style = "text",
    colors = { "h_yellow" },
    clauses = {
        { id = "20%", color = "h_yellow", symbol = "1", when = reading.compare("power_percentage", ">", 19) },
        { id = "40%", color = "h_yellow", symbol = "2", when = reading.compare("power_percentage", ">", 39) },
        { id = "60%", color = "h_yellow", symbol = "3", when = reading.compare("power_percentage", ">", 59) },
        { id = "80%", color = "h_yellow", symbol = "4", when = reading.compare("power_percentage", ">", 79) },
        { id = "99%", color = "h_yellow", symbol = "5", when = reading.compare("power_percentage", ">", 99) },
    },
    default_clause = { text = "     " },
}

-- current variant
ccb.content.define_widget {
    id = "i_bpower_graph",
    width = 5,
    style = "graph",
    fill = "bucket",
    symbols = "┈=≡Ξ",
    variable = "power_percentage",
    colors = { "h_dark_gray", "h_brown", "h_yellow", "h_white" },
}

ccb.content.define_widget {
    id = "i_bpower_balance_graph",
    width = 1,
    style = "graph",
    variable = "log_power_balance",
    symbols = "▼⎽⎼⎯⎻⎺▲",
    fill = "bucket",
    colors = { "h_red", "h_light_red", "h_yellow", "h_white", "h_light_green", "h_green", "h_light_cyan" },
    breaks = { 23, 40, 50, 51, 60, 77 },
}

ccb.content.define_widget {
    id = "a_bpower",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    clauses = {
        {
            id = "cyborg",
            widgets = { "l_bpower", "i_bpower_graph", "i_bpower_balance_graph" },
            when = reading.test("has_bionics"),
        },
        { id = "not_cyborg", widgets = { "l_space" }, when = predicate.negate(reading.test("has_bionics")) },
    },
}

ccb.content.define_widget {
    id = "a_stat_row1",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_str", "i_str_num", "l_space", "l_dex", "i_dex_num" },
}

ccb.content.define_widget {
    id = "a_stat_row2",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_int", "i_int_num", "l_space", "l_per", "i_per_num" },
}

-- TODO: Add mana widgets
ccb.content.define_widget {
    id = "a_stat_row3",
    width = 9,
    style = "layout",
    arrange = "rows",
    widgets = { "a_bpower", "l_space" },
}

ccb.content.define_widget {
    id = "w_stats",
    width = 9,
    style = "layout",
    arrange = "rows",
    widgets = { "a_stat_row1", "a_stat_row2", "a_stat_row3", "vehicle_acf_no_label_layout" },
}

ccb.content.define_widget {
    id = "l_hunger",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("H:"),
}

ccb.content.define_widget {
    id = "i_hunger_graph",
    width = 4,
    style = "text",
    clauses = {
        {
            id = "engorged",
            text = "o⁰ₒ○",
            color = "c_light_green_green",
            when = predicate.has_effect("speaker", "hunger_engorged"),
        },
        { id = "full", text = "████", color = "h_green", when = predicate.has_effect("speaker", "hunger_full") },
        { id = "satisfied", text = "  ██", color = "h_green", when = predicate.has_effect("speaker", "hunger_satisfied") },
        { id = "blank", text = "    ", color = "h_green", when = predicate.has_effect("speaker", "hunger_blank") },
        { id = "hungry", text = "█   ", color = "c_light_gray", when = predicate.has_effect("speaker", "hunger_hungry") },
        { id = "very_hungry", text = "██  ", color = "h_yellow", when = predicate.has_effect("speaker", "hunger_very_hungry") },
        { id = "near_starving", text = "███ ", color = "h_red", when = predicate.has_effect("speaker", "hunger_near_starving") },
        { id = "starving", text = "████", color = "h_red", when = predicate.has_effect("speaker", "hunger_starving") },
        { id = "famished", text = "XXXX", color = "i_red", when = predicate.has_effect("speaker", "hunger_famished") },
    },
}

ccb.content.define_widget {
    id = "l_thrist",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text(":T"),
}

ccb.content.define_widget {
    id = "i_thrist_graph",
    width = 4,
    style = "text",
    clauses = {
        { id = "turgid", text = "o⁰ₒ○", color = "c_light_green_green", when = reading.compare("instant_thirst", "<", -60) },
        {
            id = "hydrated",
            text = "████",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -60), reading.compare("instant_thirst", "<", -20) },
        },
        {
            id = "slaked",
            text = "  ██",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -20), reading.compare("instant_thirst", "<", 0) },
        },
        {
            id = "neutral",
            text = "    ",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", 0), reading.compare("instant_thirst", "<=", 40) },
        },
        {
            id = "thirsty",
            text = "█   ",
            color = "h_yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 40), reading.compare("instant_thirst", "<=", 80) },
        },
        {
            id = "very_thirsty",
            text = "██  ",
            color = "h_yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 80), reading.compare("instant_thirst", "<=", 240) },
        },
        {
            id = "dehydrated",
            text = "███ ",
            color = "h_red",
            when = predicate.all { reading.compare("instant_thirst", ">", 240), reading.compare("instant_thirst", "<=", 450) },
        },
        {
            id = "dehydrated2",
            text = "████",
            color = "h_red",
            when = predicate.all { reading.compare("instant_thirst", ">", 450), reading.compare("instant_thirst", "<=", 520) },
        },
        { id = "parched", text = "XXXX", color = "i_red", when = reading.compare("instant_thirst", ">", 520) },
    },
}

ccb.content.define_widget {
    id = "a_hunger_thrist",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_hunger", "i_hunger_graph", "i_weight_sym", "i_thrist_graph", "l_thrist" },
}

ccb.content.define_widget {
    id = "i_weight_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "sk", symbol = "ₒ", color = "c_red", when = reading.compare("bmi_permil", "<=", 1000) },
        {
            id = "e",
            symbol = "ₒ",
            color = "c_light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "u_w",
            symbol = "ₒ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "n",
            symbol = "ₒ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "o_w",
            symbol = "ₒ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "o",
            symbol = "ₒ",
            color = "c_light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "v_o",
            symbol = "ₒ",
            color = "c_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        { id = "m_o", symbol = "ₒ", color = "c_white", when = reading.compare("bmi_permil", ">", 20000) },
    },
}

ccb.content.define_widget {
    id = "i_weight_graph",
    width = 5,
    style = "symbol",
    clauses = {
        { id = "sk", symbol = "⎻⎺", color = "c_brown", when = reading.compare("bmi_permil", "<=", 1000) },
        { id = "sk", symbol = "ₗ", color = "c_yellow", when = reading.compare("bmi_permil", "<=", 1000) },
        { id = "sk", symbol = "  ", color = "c_brown", when = reading.compare("bmi_permil", "<=", 1000) },
        {
            id = "e",
            symbol = "∕ʻ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "e",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "e",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "unw",
            symbol = " ╱",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "unw",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "unw",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "nrm",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "nrm",
            symbol = "╿",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "nrm",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "ovw",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "ovw",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "ovw",
            symbol = "╲ ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "o",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "o",
            symbol = " ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "o",
            symbol = "ʽ∖",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "v_o",
            symbol = "  ",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "v_o",
            symbol = "ₕ",
            color = "c_yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "v_o",
            symbol = "⎺⎻",
            color = "c_brown",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        { id = "m_o", symbol = "  ", color = "c_brown", when = reading.compare("bmi_permil", ">", 20000) },
        { id = "m_o", symbol = "ₕ", color = "c_red", when = reading.compare("bmi_permil", ">", 20000) },
        { id = "m_o", symbol = " ⎺", color = "c_brown", when = reading.compare("bmi_permil", ">", 20000) },
    },
}

ccb.content.define_widget {
    id = "w_weight_body",
    width = 7,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_space", "l_space", "l_space", "l_sw", "i_weight_graph", "l_se" },
}

ccb.content.define_widget {
    id = "w_weight_hunger_thrist",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_hunger_thrist", "w_weight_body" },
}

ccb.content.define_widget {
    id = "l_mood",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("M:"),
}

ccb.content.define_widget {
    id = "i_mood_num",
    width = 4,
    variable = "morale_level",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "l_focus",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("F:"),
}

ccb.content.define_widget {
    id = "i_focus_num",
    width = 4,
    variable = "focus",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "a_mood_focus",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_mood", "i_mood_num", "l_space", "l_focus", "i_focus_num" },
}

ccb.content.define_widget {
    id = "w_pain_mood_focus",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "a_mood_focus", "pain_desc_no_label" },
}

ccb.content.define_widget {
    id = "i_speed_num",
    width = 3,
    variable = "speed",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "i_basemovecost_num",
    width = 4,
    style = "number",
    variable = "move_cost",
    colors = { "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "c_red_red" },
}

ccb.content.define_widget {
    id = "i_move_mode_text",
    width = 1,
    style = "symbol",
    copy_from = "move_mode_template",
}

ccb.content.define_widget {
    id = "i_move_counter",
    width = 3,
    variable = "move",
    style = "number",
}

ccb.content.define_widget {
    id = "w_speed_mbmc_move_mode",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "i_speed_num",
        "l_space",
        "i_move_mode_text",
        "i_basemovecost_num",
        "l_space",
        "i_move_counter",
    },
}

ccb.content.define_widget {
    id = "l_stamina",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("S:", "label_stamina"),
}

ccb.content.define_widget {
    id = "i_stamina_graph",
    width = 11,
    copy_from = "t_horiz_graph",
    variable = "stamina",
    colors = { "h_light_gray" },
}

ccb.content.define_widget {
    id = "w_stamina",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_stamina", "i_stamina_graph" },
}

ccb.content.define_widget {
    id = "w_movement_stamina",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_speed_mbmc_move_mode", "w_stamina" },
}

ccb.content.define_widget {
    id = "l_safe_mode",
    width = 10,
    copy_from = "t_label",
    text = ccb.content.text("Safe mode:"),
}

ccb.content.define_widget {
    id = "i_safe_mode_text",
    width = 3,
    style = "text",
    variable = "safe_mode_text",
}

ccb.content.define_widget {
    id = "w_safe_mode",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_safe_mode", "i_safe_mode_text" },
}

ccb.content.define_widget {
    id = "l_rest",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("R:"),
}

ccb.content.define_widget {
    id = "i_rest_graph",
    width = 4,
    copy_from = "t_horiz_graph",
    variable = "sleepiness",
    colors = { "h_light_gray", "h_light_red" },
}

ccb.content.define_widget {
    id = "w_rest",
    width = 6,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_rest", "i_rest_graph" },
}

ccb.content.define_widget {
    id = "l_activity",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("A:"),
}

ccb.content.define_widget {
    id = "i_activity_text",
    width = 11,
    text_align = "right",
    style = "text",
    clauses = {
        {
            id = "none",
            text = ccb.content.text("None       "),
            color = "light_gray",
            when = reading.compare("activity_level", "==", 0),
        },
        {
            id = "light",
            text = ccb.content.text("Light      "),
            color = "yellow",
            when = reading.compare("activity_level", "==", 1),
        },
        {
            id = "moderate",
            text = ccb.content.text("Moderate   "),
            color = "yellow",
            when = reading.compare("activity_level", "==", 2),
        },
        {
            id = "brisk",
            text = ccb.content.text("Brisk      "),
            color = "light_red",
            when = reading.compare("activity_level", "==", 3),
        },
        {
            id = "active",
            text = ccb.content.text("Active     "),
            color = "light_red",
            when = reading.compare("activity_level", "==", 4),
        },
        {
            id = "extreme",
            text = ccb.content.text("Extreme    "),
            color = "red",
            when = reading.compare("activity_level", ">=", 5),
        },
    },
}

ccb.content.define_widget {
    id = "w_activity",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_activity", "i_activity_text" },
}

ccb.content.define_widget {
    id = "l_wmalus",
    width = 8,
    copy_from = "t_label",
    text = ccb.content.text("W.Malus:"),
}

ccb.content.define_widget {
    id = "i_wmalus_text",
    width = 5,
    style = "text",
    variable = "weary_malus_text",
}

ccb.content.define_widget {
    id = "w_wmalus",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wmalus", "i_wmalus_text" },
}

ccb.content.define_widget {
    id = "l_weary",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("W:", "label_weary"),
}

ccb.content.define_widget {
    id = "i_weary_graph",
    width = 4,
    copy_from = "t_horiz_graph",
    variable = "weariness_level",
    colors = { "h_yellow", "h_yellow", "h_light_red", "h_red", "h_red", "h_red", "h_red" },
}

ccb.content.define_widget {
    id = "w_weary",
    width = 6,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_weary", "i_weary_graph" },
}

ccb.content.define_widget {
    id = "l_wtrns",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text("W:", "label_weary"),
}

ccb.content.define_widget {
    id = "i_wtrns_graph",
    width = 11,
    copy_from = "t_horiz_graph",
    variable = "weary_transition_level",
    colors = { "h_light_gray" },
}

ccb.content.define_widget {
    id = "w_wtrns",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_wtrns", "i_wtrns_graph" },
}

ccb.content.define_widget {
    id = "l_weight",
    width = 9,
    copy_from = "t_label",
    text = ccb.content.text("Weight : "),
}

ccb.content.define_widget {
    id = "i_weight",
    width = 3,
    text_align = "right",
    variable = "carry_weight_text",
    style = "text",
}

ccb.content.define_widget {
    id = "w_weight_carried",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "l_weight", "i_weight" },
}

ccb.content.define_widget {
    id = "w_act_safe",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_activity", "w_safe_mode" },
}

ccb.content.define_widget {
    id = "w_wgrph_rgrph",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_weary", "l_space", "w_rest" },
}

ccb.content.define_widget {
    id = "w_weight_wmalus",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_weight_carried", "w_wmalus" },
}

ccb.content.define_widget {
    id = "w_wtrns_wgrph_rgrph",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "w_wtrns", "w_wgrph_rgrph" },
}

ccb.content.define_widget {
    id = "a_wht_hd_pmf",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_weight_hunger_thrist",
        "a_vert_divider_bp",
        "w_bp_HD_status",
        "a_vert_divider_bp",
        "w_pain_mood_focus",
    },
}

ccb.content.define_widget {
    id = "a_la_ct_ra",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_bp_LA_status",
        "a_vert_divider_bp",
        "w_bp_CT_status",
        "a_vert_divider_bp",
        "w_bp_RA_status",
    },
}

ccb.content.define_widget {
    id = "a_ll_sms_rl",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_bp_LL_status",
        "a_vert_divider_bp",
        "w_movement_stamina",
        "a_vert_divider_bp",
        "w_bp_RL_status",
    },
}

ccb.content.define_widget {
    id = "a_rs_act_wt",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "w_act_safe",
        "a_vert_divider_bp",
        "w_wtrns_wgrph_rgrph",
        "a_vert_divider_bp",
        "w_weight_wmalus",
    },
}

ccb.content.define_widget {
    id = "a_wht_la_ll_rs",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_weight_hunger_thrist", "w_bp_LA_status", "w_bp_LL_status", "w_act_safe" },
}

ccb.content.define_widget {
    id = "a_hd_ct_sms_act",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_bp_HD_status", "w_bp_CT_status", "w_movement_stamina", "w_weight_wmalus" },
}

ccb.content.define_widget {
    id = "a_pmf_ra_rl_wt",
    width = 13,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_pain_mood_focus", "w_bp_RA_status", "w_bp_RL_status", "w_wtrns_wgrph_rgrph" },
}

ccb.content.define_widget {
    id = "a_ma",
    width = 13,
    style = "layout",
    arrange = "rows",
    widgets = { "style_desc_no_label", "ma_buff_legend" },
}

ccb.content.define_widget {
    id = "w_compass",
    width = 27,
    style = "layout",
    arrange = "rows",
    widgets = {
        "compass_top_danger_layout",
        "compass_middle_danger_layout",
        "compass_bottom_danger_layout",
        "compass_legend_text_alt",
    },
}

ccb.content.define_widget {
    id = "a_compass_ma",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "w_compass", "a_ma" },
}

ccb.content.define_widget {
    id = "r_1",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("! Location info"),
    widgets = { "w_overmap_7x7", "a_vert_divider_7", "a_surrounding", "a_vert_divider_7", "w_stats" },
}

ccb.content.define_widget {
    id = "r_2",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("! Player status"),
    widgets = { "a_wht_hd_pmf", "a_la_ct_ra", "a_ll_sms_rl", "a_rs_act_wt" },
}

ccb.content.define_widget {
    id = "r_2_alt",
    width = 41,
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("! Alt Player status"),
    widgets = { "a_wht_la_ll_rs", "a_hd_ct_sms_act", "a_pmf_ra_rl_wt" },
}

ccb.content.define_widget {
    id = "r_separator-top",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-top"),
    widgets = { "l_div1" },
}

ccb.content.define_widget {
    id = "r_separator-bottom",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-bottom"),
    widgets = { "l_div2" },
}

ccb.content.define_widget {
    id = "r_separator-space",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("separator-space"),
    widgets = { "l_space" },
}

ccb.content.define_widget {
    id = "r_3",
    width = 41,
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("! MA, buffs, compass"),
    widgets = { "wielding_desc_no_label", "a_compass_ma" },
}

ccb.content.define_widget {
    id = "sidebar-mobile",
    width = 43,
    style = "sidebar",
    description = ccb.content.text("This one intended for mobile use where every symbol counts. Fixed data takes 22 lines and 43 symbols width. "),
    separator = ": ",
    padding = 0,
    label = ccb.content.text("mobile", "UI sidebar"),
    widgets = { "r_1", "r_separator-space", "r_2", "r_separator-space", "r_3", "oxygen_classic_layout" },
}
