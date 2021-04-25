local M = {}
local ngx = require('ngx')

function M.index()
  ngx.say(table.concat({ 'amirreza', 'parsa', 'hesam' }, '\n'))
end

return M
