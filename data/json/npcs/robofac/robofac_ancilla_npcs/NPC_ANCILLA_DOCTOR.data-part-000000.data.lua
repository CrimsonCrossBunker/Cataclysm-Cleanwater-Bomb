local ccb = require("ccb")

ccb.content.define_npc {
    id = "ancilla_doctor",
    unique_name = ccb.content.text("Doc.  Stevens"),
    gender = "male",
    class = "NC_ANCILLA_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ANCILLA_DOCTOR",
    faction = "no_faction",
}
