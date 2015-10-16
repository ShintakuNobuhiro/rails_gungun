class Api::ApiController < ApplicationController
    protect_from_forgery with: :null_session
    def users
        
    end
    
    def categories
        user = User.find_by(card_number: params[:card_number])
        
        if user
            if user.authenticate(params[:password])
                @category = Category.find_by(id: params[:category_id])
                unless @category
                    error = { error:"404 Not Found",detail:"category not found with category_id=#{params[:category_id]}" }
                    render json: error
                end
            else 
                error = { error:"404 Not Found",detail:"invalid password" }
                render json: error
            end
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
