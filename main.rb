class Main
  require "csv"

  def initialize
    @products = [
      {name: "book", price: 12.49, category: "book", type: "inland"},
      {name: "music cd", price: 14.99, category: "music", type: "inland"},
      {name: "chocolate bar", price: 0.85, category: "food", type: "inland"},
      {name: "imported box of chocolates", price: 10.00, category: "food", type: "import"},
      {name: "imported bottle of perfume", price: 47.50, category: "perfume", type: "import"},
      {name: "imported bottle of perfume", price: 27.99, category: "perfume", type: "import"},
      {name: "bottle of perfume", price: 18.99, category: "perfume", type: "inland"},
      {name: "packet of headache pills", price: 9.75, category: "medical", type: "inland"},
      {name: "box of imported chocolates", price: 11.25, category: "food", type: "import"}
    ]
    @choosed_product = []
  end

  def main
    show_list_product
    choose_product
    display_cart
    export_csv
  end

  private

  def break_line
    puts ""
    puts "================================================="
    puts ""
  end

  def show_list_product
    @products.each_with_index do |product, index|
      print index + 1
      puts " #{product[:name]}"
    end
    break_line
  end

  def choose_product
    continue = "y"
    while !(continue == "N" || continue == "n")
      print "Choose product add to cart: "
      begin
        choose_product = Integer STDIN.gets.chomp
        if @products[choose_product.to_i - 1].nil?
          raise ArgumentError
        end
      rescue ArgumentError => ex
        puts "Please choose product in list!"
        next
      end
      @choosed_product << choose_product.to_i - 1
      puts "You choosed product: #{@products[choose_product.to_i - 1][:name]}"
      print "Do you want to add more product (press 'n' to cancel): "
      continue = STDIN.gets.chomp
    end
  end

  def calculate_tax_product index
    product = @products[index]
    basic_tax = case product[:category]
                when "book", "food", "medical" then 0
                else 10
                end
    import_tax = product[:type] == "import" ? 5 : 0
    price = product[:price]
    ((price * (basic_tax + import_tax) / 100) * 20).ceil / 20.0
  end

  def calculate_total_tax
    total_tax = 0
    @choosed_product.each do |i|
      total_tax += calculate_tax_product i
    end
    total_tax.round 2
  end

  def calculate_total_price
    total_tax = calculate_total_tax
    total_price = 0
    @choosed_product.each do |i|
      total_price += @products[i][:price]
    end
    (total_price + total_tax).round 2
  end

  def calculate_total_price_one_product index
    (@products[index][:price] + calculate_tax_product(index)).round 2
  end

  def display_cart
    break_line

    puts "Your cart:"
    puts "No.   Name   Price   Total"

    @choosed_product.each_with_index do |i, index|
      print index + 1
      puts "   #{@products[i][:name]}   #{@products[i][:price]}   #{calculate_total_price_one_product i}"
    end

    puts "================================================="
    puts "Total tax: #{calculate_total_tax}"
    puts "Total price: #{calculate_total_price}"
  end

  def export_csv
    break_line
    print "Do you want to export your cart to csv file? (press 'y' to export) "
    agree = STDIN.gets.chomp
    if agree == "Y" || agree == "y"
      CSV.open("your_cart.csv", "wb") do |csv|
        csv << ["No.", "Product name", "Price", "Tax", "Total"]
        @choosed_product.each_with_index do |i, index|
          tax = calculate_tax_product i
          csv << [index + 1, @products[i][:name], @products[i][:price], tax,
            (@products[i][:price] + tax).round(2)]
        end
        csv << ["", "", "", calculate_total_tax, calculate_total_price]
      end
    end
    puts "All done!"
  end
end

Main.new.main
