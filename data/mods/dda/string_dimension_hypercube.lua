local ccb = require("ccb")
local services = ccb.services
local content = ccb.content
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local id = services.types.id

ccb.runtime.handler("string_dimension_hypercube_use", function(context)
    local character = context.character
    if not character then return end
    local choice = ccb.presentation.choose(
        services.translate("Socketed inside the device is a transparent hypercube - a cube within a cube."), {
            {
                id = "take",
                label = services.translate("Try to take the hypercube"),
                description = services.translate("It's full of stars."),
            },
        })
    if choice ~= "take" then return end
    if travel.unanchored(character) then
        state.message(character, services.translate("You touched the cube and there was an immense explosion of light.  The object is gone and you're back in the world you know."), "neutral", true)
    else
        state.message(character, services.translate("You pull the hypercube free and space around you violently bends before snapping back in place!  The hypercube now sits in your palm, but its original housing has violently imploded into a ball of scrap."), "neutral", true)
        state.checked(services.inventory.receive_item(character, id("item", "string_dimension_hypercube"), 1))
        state.checked(services.world.transform_radius(state.position(character), 10,
            id("terrain_furniture_transform", "string_dimension_ziggurat_transform")))
        local target = services.overmap.find_target(state.position(character):project_to("omt"),
            "string_dimension_small_ziggurat_0")
        state.update_map(target:project_to("ms"), "string_dimension_small_ziggurat_0_inert")
        travel.set(character, "string_dimension_ziggurat_exit", travel.number(character, "string_dimension_ziggurat_exit") + 1)
    end
    ccb.runtime.call_character("portal_string_dimension_return", character)
end)

local housing = content.Furniture {
    id = "f_string_dimension_housing",
    name = content.text("metal container"),
    looks_like = "f_safe_c",
    description = content.text("An extremely dense metal box.  It has a door with a heavy latch.  A golden plate is affixed to the door, covered in letters you do not understand.  Examine it to use the lever on the door."),
    symbol = "O", color = "yellow",
    move_cost_mod = -1, required_str = -1, coverage = 100,
}
housing:flag("NOITEM")
housing:flag("BLOCKSDOOR")
housing:on_examine("string_dimension_hypercube_use")
content.add(housing)

local transform = content.TerrainTransform { id = "string_dimension_ziggurat_transform" }
transform:furniture { inputs = { "f_string_dimension_housing" }, results = { { "f_string_dimension_housing_imploded", 1 } } }
transform:furniture { inputs = { "f_string_dimension_pylon" }, results = { { "f_string_dimension_pylon_inert", 1 } } }
content.add(transform)
