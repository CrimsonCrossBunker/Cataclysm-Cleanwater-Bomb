local ccb = require("ccb")

-- 此文件为撤销 PR #86231 恢复 — 刀片陷阱城市地图块
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_city_trap",
    layout = {
        nested = { { id = "3x3_city_trap", x = { 4, 17 }, y = { 4, 17 } } },
    },
}
