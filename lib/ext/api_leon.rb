class Api_leon < Api
def initialize(args={})
    @class_name = self.class.name.to_s.downcase
    #@s = Setting.get_group(@class_name)
    @current_proxy = get_proxy
    @current_host  = get_host
    @s = {
      :lang         => 'ru',
      :p_games_ids  => 500
    }
    sig()
  end

  def name
    @class_name
  end

  def sports
    path = "/rest/sportline/sports"
    get_hash(path)
  end

  def champs(sport_id)
    path  = "/rest/sportline/leagues/#{sport_id}"
    get_hash(path)
  end


  def bet_groups

  end

  def bet_types

  end


  def game_ids(champ)

  end


  def detail_event(game_id, type='Line')

  end

  private

    def get_servers
      ["https://ru.leon157.com/"]
    end

    def get_host
      URI.parse(get_servers.first)
    end

    def get_args(args={})

    end

    def set_args(args={})

    end

    def get_hash(path)
      hash = g(:url => path , :type=>:post)

      if !hash.nil? && hash[:success] && hash[:value][:result] == "OK"
        hash[:value]
      else
        nil
      end
    end
end
