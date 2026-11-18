local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local sickness = require("raid_sickness")
local id = services.types.id

local function at_expedition_target(update_id)
    return function(payload)
        local position = state.point("OM_missionspot"):project_to("omt")
        state.checked(services.missions.set_target(payload.character, payload.mission, position))
        local tile = state.checked(services.overmap.tile_token(position))
        local update = state.checked(services.mapgen.update_token(id("update_mapgen", update_id)))
        state.checked(services.mapgen.run_update(tile, update, {
            mission = payload.mission, cancel_on_collision = false,
        }))
    end
end

local function set_reward(base_quantity)
    state.set("totalbonus", base_quantity)
    if state.number("challenge_mode_active") == 1 then
        state.set("totalbonus", state.number("totalbonus") * state.number("challenge_mode_reward_multiplier"))
    end
end

local function grant_reward(character)
    local quantity = math.tointeger(math.modf(state.number("totalbonus", 1)))
    state.checked(services.inventory.receive_item(character, id("item", "warptoken"), quantity))
end

local function bonus_reward(base_quantity, notice)
    return function(payload)
        local character = payload.character
        local won = state.checked(services.variables.get_number(character, "missionswon")).value or 0
        state.checked(services.variables.set(character, "missionswon", won + 1, { include_before = false }))
        set_reward(base_quantity + state.number("total_difficulty_bonus"))
        state.message(character, notice(), "mixed")
        sickness.bonus(character)
        grant_reward(character)
    end
end

local function slaughter_reward(base_quantity)
    return function(payload)
        local character = payload.character
        state.set("slaughterswon", state.number("slaughterswon") + 1)
        set_reward(base_quantity)
        state.message(character, ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you."), "mixed")
        grant_reward(character)
    end
end

local function expedition(options, start, finish, has_shard_reward)
    options.invisible_on_complete = true
    local mission = ccb.content.Mission(options)
    if start then
        local handler = "sky_expedition_start_" .. options.id
        ccb.runtime.handler(handler, start)
        mission:start_with(handler)
    end
    if finish then
        local handler = "sky_expedition_finish_" .. options.id
        ccb.runtime.handler(handler, finish)
        mission:finish_with(handler)
    end
    if has_shard_reward then
        mission:reward(1, "warptoken", "totalbonus")
    end
    if options.goal == "MGOAL_CONDITION" then
        -- The exit marker has no additional goal condition in its native definition.
        ccb.runtime.handler("sky_expedition_exit_condition", function() return true end)
        mission:complete_when("sky_expedition_exit_condition")
    end
    ccb.content.add(mission)
end

expedition({
    id = "MISSION_REACH_EXTRACT",
    name = ccb.content.text("Reach one of the exit points!"),
    description = ccb.content.text("If you want to get home with your stuff, you'll need to reach one of these nearby exit points.  They're only things that can bring you back to your sanctuary island in one piece."),
    goal = "MGOAL_CONDITION",
}, at_expedition_target("mx_skyisland_mission_reach_extract"), nil, false)

expedition({
    id = "MISSION_BONUS_TREASURE",
    name = ccb.content.text("Find the warp shards!"),
    description = ccb.content.text("A very small cluster of warp energy has left shards behind at this location.  All you need to do is find and retrieve them from the statue.  There may be threats nearby, but unlike most tasks, no special guards are on-site.  A minimal reward, but little risk."),
    goal = "MGOAL_GO_TO",
}, at_expedition_target("mx_skyisland_mission_bonus_treasure"), function(payload)
    state.message(payload.character, ccb.services.translate("You found the statue.  Now you need to find a way to get the warp shards from it."), "mixed")
end, false)

expedition({
    id = "MISSION_BONUS_KILL_LIGHT",
    name = ccb.content.text("Kill the warp-draining zombies!"),
    description = ccb.content.text("A handful of zombies are congregating at a location where warp resonance is high.  Clear them out for a minimal reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_light"), bonus_reward(3, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_HORDE",
    name = ccb.content.text("Kill the warp-draining horde!"),
    description = ccb.content.text("A horde of low level zombies are congregating at a location where warp resonance is high.  Clear them out for a small reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_horde"), bonus_reward(4, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_MID",
    name = ccb.content.text("Kill the warp-draining evolved zombies!"),
    description = ccb.content.text("A swarm of evolved zombies are congregating at a location where warp resonance is high.  Clear them out for a medium reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_mid"), bonus_reward(4, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_MID_HORDE",
    name = ccb.content.text("Kill the warp-draining evolved horde!"),
    description = ccb.content.text("A huge horde of evolved zombies are congregating at a location where warp resonance is high.  Clear them out for a large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_mid_horde"), bonus_reward(5, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_HARD",
    name = ccb.content.text("Kill the warp-draining fearsome zombies!"),
    description = ccb.content.text("A swarm of rather powerful zombies are congregating at a location where warp resonance is high.  Clear them out for a large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_hard"), bonus_reward(5, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_ELITE",
    name = ccb.content.text("Kill the warp-draining elite zombies!"),
    description = ccb.content.text("A swarm of extremely dangerous zombies are congregating at a location where warp resonance is high.  Clear them out for a very large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_elite"), bonus_reward(8, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_BOSS",
    name = ccb.content.text("Kill the warp-draining zombie lord!"),
    description = ccb.content.text("A single supremely powerful zombie has been found at a location where warp resonance is high.  Destroy it for a very large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_boss"), bonus_reward(10, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_BOSS_MULTI",
    name = ccb.content.text("Kill the warp-draining zombie superteam!"),
    description = ccb.content.text("A team of supremely powerful zombies has been found at a location where warp resonance is high.  Destroy it for a very large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_boss_multi"), bonus_reward(10, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_BOSS_GROUP",
    name = ccb.content.text("Kill the warp-draining zombie leader!"),
    description = ccb.content.text("A supremely powerful zombie has been found at a location where warp resonance is high.  Be warned that it will be accompanied by an elite swarm!  Destroy them all for a huge reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_boss_group"), bonus_reward(12, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_BOSS_HORDE",
    name = ccb.content.text("Kill the warp-draining zombie horde lord!"),
    description = ccb.content.text("A supremely powerful zombie has been found at a location where warp resonance is high.  Be warned that it will be accompanied by an massive horde of weaker zombies!  Destroy them all for a huge reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_boss_horde"), bonus_reward(12, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_MIGO",
    name = ccb.content.text("Kill the warp-draining mi-go threat!"),
    description = ccb.content.text("A group of lethal mi-gos are draining a location where warp resonance is high.  Destroy them all for a very large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_migo"), bonus_reward(9, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_KILL_MIGO_ELITE",
    name = ccb.content.text("Kill the warp-draining mi-go overlord!"),
    description = ccb.content.text("A group of lethal mi-gos are draining a location where warp resonance is high.  Destroy them all for a very large reward of warp shards."),
    goal = "MGOAL_KILL_MONSTERS",
}, at_expedition_target("mx_skyisland_mission_bonus_kill_migo_elite"), bonus_reward(12, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_ASSASSIN1",
    name = ccb.content.text("Kill the armed interloper!"),
    description = ccb.content.text("The warp has marked a single human being for death.  They will likely carry a ranged weapon.  They will be alone.  Their sins are not your concern.  All you need to know is that it must be done."),
    goal = "MGOAL_ASSASSINATE",
}, at_expedition_target("mx_skyisland_mission_bonus_assassin1"), bonus_reward(9, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_ASSASSIN2",
    name = ccb.content.text("Kill the interloper!"),
    description = ccb.content.text("The warp has marked a single human being for death.  They will likely carry a melee weapon.  They will be alone.  Their sins are not your concern.  All you need to know is that it must be done."),
    goal = "MGOAL_ASSASSINATE",
}, at_expedition_target("mx_skyisland_mission_bonus_assassin2"), bonus_reward(6, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_ASSASSIN3",
    name = ccb.content.text("Kill the guarded interlopers!"),
    description = ccb.content.text("The warp has marked human beings for death.  They may be accompanied.  Their sins are not your concern.  All you need to know is that it must be done."),
    goal = "MGOAL_ASSASSINATE",
}, at_expedition_target("mx_skyisland_mission_bonus_assassin3"), bonus_reward(12, function() return ccb.services.translate("It's done.  They're all dead.  Warp shards filter in from seams in reality.  Your reward rains down on you.") end), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_ZED1",
    name = ccb.content.text("Kill 10 Zombies this expedition"),
    description = ccb.content.text("Zombies have absorbed latent energies which must be released into the stream of warp once more.  Kill at least 10 zombified humans or creatures before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 10,
}, nil, slaughter_reward(1), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_ZED2",
    name = ccb.content.text("Kill 50 Zombies this expedition"),
    description = ccb.content.text("Zombies have absorbed latent energies which must be released into the stream of warp once more.  Kill at least 50 zombified humans or creatures before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 50,
}, nil, slaughter_reward(3), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_ZED3",
    name = ccb.content.text("Kill 100 Zombies this expedition"),
    description = ccb.content.text("Zombies have absorbed latent energies which must be released into the stream of warp once more.  Kill at least 100 zombified humans or creatures before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 100,
}, nil, slaughter_reward(5), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_MIGO",
    name = ccb.content.text("Kill a Mi-Go this expedition"),
    description = ccb.content.text("The mi-go have sucked up latent energies which must be released into the stream of warp once more.  Kill at least one mi-go creature before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "MIGO",
    monster_kill_goal = 1,
}, nil, slaughter_reward(3), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_NETHER",
    name = ccb.content.text("Kill 3 nether creatures this expedition"),
    description = ccb.content.text("A rift to another dimension has drained latent energies which must be released into the stream of warp once more.  Kill at least 3 nether-born creatures before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "NETHER",
    monster_kill_goal = 3,
}, nil, slaughter_reward(4), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_BIRD",
    name = ccb.content.text("Kill 5 un-zombified birds this expedition"),
    description = ccb.content.text("Are the birds around here…  sparkling?  It seems even the local wildlife has started absorbing latent warp energy.  Kill at least 5 non-zombie birds of any kind before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "BIRD",
    monster_kill_goal = 5,
}, nil, slaughter_reward(1), true)

expedition({
    id = "MISSION_BONUS_SLAUGHTER_MAMMAL",
    name = ccb.content.text("Kill 5 un-zombified mammals this expedition"),
    description = ccb.content.text("Are the critters around here…  sparkling?  It seems even the local wildlife has started absorbing latent warp energy.  Kill at least 5 non-zombie mammals of any kind before returning to your sanctuary for bonus warp shards."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "MAMMAL",
    monster_kill_goal = 5,
}, nil, slaughter_reward(1), true)
