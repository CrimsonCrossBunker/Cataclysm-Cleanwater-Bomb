local content = require("ccb").content

-- mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_EYES_INSECT_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("eyes_insect_1", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_EYES_INSECT_2_0", condition = "ALWAYS" }
    :bodypart_change("", "eyes")
    :bodypart_change("", "head")
    :bodypart_change("eyes_dragonfly", "")
    :bodypart_change("head_dragonfly", ""))
