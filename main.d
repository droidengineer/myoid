module main;

import std.stdio;
import std.getopt;

import console;

immutable MYOID_VERSION="1.0.1";
immutable MYOID_BUILD=100000001;


void main(string[] args)
{
	bool bResolve = false, bANSI = false;
	int verbosity = 0;
	string oidstr;
	string dbtemplatename = "oid.db";
	string dbname = "unnamed.oid";
	bool bBeep, bHTML, bXML, bNoDefaults;
	string prompt, defaultsFileName, execStatement;
	enum OIDNotation { asn_1, dot, oid_iri, urn }
	enum OIDPacking { ber, xer, per, der}
	OIDPacking packing = OIDPacking.ber;
	OIDNotation notation = OIDNotation.dot;
	bool bJSON;

	auto helpInfo = getopt(args,
		"database|d", "Start with database", &dbname,
		"resolve|r", "Resolve OID to name", &bResolve,
		"version", "Show version and build info", &doVersion,
		"interactive|i", "Start an interactive session", &doInteractive,
		"verbose|v+", "Change verbosity levels", &verbosity,
		"ansi", "Use ANSI color codes", &bANSI,
		"oid", "Search on this OID", &oidstr,
		"no-beep|b", "Turn off beep on error", &bBeep,
		"html|H", "Produce HTML output", &bHTML,
		"xml|X", "Produce XML output", &bXML,
		"json|j", "Produce JSON output", &bJSON,
		"prompt", "Set myoid prompt", &prompt,
		"defaults-file", "Set custom defaults file", &defaultsFileName,
		"exec|e", "Executes SOILDQ statements", &execStatement,
		"no-defaults", "Consults no default file", &bNoDefaults,
		"notation|n", "Set resolve and output notation", &notation,
		);
	if (helpInfo.helpWanted) {
		defaultGetoptPrinter("This is what I know about:", helpInfo.options);
	}

//	doInteractive();
}

void doInteractive()
{
	banner();

	Console con = new Console(80,40);
	con.init();
	con.run();
}

void banner()
{
	writeln("myoid version ",MYOID_VERSION," OID Management Shell");
	writeln("Copyright 2013-2016 Convoluted Systems, LLC. All rights reserved.");
	writeln("100% OSI-approved open source goodness");
	writeln("");
}

void doVersion()
{
	writeln("myoid version ", MYOID_VERSION);
	writeln("Build: ", MYOID_BUILD);
}

