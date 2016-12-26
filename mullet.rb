class Mullet
  attr_accessor :weight,:price,:level
  def initialize(weight)
    @weight = weight
    compute_price
  end
  private
  def compute_price
    case @weight.round
    when 0..3
      @level = 2400
    when 4
      @level = 2800 
    when 5
      @level = 3200 
    when 6
      @level = 3500 
    when 7
      @level = 3800 
    else
      @level = 4000  
    end
    @price = @level * @weight / 16
  end
end