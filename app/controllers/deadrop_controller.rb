require 'json'
class DeadropController < ApplicationController

  def index
    @drop = Drop.where(drop: params[:key]).first

    unless (@drop)
      render "create_drop"
    else
      render 'index'
    end
  end

  def index_blank
    redirect_to "/deadrop/#{(0..5).map { rand(36).to_s(36) }.join}"
  end

  def create_drop_from_form
    drop = Drop.new()
    drop['drop'] = params[:key]
    drop['data'] = params[:encrypted_object]
    drop['create_time'] = Time.now
    drop.save!

    redirect_to action: 'index'
  end

end