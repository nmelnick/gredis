/*
 * cleanuptest.vala
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