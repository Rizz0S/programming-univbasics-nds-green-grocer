def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  index = 0
  while index < collection.size do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  nil
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  updated_cart = []
  i = 0

  while i < cart.size do
    item = cart[i][:item]
    if find_item_by_name_in_collection(item, updated_cart)
      k = 0
      while k < updated_cart.size do
        if updated_cart[k][:item] == item
          updated_cart[k][:count] += 1
          break
        else
        k += 1
        end
      end
    else
      updated_cart << cart[i]
      updated_cart[-1][:count] = 1
    end
    i += 1
  end
  updated_cart

end

def find_index(item, collection)
  index = 0
  while index < collection.size do
    if collection[index][:item] == item
      return index
    end
    index += 1
  end
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  if coupons.size == 0
    return cart
  else
    index = 0
    while index < coupons.length do
      coupon_amt = coupons[index][:num]
      coupon_cost = (coupons[index][:cost] / coupon_amt)
      coupon_item = coupons[index][:item]

      if find_item_by_name_in_collection(coupon_item, cart)
         item_index = find_index(coupon_item, cart)
         if cart[item_index][:count] >= coupon_amt
            cart << {:item => (coupon_item + " W/COUPON"), :price => coupon_cost, :clearance => cart[item_index][:clearance], :count => coupon_amt}
            cart[item_index][:count] -= coupon_amt
          end
      end
      index += 1
    end
  end
  cart
end



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.size do
    current_price = cart[index][:price]
    if cart[index][:clearance]
      new_price  = current_price - (current_price * 0.2).round(2)
      cart[index][:price] = new_price
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customer
  discount = 0.10

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)


  cart = apply_clearance(cart)
  total = 0
  index = 0

  while index < cart.size do
    item_num = cart[index][:count]
    if item_num > 1
      total  += (item_num  * cart[index][:price])
    elsif item_num == 1
      total += cart[index][:price]
    end
    index += 1
  end

  if total > 100
    total = (total - (total * discount)).round(2)
  end

  total
end
