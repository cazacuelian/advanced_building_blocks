module Enumerable
  def my_each
    for i in (0...self.length)
      yield(self[i])
    end
    self
  end
  
  def my_each_with_index
    for i in (0...self.length)
      yield(self[i],i)
    end
    self
  end
  
  def my_select
    selection = []
    for i in (0...self.length)
      if yield(self[i]) == true
        selection << self[i]
      end
    end
    selection
  end
  
  def my_all?
    all_respect_condition = true
    for i in (0...self.length)
      if yield(self[i]) == false
        all_respect_condition = false
        break
      end
    end
    all_respect_condition
  end
  
  def my_any?
    any_respects_condition = false
    for i in (0...self.length)
      if yield(self[i]) == true
        any_respects_condition = true
        break
      end
    end
    any_respects_condition
  end
  
  def my_none?
    none_respect_condition = true
    for i in (0...self.length)
      if yield(self[i]) == true
        none_respect_condition = false
        break
      end
    end
    none_respect_condition
  end
  
  def my_count(element_to_compare=nil)
    count = 0
    if element_to_compare != nil
      if block_given?
        return "Error: unused block passed as argument."
      else
        for i in (0...self.length)
          if self[i] == element_to_compare
            count += 1
          end
        end
      end
    elsif block_given?
      for i in (0...self.length)
        if yield(self[i]) == true
          count += 1
        end
      end
    else
      count = self.length
    end
    count
  end
  
  def my_map(&modification)
    arr = []
    if block_given?
      for i in (0...self.length)
        arr << modification.call(self[i])
      end
    else
      return self
    end
    arr
  end
  
  def my_inject(*options)
    start = 0 #starting value for the iterations(1 if no initial value specified, 0 otherwise)
    if options.empty?
      initial = self[0]
      symbol = nil
      start = 1
    else
      if options[0].is_a? Integer
        initial = options[0]
        if options[1].is_a? Symbol
          symbol = options[1]
        end
      elsif options[0].is_a? Symbol
        symbol = options[0]
        initial = self[0]
        start = 1
      end
    end
    if block_given?
      memo = initial
      for i in (start...self.length)
        memo = yield(memo,self[i])
      end
    else
      if symbol == nil
        return "Error: no symbol given from: :+, :-, :*, :/"
      else
        case symbol
          when :+ then
            memo = initial
            for i in (start...self.length)
              memo += self[i]
            end
          when :- then
            memo = initial
            for i in (start...self.length)
              memo -= self[i]
            end
          when :* then
            memo = initial
            for i in (start...self.length)
              memo *= self[i]
            end
          when :/ then
            memo = initial
            for i in (start...self.length)
              if self[i] != 0
                memo /= self[i]
              end
            end
          else return "Error: no symbol given from: :+, :-, :*, :/"
        end
      end
    end
    memo
  end
end

def multiply_els(arr)
  arr.my_inject(1, :*)
end
        
=begin        
print "My_each: "
p [0,1,2,3,4,5]
print " => "
[0,1,2,3,4,5].my_each { |num| print num.to_s + " " }
puts ""

print "My_each_with_index: "
p [0,1,2,3,4,5]
print " => "
[0,1,2,3,4,5].my_each_with_index { |num,i| print i.to_s + ")" + num.to_s + " " }
puts ""
        
print "My_select (%2==0): "
p [0,1,2,3,4,5]
print " => "
p [0,1,2,3,4,5].my_select { |num| num % 2 == 0 }

print "My_all? (>3): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_all? { |num| num > 3 }

print "My_any? (>=5): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_any? { |num| num >= 5 }

print "My_none? (<0): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_none? { |num| num < 0 }

print "My_count (nothing): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_count
        
print "My_count (==5): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_count(5)
        
print "My_count (block: %2==1): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_count { |num| num % 2 == 1 }

modification = Proc.new { |num| num ** 2 }
print "My_map (**2): "
p [0,1,2,3,4,5]
print " => "
p [0,1,2,3,4,5].my_map(&modification)
        
print "My_inject (initial = 3, symbol = :+): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_inject(3, :+)
        
print "My_inject (symbol = :-): "
p [0,1,2,3,4,5]
print " => "
puts [0,1,2,3,4,5].my_inject(:-)
        
print "My_inject (initial=3, block: *num*2): "
p [1,2,3,4,5]
print " => "
puts [1,2,3,4,5].my_inject(3) { |product,num| product*num*2 }
        
print "My_inject (block: *num*2): "
p [1,2,3,4,5]
print " => "
puts [1,2,3,4,5].my_inject { |product,num| product*num*2 }
        
print "Multiply_els: "
p [2,4,5]
print " => "
puts multiply_els([2,4,5])
=end