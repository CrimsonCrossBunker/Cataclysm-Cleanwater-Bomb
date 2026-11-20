local ccb = require("ccb")

ccb.content.define_fault {
    id = "null",
    name = ccb.content.text("This is a bug"),
    description = ccb.content.text("This fault id is a reserved sentinel."),
}
