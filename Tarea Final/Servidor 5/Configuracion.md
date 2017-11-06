

/etc/openldap/ldap.conf
```
BASE dc=infraestructura,dc=com,dc=uy

URI ldap://192.168.10.189
```

/etc/openldap/slapd.ldif
```
dn: cn=config
objectClass: olcGlobal
cn: config

olcArgsFile: /usr/local/var/run/slapd.args
olcPidFile: /usr/local/var/run/slapd.pid

dn: cn=schema,cn=config
objectClass: olcSchemaConfig
cn: schema

include: file:///etc/openldap/schema/core.ldif
include: file:///etc/openldap/schema/cosine.ldif
include: file:///etc/openldap/schema/inetorgperson.ldif
include: file:///etc/openldap/schema/nis.ldif

dn: olcDatabase=frontend,cn=config
objectClass: olcDatabaseConfig
objectClass: olcFrontendConfig
olcDatabase: frontend

dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
OlcDbMaxSize: 1073741824
olcSuffix: dc=infraestructura,dc=com,dc=uy
olcRootDN: cn=Manager,dc=infraestructura,dc=com,dc=uy
olcRootPW: secret
olcDbDirectory: /usr/local/var/openldap-data
olcDbIndex: objectClass eq
```

/etc/openldap/slapd.conf
```
dn: cn=config
objectClass: olcGlobal
cn: config

olcArgsFile: /usr/local/var/run/slapd.args
olcPidFile: /usr/local/var/run/slapd.pid

dn: cn=schema,cn=config
objectClass: olcSchemaConfig
cn: schema

include: file:///etc/openldap/schema/core.ldif
include: file:///etc/openldap/schema/cosine.ldif
include: file:///etc/openldap/schema/inetorgperson.ldif
include: file:///etc/openldap/schema/nis.ldif

dn: olcDatabase=frontend,cn=config
objectClass: olcDatabaseConfig
objectClass: olcFrontendConfig
olcDatabase: frontend

dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
OlcDbMaxSize: 1073741824
olcSuffix: dc=infraestructura,dc=com,dc=uy
olcRootDN: cn=Manager,dc=infraestructura,dc=com,dc=uy
olcRootPW: secret
olcDbDirectory: /usr/local/var/openldap-data
olcDbIndex: objectClass eq
```
