local ccb = require("ccb")

-- Uses display::vehicle_azimuth_text
ccb.content.define_widget {
    id = "vehicle_azimuth_desc_label",
    label = ccb.content.text("Azimuth"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    variable = "veh_azimuth_text",
}

-- Current/target vehicle cruising speed from display::vehicle_cruise_text_color
ccb.content.define_widget {
    id = "vehicle_cruise_desc_label",
    label = ccb.content.text("Speed"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    variable = "veh_cruise_text",
}

-- Current/max fuel for active vehicle engine from display::vehicle_fuel_text_color
ccb.content.define_widget {
    id = "vehicle_fuel_desc_label",
    label = ccb.content.text("Fuel"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    variable = "veh_fuel_text",
}

-- Current/max vehicle battery from display::vehicle_battery_text_color
ccb.content.define_widget {
    id = "vehicle_battery_desc_label",
    label = ccb.content.text("Battery"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    variable = "veh_battery_text",
}

ccb.content.define_widget {
    id = "vehicle_azimuth_desc_no_label",
    copy_from = "vehicle_azimuth_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "vehicle_cruise_desc_no_label",
    copy_from = "vehicle_cruise_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "vehicle_fuel_desc_no_label",
    copy_from = "vehicle_fuel_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "vehicle_battery_desc_no_label",
    copy_from = "vehicle_battery_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "vehicle_acf_label_layout",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "vehicle_azimuth_desc_label",
        "vehicle_cruise_desc_label",
        "vehicle_battery_desc_label",
        "vehicle_fuel_desc_label",
    },
}

ccb.content.define_widget {
    id = "vehicle_acf_label_layout_columns",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "columns",
    widgets = {
        "vehicle_azimuth_desc_label",
        "vehicle_cruise_desc_label",
        "vehicle_battery_desc_label",
        "vehicle_fuel_desc_label",
    },
}

ccb.content.define_widget {
    id = "vehicle_acf_no_label_layout",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "vehicle_azimuth_desc_no_label",
        "vehicle_cruise_desc_no_label",
        "vehicle_battery_desc_no_label",
        "vehicle_fuel_desc_no_label",
    },
}
