module oid;

import std.uuid;
import std.datetime;

version(X86_64)
{
    alias ulong oid_id_t;   //object ID
    alias ulong iid_id_t;   //interface ID
    alias ulong reg_id_t;
} else {
    alias uint oid_id_t;
    alias uint iid_id_t;
    alias uint reg_id_t;
}

struct RegAuthority
{
    reg_id_t id;
    string name;
    string desc;
    string email;
    string contact;
    string tag;
	SysTime created;
    UUID uuid;
    
//    static this()
//    {
//		this.id = _incr();
//        this.uuid = randomUUID();
//		this.created = Clock.currTime();
//    }
//    this(string n, string t)
//    {
//        name = n;
//        tag = t;
//		uuid = randomUUID();
//		created = Clock.currTime();
//    }
}
//RegAuthority[string] registeredAuthories;
//RecordSid = {SID, NSD}
//RegAuthority defaultAuth = new RegAuthority(0,"default","default");

class OID(string path)
{
public:
//    static this()
//    {
//        //if (_registeredAuthorities is null)
//		//	_registeredAuthorities = new RegAuthority[string]();
//		_uuid = randomUUID();
//		_created = Clock.currTime();
//		_auth = defaultAuth;
//    }
    this(oid_id_t i) {
        _path = path;
        _id = i;
		_uuid = randomUUID();
		_created = Clock.currTime();
		//_auth = _registeredAuthorities["default"];
    }

	string print() {
		import std.conv;
		return(_path~"."~to!string(_id)~" : "~_uuid.toString());
	}

    //static OID
	@property oid_id_t id() { return _id; }
	@property string uuid() { return _uuid.toString(); }
	@property string path() { return _path; }
//	@property string canon() { return (_path~"."~to!string(_id)); }

private:
    string _path;
    oid_id_t    _id;
	SysTime _created;
	UUID _uuid;
    RegAuthority * _auth = null;
    static RegAuthority[string] _registeredAuthorities;
}