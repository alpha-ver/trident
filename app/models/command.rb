class Command < ApplicationRecord
  belongs_to :sport

  has_many :xbet_events_host,  :class_name => 'Xbet::Event',  :foreign_key => :host_command_id
  has_many :xbet_events_slave, :class_name => 'Xbet::Event',  :foreign_key => :slave_command_id
  has_many :xbet_events, ->(command) {
    unscope(:where).where("host_command_id = :id OR slave_command_id = :id", id: id)
  }, :class_name => 'Xbet::Event'


  def self.get_or_create(hash)
    if hash[:type] == 'xbet'
      model_command = self.find_by(
        :api_xbet_id => hash[:api_xbet_id],
        :sport_id    => hash[:sport_id]
      )
    elsif hash[:type] == 'leon'
      model_command = self.find_by(
        :api_leon_id => hash[:api_leon_id],
        :sport_id    => hash[:sport_id]
      )
    else
      raise "TypeNotValid"
    end

    if model_command.nil?
      normalise_name = hash[:name].mb_chars.downcase.to_s
      model_command = self.where(
        "'#{normalise_name}' = ANY (find_names)"
      ).find_by(:sport_id => hash[:sport_id])

      if model_command.nil?
        case hash[:type]
        when 'xbet'
          model_command = self.new(
            :api_xbet_id => hash[:api_xbet_id],
            :sport_id    => hash[:sport_id],
            :name        => hash[:name],
            :find_names  => [normalise_name]
            )
          model_command.save

        end
      else
        case hash[:type]
        when 'xbet'
          if !model_command.api_xbet_id.nil?
            model_command.api_xbet_id = hash[:api_xbet_id]
            model_command.save
          else
            raise "DublCategory"
          end
        end
      end

    else

    end

    model_command
  end

end
