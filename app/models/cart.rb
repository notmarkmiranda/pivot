class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {requests: [], offers: []}
  end

  def mapped_values
    requests = contents[:requests].map do |id|
      CartItem.new(id.to_i)
    end
    offers = contents[:offers].map do |id|
      CartItem.new(id.to_i)
    end
    [requests, offers]
  end

  def add_item(item_id, obj)
    obj == LoanOffer ? contents[:offers] << item_id.to_s : contents[:requests] << item_id.to_s
  end

  def requests_count
    contents[:requests].count
  end

  def offers_count
    contents[:requests].count
  end

  def remove_item(item_id)
    contents.delete(item_id)
  end

  def total_price
    if contents.empty?
      return 0
    else
      mapped_values[0].map do |ci|
        ci.amount
      end.reduce(:+)
    end
  end
end
