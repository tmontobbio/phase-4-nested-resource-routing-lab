class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error

# GET /users/:user_id/items
  def index
    # if params hash contains (user_id) (we put the id in the url so user_id = whatever id we put)
    if params[:user_id]
      # find the user with the matching id
      items = User.find(params[:user_id]).items
      # render that users items (that also contain that user's id)
      render json: items, status: :ok
    else
      # otherwise work as /items index and show all
      render json: Item.all, include: :user, status: :ok
    end
  end


# GET /users/:user_id/items/:id
  def show
    if params[:user_id]
      # self.items.find(params[:id])
      item = User.find(params[:user_id]).items.find(params[:id])
      render json: item, status: :ok
    else
      render json: Item.find(params[:id]), status: :ok
    end
  end

# POST /users/:user_id/items
  def create
    new_item = Item.create(item_params)
    render json: new_item, status: :created
  end

  private 

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def error  
    render status: :not_found
  end
end
