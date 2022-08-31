module CartsHelper
  def current_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def load_products_in_cart
    @products = Product.get_by_ids @cart.keys
  end

  def cart_total
    @sum = @products.reduce(0) do |sum, item|
      sum + (item.price * @cart[item.id.to_s].to_i)
    end
  end

  def sub_total id
    item = Product.find_by id: id
    item.price * @cart[item.id.to_s].to_i
  end

  def items_count
    current_cart.values.sum
  end

  def qty item
    @cart[item.id.to_s]
  end

  def clear_cart
    session[:cart] = {}
  end

  def add_products_to_cart product_ids
    product_ids.each do |id|
      if @cart.key? id.to_s
        @cart[id.to_s] += 1
      else
        @cart[id.to_s] = 1
      end
    end
  end
end
