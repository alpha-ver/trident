json.extract! xbet_event, :id, :sport_id, :host_command_id, :slave_command_id, :commands_ids, :status, :score_history, :message_history, :dl, :start_at, :created_at, :updated_at
json.url xbet_event_url(xbet_event, format: :json)