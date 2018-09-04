INSERT INTO groupapp(name) VALUES('user')
INSERT INTO groupapp(name) VALUES('admin')

INSERT INTO groupapp_roles(groupapp_name, roles) VALUES('user', 'BASIC')
INSERT INTO groupapp_roles(groupapp_name, roles) VALUES('admin', 'BASIC')
INSERT INTO groupapp_roles(groupapp_name, roles) VALUES('admin', 'ADVANCED')

INSERT INTO userapp(username, password, groupapp_name) VALUES('demo', 'PBKDF2WithHmacSHA512:3072:YKK12OQLbn99tCui7SKENoBDeJrmo8z6O6U+/T/vfyaUGU5S+JYPTEkyHd2ikdD5AnvA5YQEMMXzFQpd+2siyw==:Ql5wAzGY0+A1xYLQmTbV6zd3JfqxN+rKrltjd+iYOPQ=', 'user')
INSERT INTO userapp(username, password, groupapp_name) VALUES('maina', 'PBKDF2WithHmacSHA512:3072:owNrEJUGw+uovdxSSpbEGzjmVCieD8cLsWylnEiHnHTdiQaTCPKH68MV+VfZCAvr9Mlg4yNZarkx5cn3SkY6UQ==:XP0xQRlSQaX0akrpklZwKzZl2QWDIMI3KY478c6R7Qg=', 'admin')
