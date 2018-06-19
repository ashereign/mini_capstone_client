class Client::CartedProductsController < ApplicationController

  def new
    render "new.html.erb"
  end


  def create
    carted_product_params = {
      product_id: params[:product_id],
      quantity: params[:quantity],
    }
    @carted_product = Unirest.post("http://localhost:3000/api/carted_products", parameters: carted_product_params).body
    render 'show.html.erb'
  end
end
