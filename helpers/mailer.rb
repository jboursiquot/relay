class Mailer

  def self.send sender, recipient, subject, body, body_plain

    Pony.mail({
      from: sender,
      to: recipient,
      subject: subject,
      html_body: body,
      body: body_plain
    })
  end

end
