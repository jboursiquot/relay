class Mailer

  def self.send sender, recipient, cc, subject, body, body_plain

    Pony.mail({
      from: sender,
      to: recipient,
      cc: cc,
      subject: subject,
      html_body: body,
      body: body_plain
    })
  end

end
