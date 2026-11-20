local ccb = require("ccb")
local services = ccb.services
local portals = require("trap_portals")
local state = require("portal_storm_state")

local function fall(actor, message, after, random_exit)
    local search = { z = 0 }
    if random_exit then
        search.random, search.search_range, search.min_distance = true, 12, 1
    end
    local exit = portals.destination(actor, { terrain = "LIXA_entry_1", match = services.enums.value("OtMatchType", "contains") }, search)
    state.message(actor, message, "bad", true)
    actor = portals.teleport(actor, exit, true)
    state.message(actor, after)
end

local function recovered()
    return ccb.services.translate("…After feeling indescribable pain mere moments ago, unexplainably, you awaken somewhere near the facility.  Somehow your body has been restored, as if you haven't plummeted down the elevator in the first place.")
end

local function step_off(actor)
    fall(actor, ccb.services.translate("As you step into the open air… you fall.  Then you keep falling.  The shaft you thought was only a few stories in height must be miles.  You lose count repeatedly but slowly, finally, the floor approaches…  THUMP!  You feel searing final pain as every part of your body breaks when you hit the ground."),
        recovered(), false)
end

local function lose_grip(actor)
    fall(actor, ccb.services.translate("As you ascend, you inexplicably lose purchase and orientation, and then… you fall.  Then you keep falling.  The shaft you thought was only a few stories in height must be miles.  You lose count repeatedly but slowly, finally, the floor approaches…  THUMP!  You feel searing final pain as every part of your body breaks when you hit the ground."),
        recovered(), false)
end

local function peer_down(actor)
    if state.checked(services.characters.snapshot(actor, 0)).needs.morale >= -75 then
        state.message(actor, ccb.services.translate("You look down and see the elevator shaft going deeper than you expected.  Much deeper to where you can no longer see beyond."))
        return
    end
    fall(actor, ccb.services.translate("You receive an uncontrollable compulsion to step forward into the open elevator shaft.  As you step into the open air… you fall.  Then you keep falling.  The shaft you thought was only a few stories in height must be miles.  You lose count repeatedly but slowly, finally, the floor approaches… THUMP!  You feel searing final pain as every part of your body breaks when you hit the ground."),
        recovered(), true)
end

local function climb_down(actor)
    fall(actor, ccb.services.translate("You climb down as far as you can and then you let go… you fall.  Then you keep falling.  The shaft you thought was only a few stories in height must be miles.  You try to count but every so often you scrape up against the wall abrading the skin from your limbs, and bruising you to the bone.  You pass out long before you ever hit the bottom."),
        ccb.services.translate("…Against all odds, you come back to your senses somewhere near the facility; your head still pounding from the inscrutable agony you went though.  Somehow your body has been reverted back to the state right before your fall."), true)
end

portals.trap("lixa_step_off_ledge", step_off)
portals.trap("lixa_lose_grip", lose_grip)

ccb.runtime.handler("examine_lixa_elevator_ledge", function(ctx)
    local choice = services.interaction.choose({
        { id = "peek", label = ccb.services.translate("Peek down."), description = ccb.services.translate("You look down as far as you can see.") },
        { id = "climb", label = ccb.services.translate("Climb down by lowering yourself from the ledge."), description = ccb.services.translate("You hang off the ledge to get closer to a bottom you cannot see.") },
        { id = "jump", label = ccb.services.translate("Can't jump across (need a small gap)."), description = ccb.services.translate("Take a leap of faith.") },
        { id = "fall", label = ccb.services.translate("Fall down."), description = ccb.services.translate("End it all.") },
    }, { title = ccb.services.translate("There is a ledge here.  What do you want to do?"), allow_cancel = true, show_descriptions = true })
    if not choice.accepted then return end
    if choice.id == "peek" then peer_down(ctx.character)
    elseif choice.id == "climb" then climb_down(ctx.character)
    elseif choice.id == "jump" then state.message(ctx.character, ccb.services.translate("Jump where?  There's nothing to jump to.  Just the other side of the elevator shaft.  There's no ledge over there or stairs, just flat wall."))
    elseif choice.id == "fall" then step_off(ctx.character) end
end)
