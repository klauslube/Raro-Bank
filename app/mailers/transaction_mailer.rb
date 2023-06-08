class TransactionMailer < ApplicationMailer
  default from: email_address_with_name('noreply@rarobank.com', 'RaroBank')

  def notify(notify_new_transfer)
    @mailer_transaction = notify_new_transfer
    mail(
      to: sender_email,
      subject: 'Nova transferência criada'
    )
  end

  private

  def sender_email
    @mailer_transaction.sender.user.email
  end

  def token_generator
    # Todo token.key
  end
end
