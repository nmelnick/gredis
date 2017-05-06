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
     * Operations on single keys, which may also be the master keys for a Hash
     * or a List.
     */
    public interface SingleOperation : Operation {

        /**
         * Set key to hold the string value. If key already holds a value, it
         * is overwritten, regardless of its type.
         * @param key Key
         * @param value Value to set
         * @throw RedisError
         */
        public bool @set(string key, string value) throws RedisError {
            return oper_simple("SET %s %s", key, value);
        }

        /**
         * Set key to hold string value if key does not exist. In that case, it
         * is equal to SET. When key already holds a value, no operation is
         * performed.
         * @param key Key
         * @param value Value to set
         * @throw RedisError
         */
        public bool setnx(string key, string value) throws RedisError {
            return oper_intbool("SETNX %s %s", key, value);
        }

        /**
         * Set key to hold the string value and set key to timeout after a given
         * number of seconds.
         * @param key Key
         * @param seconds Seconds until expiration
         * @param value Value to set
         * @throw RedisError
         */
        public bool setex(string key, int64 seconds, string value) throws RedisError {
            return oper_simple("SETEX %s %lld %s", key, seconds, value);
        }

        /**
         * Get the value of key. If the key does not exist, null is returned.
         * @param key Key
         * @throw RedisError
         */
        public string? @get(string key) throws RedisError {
            return oper_string("GET %s", key);
        }

        /**
         * Increments the number stored at key by one. If the key does not
         * exist, it is set to 0 before performing the operation. An error is
         * returned if the key contains a value of the wrong type or contains a
         * string that can not be represented as integer. This operation is
         * limited to 64 bit signed integers.
         * @param key Key
         * @throw RedisError
         */
        public int64 incr(string key) throws RedisError {
            var reply = oper("INCR %s", key);
            return reply.integer;
        }

        /**
         * Increments the number stored at key by increment. If the key does not
         * exist, it is set to 0 before performing the operation. An error is
         * returned if the key contains a value of the wrong type or contains a
         * string that can not be represented as integer. This operation is
         * limited to 64 bit signed integers.
         * @param key Key
         * @param increment Amount to increment
         * @throw RedisError
         */
        public int64 incrby(string key, int64 increment) throws RedisError {
            var reply = oper("INCRBY %s %lld", key, increment);
            return reply.integer;
        }

        /**
         * Decrements the number stored at key by one. If the key does not
         * exist, it is set to 0 before performing the operation. An error is
         * returned if the key contains a value of the wrong type or contains a
         * string that can not be represented as integer. This operation is
         * limited to 64 bit signed integers.
         * @param key Key
         * @throw RedisError
         */
        public int64 decr(string key) throws RedisError {
            var reply = oper("DECR %s", key);
            return reply.integer;
        }

        /**
         * Decrements the number stored at key by decrement. If the key does not
         * exist, it is set to 0 before performing the operation. An error is
         * returned if the key contains a value of the wrong type or contains a
         * string that can not be represented as integer. This operation is
         * limited to 64 bit signed integers.
         * @param key Key
         * @param decrement Amount to decrement
         * @throw RedisError
         */
        public int64 decrby(string key, int64 decrement) throws RedisError {
            var reply = oper("DECRBY %s %lld", key, decrement);
            return reply.integer;
        }

        /**
         * Removes the specified key. A key is ignored if it does not exist.
         * @param key Key
         * @throw RedisError
         */
        public int64 del(string key) throws RedisError {
            var reply = oper("DEL %s", key);
            return reply.integer;
        }

        /**
         * Returns true if key exists.
         * @param key Key
         * @throw RedisError
         */
        public bool exists(string key) throws RedisError {
            return oper_intbool("EXISTS %s", key);
        }

        /**
         * Returns the length of the string value stored at key. An error is
         * returned when key holds a non-string value.
         * @param key Key
         * @throw RedisError
         */
        public int64 strlen(string key) throws RedisError {
            var reply = oper("STRLEN %s", key);
            return reply.integer;
        }

        /**
         * If key already exists and is a string, this command appends the value
         * at the end of the string. If key does not exist it is created and set
         * as an empty string, so APPEND will be similar to SET in this special
         * case. Returns the new length of the string.
         * @param key Key
         * @param value String to append
         * @throw RedisError
         */
        public int64 append(string key, string value) throws RedisError {
            var reply = oper("APPEND %s %s", key, value);
            return reply.integer;
        }

        /**
         * Set a timeout on key. After the timeout has expired, the key will
         * automatically be deleted. A key with an associated timeout is often
         * said to be volatile in Redis terminology.
         * @param key Key
         * @param seconds Number of seconds until expiration
         * @throw RedisError
         */
        public bool expire(string key, int64 seconds) throws RedisError {
            return oper_intbool("EXPIRE %s %lld", key, seconds);
        }

        /**
         * EXPIREAT has the same effect and semantic as EXPIRE, but instead of
         * specifying the number of seconds representing the TTL (time to live),
         * it takes an absolute Unix timestamp (seconds since January 1, 1970).
         * A timestamp in the past will delete the key immediately.
         * @param key Key
         * @param timestamp Unix timestamp, in seconds, for when to expire
         * @throw RedisError
         */
        public bool expireat(string key, int64 timestamp) throws RedisError {
            return oper_intbool("EXPIREAT %s %lld", key, timestamp);
        }

        /**
         * Renames key to newkey. It returns an error when key does not exist.
         * If newkey already exists it is overwritten, when this happens RENAME
         * executes an implicit DEL operation, so if the deleted key contains a
         * very big value it may cause high latency even if RENAME itself is
         * usually a constant-time operation.
         * @param key Key
         * @param new_key New key name
         * @throw RedisError
         */
        public bool rename(string key, string new_key) throws RedisError {
            return oper_simple("RENAME %s %s", key, new_key);
        }

        /**
         * Remove the existing timeout on key, turning the key from volatile (a
         * key with an expire set) to persistent (a key that will never expire
         * as no timeout is associated).
         * @param key Key
         * @throw RedisError
         */
        public bool persist(string key) throws RedisError {
            return oper_intbool("PERSIST %s", key);
        }

        /**
         * Returns the remaining time to live of a key that has a timeout. This
         * introspection capability allows a Redis client to check how many
         * seconds a given key will continue to be part of the dataset.
         * @param key Key
         * @throw RedisError
         */
        public int64 ttl(string key) throws RedisError {
            var reply = oper("TTL %s", key);
            return reply.integer;
        }

        /**
         * Returns the string representation of the type of the value stored at
         * key. The different types that can be returned are: string, list, set,
         * zset and hash.
         * @param key Key
         * @throw RedisError
         */
        public string? type(string key) throws RedisError {
            return oper_string("TYPE %s", key);
        }

        /**
         * This command is very similar to DEL: it removes the specified keys.
         * Just like DEL a key is ignored if it does not exist. However the
         * command performs the actual memory reclaiming in a different thread,
         * so it is not blocking, while DEL is. This is where the command name
         * comes from: the command just unlinks the keys from the keyspace. The
         * actual removal will happen later asynchronously.
         * @param key Key
         * @throw RedisError
         */
        public int64 unlink(string key) throws RedisError {
            var reply = oper("UNLINK %s", key);
            return reply.integer;
        }
    }
}