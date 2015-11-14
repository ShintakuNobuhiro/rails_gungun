class Api::ApiController < ApplicationController
    protect_from_forgery with: :null_session
    def users
        @user = User.find_by(card_number: params[:card_number])
        
        if @user
            if @user.authenticate(params[:password])
                @user
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
                # ミッションの存在確認
                @mission_ids = params[:mission_ids]
                unless @mission_ids
                    message ={ accepted:"200 OK",detail:"assigns cleared" }
                    render json: message and return
                end
                @mission_ids.each do |mission_id|
                    mission = Mission.find_by(id: mission_id)
                    unless mission
                        error = { error:"404 Not Found",detail:"missions not found with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                
                # ミッションの割当確認
                @mission_ids.each do |mission_id|
                    assign = @user.assigns.find_by(mission_id: mission_id)
                    unless assign
                        error = {error:"404 Not Found",detail:"missions are not assigned with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end

                # 直前の経験値を更新
                # NOTE: 達成を記録する単位ごとに直前の経験値が更新される
                statuses = @user.statuses
                statuses.each do |status|
                    status.recent_experience = status.experience
                    status.save
                end

                @mission_ids.each do |mission_id|
                    # ミッションを取得
                    mission = Mission.find(mission_id)
                    # 割当を取得
                    assign = @user.assigns.find_by(mission_id: mission.id)

                    # 未達成の割当の場合のみ
                    if assign && assign.achievement != true
                        # 割当を達成にする
                        assign.achievement = true
                        assign.save

                        # 未達成だったミッションの経験値だけを追加
                        mission.acquisitions.each do |acquisition|
                            status = statuses.find_by(category_id: acquisition.category_id)
                            status.experience += acquisition.experience
                            status.save
                        end
                    end
                    statuses = @user.statuses.reload

                    # 総経験値を計算
                    total_experience = 0
                    statuses.each do |status|
                        total_experience += status.experience
                    end

                    # 達成の記録
                    history = History.new(mission_id: mission_id, user_id: @user.id, experience: total_experience)
                    history.save!
                    
                    assign.destroy
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
    
    def levels
        user = User.find_by(card_number: params[:card_number])
        if user
            if user.authenticate(params[:password])
                @levels = Level.all
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
