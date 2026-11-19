local ccb = require("ccb")

local function can_install_railgun(event)
    if event.data.bionic ~= "fcl_bio_railgun" then
        return
    end

    local summary = ccb.services.bionics.summary(event.actors.character)
    if not summary.ok then
        ccb.services.message(ccb.services.translate(
            "Unable to detect bionic energy. Railgun CBM installation cannot proceed."
        ))
        return false
    end

    if summary.value.power:value("kilojoule") < 200 then
        ccb.services.message(ccb.services.translate(
            "Installing the Railgun CBM requires at least 200 kJ of current bionic energy."
        ))
        return false
    end

    return true
end

ccb.runtime.handler("fcl_bio_railgun_install", can_install_railgun, 1)
ccb.runtime.on("game:befor_installs_cbm", "fcl_bio_railgun_install")

