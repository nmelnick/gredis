/*
 * databasetest.vala
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

public class DatabaseTest {
    public static void add_tests() {
		Test.add_func("/gredis/live/database/keys", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                c.del("grkeystestone");
                c.del("grkeystesttwo");
				c.set( "grkeystestone", "1" );
				c.set( "grkeystesttwo", "2" );
				var array = c.keys("grkeys*");
                assert( array != null );
                assert( array.size == 2 );
				assert( array.contains("grkeystestone") );
				assert( array.contains("grkeystesttwo") );
			} catch (Error e) {
				assert_not_reached();
			}
		});
		Test.add_func("/gredis/live/database/randomkey", () => {
			try {
				GRedis.Connection c = new GRedis.Connection("127.0.0.1", 6379);
				assert( c != null );
                var k = c.randomkey();
                assert( k != null );
                assert( k.length > 0 );
			} catch (Error e) {
				assert_not_reached();
			}
		});
    }
}