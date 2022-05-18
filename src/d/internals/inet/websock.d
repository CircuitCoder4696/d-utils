module d.internals.inet.websock;

private struct wsReqHeaderParser {
    import std.base64;
    import std.digest.sha;
    import std.string;
    public string Connection;
    public string Host;
    public string Upgrade;
    public string Origin;
    public string Sec_WebSocket_Key;
    public string Sec_WebSocket_Origin;
    public string Sec_WebSocket_Protocol;
    public string Sec_WebSocket_Version;
    public bool WebSocket_GetRequest;
    public this(string requestHeader) {
        string[] shd;
        foreach(subHeader; requestHeader.split("\n"))if(subHeader.indexOf(": ") !=-1) {
            shd= subHeader.split(": ");
            if(shd[0]=="Host")this.Host= shd[1];
            if(shd[0]=="Upgrade")this.Upgrade= shd[1];
            if(shd[0]=="Connection")this.Connection= shd[1];
            if(shd[0]=="Sec_WebSocket_Protocol")this.Sec_WebSocket_Protocol= shd[1];
            if(shd[0]=="Origin")this.Origin= shd[1];
            if(shd[0]=="Sec-WebSocket-Key")this.Sec_WebSocket_Key= shd[1];
            if(shd[0]=="Sec-WebSocket-Origin")this.Sec_WebSocket_Origin= shd[1];
            if(shd[0]=="Sec-WebSocket-Version")this.Sec_WebSocket_Version= shd[1];
        } else {
            if(subHeader=="GET /chat HTTP/1.1")this.WebSocket_GetRequest= true;
        };
    };
    public string Sec_WebSocket_Accept() @property {
        auto d_00= sha1Of(this.Sec_WebSocket_Key~"258EAFA5-E914-47DA-95CA-C5AB0DC85B11");
        auto result= cast(string) Base64.encode(d_00);
        return result;
    };
};

private struct wsResHeaderParser {
    import std.string;
    public string Upgrade;
    public string Connection;
    public string Sec_WebSocket_Accept;
    public string Sec_WebSocket_Protocol;
    public bool WebSocket_HTTPResponse;
    public this(string requestHeader) {
        string[] shd;
        foreach(subHeader; requestHeader.split("\n"))if(subHeader.indexOf(": ") !=-1) {
            shd= subHeader.split(": ");
            if(shd[0]=="Upgrade")this.Upgrade= shd[1];
            if(shd[0]=="Connection")this.Connection= shd[1];
            if(shd[0]=="Sec-WebSocket-Accept")this.Sec_WebSocket_Accept= shd[1];
            if(shd[0]=="Sec-WebSocket-Protocol")this.Sec_WebSocket_Protocol = shd[1];
        } else {
            if(subHeader=="HTTP/1.1 101 Switching Protocols")this.WebSocket_HTTPResponse= true;
        };
    };
};

public enum wsDataType : uint {
    ASCII,
    Binary,
    FinalASCII,
    FinalBinary,
};

version(Experimental) {
public class contentHeader {  //ToDo:   Add additional features.  
    public BitFeild!80 data;
    private void ascii() {
        this.data[4]++;
    };
    private void binary() {
        this.data[5]++;
    };
    private void final() {
        this.data[0]++;
        this.data.setUByte(0, this.data.getUByte(0)&0x0f);
    };
    private void setLength(ulong newLen) {
        assert(newLen <= 30000, "This library is currently expiremental.  Length is limited up to 30000.  ");
        int i0;
        if(newLen>125)i0++;
        if(newLen>65535)i0++;
        switch (i0) {
            case 1:
                this.data.setUShort(16, newLen);
                break;
            case 2:
                this.data.setULong(16, newLen);
                break;
            default:
                this.data.data[1]= cast(ubyte) newLen;
        };
    };
    public static void[10] generateBinaryDescription(wsDataType wsType, ubyte[] data) {
        contentHeader ch= new contentHeader();
        switch(wsType) {
            case wsDataType.ASCII:
                ch.ascii();
                break;
            case wsDataType.Binary:
                ch.binary();
                break;
        };
        return ch.data.data;
    };
};
};   //version:   Experimental

public class wsHeaderGenerator {
    public static string generateResponseHeader(string wsRequest) {
        wsReqHeaderParser req= wsReqHeaderParser(wsRequest);
        string result= "HTTP/1.1 101 Switching Protocols\nUpgrade: "~req.Upgrade~"\nConnection: "~req.Connection~"\nSec-WebSocket-Accept: "~req.Sec_WebSocket_Accept~"\n\n";
        return result;
    };
};
