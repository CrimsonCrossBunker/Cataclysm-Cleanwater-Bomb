local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "software_archiving",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("openVault", "openVault"),
        description = ccb.content.text("A popular software suite used to extract and organize data from abandoned devices.  Can be used with minimal training, so long as the target device is powered and unsecured."),
        price_cents = 120000,
        price_postapoc_cents = 120000,
        electronic_size_kb = 256000,
    }
    content.add(item)
end
