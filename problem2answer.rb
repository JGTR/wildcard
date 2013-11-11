generation =[9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
overhead =[21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]
budget =2912

class CardOptimizer

  attr_accessor :cards, :set

  def initialize(gen_array, overhead_array, budget)
    @gen_array = gen_array
    @overhead_array = overhead_array
    @cards = []
    @budget = budget
    @set = []
    create_cards
    execute_within_budget
  end


  def create_cards
    @gen_array.each_with_index do |generation_time, index|
      @cards << [generation_time, @overhead_array[index]]
    end
    @cards
  end

  def time_estimator(card)
    card[0]+(16*card[1])
  end

  def card_index_picker
    lowest_pick = 0
    @cards.each_with_index do |card, index|
      if time_estimator(@cards[index]) < time_estimator(@cards[lowest_pick])
        lowest_pick = index
      end
    end
    lowest_pick
  end

  def pick_card(index)
    @set << @cards[index]
    @cards.delete_at(index)
  end

  def check_budget
    count = @set.size - 1
    generation_time = @set.inject(0){|result, element| result + element[0]}
    overhead_time = @set.inject(0){|result, element| result + element[1]*count}
    generation_time + overhead_time
  end

  def execute_within_budget
    running = true
    while running
      pick_card(card_index_picker)
      if check_budget == @budget
        puts "Budget matched"
        running = false
      elsif check_budget > @budget
        puts "Budget surprassed"
        running = false
        @set.pop
      end
    end
    puts "#{@set.size} Cards are possible!"
  end

end

x = CardOptimizer.new(generation, overhead, budget)
