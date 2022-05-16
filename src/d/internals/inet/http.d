module d.internals.inet.http;

private struct httpReqParser {
    import std.base64;
    import std.digest.sha;
    import std.string;
    public string Accept;
    public string Accept_Encoding;
    public string Accept_Language;
    public string Cache_Control;
    public string Connection;
    public string Host;
    public bool HTTP_GetRequest;
    public string If_Modified_Since;
    public string If_None_Match;
    public string Referer;
    public string Upgrade_Insecure_Requests;
    public string User_Agent;
    public this(string requestHeader) {
        string[] shd;
        foreach(subHeader; requestHeader.split("\n"))if(subHeader.indexOf(": ") !=-1) {
            shd= subHeader.split(": ");
            if(shd[0]=="Accept")this.Accept= shd[1];
            if(shd[0]=="Accept-Encoding")this.Accept_Encoding= shd[1];
            if(shd[0]=="Accept-Language")this.Accept_Language= shd[1];
            if(shd[0]=="Cache-Control")this.Cache_Control= shd[1];
            if(shd[0]=="Connection")this.Connection= shd[1];
            if(shd[0]=="Host")this.Host= shd[1];
            if(shd[0]=="If-Modified-Since")this.If_Modified_Since= shd[1];
            if(shd[0]=="If-None-Match")this.If_None_Match= shd[1];
            if(shd[0]=="Referer")this.Referer= shd[1];
            if(shd[0]=="Upgrade-Insecure_Requests")this.Upgrade_Insecure_Requests= shd[1];
            if(shd[0]=="User-Agent")this.User_Agent= shd[1];
        } else {
            if(subHeader=="GET /home.html HTTP/1.1")this.HTTP_GetRequest= true;
            // if(subHeader=="POST /home.html HTTP/1.1")this.HTTP_PostRequest= true;
        };
    };
};

public class httpHeaderGenerator {
    // public static string generateResponseHeader(string httpRequest) {};
};
