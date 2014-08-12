class ChargesController < ApplicationController
	def new
		@post = Post.find params[:post_id]
	end

	def create
		@post = Post.find params[:post_id]

	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => "Print of #{@post.title}",
	    :currency    => 'usd'
	  )

	  Order.create(user: current_user, post: @post)

	  flash[:notice] = 'Thanks for your payment'
	  redirect_to posts_path

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end
end
