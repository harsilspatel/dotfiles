-- https://stackoverflow.com/a/27028488/9701238
function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

-- https://github.com/AdamWagner/stackline/blob/main/lib/utils.lua#L354-L364
function p(data, howDeep) -- {{{
  -- local logger = hs.logger.new('inspect', 'debug')
  local depth = howDeep or 3
  if type(data) == 'table' then
    print(hs.inspect(data, {depth = depth}))
    -- logger.df(hs.inspect(data, {depth = depth}))
  else
    print(hs.inspect(data, {depth = depth}))
    -- logger.df(hs.inspect(data, {depth = depth}))
  end
end -- }}}
