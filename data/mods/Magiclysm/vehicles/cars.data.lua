local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "dwarf_supercompact_car",
    name = ccb.content.text("Dwarven Supercompact Car"),
    copy_from = "scompact_abstract",
    mounts = {
        { x = 1, y = 0, parts = { { part = "engine_vtwin" }, { part = "alternator_motorbike" } } },
        { x = 0, y = 0, parts = { { part = "pedal_extenders" } } },
        { x = -1, y = -1, parts = { { part = "tank_medium", fuel = "gasoline" } } },
        { x = -1, y = 0, parts = { { part = "muffler" } } },
    },
}
