module ProductsHelper
  
  def price(product)
    content_tag :strong, style: 'font-size: 20px' do
      format_price(product.discount_price || product.price)
    end
  end
  
  def stock_status(in_stock)
    css_class = in_stock ? 'in-stock' : 'coming-soon'
    content_tag :p, class: css_class do
      in_stock ? 'In Stock' : 'Coming Soon!'
    end
  end
  
  def format_price(price)
    number_to_currency price, unit: '€', separator: ',', delimiter: '.'
  end
  
end
