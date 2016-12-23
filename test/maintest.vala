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


		Test.add_func("/gredis/hash/setget", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.hset("htest", "test", "success") == true );
            assert( c.hget("htest", "test") == "success" );
		});
		Test.add_func("/gredis/hash/hsetnx", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.hset("htest", "test", "success") == true );
            assert( c.hsetnx("htest", "test", "success") == false );
		});
		Test.add_func("/gredis/hash/hexists", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.hset("htest", "test", "success") == true );
            assert( c.hexists("htest", "test") == true );
            assert( c.hexists("htest", "testisnot") == false );
		});
		Test.add_func("/gredis/hash/hincrby", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.hset("htest", "testintincrby", "0") == true );
            assert( c.hincrby("htest", "testintincrby", 3) == 3 );
            assert( c.hset("htest", "testintdecrby", "0") == true );
            assert( c.hincrby("htest", "testintdecrby", -3) == -3 );
		});
		Test.add_func("/gredis/hash/hdel", () => {
			GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
			assert( c != null );
            assert( c.hset("htest", "deltest", "success") == true );
            assert( c.hdel("htest", "deltest") == 1 );
            assert( c.hexists("htest", "deltest") == false );
		});
    }
}