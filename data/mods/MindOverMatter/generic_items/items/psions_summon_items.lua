local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "electro_robot_interface",
        name = ccb.content.plural_text("[Ψ]Robotic Interface", "[Ψ]Robotic Interfaces"),
        description = ccb.content.text("Interface with robots remotely"),
        mass_milligrams = 0,
        volume_ml = 0,
        symbol = "!",
        color = "cyan",
        looks_like = "spiral_stone",
        max_worn = 1,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_DROP")
    item:flag("PADDED")
    item:flag("PERSONAL")
    item:flag("UNBREAKABLE")
    item:flag("SEMITANGIBLE")
    item:flag("NO_SALVAGE")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("INTEGRATED")
    item:flag("MAGICAL")
    item:clear_use_actions()
    item:native_use("ROBOTCONTROL")
    content.add(item)
end
