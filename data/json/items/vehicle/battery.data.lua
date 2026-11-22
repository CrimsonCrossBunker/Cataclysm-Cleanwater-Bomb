local ccb = require("ccb")

ccb.content.define_item {
    id = "power_station_portable",
    copy_from = "storage_battery",
    name = "portable power station",
    description = "A ready-to-deploy portable rechargeable battery unit that comes with an inverter for powering home appliances and outlet ports for your electronic devices.  Useful for camping, power outage, and surviving the apocalypse.",
    ascii_picture = "small_storage_battery",
    mass = "8500 g",
    volume = "10 L",
    price = "600 USD",
    survival_price = "10 USD",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 4000 },
        },
    },
    use_actions = {
        { kind = "deploy_appliance", base = "power_station_portable" },
    },
    magazine = { capacity = 4000 },
}
