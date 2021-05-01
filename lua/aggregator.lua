local M = {}
local ngx = require('ngx')
local json = require('lunajson')
local config = require('config')

function M.request_print()
  ngx.say(json.encode({ name = 'amirreza' }))
end

return M
