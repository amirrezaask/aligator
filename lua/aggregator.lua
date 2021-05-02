local M = {}
local ngx = require('ngx')
local json = require('lunajson')
local Config = require('config')
local Group = Config.Group
local API = Config.API

local config = Group:new({
  product = Group:new({
    get_id = API:new({
      backends = {
        {
          name = 'productobj',
          host = 'localhost:8080',
          uri = 'products/' .. 'productid',
          method = 'get',
          headers = {},
          transformer = 'json.decode',
          save_to_state = {
            'category_id',
          },
        },
        {
          name = 'categoryobj',
          host = 'localhost:8080',
          uri = 'category/' .. ngx.ctx.State.category_id,
          method = 'get',
          headers = {},
          transformer = 'json.decode',
        },
      },
      returns = function() end,
    })
  })
})

function M.mux()
  local linearized = config:linearize('/')
  local resp = linearized[ngx.var.request_uri]:call()
  ngx.say(json.encode(resp))
end

return M
