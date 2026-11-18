local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local difficulty = require("raid_services")
local island = require("island_memory")
local id = services.types.id

local function notice(character, text)
    state.message(character, text, "neutral", true)
end

ccb.runtime.handler("sky_island_legacy_load", function()
    if state.number("versionupdate") == 1 then return end
    -- Native game_load has no Character field; its EOC subscriber selects the Avatar.
    local character = services.creatures.avatar()
    notice(character, services.translate("Your save was last used with an older version of Sky Island.  Attempting to update…"))
    if state.has_trait(character, "awayfromhome") then
        notice(character, services.translate("Error.  Update not applied.\n\nReason: Cannot update while on expedition.  Return home, save and close your game, and try loading this save again."))
        return
    end
    if state.number("versionupdate") < 1 then
        notice(character, services.translate("Your save was made with a pre-Milestone 1 version of Sky Island, which means it lacks upgrades and the Heart of the Island.  Attempting to update…"))
        difficulty.configure(character)
        island.remember(character)
        for _, key in ipairs {
            "OM_island_subcenter",
            "OM_island_subnw",
            "OM_island_subn",
            "OM_island_subne",
            "OM_island_subw",
            "OM_island_sube",
            "OM_island_subsw",
            "OM_island_subs",
            "OM_island_subse",
        } do
            island.update(state.point(key), "mx_skyisland_solidstoneoverride")
        end
        state.set("versionupdate", 1)
        state.set("missiondistancemax", 30)
        state.set("missiondistancemin", 5)
        state.set("exfildistancemax", 35)
        state.set("exfildistancemin", 10)
        state.set("invistime", 60)
        state.checked(services.inventory.receive_item(character, id("item", "warp_folded_heart"), 1))
        notice(character, services.translate("Milestone 1 applied.  You have been given a Heartseed.  Activate it while on your island to create the new Heart of the Island.  Interact with the Heart to access new upgrade options."))
        if state.number("raidswon") > 0 then
            local owed = 50 * state.number("raidswon")
            state.set("owed_material_tokens", owed)
            local quantity = math.modf(owed)
            state.checked(services.inventory.receive_item(character, id("item", "warptoken_material"), quantity))
            notice(character, services.translate("You have been retroactively awarded <global_val:owed_material_tokens> material tokens for your past successful expeditions."))
            state.set("backpaid_raids", state.number("raidswon"))
        end
        notice(character, services.translate("The stat stone, healing salve, difficulty adjuster, and similar items are removed.  These options are instead accessed by speaking to the Heart of the Island.\n\nWarped bags and quickheals are obsolete.  If you already have any, they can still be used, or salvaged for a refund of warp shards.\n\nAny further changes are documented in the patch notes."))
    else
        notice(character, services.translate("Your save is post-Milestone 1.  Skipping update 1…"))
    end
    notice(character, services.translate("Your save should be up to date now."))
end)
ccb.runtime.on("game:game_load", "sky_island_legacy_load")
