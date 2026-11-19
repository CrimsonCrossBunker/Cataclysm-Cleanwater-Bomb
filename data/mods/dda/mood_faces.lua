local ccb = require("ccb")
local content = ccb.content

-- Native mood-face tables
do
local definition = content.MoodFace {
    id = "DEFAULT",
}
definition:value(100, "<color_green>8D</color>")
definition:value(50, "<color_green>:D</color>")
definition:value(10, "<color_green>:)</color>")
definition:value(-10, "<color_white>:|</color>")
definition:value(-50, "<color_red>):</color>")
definition:value(-100, "<color_red>D:</color>")
definition:value(-200, "<color_red>D8</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "DEFAULT_HORIZONTAL",
}
definition:value(200, "<color_green>@U@</color>")
definition:value(100, "<color_green>OuO</color>")
definition:value(50, "<color_green>^u^</color>")
definition:value(10, "<color_green>n_n</color>")
definition:value(-10, "<color_white>-_-</color>")
definition:value(-50, "<color_red>-n-</color>")
definition:value(-100, "<color_red>TnT</color>")
definition:value(-200, "<color_red>XnX</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_BIRD",
}
definition:value(100, "<color_green>8D</color>")
definition:value(50, "<color_green>:D</color>")
definition:value(10, "<color_green>:></color>")
definition:value(-10, "<color_white>:|</color>")
definition:value(-50, "<color_red>):</color>")
definition:value(-100, "<color_red>D:</color>")
definition:value(-200, "<color_red>D8</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_BIRD_HORIZONTAL",
}
definition:value(200, "<color_green>@v@</color>")
definition:value(100, "<color_green>OvO</color>")
definition:value(50, "<color_green>ovo</color>")
definition:value(10, "<color_green>^v^</color>")
definition:value(-10, "<color_white>-v-</color>")
definition:value(-50, "<color_red>.v.</color>")
definition:value(-100, "<color_red>TvT</color>")
definition:value(-200, "<color_red>XvX</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_FELINE",
}
definition:value(100, "<color_green>8D</color>")
definition:value(50, "<color_green>:D</color>")
definition:value(10, "<color_green>:3</color>")
definition:value(-10, "<color_white>:|</color>")
definition:value(-50, "<color_red>):</color>")
definition:value(-100, "<color_red>D:</color>")
definition:value(-200, "<color_red>D8</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_FELINE_HORIZONTAL",
}
definition:value(200, "<color_green>@W@</color>")
definition:value(100, "<color_green>OWO</color>")
definition:value(50, "<color_green>owo</color>")
definition:value(10, "<color_green>^w^</color>")
definition:value(-10, "<color_white>-w-</color>")
definition:value(-50, "<color_red>-m-</color>")
definition:value(-100, "<color_red>TmT</color>")
definition:value(-200, "<color_red>XmX</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_URSINE",
}
definition:value(200, "<color_green>8(80D)</color>")
definition:value(100, "<color_green>8(:0D)</color>")
definition:value(50, "<color_green>8(:0))</color>")
definition:value(10, "<color_green>8(:0P)</color>")
definition:value(-10, "<color_white>8(:0|)</color>")
definition:value(-50, "<color_red>8(:0/)</color>")
definition:value(-100, "<color_red>8(:0()</color>")
definition:value(-200, "<color_red>8(>:0()</color>")
content.add(definition)
end
do
local definition = content.MoodFace {
    id = "THRESH_URSINE_HORIZONTAL",
}
definition:value(200, "<color_green>@W@</color>")
definition:value(100, "<color_green>OWO</color>")
definition:value(50, "<color_green>owo</color>")
definition:value(10, "<color_green>^w^</color>")
definition:value(-10, "<color_white>-w-</color>")
definition:value(-50, "<color_red>-m-</color>")
definition:value(-100, "<color_red>TmT</color>")
definition:value(-200, "<color_red>XmX</color>")
content.add(definition)
end
