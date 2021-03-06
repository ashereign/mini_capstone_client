class Client::ProductsController < ApplicationController


def index
client_params = {
  search: params[:search],
  price_sort: params[:price_sort],
  category: params[:category]
}

  @products = Unirest.get("http://localhost:3000/api/products", parameters: client_params).body
  render "index.html.erb"
end

  def show
     
     response = Unirest.get("http://localhost:3000/api/products/#{params[:id]}")
     @product = response.body
     render "show.html.erb"
  end

  def new

    render 'new.html.erb'
    
  end

  def create
    product_params = {
      name: params[:name],
      price: params[:price],
      supplier_id: params[:supplier_id],
      description: params[:description]
    }

    product = Unirest.post("http://localhost:3000/api/products", parameters: product_params).body
    # render 'create.html.erb'
    #flash needs to happen before redirect
    flash[:success] = "Product created successfully!"

    redirect_to "/client/products/#{product['id']}"
    # redirect are always get requests

end

def edit
 response = Unirest.get("http://localhost:3000/api/products/#{params[:id]}")
@product = response.body
render 'edit.html.erb'  
end

def update
product_params = {
      name: params[:name],
      price: params[:price],
      supplier_id: params[:supplier_id],
      description: params[:description]
    }

    product = Unirest.patch("http://localhost:3000/api/products/#{params[:id]}", parameters: product_params).body
    flash[:win] = "Product updated successfully!"
  redirect_to "/client/products/#{product['id']}"
  end

  def destroy
    product_id = params[:id] 
    response = Unirest.delete("http://localhost:3000/api/products/#{product_id}").body
    # render 'destroy.html.erb'
    flash[:danger] = "Product destroyed successfully!"
    redirect_to "/client/products"
  end

end
