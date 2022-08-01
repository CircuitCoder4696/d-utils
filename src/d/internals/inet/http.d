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

public class HTTPS_reqHeader {
    import std.array:replaceAll;
    public string[string] data;
    public void opDispatch(string n)(string value) {
        this.data[n]= value;
    };
    public string generateHeader() {
        string result= "";
        foreach(index; indexes) {
            if(this.data[index] is null)continue;
            result ~= index ~ ": " ~ (this.data[index].replaceAll("_", "-") ~ "\n");
        };
        return result;
    };
    public string generate_httpPage(string data) {
        return this.generateHeader() ~ "/n" ~ data;
    };
};
public class t_HTTPS_reqHeader {
    void generate_httpReq() {
        auto v0= new HTTPS_reqHeader();
        v0.Accept_Encoding= "utf-8";
        auto v1= new httpReqParser(v0.generate_httpPage("<html></html>"));
        writeln(v1.Accept_Encoding);
    };
    public void test(string[] ArgV) {
        generate_httpReq();
    };
};

private struct httpResParser {
    import std.base64;
    import std.digest.sha;
    import std.string;
    public bool Status_200_OK;
    public string Access_Control_Allow_Origin;
    public string Connection;
    public string Content_Encoding;
    public string Content_Type;
    public string Date;
    public string Etag;
    public string Keep_Alive;
    public string Last_Modified;
    public string Server;
    public string Set_Cookie;
    public string Transfer_Encoding;
    public string Vary;
    public string X_Backend_Server;
    public string X_Cache_Info;
    public string X_kuma_revision;
    public string x_frame_options;
    public this(string requestHeader) {
        string[] shd;
        foreach(subHeader; requestHeader.split("\n"))if(subHeader.indexOf(": ") !=-1) {
            shd= subHeader.split(": ");
            if(shd[0]=="Access-Control-Allow-Origin")this.Access_Control_Allow_Origin= shd[1];
            if(shd[0]=="Connection")this.Connection= shd[1];
            if(shd[0]=="Content-Encoding")this.Content_Encoding= shd[1];
            if(shd[0]=="Content-Type")this.Content_Type= shd[1];
            if(shd[0]=="Date")this.Date= shd[1];
            if(shd[0]=="Etag")this.Etag= shd[1];
            if(shd[0]=="Keep-Alive")this.Keep_Alive= shd[1];
            if(shd[0]=="Last-Modified")this.Last_Modified= shd[1];
            if(shd[0]=="Server")this.Server= shd[1];
            if(shd[0]=="Set-Cookie")this.Set_Cookie= shd[1];
            if(shd[0]=="Transfer-Encoding")this.Transfer_Encoding= shd[1];
            if(shd[0]=="Vary")this.Vary= shd[1];
            if(shd[0]=="X-Backend-Server")this.X_Backend_Server= shd[1];
            if(shd[0]=="X-Cache-Info")this.X_Cache_Info= shd[1];
            if(shd[0]=="X-kuma-revision")this.X_kuma_revision= shd[1];
            if(shd[0]=="x-frame-options")this.x_frame_options= shd[1];
        } else {
            if(subHeader=="200 OK")this.Status_200_OK= true;
            // if(subHeader=="POST /home.html HTTP/1.1")this.HTTP_PostRequest= true;
        };
    };
};

public class httpHeaderGenerator {
    // public static string generateResponseHeader(string httpRequest) {};
};
