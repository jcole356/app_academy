require 'rspec'
require 'array' #Think this should be ok

describe "#my_uniq" do

  subject(:array) { [2,3,3,3,4,6,6] }

  it "returns a new array with no duplicated elements" do
    expect(array.my_uniq).to eq([2,3,4,6])
  end
end

describe "#two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }
  it "finds indices whose elements sum to zero" do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe "#my_transpose" do
  subject(:matrix) { [
                      [0, 1, 2],
                      [3, 4, 5],
                      [6, 7, 8]
                    ]}

  it "converts between row and column oriented representatons of matrices" do
    expect(matrix.my_transpose).to eq( [[0, 3, 6],
                                        [1, 4, 7],
                                        [2, 5, 8]])
  end
end

describe "stock_picker" do
  subject(:stock_prices) { [36, 42, 20, -1, 75] }

  it "finds the best pair of indices on which to buy and sell the stock" do
    expect(stock_picker(stock_prices)).to eq([3, 4])
  end
end
