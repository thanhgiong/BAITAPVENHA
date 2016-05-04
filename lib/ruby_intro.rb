#Part1
def sum arr
  if arr.length == 0
    return 0
  else
    arr.reduce(:+)
  end
end

def max_2_sum arr
  if arr.length == 0
    return 0
  else
    sum(arr.sort.last(2))
  end
end

def sum_to_n? arr, n
  return false if arr.empty? && n.zero? 
  arr.combination(2).any? { |a, b| a + b == n }
end

#Part2
def hello(name)
  "Hello, " + name
end

def starts_with_consonant? s
  s.empty? ? false : (s =~ /^[ueoaiUEOAI#]/ ? false : true)
end

def binary_multiple_of_4? s
    return false unless s =~ /^[01]+$/
    s.to_i(2) % 4 == 0
end

#Part3
class BookInStock
  def initialize(isbn, price)  
      if isbn.empty?
         raise(ArgumentError)
      elsif price <= 0
          raise(ArgumentError)
      end
      @isbn = isbn
      @price = price
  end
  def isbn= isbn 
    @isbn = isbn
  end
  def price= price
    @price = price
  end
  def isbn
    @isbn
  end
  def price
    @price
  end
  def price_as_string
    "$%.2f" % self.price
  end 
end