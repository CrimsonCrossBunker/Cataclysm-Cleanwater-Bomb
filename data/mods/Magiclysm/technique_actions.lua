local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

ccb.runtime.handler("hybrasil_rod_spell", function(combat)
    local caster = combat.attacker
    local torso = services.characters.hp(caster, id("body_part", "torso"))
    if not torso.ok then error(torso.error.message) end

    local hp = torso.value
    local spell, options
    if hp >= 75 then
        spell, options = "druid_thorn_skin", { hit_self = true }
    elseif hp >= 50 then
        spell, options = "recover_stamina", { hit_self = true }
    elseif hp >= 25 then
        spell, options = "pain_split", { hit_self = true }
    elseif hp >= 0 then
        spell, options = "druid_summon_brambles_arc", { targeted = true }
    else
        return
    end
    local cast = services.characters.cast_spell(caster, id("spell", spell), options)
    if not cast.ok then error(cast.error.message) end
end)
