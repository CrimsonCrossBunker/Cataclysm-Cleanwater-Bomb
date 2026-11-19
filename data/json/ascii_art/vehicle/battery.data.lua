local ccb = require("ccb")

ccb.content.define_ascii_art {
    id = "battery_car",
    lines = {
        " <color_red>_</color>               <color_dark_gray>_</color>",
        "<color_light_cyan>┌<color_red>\"</color>───────────────<color_dark_gray>\"</color>┐",
        "[=================]",
        "<color_dark_gray>║   <color_light_blue>┌─────────┐</color>   ║",
        "║   <color_light_blue>│<color_white>Duralast </color>│</color>   ║",
        "║   <color_light_blue>│  <color_light_cyan>Iridium</color>│</color>   ║",
        "║   <color_light_cyan>╘═≈≈≈≈≈≈≈═╛</color>   ║",
        "║                 ║",
        "╙─────\"\"\"\"\"\"\"─────╜",
    },
}

ccb.content.define_ascii_art {
    id = "battery_motorbike",
    lines = {
        "<color_light_cyan>╓<color_red>▄</color>┬─────┬<color_light_gray>▄</color>╖",
        "<color_dark_gray>│<color_white>Duralast</color> │",
        "│  <color_light_cyan>Iridium</color>│",
        "│<color_light_cyan>═≈≈≈≈≈≈≈═</color>│",
        "└─────────┘",
    },
}

ccb.content.define_ascii_art {
    id = "battery_motorbike_small",
    lines = {
        " <color_light_cyan>_______",
        "├<color_red>▀</color>└───┘<color_light_gray>▀</color>┤",
        "<color_dark_gray>│ <color_light_cyan>≈≈≈≈≈</color> │",
        "└───────┘",
    },
}

ccb.content.define_ascii_art {
    id = "small_storage_battery",
    lines = {
        "<color_light_cyan>┌<color_light_gray>•</color>──<color_light_gray>•</color>┐",
        "│ <color_white>≈≈</color> │",
        "│    │",
        "│    │",
        "└────┘",
    },
}

ccb.content.define_ascii_art {
    id = "medium_storage_battery",
    lines = {
        "<color_light_cyan>╒<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╕",
        "│ <color_white>≈≈</color> │ <color_white>≈≈</color> │",
        "│    │    │",
        "│    │    │",
        "<color_light_gray>╚════╩════╝",
    },
}

ccb.content.define_ascii_art {
    id = "storage_battery",
    lines = {
        "<color_light_cyan>╒<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╕",
        "│ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │",
        "│    │    │    │    │    │",
        "│    │    │    │    │    │",
        "<color_light_gray>╚════╩════╩════╩════╩════╝",
    },
}

ccb.content.define_ascii_art {
    id = "large_storage_battery",
    lines = {
        "<color_light_cyan>╒<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╤<color_light_gray>■══■</color>╕",
        "│ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │",
        "│    │    │    │    │    │",
        "│    │    │    │    │    │",
        "<color_light_gray>╠════╬════╬════╬════╬════╣</color>",
        "<color_light_gray>╠■══■╬■══■╬■══■╬■══■╬■══■╣</color>",
        "│ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │ <color_white>≈≈</color> │",
        "│    │    │    │    │    │",
        "│    │    │    │    │    │",
        "<color_light_gray>╚════╩════╩════╩════╩════╝",
    },
}

ccb.content.define_ascii_art {
    id = "it_battery_mount",
    lines = {
        "<color_light_gray>■════0══════════════0════■",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "0<color_dark_gray>────┼────┼────┼────┼────</color>0",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "║<color_dark_gray>────┼────┼────┼────┼────</color>║",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "║<color_dark_gray>────┼────┼────┼────┼────</color>║",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "0<color_dark_gray>────┼────┼────┼────┼────</color>0",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "■<color_dark_gray>════╪════╪════╪════╪════</color>■",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "0<color_dark_gray>────┼────┼────┼────┼────</color>0",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "║<color_dark_gray>────┼────┼────┼────┼────</color>║",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "║<color_dark_gray>────┼────┼────┼────┼────</color>║",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "0<color_dark_gray>────┼────┼────┼────┼────</color>0",
        "║<color_dark_gray>    │    │    │    │    </color>║",
        "■════0══════════════0════■",
        "      \\_<color_light_gray>()</color>_.──._<color_light_gray>()</color>_/",
        "         <color_dark_gray>│      │",
        "         │.====.│",
        "         //    \\\\",
        "    <color_light_gray>()</color>──'││    ││\\",
        "         \\\\    // │",
        "          '====' <color_light_gray>()</color>",
    },
}
