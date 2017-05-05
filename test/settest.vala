public class SetTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/set/sadd", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                assert( c.sadd( "testset", "value_1" ) == 1 );
                assert( c.sadd( "testset", "value_1" ) == 0 );
                assert( c.sadd( "testset", "value_2" ) == 1 );
			} catch (Error e) {
				assert_not_reached();
			}
		});

        Test.add_func("/gredis/live/set/scard", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                assert(c.scard("testset") == 3);
            } catch (Error e) {
                assert_not_reached();
            }
        });

        Test.add_func("/gredis/live/set/sdiff", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var diff = c.sdiff("testset","testset2");
                assert("value1" in diff);
                assert(!("value2" in diff));
                assert(!("value3" in diff));
            } catch (Error e) {
                assert_not_reached();
            }
        });

        Test.add_func("/gredis/live/set/sdiffstore", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.del("diffset");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var res = c.sdiffstore("diffset", "testset","testset2");
                assert(res == 1);
            } catch (Error e) {
                assert_not_reached();
            }
        });

        Test.add_func("/gredis/live/set/sinter", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var inter = c.sinter("testset","testset2");
                assert(!("value1" in inter));
                assert("value2" in inter);
                assert("value3" in inter);
            } catch (Error e) {
                assert_not_reached();
            }
        });

        Test.add_func("/gredis/live/set/sinterstore", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.del("diffset");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var res = c.sinterstore("diffset", "testset","testset2");
                assert(res == 2);
            } catch (Error e) {
                assert_not_reached();
            }
        });

		Test.add_func("/gredis/live/set/sismember", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                assert(!c.sismember("testset", "value_1"));
                assert( c.sadd( "testset", "value_1" ) == 1 );
                assert(c.sismember("testset", "value_1"));
                assert(!c.sismember("testset", "value_2"));
			} catch (Error e) {
				assert_not_reached();
			}
		});

		Test.add_func("/gredis/live/set/smembers", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                var testset = c.smembers("testset");
                assert(!("value_1" in testset));
                assert(!("value_2" in testset));
                assert(!("value_3" in testset));
                c.sadd("testset", "value_1");
                c.sadd("testset", "value_2");
                c.sadd("testset", "value_3");
                testset = c.smembers("testset");
                assert("value_1" in testset);
                assert("value_2" in testset);
                assert("value_3" in testset);
			} catch (Error e) {
				assert_not_reached();
			}
		});

		Test.add_func("/gredis/live/set/smove", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.sadd("testset", "value_1");
                var res = c.smove("testset", "testset2", "value_1");
                assert(res == 1);
                assert(c.sismember("testset2", "value_1"));
			} catch (Error e) {
				assert_not_reached();
			}
		});

		Test.add_func("/gredis/live/set/spop", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.sadd("testset", "value_1");
                c.sadd("testset", "value_2");
                c.sadd("testset", "value_3");
                var res = c.spop("testset", 2);
                assert(res.size == 2);
                assert(c.scard("testset") == 1);
			} catch (Error e) {
				assert_not_reached();
			}
		});

		Test.add_func("/gredis/live/set/srandmember", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.sadd("testset", "value_1");
                c.sadd("testset", "value_2");
                c.sadd("testset", "value_3");
                var res = c.srandmember("testset", 2);
                assert(res.size == 2);
                assert(c.scard("testset") == 3);
			} catch (Error e) {
				assert_not_reached();
			}
		});

		Test.add_func("/gredis/live/set/srem", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.sadd("testset", "value_1");
                c.sadd("testset", "value_2");
                c.sadd("testset", "value_3");
                var res = c.srem("testset", "value_1", "value_2");
                assert(res == 2);
                assert(c.scard("testset") == 1);
			} catch (Error e) {
				assert_not_reached();
			}
		});

        Test.add_func("/gredis/live/set/sunion", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var inter = c.sunion("testset","testset2");
                assert("value1" in inter);
                assert("value2" in inter);
                assert("value3" in inter);
            } catch (Error e) {
                assert_not_reached();
            }
        });

        Test.add_func("/gredis/live/set/sunionstore", () => {
            try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("testset");
                c.del("testset2");
                c.del("diffset");
                c.sadd("testset", "value1");
                c.sadd("testset", "value2");
                c.sadd("testset", "value3");
                c.sadd("testset2", "value2");
                c.sadd("testset2", "value3");
                var res = c.sunionstore("diffset", "testset","testset2");
                assert(res == 3);
            } catch (Error e) {
                assert_not_reached();
            }
        });
    }
}
