local ccb = require("ccb")

ccb.content.define_npc {
    id = "augustmoon_shipping_chief",
    class = "NC_AUGUSTMOON_shipping_chief",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
    suffix = ccb.content.text("Portmaster"),
    faction = "UICA",
}

ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_shipping_chief",
    name = ccb.content.text("Portmaster"),
    job_description = ccb.content.text("I manage incoming and outgoing ships and shuttlecraft."),
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 5, 7 } },
    worn = "NC_UICA_PORT_CREW_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    shop_groups = { { id = "NC_AUGUSTMOON_shipping_stock", rigid = true } },
}
