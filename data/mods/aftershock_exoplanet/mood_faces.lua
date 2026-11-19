local ccb = require("ccb")
local content = ccb.content

-- Native mood-face tables
do
local definition = content.MoodFace {
    id = "THRESH_YUGGOTH_HORIZONTAL",
}
definition:value(200, "<color_green>*~*</color>")
definition:value(100, "<color_green>O~O</color>")
definition:value(50, "<color_green>o~o</color>")
definition:value(10, "<color_green>^~^</color>")
definition:value(-10, "<color_white>-~-</color>")
definition:value(-50, "<color_red>.~.</color>")
definition:value(-100, "<color_red>T~T</color>")
definition:value(-200, "<color_red>X~X</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_MASTODON_HORIZONTAL",
}
definition:value(200, "<color_green>*J*</color>")
definition:value(100, "<color_green>OJO</color>")
definition:value(50, "<color_green>oJo</color>")
definition:value(10, "<color_green>^J^</color>")
definition:value(-10, "<color_white>-J-</color>")
definition:value(-50, "<color_red>.J.</color>")
definition:value(-100, "<color_red>TJT</color>")
definition:value(-200, "<color_red>XJX</color>")
content.add(definition)
end
