local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("xedrawood_psychic_on_damage", function(payload)
    local target = payload.target
    if not target or payload.damage_taken <= 0 then
        return
    end
    if services.random.native_probability(1, 3) then
        value(services.effects.add(
            target,
            services.types.id("effect", "psi_stunned"),
            services.time.duration(1)
        ))
    end
    if services.random.native_probability(2, 3) then
        value(services.effects.add(
            target,
            services.types.id("effect", "psi_dazed"),
            services.time.duration(2)
        ))
    end
    if services.random.native_probability(1, 20) then
        value(services.effects.add(
            target,
            services.types.id("effect", "downed"),
            services.time.duration(1)
        ))
    end
end, 1)

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "psychic_damage",
    name = ccb.content.text("psychic"),
    magic_color = "white",
    physical = false,
}
definition:on_damage("xedrawood_psychic_on_damage")
content.add(definition)
end

-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "psychic_damage",
    display = "detailed",
    verb = ccb.content.text("mindblasting"),
}
definition:section("bionic", 999900, false)
definition:section("protection", 999900, false)
definition:section("pet_protection", 999900, false)
definition:section("melee", 999900, false)
definition:section("ablative", 999900, false)
content.add(definition)
end
