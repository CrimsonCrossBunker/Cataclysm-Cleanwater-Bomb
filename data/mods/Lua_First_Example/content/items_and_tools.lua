local content = {}

function content.register(ccb)
    local codex = ccb.content.Item {
        id = "lua_first_dev_codex",
        name = "Lua 开发手册与全息终端",
        description = "面向 CCB Lua 平台的一体化便携开发手册与调试终端。使用它可直接查阅各子系统开发教程、启动交互式沙盒及检视运行时持久化状态。",
        symbol = "?",
    }
    codex:mass_grams(150)
    codex:volume_ml(250)
    codex:price_cents(500)
    codex:material("plastic", 1)
    codex:on_use("lua_first_open_dev_codex", "查阅开发教程并打开调试终端")
    ccb.content.add(codex)

    local omnitool = ccb.content.Item {
        id = "lua_first_omnitool",
        name = "多功能高频振波刃",
        description = "基于纯 Lua 架构设计的高频震荡切割与维护工具。兼备高阶切割、撬锁、锤击以及极为出色的屠宰解剖能力。",
        symbol = "/",
    }
    omnitool:mass_grams(450)
    omnitool:volume_ml(350)
    omnitool:price_cents(3500)
    omnitool:material("steel", 2)
    omnitool:quality("CUT", 3)
    omnitool:quality("BUTCHER", 20)
    omnitool:quality("HAMMER", 2)
    omnitool:quality("PRY", 2)
    omnitool:flag("DURABLE_MELEE")
    omnitool:on_use("lua_first_use_omnitool", "切换震荡动力模式")
    ccb.content.add(omnitool)

    local tonic = ccb.content.Item {
        id = "lua_first_nano_tonic",
        name = "净化纳米注射剂",
        description = "通过纯 Lua 化学配方合成的微型医疗注射针剂。注入后可在多回合内提供持续性细胞再生与跨生命周期状态循环。",
        symbol = "!",
    }
    tonic:mass_grams(60)
    tonic:volume_ml(50)
    tonic:price_cents(1200)
    tonic:material("glass", 1)
    tonic:on_use("lua_first_use_nano_tonic", "注射纳米再生针剂")
    ccb.content.add(tonic)

    local cell = ccb.content.Item {
        id = "lua_first_cleanwater_cell",
        name = "高能净化电容电池",
        description = "用于纯水实验设备的紧凑型高能量密度电源元件。",
        symbol = "=",
    }
    cell:mass_grams(80)
    cell:volume_ml(40)
    cell:price_cents(300)
    cell:material("steel", 1)
    ccb.content.add(cell)
end

return content
