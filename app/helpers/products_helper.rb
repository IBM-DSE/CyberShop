module ProductsHelper
  
  def price(product)
    content_tag :strong, style: 'font-size: 20px' do
      number_to_currency product.discount_price || product.price, unit: '€'
    end
  end
  
  def stock_status(in_stock)
    css_class = in_stock ? 'in-stock' : 'coming-soon'
    content_tag :p, class: css_class do
      in_stock ? 'In Stock' : 'Coming Soon!'
    end
  end
  
end
