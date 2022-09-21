#include <std/sys.pat>
#include <std/mem.pat>
#include <std/core.pat>
#include <type/time.pat>

struct Data {
    char data[parent.files[std::core::array_index()].size];
};

struct GMAFile {
    u32 id;
    if(id == 0) break;
    else {
        char name[];
        u64 size;
        u32 crc32;
    }
};

struct Info {
    char title[];
	char description[];
	char author[];
};

struct GMA {
    char magic[4] [[hidden]];
    u8 version [[hidden]];
    
    std::assert(magic == "GMAD", "The file is not a gma");
    std::assert(version == 3, "Invalid version");
    
    u64 steamid;
    type::time64_t timestamp;
    
    u8 required_content; // unsure about this one, gmad just writes 0
    
	Info info;
    
    u32 addon_version;
    
    GMAFile files[while(true)];
    std::assert(files[std::core::member_count(files) - 1].id == 0, "Bad file array");
    
    Data filesData[std::core::member_count(files) - 1];
    
    if(sizeof($) - $ >= 4) // some seem to omit this
    	u32 crc32;
};

GMA gma @ 0;