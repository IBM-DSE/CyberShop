class StatusController < ApplicationController
  def status
    @products = [
      { product_name: 'Pre-Order aPhone 8', customer_name: 'Matt' },
      { product_name: 'sPhone 8', customer_name: 'David' }
    ]
    @products.each do |product|
      
      deployment                = Product.find_by_name(product[:product_name]).deployment
      product[:deployment_guid] = deployment.guid
      product[:input_data] = deployment.input_data(Customer.find_by_name(product[:customer_name]))

      begin
        product[:output] = deployment.machine_learning_service.get_score deployment.guid, product[:input_data]
        product[:score] = Util.extract product[:output]
        product[:status] = 'green'
      rescue Exception => e
        STDERR.puts "#{e.class} : #{e.message}"
        STDERR.puts e.backtrace.select{ |l| l.start_with? Rails.root.to_s }[0]
        product[:output] = e
        product[:status] = 'failure'
      end
      
    end
  end
end
