class AdminMailer < ApplicationMailer
  default from: 'receipt@app.klus-snel.nl'
 
  def receipt_email
    # @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: 'info@klus-snel.nl', subject: 'Nieuwe bon geupload')
  end
 
  def registration_email
    # @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: 'info@klus-snel.nl', subject: 'Nieuwe registratie')
  end
end
