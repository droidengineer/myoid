module console;

import std.experimental.logger;
import std.file;
import std.stdio;
import std.string;

import cmd;

class Console
{
	struct Screen {
		static int width;
		static int height;
	}

	this(int w, int h, bool ansi=true)
	{
		Screen.width = w;
		Screen.height = h;
		_ansi = ansi;
	}

	@property string prompt() { return __prompt__; }

	void init()
	{
		log("Initializing console.");

	}

	void run()
	{
		string choice;
		writeln("Enter \".help\" for usage hints.");
		writeln("Connecting to a transient in-memory database.");
		writeln("Use \".open <DB>\" to open a persistent database.");
		do
		{
			write(__prompt__);
			choice = readln();
			choice = stripRight(choice);
			auto cmds = split(choice);
			if (cmds is null)
				continue;

			if (choice[0] is '.')
				processCommand(cmds);
			else
				processSQL(choice);

		} while(choice != ".exit" || choice != ".quit");
		log("Exiting console.");
	}

	private void processSQL(string stmt)
	{
		log("Processing ",stmt);

	}

	private void processCommand(string[] cmds)
	{
		switch(cmds[0])
		{
			case ".use":
				Command!".use".process(cmds);
				break;
			case ".help":
				//cmdproc!".help"();
				Command!(".help").process(null);
				break;
			case ".create":
				assert(cmds.length == 2);
				// TODO
				writefln("%s created", cmds[1]);
				Command!".create".process(cmds);
				break;
			case ".open":
				assert(cmds.length > 1);
				if (!exists(cmds[1])) {
					writefln("Couldn't find database: %s", cmds[1]);
					writefln("Did you want \".create <DB>\" instead?");
					return;
				}
				// TODO
				writef("Found %s. Testing integrity/validity...", cmds[1]);
				writeln("Good.");
				//Command!(".open",delegate {doOpen();});
				Command!(".open").process(cmds);
				break;
			case ".uuid":
				Command!(".uuid").process(cmds);
				break;
			case ".quit":
			case ".exit":
				import oid;
				auto newoid = new OID!"1.2.3.4"(1);
				writeln(newoid.print());
				//OID!"1.2.3.4.1"(1).print();
				Command!".exit".process(cmds);
				//cmdproc!".exit".parse(cmd);
				break;
			default:
				log("Unknown command or argument");
		} 
	}

	bool _ansi;
	static string __prompt__ = "myoid> ";
}

