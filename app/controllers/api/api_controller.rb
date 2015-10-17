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
                @mission_ids = params[:mission_ids]
                @mission_ids.each do |mission_id|
                    mission = Mission.find_by(id: mission_id)
                    unless mission
                        error = { error:"404 Not Found",detail:"missions not found with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                @user.assigns.destroy_all
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
        @user = User.find_by(card_number: params[:card_number])
        
        if @user
            if @user.authenticate(params[:password])
                # 指定されたミッションがあるかチェック
                @mission_ids = params[:mission_ids]
                @mission_ids.each do |mission_id|
                    mission = Mission.find_by(id: mission_id)
                    unless mission
                        error = { error:"404 Not Found",detail:"missions not found with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                
                # そのミッションが割り当てられているかチェック
                @assign = @user.assigns
                @assign.each do |assign_id|
                    assign = Assign.find_by(id: assign_id)
                    unless assign
                        error = { error:"404 Not Found",detail:"missions are not assigned with mission_ids=#{params[:mission_ids]}"}
                        render json: error 
                    end
                end
                
                # 割り当ての達成状態をtrueに切り替える
                @assign.achievement = true
                # historyに達成データ書き込み
                history = History.new
                history.experience += acquisition.experience
                
                history.save
                
                # ユーザーの経験値増加
                
                error = { error:"404 Not Found",detail:"invalid password" }
                render json: error
            end
        else 
            error = { error:"404 Not Found",detail:"user not found with card_number=#{params[:card_number]}" }
            render json: error
        end
    end
end
