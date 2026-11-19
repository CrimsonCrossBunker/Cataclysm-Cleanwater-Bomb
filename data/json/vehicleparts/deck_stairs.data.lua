local ccb = require("ccb")

-- Original Chinese: 车内楼梯
-- Original Chinese: 连接当前车内楼层与上一层的可拆卸通道。上下两层都需要可站立的车内部件。
ccb.content.define_vehicle_part {
    id = "deck_stairs",
    copy_from = "ladder_3",
    name = ccb.content.text("interior stairs"),
    item = "rope_30",
    location = "under",
    looks_like = "f_rope_up",
    flags = { "DECK_STAIRS", "SHOCK_IMMUNE" },
    description = ccb.content.text("A removable passage connecting this vehicle deck to the one above.  Both decks need a vehicle part you can stand on."),
}
