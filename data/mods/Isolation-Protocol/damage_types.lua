local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("iso_bullet_on_damage", function(payload)
    local source = payload.source
    if not source then
        return
    end
    if value(services.creatures.snapshot(source)).kind ~= "monster"
        and value(services.mutations.has_id_text(source, "iso_backup"))
    then
        value(services.effects.add(
            source,
            services.types.id("effect", "iso_eff_backup"),
            services.time.duration(2)
        ))
    end
end, 1)

do
    local definition = content.DamageType {
        id = "bullet",
        name = content.text("ballistic"),
        magic_color = "light_red",
        bash_conversion_factor = 0.5,
        physical = true,
        monster_difficulty = true,
        material_required = true,
    }
    definition:immune_character_flag("BULLET_IMMUNE")
    definition:immune_monster_flag("BULLETPROOF")
    definition:on_damage("iso_bullet_on_damage")
    content.replace(definition)
end
