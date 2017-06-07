module ProductsHelper
  
  def stock_status(in_stock)
    css_class = in_stock ? 'in-stock' : 'coming-soon'
    content_tag :p, class: css_class do
      in_stock ? 'In Stock' : 'Coming Soon!'
    end
  end
  
end
