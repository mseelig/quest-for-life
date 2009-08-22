class RationalOptionsController < ApplicationController
  before_filter :authenticate, :verify_admin

  make_resourceful do
    actions :all
    
    response_for :create, :update, :destroy do |format|
      format.html { redirect_to rational_options_path }
    end
    
  end  
  
end
