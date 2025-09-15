component extends="types.Driver" output="no" implements="types.IDatasource" {

	fields=array(
		field("path","path","",true,"Path where the database is or should be located (only Filesystem, virtual Resources like ""ram"" not supported)"),
		field("mode","mode","MySQL,PostgreSQL,HSQLDB",true,"All database engines behave a little bit different. For certain features, this database can emulate the behavior of specific databases. Not all features or differences of those databases are implemented. Currently, this feature is mainly used for randomized comparative testing","radio")
	);
	
	SLASH=struct(
		'/':'\',
		'\':'/'
	);
	
	this.className="{class-name}";
	this.bundleName="{bundle-name}";
	this.dsn="{connString}";

	/**
	* returns display name of the driver
	*/
	public string function getName() {
		return "{label}";
	}

	/**
	* returns the id of the driver
	*/
	public string function getId() {
		return "{id}";
	}

	/**
	* returns the description of the driver
	*/
	public string function getDescription() {
		return "{description}";
	}

	/**
	* returns array of fields
	*/
	public array function getFields() {
		return fields;
	}

	public boolean function literalTimestampWithTSOffset() {
		return false;
	}

	public boolean function alwaysSetTimeout() {
		return true;
	}
}