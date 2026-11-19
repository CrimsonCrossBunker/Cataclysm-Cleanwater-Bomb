local ccb = require("ccb")

ccb.content.define_npc {
    id = "uica_vehicle_merchant",
    unique_name = ccb.content.text("Artemis Burton"),
    suffix = ccb.content.text("garage clerk"),
    gender = "male",
    class = "NC_UICA_VEHICLE_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_UICA_VEHICLE_MERCHANT",
    faction = "UICA",
}
