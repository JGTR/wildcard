class CardArranger

  attr_accessor :rows, :columns, :input

  def initialize
    @input = File.read('./problem1input.txt')
    @rows = []
    @columns = []
    parser
  end

  
  def parser
    @input.split(/\n/).each_with_index{|row, index|@rows[index]=row}
    index = 0
    while index < @rows[0].size do
      @rows.each do |row|
        if @columns[index].nil?
          @columns[index] = row[index]
        else
          @columns[index] =  @columns[index] + row[index]
        end
      end
      puts @columns
      index += 1
    end
  end

  def find_spaces(string)
    string.scan(/\W/).size
  end

  def calculate_permutations(spaces)
    spaces*(spaces-1)*(spaces-2)*(spaces-3)*(spaces-4)
  end

  def find_answer
    answer = 0
    sets = @rows + @columns
    sets.each do |set|
      spaces = find_spaces(set)
      if spaces >= 5
        answer = answer + calculate_permutations(spaces)
      end
    end
    answer
  end

end

