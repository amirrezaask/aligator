local M = {}
local ngx = require('ngx')
local json = require('lunajson')

function M.read_config(path)
  local config_file = io.open(path, 'rb')
  assert(config_file, 'cannot read config file')
  local config = config_file:read('*a')
  config_file:close()
  return config
end

function M.request_print()
  ngx.say(json.encode({ name = 'amirreza' }))
end

return M
