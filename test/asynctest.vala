public class AsyncTest {
    public static bool connect = false;
    public static bool disconnect = false;
    public static void add_tests() {
		Test.add_func("/gredis-async/live/connect", () => {
            var loop = new MainLoop();
			try {
				GRedis.AsyncConnection c = new GRedis.AsyncConnection("127.0.0.1", 6379, loop.get_context());
                c.verbose_callbacks = true;
                c.set_connect_callback(connect_callback);
                c.set_disconnect_callback(disconnect_callback);
				assert( c != null );
			} catch (Error e) {
				assert_not_reached();
			}
            loop.run();
            assert( connect == true );
            assert( disconnect == true );
		});
    }

    public static void connect_callback(GRedis.AsyncConnection ac, GRedis.Status status) {
                stdout.printf("!c\n");
        connect = true;
        ac.disconnect();
    }
    public static void disconnect_callback(GRedis.AsyncConnection ac, GRedis.Status status) {
                stdout.printf("!d\n");
        disconnect = true;
    }
}