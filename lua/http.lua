local httpc = require('resty.http')
local json = require('lunajson')

return function(opts)
  opts = opts or {}
  opts.headers = opts.headers or {}
  assert(opts.host, 'host needs to be specify')
  assert(opts.method, 'method needs to be specify')
  opts.uri = opts.uri or ''
  if opts.body then
    -- TODO(amirreza): Need to support other Content-Type
    if type(opts.body) == 'table' then
      opts.body = json.encode(opts.body)
    end
  end
  local res, err = httpc:request_uri(opts.host .. opts.uri, {
    method = opts.method,
    body = opts.body,
    headers = opts.headers,
  })

  if err then
    error(err)
    return nil
  end

  return res
end
