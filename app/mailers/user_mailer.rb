class UserMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "support@mygreenspace.com"

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end

  def reset_password(user)
    template_name = 'forgot-password-email-template'
    template_content = []
    message = {
      to: [{email: user.email}],
      merge_vars: [
        rcpt: user.email,
        vars: [
          {name: 'TO_NAME', content: user.first_name},
          {name: 'RESET_LINK', content: edit_password_reset_url(user.reset_digest)},
          {name: 'FROM_EMAIL', content: 'kurilyaks@gmail.com'},
          {name: 'FROM_NAME', content: 'Slav'}
        ]
      ]
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end
end

