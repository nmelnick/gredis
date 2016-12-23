public class MainTest {
    public static void add_tests() {
		Test.add_func("/gredis/single/setget", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("test", "success") == true );
            assert( c.get("test") == "success" );
		});
		Test.add_func("/gredis/single/setnx", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("test", "success") == true );
            assert( c.setnx("test", "success") == false );
		});
		Test.add_func("/gredis/single/exists", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("test", "success") == true );
            assert( c.exists("test") == true );
            assert( c.exists("testisnot") == false );
		});
		Test.add_func("/gredis/single/incr", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("testintincr", "0") == true );
            assert( c.incr("testintincr") == 1 );
		});
		Test.add_func("/gredis/single/incrby", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("testintincrby", "0") == true );
            assert( c.incrby("testintincrby", 3) == 3 );
		});
		Test.add_func("/gredis/single/decr", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("testintdecr", "0") == true );
            assert( c.decr("testintdecr") == -1 );
		});
		Test.add_func("/gredis/single/decrby", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("testintdecrby", "0") == true );
            assert( c.decrby("testintdecrby", 3) == -3 );
		});
		Test.add_func("/gredis/single/del", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("deltest", "success") == true );
            assert( c.del("deltest") == 1 );
            assert( c.exists("deltest") == false );
		});
		Test.add_func("/gredis/single/strlen", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("strlentest", "success") == true );
            assert( c.strlen("strlentest") == 7 );
		});
		Test.add_func("/gredis/single/append", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.set("appendtest", "success") == true );
            assert( c.append("appendtest", "ful") == 10 );
		});
    }
}