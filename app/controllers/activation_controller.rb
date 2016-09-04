class ActivationController < ApplicationController

    def index
        render :template => 'activation/already_activated' if current_site.activationkey == nil
        proposed_key = params[:activationkey]
        render :template => 'activation/invalid_activation' if current_site.activationkey != proposed_key
        if current_site.activationkey == proposed_key then
            render :template => 'activation/activated' if current_site.update_attribute(:activationkey , nil)
            render :template => 'activation/activation_failed'
        end
    end

end
