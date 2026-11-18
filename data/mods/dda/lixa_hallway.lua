local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(actor, key)
    return checked(variables.get_number(actor, key)).value or 0
end

local function point(key)
    return checked(variables.get_global_tripoint(key)).value or services.coords.tripoint_abs_ms(0, 0, 0)
end

local function update_map(key, update_id)
    local target = checked(services.overmap.tile_token(point(key):project_to("omt")))
    local update = checked(services.mapgen.update_token(services.types.id("update_mapgen", update_id)))
    checked(services.mapgen.run_update(target, update))
end

ccb.runtime.handler("lixa_unfold_hallway", function(payload)
    local stage = payload.data.stage
    checked(variables.set(payload.character, "LIXA_unfold_level", math.min(stage + 1, 6), { include_before = false }))
    if stage > 0 then
        update_map("LIXA_unfold_A", "spawn_LIXA_" .. stage .. "a")
        update_map("LIXA_unfold_B", "spawn_LIXA_" .. stage .. "b")
    end
end, 1)

local function is_character(actor)
    return actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character"
end

local function unfold(actor)
    local level = number(actor, "LIXA_unfold_level")
    if level >= 0 then
        local stage = math.floor(math.min(level, 6))
        if stage > 0 then
            update_map("LIXA_unfold_A", "cleanup_LIXA")
            update_map("LIXA_unfold_B", "cleanup_LIXA")
        end
        -- Only Characters have a local queue for the delayed map updates.
        if is_character(actor) then
            ccb.tasks.after_character_turn(actor, 2, "lixa_unfold_hallway", { stage = stage })
        end
    end
end

local function register_hallway_trap(direction, name, description, index)
    local key = direction == 1 and "back" or "forward"
    local suffix = key .. "_" .. index
    local handler = "lixa_" .. suffix
    local spell = "spell_LIXA_" .. suffix
    local variable = "LIXA_tp_" .. key
    local destination = "LIXA_" .. key .. "_tp_" .. index

    ccb.runtime.handler(handler, function(impact)
        local actor = impact.target_creature
        checked(variables.set(actor, variable, index, { include_before = false }))
        local moved = checked(services.relocation.teleport_creature(actor, point(destination), { force = true }))
        actor = moved.handle
        if moved.accepted and is_character(actor) then
            local message = ccb.services.translate("You walk for a long while.")
            checked(services.characters.add_msg_if_player(actor, "%s", message))
        end

        if number(actor, "LIXA_hallway_direction") == direction then
            unfold(actor)
        end
        checked(variables.set(actor, "LIXA_hallway_direction", direction, { include_before = false }))
    end)

    content.add(content.Spell {
        id = spell,
        name = name,
        description = description,
        valid_targets = { "self", "hostile", "ally" },
        max_level = 1,
        flags = { "SILENT", "NO_EXPLOSION_SFX" },
        base_casting_time = 1,
        shape = "blast",
        min_range = 0,
        min_aoe = 1,
        max_aoe = 1,
    }:lua_impact(handler))

    content.add(content.Trap {
        id = "tr_LIXA_" .. suffix,
        name = "",
        color = "green",
        symbol = "#",
        visibility = 99,
        always_invisible = true,
        avoidance = 99,
        difficulty = 99,
        trap_radius = 0,
        action = "spell",
        spell = spell,
    }:flag("UNDODGEABLE"):flag("UNCONSUMED"))
end

for index = 1, 16 do
    register_hallway_trap(1, "LIXA Back Teleport", "Teleports the victim backwards.", index)
    register_hallway_trap(2, "LIXA Forward Teleport", "Teleports the victim forwards.", index)
end
