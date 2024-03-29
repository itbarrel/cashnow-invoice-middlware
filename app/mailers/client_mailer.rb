# frozen_string_literal: true

class ClientMailer < ApplicationMailer
  def mailer(client)
    mail to: client.notify_email
  end
end
