local ccb = require("ccb")
local services = ccb.services
local H = {}

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end

H.receive_item = function(actor, item_id, count, container_id, flags)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    local opts = nil
    if container_id and container_id ~= "" then
        local cgid = H.safe_id("item", container_id)
        if cgid then opts = { container = cgid } end
    end
    services.inventory.receive_item(actor, gid, math.floor(count or 1), opts)
end

H.u = function(ctx)
    return ctx:speaker()
end

ccb.runtime.handler("dlg_a_no_hope_8683ce392b9e", function(ctx)
    H.receive_item(H.u(ctx), "necropolis_freq", 1, nil)
end)
