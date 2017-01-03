public class ListTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/list/lpush", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("lpushlist");
                assert( c.lpush( "lpushlist", "val" ) == 1 );
                assert( c.lindex( "lpushlist", 0 ) == "val" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/lpushx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                assert( c.lpushx( "lpushxlist", "val" ) == 0 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/rpush", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("rpushlist");
                assert( c.rpush( "rpushlist", "val" ) == 1 );
                assert( c.lindex( "rpushlist", 0 ) == "val" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/rpushx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                assert( c.rpushx( "rpushxlist", "val" ) == 0 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/llen", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("llenlist");
                assert( c.lpush( "llenlist", "val" ) == 1 );
                assert( c.llen("llenlist") == 1 );
                assert( c.lpush( "llenlist", "val2" ) == 2 );
                assert( c.llen("llenlist") == 2 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/linsert", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("linsertlist");
                assert( c.lpush( "linsertlist", "val" ) == 1 );
                assert( c.lpush( "linsertlist", "val2" ) == 2 );
                assert( c.llen("linsertlist") == 2 );
                assert( c.linsert( "linsertlist", "val3", GRedis.InsertPivot.BEFORE, "val" ) == 3 );
                assert( c.lindex( "linsertlist", 1 ) == "val3" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/lrange", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("lrangelist");
                assert( c.lpush( "lrangelist", "val" ) == 1 );
                assert( c.lpush( "lrangelist", "val2" ) == 2 );
                assert( c.lpush( "lrangelist", "val3" ) == 3 );
                assert( c.llen("lrangelist") == 3 );
                var array = c.lrange( "lrangelist", 0, 2 );
                assert( array != null );
                assert( array.size == 3 );
                assert( array[0] == "val3" );
                assert( array[1] == "val2" );
                assert( array[2] == "val" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/lrem", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("lremlist");
                assert( c.lpush( "lremlist", "val" ) == 1 );
                assert( c.lpush( "lremlist", "val2" ) == 2 );
                assert( c.lpush( "lremlist", "val3" ) == 3 );
                assert( c.llen("lremlist") == 3 );
                assert( c.lrem("lremlist", 0, "val2") == 1 );
                assert( c.llen("lremlist") == 2 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/ltrim", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("ltrimlist");
                assert( c.lpush( "ltrimlist", "val" ) == 1 );
                assert( c.lpush( "ltrimlist", "val2" ) == 2 );
                assert( c.lpush( "ltrimlist", "val3" ) == 3 );
                assert( c.llen("ltrimlist") == 3 );
                assert( c.ltrim("ltrimlist", 0, 0) == true );
                assert( c.llen("ltrimlist") == 1 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/lpop", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("lpoplist");
                assert( c.lpush( "lpoplist", "val" ) == 1 );
                assert( c.lpush( "lpoplist", "val2" ) == 2 );
                assert( c.lpush( "lpoplist", "val3" ) == 3 );
                assert( c.llen("lpoplist") == 3 );
                assert( c.lpop("lpoplist") == "val3" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/list/rpop", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("rpoplist");
                assert( c.lpush( "rpoplist", "val" ) == 1 );
                assert( c.lpush( "rpoplist", "val2" ) == 2 );
                assert( c.lpush( "rpoplist", "val3" ) == 3 );
                assert( c.llen("rpoplist") == 3 );
                assert( c.rpop("rpoplist") == "val" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}