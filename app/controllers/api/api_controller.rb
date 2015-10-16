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
        @user = User.find_by(card_number: params[:card_number])
        
        if @user
            if @user.authenticate(params[:password])
                # 指定されたミッションの存在を確認
                @mission_ids = params[:mission_ids]
                @mission_ids.each do |mission_id|
                    mission = Mission.find_by(id: mission_id)
                    unless mission
                        error = { error:"404 Not Found",detail:"missions not found with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                #ユーザーの割り当てをすべて取得し、削除
                @user.assigns.destroy_all
                #指定されたユーザーとミッションの割り当てを作る
                @mission_ids.each do |mission_id|
                    @user.assigns.create(mission_id: mission_id)
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
    
    def histories
        
    end
end
