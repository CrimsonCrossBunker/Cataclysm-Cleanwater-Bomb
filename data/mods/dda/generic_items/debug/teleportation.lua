local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = require("portal_storm_state")

do
    local item = content.Item {
        id = "dimensional_perambulator",
        category = "veh_parts",
        name = ccb.content.plural_text("dimensional perambulator", "dimensional perambulators"),
        description = ccb.content.text("A perambulator, for perambulating through dimensions"),
        mass_milligrams = 1000000,
        volume_ml = 5000,
        symbol = "#",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

local destination_key = "destination_dimension"

ccb.runtime.handler("activate_dimensional_perambulator", function(context)
    local environment = services.gameplay.environment
    local destination = environment.dimension() == "default" and "test" or ""
    services.random.native_int(0, 0)
    state.checked(services.variables.set(context.character, destination_key, destination, { include_before = false }))

    local travel = services.relocation.travel_to_dimension(destination, { take_vehicle = true })
    if travel.ok and travel.value.accepted then
        services.messages.add(ccb.services.translate(
            "In a flash of light the surroundings outside the Perambulator are changed!."
        ), "neutral")
    else
        services.messages.add(ccb.services.translate("The Perambulator shivers but does not move."), "neutral")
    end

    local avatar = services.characters.avatar()
    local stored = state.checked(services.variables.get_string(avatar, destination_key)).value
    services.messages.add(stored or "", "neutral")
    if environment.dimension() == "default" then
        services.messages.add(ccb.services.translate("home sweet home"), "neutral")
    end
end)

content.add(ccb.content.VehiclePart {
    id = "dimensional_perambulator",
    name = ccb.content.text("Dimensional Perambulator"),
    item = "dimensional_perambulator",
    location = "center",
    categories = { "utility" },
    durability = 100,
    description = ccb.content.text("A perambulator, for perambulating through dimensions"),
    flags = { "EOC_ACTIVATION" },
    variants = { { symbols = "#", broken_symbols = "X" } },
    on_activate = "activate_dimensional_perambulator",
})
