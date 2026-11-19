local ccb = require("ccb")

-- PrepNet Phyle Gardener.
ccb.content.define_npc {
    id = "afs_gardener_cyborg",
    suffix = ccb.content.text("Gardener"),
    class = "afs_prepnet_gardener",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_PrepNet_gardener_1",
    faction = "Prepnet_Phyle",
}

-- Abomination.  Change the chat if this loads.
ccb.content.define_npc {
    id = "whately_cousin",
    suffix = ccb.content.text("Cousin"),
    class = "whately_cousin",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_WHATELY_1",
    faction = "whately_family",
}
