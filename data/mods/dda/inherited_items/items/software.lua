local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "abstract_software",
        copy_from = "abstract_efile_exclusive",
        category = "software",
        name = content.plural_text("abstract software", "abstract software"),
        description = content.text("Copy from this for any software."),
        electronic_size_kb = 1,
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "abstract_efile_exclusive",
        abstract = true,
        copy_from = "abstract_efile",
        symbol = "o",
        name = content.plural_text("abstract e-only electronic file", "abstract e-only electronic files"),
        description = content.text("abstract e-only electronic file"),
        electronic_size_kb = 1,
    }
    item:clear_flags()
    item:flag("E_STORABLE_EXCLUSIVE")
    item:flag("IRREMOVABLE")
    item:flag("NO_DROP")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end
