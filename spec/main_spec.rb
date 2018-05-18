require_relative "../main"

describe Main do
  subject(:main) {Main.new}

  context "Correct output 1" do
    it "Calculate total price output 1 product 1" do
      expect(main.send :calculate_total_price_one_product, 0).to eq 12.49
    end

    it "Calculate total price output 1 product 2" do
      expect(main.send :calculate_total_price_one_product, 1).to eq 16.49
    end

    it "Calculate total price output 1 product 3" do
      expect(main.send :calculate_total_price_one_product, 2).to eq 0.85
    end

    it "Calculate tax sales output 1" do
      main.instance_variable_set(:@choosed_product, [0, 1, 2])
      expect(main.send :calculate_total_tax).to eq 1.50
    end

    it "Calculate total price output 1" do
      main.instance_variable_set(:@choosed_product, [0, 1, 2])
      expect(main.send :calculate_total_price).to eq 29.83
    end
  end

  context "Correct output 2" do
    it "Calculate total price output 2 product 1" do
      expect(main.send :calculate_total_price_one_product, 3).to eq 10.50
    end

    it "Calculate total priceoutput 2 product 2" do
      expect(main.send :calculate_total_price_one_product, 4).to eq 54.65
    end

    it "Calculate tax sales output 2" do
      main.instance_variable_set(:@choosed_product, [3, 4])
      expect(main.send :calculate_total_tax).to eq 7.65
    end

    it "Calculate total price output 2" do
      main.instance_variable_set(:@choosed_product, [3, 4])
      expect(main.send :calculate_total_price).to eq 65.15
    end
  end

  context "Correct output 3" do
    it "Calculate total price output 3 product 1" do
      expect(main.send :calculate_total_price_one_product, 5).to eq 32.19
    end

    it "Calculate total price output 3 product 2" do
      expect(main.send :calculate_total_price_one_product, 6).to eq 20.89
    end

    it "Calculate total price output 3 product 3" do
      expect(main.send :calculate_total_price_one_product, 7).to eq 9.75
    end

    it "Calculate total price output 3 product 4" do
      expect(main.send :calculate_total_price_one_product, 8).to eq 11.85
    end

    it "Calculate tax sales output 3" do
      main.instance_variable_set(:@choosed_product, [5, 6, 7, 8])
      expect(main.send :calculate_total_tax).to eq 6.70
    end

    it "Calculate total price output 3" do
      main.instance_variable_set(:@choosed_product, [5, 6, 7, 8])
      expect(main.send :calculate_total_price).to eq 74.68
    end
  end
end
