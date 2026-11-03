local ccb = require("ccb")

local function on_avatar_fatal(payload)
    local character = payload.character
    if character == nil then
        return true
    end
    local has_blood_brain = ccb.services.bionics.has(
        character, ccb.services.types.id("bionic", "fcl_bio_blood_brain"))
    if has_blood_brain.ok and has_blood_brain.value then
        ccb.services.characters.set_hp(
            character, ccb.services.types.id("body_part", "head"), 1)
        return true
    end
    return true
end

ccb.runtime.handler("fcl_blood_brain_avatar_fatal", on_avatar_fatal, 1)
ccb.runtime.hook("on_avatar_fatal", "fcl_blood_brain_avatar_fatal")