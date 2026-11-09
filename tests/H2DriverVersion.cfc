component extends="org.lucee.cfml.test.LuceeTestCase" labels="h2" {

	// keep in sync with pom.xml driverVersion
	variables.driverVersion = "2.1.214";
	variables.bundleName = "com.h2database";

	private boolean function luceeSupportsMavenJdbc() {
		try {
			return server.doesJDBCSupportMaven();
		} catch ( any e ) {
			return false;
		}
	}

	private struct function getDatasourceDefinition() {
		var ds = {
			class: "org.h2.Driver",
			connectionString: "jdbc:h2:mem:ldev6896;MODE=MySQL;DB_CLOSE_DELAY=-1"
		};

		// Lucee 7.1+ prefers the maven coordinates, older versions load the OSGi bundle shipped in the extension
		if ( luceeSupportsMavenJdbc() ) {
			ds.maven = "com.h2database:h2:#variables.driverVersion#";
		} else {
			ds.bundleName = variables.bundleName;
			ds.bundleVersion = variables.driverVersion;
		}
		return ds;
	}

	function run( testResults, testBox ) {
		describe( title="H2 JDBC extension", body=function() {

			it( title="provides H2 #variables.driverVersion#", body=function( currentSpec ) {
				var ds = getDatasourceDefinition();

				dbinfo datasource=ds name="local.dbVersion" type="version";

				systemOutput( "H2 JDBC driver info: " & serializeJSON( {
					luceeVersion: server.lucee.version,
					datasource: ds,
					driverName: dbVersion.driver_name,
					driverVersion: dbVersion.driver_version,
					databaseProduct: dbVersion.database_productname,
					databaseVersion: dbVersion.database_version
				} ), true );

				expect( dbVersion.recordCount ).toBe( 1 );
				expect( dbVersion.database_productname ).toInclude( "H2" );
				expect( dbVersion.driver_version ).toInclude( variables.driverVersion );
				expect( dbVersion.database_version ).toInclude( "2.1" );
			} );

			it( title="can create a table, insert and read rows", body=function( currentSpec ) {
				var ds = getDatasourceDefinition();

				query datasource=ds {
					echo( "CREATE TABLE ldev6896 ( id INT PRIMARY KEY, name VARCHAR(50) )" );
				}
				try {
					query datasource=ds {
						echo( "INSERT INTO ldev6896 ( id, name ) VALUES ( 1, 'lucee' ), ( 2, 'h2' )" );
					}
					query datasource=ds name="local.qry" {
						echo( "SELECT id, name FROM ldev6896 ORDER BY id" );
					}
					expect( qry.recordCount ).toBe( 2 );
					expect( qry.name[ 1 ] ).toBe( "lucee" );
					expect( qry.name[ 2 ] ).toBe( "h2" );
				}
				finally {
					query datasource=ds {
						echo( "DROP TABLE ldev6896" );
					}
				}
			} );

		} );
	}

}
