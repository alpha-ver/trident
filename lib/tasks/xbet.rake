namespace :xbet do

  desc "Global update"
  task :upd_all => :environment do
    Rake::Task["xbet:upd_sports"].invoke
    Rake::Task["xbet:upd_champs"].invoke
    Rake::Task["xbet:upd_betgroups" ].invoke
    Rake::Task["xbet:upd_bettypes"  ].invoke
  end

  desc "Update Sports"
  task :upd_sports => :environment do
    puts "Starting update Sports\n".colorize(:green)
    api = Api_xbet.new()
    sports = api.sports

    sports.each do |sport|
      model_sport = Sport.find_by(:api_xbet_id => sport[:id])
      if model_sport.nil?
        normalize_name = sport[:name].mb_chars.downcase.to_s
        model_sport = Sport.find_by("'#{normalize_name}' = ANY (find_names)")
        if model_sport.nil?
          puts "Sport \"#{sport[:name]}\" CREATED.".colorize(:green)
          model_sport = Sport.new(
            name: sport[:name],
            find_names: [normalize_name],
            created: api.name,
            enable: true,
            api_xbet_id: sport[:id],
            api_xbet_params: sport
          )

          model_sport.save
        else
          puts "Sport \"#{sport[:name]}\" merge.".colorize(:yellow)
          model_sport.api_xbet_id = sport[:id]
          model_sport.api_xbet_params = sport
          model_sport.save

        end
      else
        puts "Sport \"#{sport[:name]}\" exist.".colorize(:light_blue)
      end
    end

  end

  desc "Update Champs"
  task :upd_champs => :environment do
    puts "Starting update Champs\n".colorize(:green)
    api = Api_xbet.new()
    Sport.xbets.each do |model_sport|
      puts "Sport selected:#{model_sport.name}.".colorize(:green)
      champs = api.champs(model_sport.api_xbet_id)
      champs.each do |champ|
        #=> { :CountryId=>225, :Game=>nil, :Id=>3355, :MbTop=>300, :Name=>"КХЛ", :Sport=>2, :Top=>1}
        model_champ = model_sport.champs.find_by(:api_xbet_id => champ[:Id])
        if model_champ.nil?
          normalize_name = champ[:Name].mb_chars.downcase.to_s.gsub("'","")
          model_champ = model_sport.champs.find_by("'#{normalize_name}' = ANY (find_names)")
          if model_champ.nil?
            model_champ = Champ.new(
              name: champ[:Name],
              find_names: [normalize_name],
              created: api.name,
              sport_id: model_sport.id,
              country_id:  champ[:CountryId],
              api_xbet_id: champ[:Id],
              api_xbet_params: champ
            )
            if model_champ.save
              puts "Champ \"#{champ[:Name]}\" CREATED.".colorize(:green)
            else
              puts "Champ \"#{champ[:Name]}\" ERROR.".colorize(:red)
              ap model_champ.errors.to_json
            end
          else
            puts "Champ \"#{champ[:Name]}\" merge.".colorize(:yellow)
            raise "DEV"
            model_champ.api_xbet_id = champ[:Id]
            model_champ.api_xbet_params = champ
            model_champ.save
          end
        else
          puts "Champ \"#{champ[:Name]}\" exist.".colorize(:light_blue)
        end


      end
    end

  end

  desc "Update bet Groups"
  task :upd_betgroups => :environment do
    puts "Starting update Bet Groups\n".colorize(:green)
    api = Api_xbet.new()
    bet_groups = api.bet_groups
    bet_groups.each do |bet_group| #{:id=>3, :name=>"Б/М", :pos=>nil, :CountCols=>2}
      model_bet_group =  Xbet::Betgroup.find_by(:id => bet_group[:id])
      if model_bet_group.nil?
        model_bet_group = Xbet::Betgroup.new(
          id: bet_group[:id],
          name: bet_group[:name],
          pos: bet_group[:pos],
          countcols: bet_group[:CountCols]
        )
        if model_bet_group.save
          puts "Bet Group: #{bet_group[:name]} CREATED.".colorize(:green)
        else
          puts "Bet Group: #{bet_group[:name]} ERROR.".colorize(:red)
          ap bet_group
          ap model_bet_group.errors
          raise 'DEV'
        end
      else
        puts "Bet Group: #{bet_group[:name]} EXIST.".colorize(:yellow)
      end

    end

  end

  desc "Update bet Types"
  task :upd_bettypes => :environment do
    puts "Starting update Types\n".colorize(:green)
    api = Api_xbet.new()
    bet_types = api.bet_types
    bet_types.each do |bet_type| #{:id=>423, :MobileName=>"Фиктивное означает что игра заблокирована", :group=>0, :col=>nil, :colpos=>nil, :GroupNameVid=>344, :typeparam=>5}
      model_bet_type =  Xbet::Bettype.find_by(:id => bet_type[:id])
      if model_bet_type.nil?
        model_bet_type = Xbet::Bettype.new(
          :id           => bet_type[:id],
          :name         => bet_type[:MobileName],
          :betgroup_id  => bet_type[:group],
          :col          => bet_type[:col],
          :colpos       => bet_type[:colpos],
          :groupnamevid => bet_type[:GroupNameVid],
          :typeparam    => bet_type[:id]
        )
        if model_bet_type.save
          puts "Bet Group: #{bet_type[:MobileName]} CREATED.".colorize(:green)
        else
          puts "Bet Group: #{bet_type[:MobileName]} ERROR.".colorize(:red)
          ap bet_type
          ap model_bet_type.errors
          raise 'DEV'
        end
      else
        puts "Bet Group: #{bet_type[:MobileName]} EXIST.".colorize(:yellow)
      end

    end

  end

  desc "Add new events ids"
  task :add_events => :environment do
    puts "Starting add ids events.\n".colorize(:green)
    api = Api_xbet.new()
    Champ.xbets.each do |champ|
      ids     =  api.game_ids(champ.api_xbet_id)
      new_ids =  Xbet::Event.add_ids(ids, champ.id)
      puts "ADD. New_ids: #{new_ids.count}. All_ids:#{ids.count}. Champ: #{champ.name}".colorize(:green)
    end
  end

  desc "Add details info in status 0"
  task :details_new_events => :environment do
    puts "Add details info in status 0(no parsed)".colorize(:green)
    model_events = Xbet::Event.where(:status => 0)
    puts "Find event count:#{model_events.count}".colorize(:green)
    api = Api_xbet.new
    model_events.each do |model_event|
      response_event = api.detail_event(model_event.id)
      if !response_event.nil?
        if response_event[:Value].blank?
        # id: 108661177, champ_id: 1, host_command_id: nil, slave_command_id: nil,
        # commands_ids: nil, status: 0, score_history: nil,
        # message_history: nil, dl: nil, start_at: nil
          puts "Возможно игра закончилась. РЕАЛИЗОВАТЬ!".colorize(:red) #@todo
          ap response_event
          ap model_event
        else
          model_event.res_upd(response_event)

        end
      end
    end

  end

  desc "Live update"
  task :live_events => :environment do
    puts "Add details info in status 0(no parsed)".colorize(:green)
    model_events = Xbet::Event.where(:status => 2)
    puts "Find event count:#{model_events.count}".colorize(:green)
    api = Api_xbet.new
    model_events.each do |model_event|
      response_event = api.detail_event(model_event.id)
      if !response_event.nil?
        if response_event[:Value].blank?
        # id: 108661177, champ_id: 1, host_command_id: nil, slave_command_id: nil,
        # commands_ids: nil, status: 0, score_history: nil,
        # message_history: nil, dl: nil, start_at: nil
          puts "Возможно игра закончилась. РЕАЛИЗОВАТЬ!".colorize(:red) #@todo
          ap response_event
          ap model_event
        else
          model_event.res_upd(response_event)

        end
      end
    end

  end


end
