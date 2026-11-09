# Lucee H2 JDBC Extension

H2 JDBC driver for Lucee. The extension ships the official `com.h2database:h2` jar from Maven Central, which is an OSGi bundle (`com.h2database`).

- Lucee 7.1+ loads the driver through the `maven` coordinates in the extension manifest (`com.h2database:h2`).
- Lucee 7.0 loads the OSGi bundle from the `jars` folder of the extension.
- The extension requires Lucee 7.0 or later.
- Driver line stays at **2.1.214** (same engine as the previous `org.lucee:h2:2.1.214.0001L` extension). H2 2.2+ / 2.3+ / 2.5 change the on-disk format relative to 2.1.x, so they are not used here.
- Bundle symbolic name changes from `org.lucee.h2` to the upstream `com.h2database`.

The version of the extension is the H2 version plus a build number (for example `2.1.214.1`).

## Build

```
mvn clean install
```

creates `target/h2-jdbc-extension-<version>.lex` and `target/h2-jdbc-extension-<version>.lite.lex` (without the `maven` folder).

## Issues

[H2 Issues on Jira](https://luceeserver.atlassian.net/issues/?jql=labels%20%3D%20%22h2%22)
