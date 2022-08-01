module test.Main;

void d_proc(string[] ArgV) {
    import d.proc.ArrayProcessor;
    (new t_ArrayProcessor()).test(ArgV);
};

void main(string[] ArgV) {
    d_proc(ArgV);
};
