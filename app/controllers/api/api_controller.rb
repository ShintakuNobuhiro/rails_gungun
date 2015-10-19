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
                @mission_ids.each do |mission_id|
                    #assigns = @user.assigns
                    assign = @user.assigns.find_by(mission_id: mission_id)
                    unless assign
                        error = {error:"404 Not Found",detail:"missions are not assigned with mission_ids=#{params[:mission_ids]}"}
                        render json: error and return
                    end
                end
                
                # 割り当ての達成状態をtrueに切り替える
                @assigns = @user.assigns
                @assigns.each do |assign|
                    assign.achievement = true
                    assign.save
                end

                # historyに達成データ書き込み
                
                # ユーザーのステータスを持ってくる 
                statuses = @user.statuses
                # mission_idsのループをまわす
                @mission_ids.each do |mission_id|
                    # ミッションの獲得を取り出す
                    acquisitions = Mission.find_by(id: mission_id).acquisitions
                    # 獲得ごとのループをまわす
                    acquisitions.each do |acquisition|
                        # ステータスの中から獲得のcategory_idと一致するものを取り出す
                        status = statuses.find_by(category_id: acquisition.category_id)
                        # 新しい経験値を計算 ← ステータスに入っている現在の経験値 + ミッションの経験値 
                        experience = status.experience + acquisition.experience
                        # ステータスの経験値をステータスの以前の経験値にコピー
                        status.recent_experience = status.experience
                        # 新しい経験値をステータスの経験値に書き込み
                        status.experience = experience
                        # ステータスをセーブする
                        status.save
                     end
                    # 総経験値を計算するためにステータスのループをまわす
                    total_experience = 0
                    statuses.each do |status|
                        total_experience += status.experience
                    end
                    # historyを作る ← mission_id, user_id, 総経験値
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
