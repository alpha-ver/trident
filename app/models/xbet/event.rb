class Xbet::Event < ApplicationRecord
  has_many :bets, :class_name => 'Xbet::Bet'

  belongs_to :champ, :class_name => 'Champ', optional: true

  belongs_to :command_host,  :class_name => 'Command',  :foreign_key => :host_command_id, optional: true
  belongs_to :command_slave, :class_name => 'Command',  :foreign_key => :slave_command_id, optional: true

  def self.add_ids(ids, champ_id=nil)
    ids.uniq!
    find_ids  = self.select("id").where(:id => ids).map{|i| i.id}
    new_ids   = ids - find_ids

    events = new_ids.map do |new_id|
      [new_id, champ_id, 0]
    end

    self.import [:id, :champ_id, :status], events, validate: false

    new_ids
  end


  def res_upd(res)
    #ap self
    if !res.nil? && !res[:Value].blank? && res[:Success] == 1

      # Get command or create()
      model_sport = self.champ.sport
      model_host_command = Command.get_or_create(
        :api_xbet_id => res[:Value][0][:Opp1Id],
        :sport_id    => model_sport.id,
        :name        => res[:Value][0][:Opp1]
        :type        => 'xbet'
      )
      model_slave_command   = Command.get_or_create(
        :api_xbet_id => res[:Value][0][:Opp2Id],
        :sport_id    => model_sport.id,
        :name        => res[:Value][0][:Opp2]
        :type        => 'xbet'
      )

      self.host_command_id  =  model_host_command.id
      self.slave_command_id = model_slave_command.id

      #type
      if res[:type] == 'Line'
        self.status = 1
      elsif res[:type] == 'Live'
        self.status = 2
      end

      #bets
      response_event[:Value][0][:Events].map do |event|
        model_bet = Xbet::Bet.new(
          :event_id   => self.id,
          :bettype_id => event[:T],
          :ratio      => event[:C],
          :active     => event[:B] == 0 ? true : false,
          :p          => event[:P],
          :pl         => event[:PL],
          ###########################
          :dl         => event
        )

        model_bet.save
      end

      self.constid     = res[:Value][0][:ConsId]
      self.contora     = res[:Value][0][:Contora]
      self.dopinfo     = res[:Value][0][:DopInfo]
      self.finish      = res[:Value][0][:Finish] == 0 ? false : true
      self.maingame_id = res[:Value][0][:MainGameId]
      self.num         = res[:Value][0][:Num]
      self.period      = res[:Value][0][:Period]
      self.start_at    = Time.at(res[:Value][0][:Start]).utc
      self.score       = res[:Value][0][:score]
      self.dl          = res[:Value]

      self.save
    end
  end

end
