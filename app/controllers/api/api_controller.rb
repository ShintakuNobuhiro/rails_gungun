class Api::ApiController < ApplicationController
    protect_from_forgery with: :null_session
    def users
        
    end
    
    def categories
        user = User.find_by(card_number: params[:card_number])
        if user && user.authenticate(params[:password])
            @category = Category.find(params[:category_id])
        else
            error = { error:"404 Not Found",detail:"user not found with card_number=#{params[:card_number]}" }
            render json: error
        end
    end
    
    def assigns
        
    end
    
    def histories
        
    end
end
