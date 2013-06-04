Relay
======

Super simple mail relay web service.

## Configuration

**Relay** relies on environment variables to provide it with SMTP host,
 port, username, password as well as an arbitrary token parameter:

- SMTP_HOST
- SMTP_PORT
- SMTP_USERNAME
- SMTP_PASSWORD
- RELAY_TOKEN

A *token* parameter must be sent it with requests which
*Relay* validates against the "RELAY_TOKEN" environment variable.

## Usage

| METHOD | URL   | PARAMS                                               | DESCRIPTION                                        |
| ------ | ---   | ------                                               | -----------                                        |
| POST   | /send | token, sender, recipients, subject, body             | Submits an email                                   |
| POST   | /send | token, sender, recipients, subject, body, body_plain | Submits an email with a plain alternative included |
| POST   | /send | token, sender, recipients, cc, subject, body         | Submits an email with a CC                         |

## Example Request/Response

```
curl -v -d
"token=test&sender=john@gmail.com&recipients=jane@gmail.com&subject=Test&body=Body"
localhost:5000/send
```

```
* About to connect() to localhost port 5000 (#0)
* *   Trying ::1... Connection refused
* *   Trying 127.0.0.1... connected
* * Connected to localhost (127.0.0.1) port 5000 (#0)
* > POST /send HTTP/1.1
* > User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4
  OpenSSL/0.9.8r zlib/1.2.5
> Host: localhost:5000
> Accept: */*
> Content-Length: 80
> Content-Type: application/x-www-form-urlencoded
>
< HTTP/1.1 200 OK
< Date: Mon, 03 Jun 2013 15:39:46 GMT
< Status: 200 OK
< Connection: close
< Content-Type: application/json
< Content-Length: 102
< X-Content-Type-Options: nosniff
<
* Closing connection #0
*
{"token":"test","sender":"john@gmail.com","recipients":"jane@gmail.com","subject":"Test","body":"Body"}
```

A successfully processed response will include the parameters you sent
in:

```json
{
  "token":"test",
  "sender":"john@gmail.com",
  "recipients":"jane@gmail.com",
  "subject":"Test",
  "body":"Body"
}
```

You can have multiple email addresses passed in for *recipients* as well
as *cc* params.

## Deployment
*Relay* is a Sinatra-based Ruby application that can easilily be hosted
 on a PaaS like Heoku. It was developed and testing on Ruby 1.9.3.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes with tests(`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

