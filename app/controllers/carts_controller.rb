class CartsController < ApplicationController

  before_action :sock_setter

  def index
    if current_user_session
      @cart = current_user.cart
    elsif session['cart_id']
      @cart = Cart.find(session['cart_id'])
    else
      @cart = Cart.new
      @cart.name = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{SecureRandom.hex}"
      @cart.save!
      session['cart_id'] = @cart.id
    end
    @items = @cart.items
  end

  def show
    @cart = Cart.friendly.find(params[:id])
    @items = @cart.items
    render 'index'
  end

  def create
    @cart = Cart.new()
    @cart.name = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{SecureRandom.hex}"
    if current_user_session
      @cart.user = current_user
    end
    @cart.save!
  end

  def destroy
    @cart = Cart.find(params['id'])
    @cart.destroy
    #CartMailer.receipt_email(cart).deliver_now
  end

  private


  def sock_setter
    @sock = Sock.new
  end

end
