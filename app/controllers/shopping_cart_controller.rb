class ShoppingCartController < ApplicationController
	skip_before_action :verify_authenticity_token

	@@user = User.first_or_create(name: 'Tester')
	@@cart = Cart.first_or_create(user_id: @@user.id)

	# - Get the details of a cart
	def index
		line_items = LineItem.where(cart_id: @@cart.id).all

		render json: line_items
	end

	# - Create and persist a shopping cart
	def new
		render json: @@cart
	end

	# - Add products to a shopping cart
	def create
		product = Product.find_by_id(params[:product_id])
		error_msg = 'Check params, this product don\'t exist or quantity is 0!'

		if product.nil? || params[:quantity].to_i < 1
			render :json => { :errors => error_msg} 
		else
			sum_price = params[:quantity].to_i * product.price.to_i
			line_item = LineItem.create(product_id: product.id,
				cart_id: @@cart.id,
				quantity: params[:quantity],
				price: sum_price)

			render json: line_item
		end
	end

	# - Remove products from a shopping cart
	def update
		product = Product.find_by_id(params[:product_id])
		error_msg = 'Check params, this product don\'t exist or quantity is 0!'

		if product.nil? || params[:quantity].to_i < 1
			render :json => { :errors => error_msg} 
		else
			line_item = LineItem.where(product_id: product.id).first
			quantity_result = line_item.quantity - params[:quantity].to_i
			sum_price = params[:quantity].to_i * product.price.to_i

			if quantity_result > 0
				line_item.quantity = quantity_result
				line_item.price = line_item.price - sum_price
				line_item.save

				render json: line_item
			else
				line_item.delete

				respond_to do |format|
				format.json { head :no_content }
				end
			end
		end
	end

	# - Empty a shopping cart
	def destroy
		LineItem.where(cart_id: @@cart.id).delete_all

		respond_to do |format|
		# format.html { redirect_to @cart }
		format.json { head :no_content }
		end
	end

# - Create and persist a shopping cart
# - Add products to a shopping cart
# - Remove products from a shopping cart
# - Empty a shopping cart
# - Get the details of a cart

end
