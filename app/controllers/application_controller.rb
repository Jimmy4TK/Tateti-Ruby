class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def render_errors_response(model)
        messages=[]
        if model.errors.full_messages.length>1
            model.errors.full_messages.each_with_index do |error,i|
                messages.push({path:i,message:error})
            end
            render status:400, json:{ error: messages }
        else
            render status:400, json:{ error: model.errors.full_messages[0] }
        end
    end
end
