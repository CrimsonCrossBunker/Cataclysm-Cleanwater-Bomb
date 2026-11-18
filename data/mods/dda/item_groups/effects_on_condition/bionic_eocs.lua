local content = require("ccb").content

do
    local group = content.ItemGroup { id = "internal_mp3_music_group", kind = "distribution" }
    group:entry { item = "internal_mp3_music", active = true }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "internal_mp3_radio_group", kind = "distribution" }
    group:entry { item = "internal_mp3_radio", active = true }
    content.add(group)
end
