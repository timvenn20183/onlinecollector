class SiteMailer < ApplicationMailer

    default from: Onlinecollector::Application.config.support_email

    def activation(site)
        @user = site.users.first
        @url = site.full_url + "/activation"
        mail(to: @user.email, subject: "Activation request for " + site.subdomain + "." + Onlinecollector::Application.config.domain)
    end

    def activation_confirmaion(site)
        @user = site.users.first
        @url = site.full_url
        mail(to: @user.email, subject: "Activation confirmation for " + site.subdomain + "." + Onlinecollector::Application.config.domain)
    end

end
