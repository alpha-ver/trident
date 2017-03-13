require 'rubygems'
require 'faraday'
require 'socksify'
require 'socksify/http'

# This is a SOCKS monkey patch for Faraday, with example use/unit test.
# Notes:
#    * It is altered to work with SOCKS5 authentication.
#    * net_http_class must return a Faraday::Adapter::NetHttp instance.
#    * Verified as of 2014-06-09 with:
#        - SOCKS5 ss5 server
#        - gem faraday, '0.9.0'
#        - gem socksify,'1.5.0', git: 'git://github.com/pirateradio/socksify-ruby.git'
#        - ruby 1.9.3, 2.1

Socksify::debug = true

class Faraday::Adapter::NetHttp
  def net_http_connection(env)
    if proxy = env[:request][:proxy]
      if proxy[:socks]
        TCPSocket.socks_username = proxy[:user] if proxy[:user]
        TCPSocket.socks_password = proxy[:password] if proxy[:password]
        Net::HTTP::SOCKSProxy(proxy[:uri].host, proxy[:uri].port)
      else
        Net::HTTP::Proxy(proxy[:uri].host, proxy[:uri].port, proxy[:uri].user, proxy[:uri].password)
      end
    else
        Net::HTTP
    end.new(env[:url].host, env[:url].port)
  end
end