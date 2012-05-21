require 'json'
class DeadropController < ApplicationController

  def index
    @drop = Drop.where(drop: params[:key]).first

    unless (@drop)
      render 'create_drop'
    else
      render 'index'
    end
  end

  def create_drop_from_form
    drop = Drop.new()
    drop['drop'] = params[:key]
    drop['data'] = params[:encrypted_object]
    drop.save!

    redirect_to URI.escape "/#{params[:key]}"
  end
end