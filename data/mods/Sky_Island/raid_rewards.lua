local ccb = require("ccb")
local services = ccb.services
local content = ccb.content
local state = require("raid_state")
local sickness = require("raid_sickness")
local id = services.types.id

ccb.runtime.handler("sky_warp_shard_reward", function(payload)
    local character = payload.character
    local won = state.checked(services.variables.get_number(character, "missionswon")).value or 0
    state.checked(services.variables.set(character, "missionswon", won + 1, { include_before = false }))
    state.set("totalbonus", services.random.native_int(0, 5) + 1)
    if state.number("challenge_mode_active") == 1 then
        state.set("totalbonus", state.number("totalbonus") * state.number("challenge_mode_reward_multiplier"))
    end
    state.message(character, services.translate("You retrieved the warp shards from the statue."), "mixed")
    sickness.bonus(character)
    local count = math.tointeger(math.modf(state.number("totalbonus", 1)))
    state.checked(services.inventory.receive_item(character, id("item", "warptoken"), count))
    if services.gameplay.mods.is_loaded("innawood") then
        ccb.runtime.call_character("innawood_shard_reward", character)
    end
    state.checked(services.world.transform_radius(state.position(character), 3,
        id("terrain_furniture_transform", "sky_island_shard_statue")))
end)

local function statue(name, description, handler)
    local definition = content.Furniture {
        id = name,
        name = content.text("Warp Shard Obelisk"),
        description = content.text(description),
        color = "dark_gray", symbol = "S", looks_like = "f_statue",
        move_cost_mod = -1, required_str = -1, coverage = 0, transparent = true,
    }
    definition:flag("NOCOLLIDE")
    definition:flag("NO_PICKUP_ON_EXAMINE")
    definition:flag("TRANSPARENT")
    if handler then definition:on_examine(handler) end
    content.add(definition)
end

statue("f_warpshardrewardstatue", "A strange statue with an arm raised, holding some warp shards in it's palm.",
    "sky_warp_shard_reward")
statue("f_warpshardrewardstatue_empty", "A strange statue with an arm raised, it's palm empty.")

local transform = content.TerrainTransform { id = "sky_island_shard_statue" }
transform:furniture {
    inputs = { "f_warpshardrewardstatue" },
    results = { { "f_warpshardrewardstatue_empty", 1 } },
}
content.add(transform)
