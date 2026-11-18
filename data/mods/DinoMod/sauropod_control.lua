local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local monsters = services.monsters
local id = services.types.id
local offset = services.coords.tripoint_rel_ms

local steps = { offset(1, 0, 0), offset(-1, 0, 0), offset(0, 1, 0), offset(0, -1, 0) }
local spawn_options = { count = 4, min_radius = 1, max_radius = 1 }
local write_options = { include_before = false }

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function position(handle)
    return checked(services.creatures.snapshot(handle)).position
end

local function number(handle, key)
    return checked(variables.get_number(handle, key)).value or 0
end

local function update_legs(body, legs, body_id, zombie)
    -- The update chain starts before setup draws a UID, so its old context read zero.
    checked(variables.set(body, body_id, 0, write_options))
    local center = position(body)
    for _, leg in ipairs(checked(monsters.nearby(center, 3, legs))) do
        if not zombie or number(leg, "zauropod_id") == 0 then
            for _, step in ipairs(steps) do
                checked(services.relocation.teleport_creature(leg, center:add(step)))
            end
        end
    end
end

local function register_control(species, description, zombie)
    local body_types = { id("monster", "mon_" .. species) }
    local prefix = zombie and "zauropod" or "sauropod"
    local leg_type = id("monster", "mon_" .. prefix .. "_leg")
    local legs = { leg_type }
    local updating = "updating_" .. species
    local body_id = prefix .. "_id"
    local body_uid = prefix .. "_uid"
    local assigned_leg_key = zombie and body_uid or body_id
    local update_due = "sauropod_update_" .. species
    local control = species .. "_control"

    local function update(center)
        -- The legacy predicate uses hostile monsters across z-levels. Its
        -- follow-up loop selects all matching monsters on the same z-level.
        if checked(monsters.count_nearby(center, body_types, { radius = 3 })) == 0 then
            checked(variables.set_global(updating, 0, write_options))
            return
        end
        checked(variables.set_global(updating, 1, write_options))
        ccb.tasks.after_avatar_turn(1, update_due)
        for _, body in ipairs(checked(monsters.nearby(center, 3, body_types))) do
            update_legs(body, legs, body_id, zombie)
        end
    end

    ccb.runtime.handler(update_due, function(task)
        update(position(task.character))
    end, 1)

    ccb.runtime.handler(control, function(impact)
        local body = impact.target_creature
        local center = position(body)
        if checked(variables.get_global_number(updating)).value ~= 1 then
            update(center)
        end
        if number(body, "setup") == 1 then return end

        local uid = services.random.native_int(0, 1200)
        checked(variables.set(body, body_uid, uid, write_options))
        checked(variables.set(body, "setup", 1, write_options))
        checked(services.spawns.population(leg_type, center, spawn_options))
        for _, leg in ipairs(checked(monsters.nearby(center, 2, legs))) do
            checked(variables.set(leg, assigned_leg_key, uid, write_options))
        end
    end)

    content.add(content.Spell {
        id = control,
        name = species .. " control",
        description = description,
        message = "",
        sound_description = ccb.content.text("an explosion."),
        valid_targets = { "self" },
        flags = { "SILENT", "NO_EXPLOSION_SFX" },
        shape = "blast",
        min_range = 1,
        max_range = 1,
    }:lua_impact(control))
end

register_control("moabosaurus", "Moabosaurus control themselves using this one.", false)
register_control("haplocanthosaurus", "Haplocanthosaurus control themselves using this one.", false)
register_control("amargasaurus", "amargasaurus control themselves using this one.", false)
register_control("apatosaurus", "apatosaurus control themselves using this.", false)
register_control("brontosaurus", "brontosaurus control themselves using this.", false)
register_control("diplodocus", "diplodocus control themselves using this.", false)
register_control("barosaurus", "barosaurus control themselves using this.", false)
register_control("camarasaurus", "camarasaurus control themselves using this.", false)
register_control("brachiosaurus", "brachiosaurus control themselves using this.", false)
register_control("astrodon", "astrodon control themselves using this.", false)
register_control("alamosaurus", "alamosaurus control themselves using this.", false)
register_control("zapatosaurus", "Zombie apatosaurus control themselves using this one.", true)
