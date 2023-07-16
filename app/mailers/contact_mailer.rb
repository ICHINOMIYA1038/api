class ContactMailer < ApplicationMailer
    def send_contact_email(contact)
      @contact = contact
      mail(
        to: 'gekidankatakago@gmail.com',
        subject: 'お問い合わせがありました'
      )
    end

    def accept_contact_email(contact)
        @contact = contact
        mail(
          to:contact.email,
          subject: 'お問い合わせを受け付けました'
        )
    end
  end