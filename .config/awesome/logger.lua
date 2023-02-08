local naughty = require("naughty")

function log(title, msg)
    naughty.notify({ preset = naughty.config.presets.normal,
                     title = title,
                     text = msg,
    })
end


function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
-- print(dump(root.tags()))