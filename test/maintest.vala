public class MainTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/single/setget", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("grtest", "success") == true );
				assert( c.get("grtest") == "success" );
			} catch (Error e) {
				stdout.printf(e.message);
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/setnx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("grtest", "success") == true );
				assert( c.setnx("grtest", "success") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/exists", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("grtest", "success") == true );
				assert( c.exists("grtest") == true );
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
    }
}