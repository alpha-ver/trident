class Api < Daemon

  def g(params)
    begin
      if params.class == String
        url=full_url(params)
      elsif params.class == Hash
        url=full_url(params[:url])
      else
        raise 'NotValidClass'
      end

      connection = Faraday.new(url: url,
                               ssl: {verify: true},
                               request: {
                                proxy: {
                                  uri:  @current_proxy,
                                  socks: true }}) do |c|
        #c.headers[:user_agent] = "Just Some Engineer"
        c.adapter  :net_http
        c.response :logger
      end
      if params.class == Hash && params[:type] == :post
        response = connection.post
      else
        response = connection.get
      end

      if response.status == 200
        if params.class == Hash && params[:string]
          res = response.body
        else
          res = JSON.parse(response.body, :symbolize_names=>true)
        end
        r true, res
      else
        r false, {:error => :http_code}, response.to_hash
      end
    rescue Exception => e
      ap e.inspect
      ap e.backtrace
      r false, {:error => Exception, :name => e.inspect, :trace => e.backtrace}
    end
  end


  def full_url(url)
    url = URI.parse(url)
    if url.host.nil?
      url.host   = @current_host.host
      url.scheme = @current_host.scheme
    end
    url.to_s
  end

  def get_proxy
    URI.parse('socks://127.0.0.1:9050')
  end

  def r success, value, data=nil
    {
      :success => success,
      :value => value,
      :data => data
    }
  end

  def pause(ms)
    sleep @s[ms] / 1000.0
  end

  def setting(name)
    @s[name]
  end

end



###############################################
###############################################
###############################################
Dir['lib/ext/api_*.rb'].map do |file|##########
  require file.match(/\Alib\/(.+)\.rb$/)[1]####
end############################################
###############################################
