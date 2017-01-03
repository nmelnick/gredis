public class HashTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/hash/setget", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.hset("htest", "test", "success") == true );
				assert( c.hget("htest", "test") == "success" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hsetnx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.hset("htest", "test", "success") == true );
				assert( c.hsetnx("htest", "test", "success") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hexists", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.hset("htest", "test", "success") == true );
				assert( c.hexists("htest", "test") == true );
				assert( c.hexists("htest", "testisnot") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hincrby", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.hset("htest", "testintincrby", "0") == true );
				assert( c.hincrby("htest", "testintincrby", 3) == 3 );
				assert( c.hset("htest", "testintdecrby", "0") == true );
				assert( c.hincrby("htest", "testintdecrby", -3) == -3 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hdel", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.hset("htest", "deltest", "success") == true );
				assert( c.hdel("htest", "deltest") == 1 );
				assert( c.hexists("htest", "deltest") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}