local ccb = require("ccb")

-- Tier 2 mantle
ccb.content.define_item {
    id = "xedra_rubber_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("remediator kinetic mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  This model incorporates a rubber coating that diffuses impacts and provides excellent protection from blunt trauma, even if it does feel a bit like a rain coat.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}
