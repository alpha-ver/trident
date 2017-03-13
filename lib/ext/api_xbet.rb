class Api_xbet < Api

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
    path = "/MobileOpen/Mobile_sports?lng=#{@s[:lang]}"
    get_hash(path)
  end

  def bet_groups
    path = "/MobileOpen/Mobile_vid_sobitiy_groups?lng=#{@s[:lang]}"
    get_hash(path)
  end

  def bet_types
    path = "/MobileOpen/Mobile_vid_sobitiy?lng=#{@s[:lang]}"
    get_hash(path)
  end

  def champs(sport_id)
    path = "/LineFeed/Mb_GetChamps?sports=#{sport_id}&lng=#{@s[:lang]}"
    hash = g(path)
    if hash[:success] && hash[:value][:Success] != 0
      hash[:value][:Value]
    else
      #log to do
      print "---> ERROR!!! \n".colorize(:light_white).on_red
      ap games_hash
      print "\n".colorize(:light_white).light_red
      []
    end
  end

  def game_ids(champ)
    path = "/LineFeed/Mb_GetGames?champs=#{champ}&lng=#{@s[:lang]}"
    games_hash = g(path)

    if games_hash[:success] && games_hash[:value][:Success] != 0
      games_hash[:value][:Value].map{|i| i[:MainGameId]}.uniq
    else
      print "---> ERROR!!! \n".colorize(:light_white).on_red
      ap games_hash
      print "\n".colorize(:light_white).on_light_red
      #log to do
      []
    end
  end


  def detail_event(game_id, type='Line')

    path       = "/#{type}Feed/Mb_GetEvents?games=#{game_id}&lng=ru&whence=2&cfview=3"
    event_hash = g(path)
    if event_hash[:success] && event_hash[:value][:Success] != 0
      if event_hash[:value][:Value].blank? && type == 'Line'
        detail_event(game_id, 'Live')
      else
        event_hash[:value][:type] = type
        event_hash[:value]
      end
    else
      print "---> ERROR!!! \n".colorize(:light_white).on_red
      ap event_hash
      print "\n".colorize(:light_white).on_light_red
      #log to do
      nil
    end
  end

  private

    def get_servers
      ["https://mobbob.pw"]
    end

    def get_host
      URI.parse(get_servers.first)
    end

    def get_args(args={})

    end

    def set_args(args={})

    end

    def get_hash(path)
      hash = g(path)
      if hash[:success] && hash[:value][:Success]


        hash = hash[:value][:Data].map do |row|
          Hash[
            hash[:value][:Columns].each_with_index.map do |col,i|
              [col, row[i]]
            end
          ].symbolize_keys
        end
      else

      end
    end


end
