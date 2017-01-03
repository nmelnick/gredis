namespace GRedis {
    public interface SingleOperation : Operation {

        /**
         * Set key to hold the string value. If key already holds a value, it
         * is overwritten, regardless of its type.
         * @param key Key
         * @param value Value to set
         * @throw RedisError
         */
        public bool @set(string key, string value) throws RedisError {
            oper("SET %s %s", key, value);
            return true;
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
            var reply = oper("SETNX %s %s", key, value);
            return ( reply.integer == 1 ? true : false );
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
            oper("SETEX %s %lld %s", key, seconds, value);
            return true;
        }

        /**
         * Get the value of key. If the key does not exist, null is returned.
         * @param key Key
         * @throw RedisError
         */
        public string? @get(string key) throws RedisError {
            var reply = oper("GET %s", key);
            if (reply.type == Redis.ReplyType.INTEGER) {
                return reply.integer.to_string();
            } else if (reply.type == Redis.ReplyType.STRING) {
                return (string) reply.str;
            } else if (reply.type == Redis.ReplyType.NIL) {
                return null;
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
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
            var reply = oper("EXISTS %s", key);
            return ( reply.integer == 1 ? true : false );
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
            var reply = oper("EXPIRE %s %lld", key, seconds);
            return ( reply.integer == 1 ? true : false );
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
            var reply = oper("EXPIREAT %s %lld", key, timestamp);
            return ( reply.integer == 1 ? true : false );
        }
    }
}