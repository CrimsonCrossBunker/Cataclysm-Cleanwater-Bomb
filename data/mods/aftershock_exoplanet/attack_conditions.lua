local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function intensity(creature, name)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name)))
end

ccb.runtime.handler("allow_android_crush", function(attack)
    return intensity(attack.target, "downed") ~= nil
        and intensity(attack.attacker, "afs_android_crawling") == nil
        and attack.target.subtype ~= "monster"
end)

ccb.runtime.handler("allow_android_crush_monster", function(attack)
    return intensity(attack.target, "downed") ~= nil
        and intensity(attack.attacker, "afs_android_crawling") == nil
        and attack.target.subtype == "monster"
        and attack.attacker_size + 1 >= attack.target_size
end)

ccb.runtime.handler("allow_android_drop", function(attack)
    return intensity(attack.target, "downed") == nil
        and attack.attacker_size + 1 >= attack.target_size
        and intensity(attack.attacker, "afs_android_crawling") == nil
end)
