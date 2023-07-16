class ContactsController < ApplicationController
    def create
        contact = Contact.new(contact_params)
        contact.save
    
        if contact.valid?
          ContactMailer.send_contact_email(contact).deliver_now
          ContactMailer.accept_contact_email(contact).deliver_now
          render json: { success: true, message: 'お問い合わせが送信されました。' }
        else
          render json: { success: false, errors: contact.errors.full_messages }
        end
      end
    
      private
    
      def contact_params
        params.require(:contact).permit(:name, :email, :message)
      end


end
