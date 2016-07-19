module cmd;

import std.stdio;
import std.experimental.logger;
import std.file;

//template Command(alias cmd, alias func)
//use: Command!".create".process(cmds);
//  Command!".open".process([".open","oid.db"]);
template Command(string cmd)
{
	string _usedb;
	@property string using() { return _usedb; }

	void process(string[] cmdstr) {
		switch(cmd)
		{
			case ".help":
				doHelp();
				break;
			case ".open":
				doOpen(cmdstr);
				break;
			case ".create":
				doCreate(cmdstr);
				break;
			case ".uuid":
				doUUID();
				break;
			case ".use":
				if (doUse(cmdstr))
					_usedb = cmdstr[1];
				break;
			case ".source":
				doSource(cmdstr);
				break;
			case ".system":
			case ".exec":
				doSystem(cmdstr);
				break;
			case ".status":
				doStatus();
				break;
			case ".exit":
			case ".quit":
				log(cmd);
				break;
			default:
				break;
		}
	}
}


void doSource(string[] cmds)
{

}

/*
enum cmdproc(string cmd) = delegate {
	switch(cmd)
	{
		case ".help":
			doHelp();
			break;
		case ".open":
			doOpen(cmds);
			break;
		case ".create":
			doCreate(cmd);
		case ".uuid":
			doUUID();
			break;
		case ".use":
			doUse(cmds);
			break;
		case ".system":
			doSystem(cmds);
			break;
		case ".status":
			doStatus();
			break;
		default:
			break;
	}
	log("cmdproc: ",cmd);
};
*/

public void doOpen(string[] cmdstr)
{
	import std.file;

	log("doOpen(",cmdstr,")");
	if (cmdstr.length <= 1) {
		writeln("Wrong number of arguments.");
		return;
	}
	if (!exists(cmdstr[1])) {
		writefln("Couldn't find OID database: %s", cmdstr[1]);
		writeln("Did you want \".create <db>\" instead?");
		return;
	}
	writef("Found %s. Testing integrity/validity...",cmdstr[1]);
	//TODO
	writeln("Good.");

}
public void doHelp()
{
	writeln("Help for myoid console:");
	writeln("Note that all shell commands begin with \'.\'");
	writefln("%10s %-50s",".create <db>","Creates new OID database");
	writefln("%10s %-50s",".help","Shows this helpful screen");
	writefln("%10s %-50s",".open <db>","Open OID database <db>");
	writefln("%10s %50s", ".use <db>", "Switch to using new schema");
	writefln("%10s %50s",".uuid","Generate a spacio-temporally unique ID");
	writefln("%10s %50s",".exit/.quit","Quit and leave the myoid console");
}
void doSystem(string[] cmdstr)
{
	log(cmdstr);

}
void doStatus()
{

}
bool doUse(string[] cmdstr)
{
	info();
	if (cmdstr.length == 2 && exists(cmdstr[1])) {
		//TODO

		return true;
	} else {
		writeln("Bad args or filename does not exist.");
	}
	return false;
}
void doUUID()
{
	import std.uuid;
	writeln(randomUUID().toString());
}
void doCreate(string[] cmdstr)
{
	info();
	if (cmdstr.length == 2 && !exists(cmdstr[1])) {
		//TODO
	} else {
		writeln("There was a problem with the cmd args");
	}
}

//mixin Command!(".open", delegate { doOpen(); });