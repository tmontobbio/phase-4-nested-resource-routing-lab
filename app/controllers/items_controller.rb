class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error

  def error  
    render status: :not_found
  end

# GET /users/:user_id/items
  def index
    # if params hash contains (user_id) (we put the id in the url so user_id = whatever id we put)
    if params[:user_id]
      # find the user with the matching id
      user = User.find(params[:user_id])
      # render that users items (that also contain that user's id)
      render json: user.items, status: :ok
    else
      # otherwise work as /items index and show all
      render json: Item.all, include: :user, status: :ok
    end
  end


# GET /users/:user_id/items/:id
  def show
    if params[:user_id]
      items = User.find(params[:user_id]).items.find(params[:id])
      render json: items, status: :ok
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

end
