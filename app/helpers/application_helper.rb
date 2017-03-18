module ApplicationHelper


  def p_champ_sport_id()
    if !params[:champ].nil? && !params[:champ][:sport_id].nil?
      params[:champ][:sport_id]
    end
  end
end


