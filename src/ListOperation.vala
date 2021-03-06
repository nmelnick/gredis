/*
 * ListOperation.vala
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
     * For the linsert/LINSERT command, this enum provides BEFORE or AFTER.
     */
    public enum InsertPivot {
        BEFORE,
        AFTER;

        public string to_string() {
            switch (this) {
                case BEFORE:
                    return "BEFORE";
                case AFTER:
                    return "AFTER";
                default:
                    assert_not_reached();
            }
        }
    }

    /**
     * Operations on a List.
     */
    public interface ListOperation : Operation {
        /**
         * Returns the element at index index in the list stored at key. The
         * index is zero-based, so 0 means the first element, 1 the second
         * element and so on. Negative indices can be used to designate elements
         * starting at the tail of the list. Here, -1 means the last element, -2
         * means the penultimate and so forth.
         */
        public string? lindex(string key, int64 index) throws RedisError {
            return oper_string("LINDEX %s %lld", key, index);
        }

        /**
         * Inserts value in the list stored at key either before or after the
         * reference value pivot. When key does not exist, it is considered an
         * empty list and no operation is performed.
         *
         * @param key List key
         * @param set_value Value to insert
         * @param pivot InsertPivot (BEFORE/AFTER)
         * @param pivot_value Value to pivot at
         */
        public int64 linsert(string key, string set_value, InsertPivot pivot, string pivot_value) throws RedisError {
            var reply = oper("LINSERT %s %s %s %s", key, pivot.to_string(), pivot_value, set_value);
            return reply.integer;
        }

        /**
         * Returns the length of the list stored at key. If key does not exist,
         * it is interpreted as an empty list and 0 is returned. An error is
         * returned when the value stored at key is not a list.
         *
         * @param key List key
         */
        public int64 llen(string key) throws RedisError {
            var reply = oper("LLEN %s", key);
            return reply.integer;
        }

        /**
         * Removes and returns the first element of the list stored at key.
         */
        public string? lpop(string key) throws RedisError {
            return oper_string("LPOP %s", key);
        }

        /**
         * Removes and returns the last element of the list stored at key.
         */
        public string? rpop(string key) throws RedisError {
            return oper_string("RPOP %s", key);
        }

        /**
         * Insert the specified value at the head of the list stored at key. If
         * key does not exist, it is created as empty list before performing the
         * push operations. When key holds a value that is not a list, an error
         * is returned.
         *
         * @param key List key
         * @param value Value to insert
         */
        public int64 lpush(string key, string value) throws RedisError {
            var reply = oper("LPUSH %s %s", key, value);
            return reply.integer;
        }

        /**
         * Insert the specified value at the head of the list stored at key,
         * only if key already exists and holds a list. In contrary to LPUSH, no
         * operation will be performed when key does not yet exist.
         *
         * @param key List key
         * @param value Value to insert
         */
        public int64 lpushx(string key, string value) throws RedisError {
            var reply = oper("LPUSHX %s %s", key, value);
            return reply.integer;
        }

        /**
         * Insert the specified value at the tail of the list stored at key. If
         * key does not exist, it is created as empty list before performing the
         * push operations. When key holds a value that is not a list, an error
         * is returned.
         *
         * @param key List key
         * @param value Value to insert
         */
        public int64 rpush(string key, string value) throws RedisError {
            var reply = oper("RPUSH %s %s", key, value);
            return reply.integer;
        }

        /**
         * Insert the specified value at the tail of the list stored at key,
         * only if key already exists and holds a list. In contrary to LPUSH, no
         * operation will be performed when key does not yet exist.
         *
         * @param key List key
         * @param value Value to insert
         */
        public int64 rpushx(string key, string value) throws RedisError {
            var reply = oper("RPUSHX %s %s", key, value);
            return reply.integer;
        }

        /**
         * Insert the specified value at the head of the list stored at key,
         * only if key already exists and holds a list. In contrary to LPUSH, no
         * operation will be performed when key does not yet exist. Returns a
         * read-only Gee.List.
         *
         * @param key List key
         * @param start Start index
         * @param end End index
         */
        public Gee.List<string> lrange(string key, int64 start, int64 end) throws RedisError {
            return oper_arraylist("LRANGE %s %lld %lld", key, start, end).read_only_view;
        }

        /**
         * Removes the first count occurrences of elements equal to value from
         * the list stored at key. The count argument influences the operation
         * in the following ways:
         *   count > 0: Remove elements equal to value moving from head to tail.
         *   count < 0: Remove elements equal to value moving from tail to head.
         *   count = 0: Remove all elements equal to value.
         * For example, LREM list -2 "hello" will remove the last two
         * occurrences of "hello" in the list stored at list.
         * Note that non-existing keys are treated like empty lists, so when key
         * does not exist, the command will always return 0.
         *
         * @param key List key
         * @param count Number of values to remove
         * @param value Value to remove
         */
        public int64 lrem(string key, int64 count, string value) throws RedisError {
            var reply = oper("LREM %s %lld %s", key, count, value);
            return reply.integer;
        }

        /**
         * Sets the list element at index to value. For more information on the
         * index argument, see LINDEX. An error is returned for out of range
         * indexes.
         *
         * @param key List key
         * @param index Index to change
         * @param value Value to set
         */
        public bool lset(string key, int64 index, string value) throws RedisError {
            return oper_simple("LSET %s %lld %s", key, index, value);
        }

        /**
         * Trim an existing list so that it will contain only the specified
         * range of elements specified. Both start and stop are zero-based
         * indexes, where 0 is the first element of the list (the head), 1 the
         * next element and so on.
         * For example: ltrim("foobar", 0, 2) will modify the list stored at
         * foobar so that only the first three elements of the list will remain.
         * start and end can also be negative numbers indicating offsets from
         * the end of the list, where -1 is the last element of the list, -2 the
         * penultimate element and so on.
         * Out of range indexes will not produce an error: if start is larger
         * than the end of the list, or start > end, the result will be an empty
         * list (which causes key to be removed). If end is larger than the end
         * of the list, Redis will treat it like the last element of the list.
         *
         * @param key List key
         * @param start Start index
         * @param end End index
         */
        public bool ltrim(string key, int64 start, int64 end) throws RedisError {
            return oper_simple("LTRIM %s %lld %lld", key, start, end);
        }
    }
}