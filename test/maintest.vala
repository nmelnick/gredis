/*
 * maintest.vala
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

public class MainTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/single/setget", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("grtest", "success") == true );
				assert( c.get("grtest") == "success" );
			} catch (Error e) {
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
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
				stdout.printf("%s\n", e.message);
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/single/type", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
				assert( c.set("typetest", "success") == true );
				assert( c.type("typetest") == "string" );
				c.hset("typehtest", "foo", "success");
				assert( c.type("typehtest") == "hash" );
			} catch (Error e) {
				stdout.printf("%s\n", e.message);
				assert_not_reached();
			}
		});
    }
}