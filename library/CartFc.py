
class CartFc():
  def get_total_price_product_in_cart(self, products):
    total = 0
    for item in products:
      total += item['total']
    return total

  def compare_two_products(self, list_products_one, list_products_two):
    is_check = True
    for i in list_products_one:
      if i not in list_products_two:
        is_check = False
    return is_check

  def update_info_products(self, products, product_item, type_evt):
    if type_evt == 'update':
      for index, item in enumerate(products):
        if item['name']==product_item['name']:
          products[index] = product_item

    elif type_evt == 'delete':
      for index, item in enumerate(products):
        if item['name']==product_item['name']:
          del products[index]
    return  products
