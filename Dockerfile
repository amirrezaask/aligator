FROM openresty/openresty:alpine-fat

# Install dependencies
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-ljsonschema
RUN /usr/local/openresty/luajit/bin/luarocks install lunajson 



