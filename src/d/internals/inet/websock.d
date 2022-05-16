module d.internals.inet.websock;

public struct wsReqHeaderParser {
    import std.string;
    public string Host;
    public string Upgrade;
    public string Connection;
    public string Sec_WebSocket_Key;
    public string Sec_WebSocket_Version;
    public bool WebSocket_GetRequest;
    public this(string requestHeader) {
        string[] shd;
        foreach(subHeader; requestHeader.split("\n"))if(subHeader.indexOf(": ") !=-1) {
            shd= subHeader.split(": ");
            if(shd[0]=="Host")this.Host= shd[1];
            if(shd[0]=="Upgrade")this.Upgrade= shd[1];
            if(shd[0]=="Connection")this.Connection= shd[1];
            if(shd[0]=="Sec-WebSocket-Key")this.Sec_WebSocket_Key= shd[1];
            if(shd[0]=="Sec-WebSocket-Version")this.Sec_WebSocket_Version= shd[1];
        } else {
            if(subHeader=="GET /chat HTTP/1.1")this.WebSocket_GetRequest= true;
        };
    };
};
