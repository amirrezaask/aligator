local ngx = require('ngx')

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local Types = {
  Group = 'group',
  API = 'api',
}

local Group = {}
Group.__index = Group
Group.__call = Group.new

-- @returns Group
function Group:new(opts)
  opts = opts or {}
  opts['type'] = Types.Group
  return setmetatable(opts, Group)
end

function Group:linearize(base)
  local new_t = {}
  for route, obj in pairs(self) do
    if route == 'type' then goto continue end
    if obj['type'] == Types.Group then
      local linearized = obj:linearize(base .. route)
      for r, obj in pairs(linearized) do
        new_t[r] = obj
      end
    elseif obj['type'] == Types.API then
      new_t[base.. '/' .. route] = obj
    end
    ::continue::
  end
  return new_t
end

local API = {}
API.__index = API
API.__call = API.new

-- @returns API
function API:new(opts)
  opts = opts or {}
  opts['type'] = Types.API
  assert(opts.host, 'need a host for API')
  assert(opts.method, 'need a method for API')
  assert(opts.transformer, 'need a transformer for API')
  return setmetatable(opts, API)
end

-- @returns API
function Group:get_api_for_uri()
  local uri = ngx.var.request_uri
  uri = split(uri, '/')
  for _, part in pairs(uri) do
    ngx.log(ngx.ERR, part)
  end
end

return { Group = Group, API = API }
