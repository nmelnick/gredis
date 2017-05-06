/*
 * SingleOperation.vala
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

namespace GRedis {
    /**
     * Operations database-wide, which may work with single or multiple keys,
     * but at a global level.
     */
    public interface DatabaseOperation : Operation {

        /**
         * Returns all keys matching pattern. Returns a read-only Gee.List.
         *
         * @param pattern Search pattern
         * @param start Start index
         * @param end End index
         */
        public Gee.List<string> keys(string pattern) throws RedisError {
            return oper_arraylist("KEYS %s", pattern).read_only_view;
        }

        /**
         * Return a random key from the currently selected database.
         * @throw RedisError
         */
        public string? randomkey() throws RedisError {
            return oper_string("RANDOMKEY");
        }
    }
}