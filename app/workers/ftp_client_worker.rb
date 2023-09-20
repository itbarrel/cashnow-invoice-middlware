# frozen_string_literal: true

class FtpClientWorker
  include Sidekiq::Worker

  def perform(client_id)
    client = Client.find_by_id(client_id)
    connection = FtpClient.new.connection(client)
    return unless connection.present?

    f = connection.nlst('*.txt')
    f.each do |x|
      connection.gettextfile(x, "#{Rails.root}/ftp_files/#{x}")
    end
    connection.close
    ClientMailer.mailer(client).deliver if connection.closed?
  end
end
