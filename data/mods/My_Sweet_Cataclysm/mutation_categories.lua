local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "SUGAR",
    name = ccb.content.text("Sugar Kin"),
    mutagen_message = ccb.content.text("How sweet!"),
    threshold_mutation = "SUGAR",
    memorial_message = "Crystallized.",
}
content.add(definition)
end
