local M = {}
local ngx = require('ngx')
local json = require('json')

function M.read_config(path)
  local config_file = io.open(path, 'rb')
  assert(config_file, 'cannot read config file')
  local config = config_file:read('*a')
  config_file:close()
  return config
end

function M.index()
  local config = json.decode(M.read_config('/etc/agg/config.json'))
  local output = {}
  for k, v in pairs(config) do
    table.insert(output, k .. ' ' .. v)
  end
  ngx.say(table.concat(output, '\n'))
end

return M
