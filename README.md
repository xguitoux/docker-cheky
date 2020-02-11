# docker-cheky

Added MySql dependencies in case you want to switch to MySql storage instead of file storage.

This a fork of menardorama/docker-cheky. It's just a more up to date version.

Dockerize version of **[Cheky](https://github.com/Blount/Cheky)**.



## Usage

### Basic usage

Simply run the docker image and expose the port 80:

```
$ docker run -d --name=cheky -p 80:80 xguitoux/docker-cheky:latest
```

### Persistent data

To persist **Cheky** configuration you can bind mount a docker volume to ``/var/www/html/var/``.

```
$ docker run -d --name=cheky -p 80:80 -v <host_cheky_data_dir>:/var/www/html/var/  xguitoux/docker-cheky:latest
```


### Notes

* This image use the **files** storage type.



## Environment Variables

Some **Cheky** settings can be customize with  environments variables.

### Application access

#### ``CHEKY_BASEURL``

Set the **Checky** base URL.

* Example : 

    ```
    CHEKY_BASEURL=http://cheky.example.com
    ```

* The default base URL is ``http://cheky.local``.


### Admin password

Set the ``admin`` password. 

* The default password is ``admin``.

The ``admin`` password can be set in plain test or with it SHA1 checksum.

#### ``CHEKY_ADMIN_PASSWORD``

Set the password in plain text.

#### ``CHEKY_ADMIN_PASSWORD_SHA1``

Set the password with it SHA1 checksum. 

To generate the SHA1 checksum you can use the ``sha1sum`` command.

  * For example for the plain text password ``test``:

```
$ echo -n "test" | sha1sum | cut -d" " -f1
a94a8fe5ccb19ba61c4c0873d391e987982fbbd3
```


### Mailer configuration

Configure the ``mailer`` for alerts.

#### ``CHEKY_CONFIG_MAILER``

Disable/enable the ``mailer`` configuration : ``0|1``

* The default value is ``0``.

#### ``CHEKY_MAILER_SMTP_HOST``

Set the SMTP hostname.

#### ``CHEKY_MAILER_SMTP_PORT``

Set the SMTP port.

#### ``CHEKY_MAILER_SMTP_USERNAME``

Set the SMTP username.

#### ``CHEKY_MAILER_SMTP_PASSWORD``

Set the SMTP password.

#### ``CHEKY_MAILER_SMTP_SECURE``

Set the SMTP connection security : ``<empty>|tls|ssl``

#### ``CHEKY_MAILER_FROM``

Set the sender email for **Cheky** alerts.

* SMTP configuration example:

	```
    CHEKY_MAILER_SMTP_HOST=smtp.mailgun.org
	CHEKY_MAILER_SMTP_PORT=587
	CHEKY_MAILER_SMTP_USERNAME=xxx
	CHEKY_MAILER_SMTP_PASSWORD="yyy"
	CHEKY_MAILER_SMTP_SECURE=tls
	CHEKY_MAILER_FROM=cheky@example.com
    ```


### Check cronjob

#### ``CHEKY_CRON_INTERVAL``

Set the cron interval for the **Cheky** [check cronjob](https://www.cheky.net/documentation/configuration-alerte-leboncoin-mail-sms).

* Example : 

    ```
    CHEKY_CRON_INTERVAL="*/5 * * * *"
    ```

* The default value is ``*/30 * * * *``.

## Docker-compose file example

### 3 services Cheky / Database (mysql) / Database browser (adminer)

```yaml
cheky:
    depends_on:
        - db
    image: xguitoux/docker-cheky
    user: root
    container_name: cheky
    restart: always
    environment:
        - 'CHEKY_BASEURL=http://yourcheky.url'
        - CHEKY_ADMIN_PASSWORD=myPassW0rd
        - CHEKY_ADMIN_PASSWORD_SHA1=fdsq161fds5q5fdsq1f9sdq1fsdq
        - CHEKY_CONFIG_MAILER=1
        - CHEKY_MAILER_SMTP_HOST=mail.gandi.net
        - CHEKY_MAILER_SMTP_PORT=587
        - CHEKY_MAILER_SMTP_USERNAME=checky@yourdomain.me
        - CHEKY_MAILER_SMTP_PASSWORD=myPassW0rd
        - CHEKY_MAILER_SMTP_SECURE=tls
        - CHEKY_MAILER_FROM=checky@yourdomain.me
    ports:
        - '7251:80'
    volumes:
        - '/home/media/cheky:/var/www/html/var/'
        - '/home/media/cheky/container_logs:/var/log/'
db:
    image: mysql
    container_name: mysql
    ports:
        - '6603:3306'
    command: '--default-authentication-plugin=mysql_native_password'
    restart: always
    environment:
        - MYSQL_ROOT_PASSWORD=myPassW0rd
adminer:
    image: adminer
    restart: always
    ports:
        - '7252:8080'
```
