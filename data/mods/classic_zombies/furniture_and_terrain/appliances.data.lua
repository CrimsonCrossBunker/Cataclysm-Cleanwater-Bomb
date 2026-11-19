local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "app_battery_car_assembly",
    name = ccb.content.text("grid-attached car battery assembly"),
    categories = { "energy" },
    looks_like = "large_storage_battery",
    color = "red",
    flags = { "OBSTACLE", "APPLIANCE", "NO_INSTALL_HIDDEN" },
    description = ccb.content.text("A group of six car batteries connected with a battery management system and wired into a static power grid."),
    item = "battery_car_assembly",
    breaks_into = {
        { item = "lead", count = { 10080, 14280 } },
        { item = "chem_sulphuric_acid", count = { 30, 40 }, container_item = "null" },
        { item = "plastic_chunk", count = { 84, 120 } },
        { item = "scrap", count = { 12, 18 } },
        { item = "shredded_rubber", count = { 60, 84 } },
    },
    durability = 120,
    requirements = { removal = { duration = "25 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}
