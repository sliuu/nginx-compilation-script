# Install openssl first

# Install dependencies
#
# * checkinstall: package the .deb
# * libpcre3, libpcre3-dev: required for HTTP rewrite module
# * zlib1g zlib1g-dbg zlib1g-dev: required for HTTP gzip module
sudo apt-get -y install checkinstall libpcre3 libpcre3-dev zlib1g zlib1g-dbg zlib1g-dev && \
# Keep nginx conf files
sudo apt-get -y remove nginx nginx-common && \

rm -rf ~/sources/nginx-1.9.3* ~/sources/ngx_cache_purge* ~/sources/ngx_pagespeed* ~/sources/openssl-1.0.1d* && \

mkdir -p ~/sources/ && \

# Install passenger
#
gem install passenger -v 5.0.14 && \

# Compile against OpenSSL to enable NPN
cd ~/sources && \
wget http://www.openssl.org/source/openssl-1.0.2d.tar.gz && \
tar -xzvf openssl-1.0.2d.tar.gz && \

# Download oboe module
#cd ~/sources && \
#wget https://files.appneta.com/src/nginx_oboe-latest.x86_64.tar.gz && \
#tar -xzvf ~/sources/nginx_oboe-latest.x86_64.tar.gz && \

# Download pagespeed module for AppNeta
#cd ~/sources/nginx_oboe/psol/ngx_pagespeed/ && \
#wget https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz && \
#tar -xzvf 1.7.30.3.tar.gz && \

# Get the Nginx source.
#
# Best to get the latest mainline release. Of course, your mileage may
# vary depending on future changes
cd ~/sources/ && \
wget http://nginx.org/download/nginx-1.9.3.tar.gz && \
tar zxf nginx-1.9.3.tar.gz && \
cd nginx-1.9.3 && \

# Compile nginx with passenger
#
rvmsudo passenger-install-nginx-module && \
\
2 \
/home/deploy/source/nginx-1.9.3 \
\
--with-stream --with-http_realip_module --with-stream_ssl_module --with-openssl=$HOME/sources/openssl-1.0.2d \
\

# Configure nginx.
#
# This is based on the default package in Debian. Additional flags have
# been added:
#
# * --with-debug: adds helpful logs for debugging
# * --with-openssl=$HOME/sources/openssl-1.0.2d: compile against newer version
#   of openssl
# * --with-http_spdy_module: include the SPDY module
#./configure --prefix=/etc/nginx \
#--sbin-path=/usr/sbin/nginx \
#--conf-path=/etc/nginx/nginx.conf \
#--error-log-path=/var/log/nginx/error.log \
#--http-log-path=/var/log/nginx/access.log \
#--pid-path=/var/run/nginx.pid \
#--lock-path=/var/run/nginx.lock \
#--http-client-body-temp-path=/var/cache/nginx/client_temp \
#--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
#--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
#--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
#--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
#--user=www-data \
#--group=www-data \
#--with-http_ssl_module \
#--with-http_realip_module \
#--with-http_addition_module \
#--with-http_sub_module \
#--with-http_dav_module \
#--with-http_gunzip_module \
#--with-http_gzip_static_module \
#--with-http_random_index_module \
#--with-http_secure_link_module \
#--with-http_stub_status_module \
#--with-file-aio \
#--with-http_spdy_module \
#--with-stream \
#--with-stream_ssl_module \
#--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' \
#--with-ld-opt='-Wl,-z,relro -Wl,--as-needed' \
#--with-ipv6 \
#--with-debug \
#--with-openssl=$HOME/sources/openssl-1.0.2d \
#--add-module=$HOME/sources/nginx_oboe \
#--add-module=$HOME/sources/nginx_oboe/psol/ngx_pagespeed && \

# Make the package.
#make && \

# Create a .deb package.
#
# Instead of running `make install`, create a .deb and install from there. This
# allows you to easily uninstall the package if there are issues.
#sudo checkinstall --install=no -y && \

# Install the package.
#sudo dpkg -i nginx_1.9.3-1_amd64.deb
