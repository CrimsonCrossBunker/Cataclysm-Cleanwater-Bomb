local content = require("ccb").content

-- Damage indicator string to show for damage level 0
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_0", kind = "string_input", value = "<color_c_green>++</color>" }

-- Damage indicator string to show for damage level 1
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_1", kind = "string_input", value = "<color_c_light_green>||</color>" }

-- Damage indicator string to show for damage level 2
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_2", kind = "string_input", value = "<color_c_yellow>|\\</color>" }

-- Damage indicator string to show for damage level 3
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_3", kind = "string_input", value = "<color_c_light_red>|.</color>" }

-- Damage indicator string to show for damage level 4
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_4", kind = "string_input", value = "<color_c_red>\\.</color>" }

-- Damage indicator string to show for damage level 5
content.define_external_option { id = "DAMAGE_INDICATOR_LEVEL_5", kind = "string_input", value = "<color_c_dark_gray>XX</color>" }
