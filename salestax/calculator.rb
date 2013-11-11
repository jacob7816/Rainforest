module Utils
  def self.round(amount)
    return amount if (amount % 5) == 0
    amount + 5 - (amount % 5)
  end

  def self.format_price(price)
    sprintf("%.2f", price / 100.00)
  end
end

class Product
  def initialize(quantity, name, price)
    @quantity = quantity
    @price = price * 100
    @name = name
  end

  def subtotal
    @quantity * @price
  end

  def sales_tax
    Utils.round (subtotal * tax_rate).ceil
  end

  def total
    subtotal + sales_tax
  end

  def tax_rate
    0.10
  end

  def to_s
    "#{@quantity} #{@name} : #{Utils.format_price(total)}"
  end
end

class Exempt < Product
  def tax_rate
    0
  end
end

class Import < Product
  def tax_rate
    super + 0.05
  end
end

class ImportedExempt < Exempt
  def tax_rate
    super + 0.05
  end
end

class ShoppingCart
  def initialize
    @products = []
  end

  def add_item(product_string)
    strings = product_string.split(" ")
    quantity = strings[0].to_i
    price = strings[-1].to_f
    name = strings[1...-2].join(" ")

    @products << product_factory(quantity, name, price)
  end

  def receipt
    calculate

    results = ""
    @products.each {|product| results << "#{product.to_s}\n"}

    results << "Sales Tax: #{Utils::format_price(@sales_tax)}\n"
    results << "Total: #{Utils::format_price(@total)}"
  end

  private
  def calculate
    @total = 0
    @sales_tax = 0

    @products.each do |product|
      @sales_tax += product.sales_tax
      @total += product.total
    end
  end

  def product_factory(quantity, name, price)
    if name == "imported box of chocolates"
      ImportedExempt.new(quantity, name, price)
    elsif name.include?("book") || name.include?("chocolate") || name.include?("pills")
      Exempt.new(quantity, name, price)
    elsif name.include?("imported")
      Import.new(quantity, name, price)
    else
      Product.new(quantity, name, price)
        endclass Person
        attr_accessor :name
        def greeting
   		puts "Hello my name is #{@name}"
    end
  end
    
    
    
    class Students < Person
        def learn
            puts "I'm learning"
        end
    end
    
    class Instructor < Person
        def teach
            puts "Everything in Ruby is an Object"
        end
    end
    
    
    
    students = Students.new
    students.name = "Cristina"
    students.greeting
    students.learn
    
    instructor= Instructor.new
    instructor.name ="Chris"
    instructor.greeting
    instructor.teach
    
    # When you apply the teach method on your students instance only the gretting it run followed by an error msg stating an undefined method for "teach"  end
end

# exempt = books, food, medical
# imported 

cart = ShoppingCart.new

cart.add_item "1 book at 12.49"
cart.add_item "1 music CD at 14.99"
cart.add_item "1 chocolate bar at 0.85"
puts cart.receipt

puts "------------------------"

# cart = ShoppingCart.new

# cart.add_item ImportedExempt.new(1, "imported box of chocolates", 10.00)
# cart.add_item Import.new(1, "imported bottle of perfume", 47.50)
# puts cart.receipt

# puts "------------------------"

# cart = ShoppingCart.new

# cart.add_item Import.new(1, "imported bottle of perfume", 27.99)
# cart.add_item Product.new(1, "bottle of perfume", 18.99)
# cart.add_item Exempt.new(1, "packet of headache pills", 9.75)
# cart.add_item ImportedExempt.new(1, "imported chocolates", 11.25)
# puts cart.receipt


#---- Tests -----------------------
# product = Product.new(1, "music CD", 14.99)
# puts product.to_s
# puts Utils.format_price(product.sales_tax)

# exempt = Exempt.new(1, "book", 12.49)
# puts exempt.to_s
# puts Utils.format_price(exempt.sales_tax)

# import = Import.new(1, "imported box of chocolates", 10.00)
# puts import.to_s
# puts Utils.format_price(import.sales_tax)

# puts Utils::round(1243)
# puts Utils::round(1200)
# puts Utils::round(1205)
# puts Utils::round(1247)
