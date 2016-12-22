public int main(string[] args ) {
    var context = Redis.connect("127.0.0.1", 6379);
    if (context == null || context.err > 0) {
        if (context != null) {
            stdout.printf("Error: %s\n", (string) context.errstr);
        } else {
            stdout.printf("Can't allocate redis context\n");
        }
        return 1;
    }
    stdout.printf("Connected\n");

    stdout.printf("Setting 'foo' to 'bar'\n");
    var reply = context.command("SET foo %s", "bar");
    stdout.printf("Result: %s\n", (string) reply.str);

    stdout.printf("Reading 'foo'\n");
    reply = context.command("GET %s", "foo");
    stdout.printf("Result: %s\n", (string) reply.str);
    
    return 0;
}