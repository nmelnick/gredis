public class MainTest {
    public static void add_tests() {
		Test.add_func("/gredis/general", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("test", "success") == true );
            assert( c.get("test") == "success" );
            assert( c.incr("testint") > 0 );
		});
    }
}