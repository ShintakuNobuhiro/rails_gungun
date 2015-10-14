class Api::ApiController < ApplicationController
    
    def users
        
    end
    
    def categories
        @category = Category.find(params[:category_id])
    end
    
    def assigns
        
    end
    
    def histories
        
    end
end
