pkill slapd

rm -r /etc/slapd.d
mkdir /etc/slapd.d

/usr/local/sbin/slapadd -n 0 -F /etc/slapd.d -l /etc/openldap/slapd.ldif

/usr/local/libexec/slapd -d 16 -F /etc/slapd.d
