/*
 * hashtest.vala
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

public class HashTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/hash/setget", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				c.hdel("htest", "test");
				assert( c.hset("htest", "test", "success") == GRedis.FieldStatus.SUCCESS_VALUE_SET );
				assert( c.hget("htest", "test") == "success" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hsetnx", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				c.hdel("htest", "test");
				assert( c.hset("htest", "test", "success") == GRedis.FieldStatus.SUCCESS_VALUE_SET );
				assert( c.hsetnx("htest", "test", "success") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hexists", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				c.hdel("htest", "test");
				assert( c.hset("htest", "test", "success") == GRedis.FieldStatus.SUCCESS_VALUE_SET );
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
				c.hset("htest", "testintincrby", "0");
				assert( c.hincrby("htest", "testintincrby", 3) == 3 );
				c.hset("htest", "testintdecrby", "0");
				assert( c.hincrby("htest", "testintdecrby", -3) == -3 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hdel", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				c.hset("htest", "deltest", "success");
				assert( c.hdel("htest", "deltest") == 1 );
				assert( c.hexists("htest", "deltest") == false );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/hash/hgetall", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				c.hset("hgetalltest", "foo", "bar");
				c.hset("hgetalltest", "baz", "bee");
				var hm = c.hgetall_hm("hgetalltest");
				assert( hm != null );
				assert( hm.get("foo") == "bar" );
				assert( hm.get("baz") == "bee" );
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}