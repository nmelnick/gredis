/*
 * SetOperation.vala
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

using Gee;

namespace GRedis {
    /**
     * Operations on a Set.
     */
    public interface SetOperation : Operation {
        /**
         * Add one or more members to a set
         */
        public int64 sadd(string key, string member, ...) {
            // TODO: read va_list
            var list = va_list();
            string operation = "SADD %s %s".printf(key, member);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
               
            var reply = oper(operation);
            return reply.integer;
        }

        /**
         * Get the number of members in a set
         */
        public int64 scard(string key) {
            var reply = oper("SCARD %s", key);
            return reply.integer;
        }

        /**
         * Subtract multiple sets
         */
        public Gee.Set<string> sdiff(string key, ...) {
            var list = va_list();
            string operation = "SDIFF %s".printf(key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            return oper_set(operation);
        }

        /**
         * Subtract multiple sets and store the resulting set in a key
         */
        public int64 sdiffstore(string destination, string key, ...) {
            var list = va_list();
            string operation = "SDIFFSTORE %s %s".printf(destination, key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            var reply = oper(operation);
            return reply.integer;
        }

        /**
         * Intersect multiple sets
         */
        public Gee.Set<string> sinter(string key, ...) {
            var list = va_list();
            string operation = "SINTER %s".printf(key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            return oper_set(operation);
        }

        /**
         * Intersect multiple sets and store the resulting set in a key
         */
        public int64 sinterstore(string destination, string key, ...) {
            var list = va_list();
            string operation = "SINTERSTORE %s %s".printf(destination, key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            var reply = oper(operation);
            return reply.integer;
        }

        /**
         * Determine if a given value is a member of a set
         */
        public bool sismember(string key, string member) {
            var reply = oper("SISMEMBER %s %s", key, member);
            return reply.integer == 1;
        }

        /**
         * Get all members in a set
         */
        public Gee.Set<string> smembers(string key) {
            return oper_set("SMEMBERS %s", key);
        }

        /**
         * Move a member from one set to another
         */
        public int64 smove(string source, string destination, string member) {
            var reply = oper("SMOVE %s %s %s", source, destination, member);
            return reply.integer;
        }

        /**
         * Remove and return one or multiple random members from a set
         */
        public Gee.Set<string> spop(string key, uint count=1) {
            return oper_set("SPOP %s %u", key, count);
        }

        /**
         * Get one or multiple random members from a set
         */
        public Gee.Set<string> srandmember(string key, uint count=1) {
            return oper_set("SRANDMEMBER %s %u", key, count);
        }

        /**
         * Remove one or more members from a set
         */
        public int64 srem(string key, string member, ...) {
            var list = va_list();
            string operation = "SREM %s %s".printf(key, member);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            var reply = oper(operation);
            return reply.integer;
        }

        /**
         * Add multiple sets
         */
        public Gee.Set<string> sunion(string key, ...) {
            var list = va_list();
            string operation = "SUNION %s".printf(key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            return oper_set(operation);
        }

        /**
         * Add multiple sets and store the resulting set in a key
         */
        public int64 sunionstore(string destination, string key, ...) {
            var list = va_list();
            string operation = "SUNIONSTORE %s %s".printf(destination, key);
            for (string? str = list.arg<string?>(); str != null; str = list.arg<string?>()){
                operation += " " + str;
            }
            var reply = oper(operation);
            return reply.integer;
        }
    }
}
