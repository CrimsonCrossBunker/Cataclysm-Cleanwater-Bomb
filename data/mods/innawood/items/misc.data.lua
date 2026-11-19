local ccb = require("ccb")

ccb.content.define_item {
    id = "super_glue",
    copy_from = "glue_strong",
    name = ccb.content.text("glue"),
    description = ccb.content.text("A thick, goopy glue that cures fast."),
    ammunition = {},
}
