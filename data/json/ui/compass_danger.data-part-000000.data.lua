local ccb = require("ccb")
local reading = ccb.content.widget_conditions

local function compass_label(id, direction, label)
    ccb.content.define_widget {
        id = id, style = "text", direction = direction,
        default_clause = { text = label, color = "c_dark_gray" },
        clauses = {
            { id = "safe_mode_trigger", text = label, color = "c_light_red", when = reading.test("safe_mode_trigger", direction) },
            { id = "danger", text = label, color = "c_light_gray", when = reading.test("visible_monsters", direction) },
        },
    }
end

compass_label("compass_N_danger_label", "N", ccb.content.text("N:"))
compass_label("compass_S_danger_label", "S", ccb.content.text("S:"))
compass_label("compass_E_danger_label", "E", ccb.content.text("E:"))
compass_label("compass_W_danger_label", "W", ccb.content.text("W:"))
compass_label("compass_NE_danger_label", "NE", ccb.content.text("NE:"))
compass_label("compass_NW_danger_label", "NW", ccb.content.text("NW:"))
compass_label("compass_SE_danger_label", "SE", ccb.content.text("SE:"))
compass_label("compass_SW_danger_label", "SW", ccb.content.text("SW:"))
