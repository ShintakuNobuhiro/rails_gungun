class Api::ApiController < ApplicationController
    protect_from_forgery with: :null_session
    def users
        user = User.find_by(card_number: params[:card_number])
        
        if user
            if user.authenticate(params[:password])
                
            else
                error = { error:"404 Not Found",detail:"invalid password" }
                render json: error
            end
        else
            error = { error:"404 Not Found",detail:"user not found with card_number=#{params[:card_number]}" }
            render json: error
        end
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
                @mission_ids = params[:mission_ids]
                @mission_ids.each do |mission_id|
                    mission = Mission.find_by(id: mission_id)
                    unless mission
                        error = { error:"404 Not Found",detail:"missions not found with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                
                @mission_ids.each do |mission_id|
                    assign = @user.assigns.find_by(mission_id: mission_id)
                    unless assign
                        error = {error:"404 Not Found",detail:"missions are not assigned with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                @assigns = @user.assigns
                @assigns.each do |assign|
                    assign.achievement = true
                    assign.save
                end
                statuses = @user.statuses
                @mission_ids.each do |mission_id|
                    acquisitions = Mission.find_by(id: mission_id).acquisitions
                    acquisitions.each do |acquisition|
                        status = statuses.find_by(category_id: acquisition.category_id)
                        experience = status.experience + acquisition.experience
                        status.recent_experience = status.experience
                        status.experience = experience
                        status.save
                    end
                    total_experience = 0
                    statuses.each do |status|
                        total_experience += status.experience
                    end
                    history = History.new(mission_id: mission_id, user_id: @user_id, experience: total_experience)
                    history.save
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
end
