# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/client_mailer/mailer
  def mailer
    ClientMailer.mailer
  end
end
