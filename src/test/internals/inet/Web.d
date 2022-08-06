module test.internals.inet.Web;

public class t_Web {
    public void generate_http_req_packet(string domainName, string path, string query) { };
    public void test(string[] ArgV) {
        import std.stdio:writeln;
        // (new t_HTTPS_reqHeader()).test(ArgV);
        generate_http_req_packet("google.com", null, null);
    };
};
