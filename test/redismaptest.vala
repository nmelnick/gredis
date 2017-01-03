public class RedisMapTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/redismap/set-get-size", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("redismaptest");
                var rm = new GRedis.RedisMap(c, "redismaptest");
				assert( rm != null );
                rm["foo"] = "bar";
                assert( rm["foo"] == "bar" );
                assert( rm.size == 1 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}