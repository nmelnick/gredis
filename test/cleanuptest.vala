public class CleanupTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/z/z/cleanup", () => {
            string[] l = {
                "htest",
                "rpoplist",
                "lpoplist",
                "ltrimlist",
                "lremlist",
                "lrangelist",
                "linsertlist",
                "llenlist",
                "rpushxlist",
                "rpushlist",
                "lpushxlist",
                "lpushlist",
                "grtest",
                "testintincr",
                "testintincrby",
                "testintdecr",
                "testintdecrby",
                "deltest",
                "strlentest",
                "appendtest",
                "redismaptest"
            };
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                foreach ( var key in l ) {
                    c.del(key);
                }
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}