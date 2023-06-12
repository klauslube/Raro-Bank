class TransactionMailer < ApplicationMailer
  default from: email_address_with_name('noreply@rarobank.com', 'RaroBank')

  def token_confirmation(id)
    @mailer_token_notification = id
    mail(to: confirmation_sender_email, subject: "Confirme sua transferência para #{receiver_name.titleize}")
  end

  def transfer_notification(id)
    @mailer_notification = id
    mail(to: sender_email, subject: 'Nova transferência criada')
  end

  private

  def confirmation_sender_email
    @mailer_token_notification.sender.user.email
  end

  def sender_email
    @mailer_notification.sender.user.email
  end

  def receiver_name
    @mailer_token_notification.receiver.user.name
  end
end
