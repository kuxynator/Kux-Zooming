--- stringEx module
-- @module stringEx
local module = {}

--- Concatenances a string
-- @param ... Values to concatenation
-- @return The concatenanced string
function module.concat(...)
    local result = ""
    local args = {...}
    for i,v in ipairs(args) do
        if v == nil then v = "" end
       result = result .. v
    end
    return result
end

function module.print(dest, ...)
    dest.print(module.concat(...))
end

return module