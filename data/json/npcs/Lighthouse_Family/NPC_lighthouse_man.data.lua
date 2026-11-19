local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "lighthouse_man_survivor",
    layout = {
        npc_placements = { { id = "NPC_survivor_lighthouse", x = { 7, 17 }, y = { 10, 15 } } },
    },
}
