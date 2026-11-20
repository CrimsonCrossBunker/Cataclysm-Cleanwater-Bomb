local ccb = require("ccb")
local reading = ccb.content.widget_conditions

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
