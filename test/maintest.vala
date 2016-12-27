public class MainTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/single/setget", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("test", "success") == true );
				assert( c.get("test") == "success" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/setnx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("test", "success") == true );
				assert( c.setnx("test", "success") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/exists", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("test", "success") == true );
				assert( c.exists("test") == true );
				assert( c.exists("testisnot") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/incr", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("testintincr", "0") == true );
				assert( c.incr("testintincr") == 1 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/incrby", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("testintincrby", "0") == true );
				assert( c.incrby("testintincrby", 3) == 3 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/decr", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("testintdecr", "0") == true );
				assert( c.decr("testintdecr") == -1 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/decrby", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("testintdecrby", "0") == true );
				assert( c.decrby("testintdecrby", 3) == -3 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/del", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("deltest", "success") == true );
				assert( c.del("deltest") == 1 );
				assert( c.exists("deltest") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/strlen", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("strlentest", "success") == true );
				assert( c.strlen("strlentest") == 7 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/append", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("appendtest", "success") == true );
				assert( c.append("appendtest", "ful") == 10 );
			} catch (Error e) {
				assert_not_reached();
			}
		});

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