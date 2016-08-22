class SiteMailer < ApplicationMailer

    default from: "webmaster@onlinecollector.co.za"

    def activation_email(site)
        @user = Site.user.first
        @url = site.subdomain + ".onlinecollector.co.za/activation"
        mail(to: @user.email, subject: "Activation request for " + site.subdomain + ".onlinecollector.co.za")
    end

end
