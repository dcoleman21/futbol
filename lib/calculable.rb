module Calculable
  def calculate_percentage(portion, total)
    (portion / total.to_f).round(2)
  end
end
