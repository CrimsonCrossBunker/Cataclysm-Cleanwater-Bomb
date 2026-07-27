local M = {}

function M.clamp_query(value)
    value = tostring(value or "")
    if #value > 64 then
        return string.sub(value, 1, 64)
    end
    return value
end

function M.safe_action_options(context, limit)
    local result = {}
    for _, action in ipairs(context.actions) do
        if context.available[action.id] and not action.dangerous then
            result[#result + 1] = {
                id = action.id,
                label = action.label,
            }
            if #result >= limit then
                break
            end
        end
    end
    return result
end

return M
