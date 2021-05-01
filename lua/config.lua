local json = require('lunajson')

local Types = {
  Group = 'group',
  API = 'api',
}

local function group(apis)
  return { ['type'] = Types.Group, apis = apis }
end

local function api(opts)
  opts = opts or {}
  assert(opts.host, 'need a host for API')
  assert(opts.method, 'need a method for API')
  assert(opts.transformer, 'need a transformer for API')
  return opts
end

return {
  product = group {
    api {
      host = 'localhost:8080',
      uri = 'products/' .. 'productid',
      method = 'get',
      headers = {},
      transformer = function(res)
        return json.decode(res.body)
      end,
    },
  },
}
