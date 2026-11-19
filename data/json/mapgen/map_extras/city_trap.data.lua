local ccb = require("ccb")

-- 此文件为撤销 PR #86231 恢复 — 刀片陷阱城市地图块
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_city_trap",
    layout = {
        nested = { { id = "3x3_city_trap", x = { 4, 17 }, y = { 4, 17 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_city_trap",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "///",
            "/O/",
            "///",
        },
        furniture = { ["/"] = "f_clear", O = "f_clear" },
        traps = { ["/"] = "tr_blade", O = "tr_engine" },
        vehicle_removals = { { x = { 0, 2 }, y = { 0, 2 } } },
        monster_glyphs = { O = { id = "mon_turret_speaker", chance = 100 } },
    },
}
