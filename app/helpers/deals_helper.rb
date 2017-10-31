module DealsHelper
  def render_description(description)
    description.gsub(/€/, t('currency')).html_safe
  end
end
