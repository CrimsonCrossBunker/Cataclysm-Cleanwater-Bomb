local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local bodies = {}
for _, name in ipairs {
    "moabosaurus", "haplocanthosaurus", "amargasaurus", "apatosaurus", "brontosaurus",
    "diplodocus", "barosaurus", "camarasaurus", "brachiosaurus", "astrodon", "alamosaurus",
} do
    bodies[#bodies + 1] = id("monster", "mon_" .. name)
end

local zombie_bodies = {}
for _, name in ipairs {
    "zoabosaurus", "zaplocanthosaurus", "zamargasaurus", "zapatosaurus", "zrontosaurus",
    "ziplodocus", "zarosaurus", "zamarasaurus", "zrachiosaurus", "zastrodon", "zalamosaurus",
} do
    zombie_bodies[#zombie_bodies + 1] = id("monster", "mon_" .. name)
    zombie_bodies[#zombie_bodies + 1] = id("monster", "mon_" .. name .. "_scorched")
end

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local strict = { strict = true }

local function has_uid(body, key, uid)
    local stored = services.variables.get_number(body, key, strict)
    if not stored.ok and stored.error.code == "variable_type_mismatch" then return false end
    return (checked(stored).value or 0) == uid
end

local function bind_leg_death(leg, body_types, leg_key, body_key, spell_name)
    local handler = leg .. "_death"
    local spell = id("spell", spell_name)
    ccb.runtime.handler(handler, function(payload)
        local uid = payload.get_number(leg_key) or 0
        local where = payload.position
        local origin = payload.killer_position or services.coords.tripoint_abs_ms(where.x, where.y, where.z)
        for _, body in ipairs(checked(services.monsters.nearby(origin, 3, body_types))) do
            if has_uid(body, body_key, uid) then
                checked(services.monsters.cast_spell(body, spell))
            end
        end
    end)
    ccb.content.bind_monster_death(leg, handler)
end

bind_leg_death("mon_sauropod_leg", bodies, "sauropod_id", "sauropod_uid", "sauropod_hurt_self")
-- This body variable spelling is used by the original zombie leg death rule.
bind_leg_death("mon_zauropod_leg", zombie_bodies, "zauropod_id", "zauopod_uid", "zauropod_hurt_self")
