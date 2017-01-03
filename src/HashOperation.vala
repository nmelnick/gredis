namespace GRedis {
    /**
     * Status on an hset.
     */
    public enum FieldStatus {
        /**
         * Value was set successfully on a new field.
         */
        SUCCESS_VALUE_SET,
        /**
         * Value was updated successfully on an existing field.
         */
        SUCCESS_VALUE_UPDATED,
        /**
         * Value was not set.
         */
        FAILED
    }

    /**
     * Operations on a Hash.
     */
    public interface HashOperation : Operation {
        public FieldStatus hset(string key, string field, string value) throws RedisError {
            return ( oper_intbool("HSET %s %s %s", key, field, value) ? FieldStatus.SUCCESS_VALUE_SET : FieldStatus.SUCCESS_VALUE_UPDATED );
        }

        public bool hsetnx(string key, string field, string value) throws RedisError {
            return oper_intbool("HSETNX %s %s %s", key, field, value);
        }

        public string? hget(string key, string field) throws RedisError {
            return oper_string("HGET %s %s", key, field);
        }

        public int64 hdel(string key, string field) throws RedisError {
            var reply = oper("HDEL %s %s", key, field);
            return reply.integer;
        }

        public bool hexists(string key, string field) throws RedisError {
            var reply = oper("HEXISTS %s %s", key, field);
            return ( reply.integer == 1 ? true : false );
        }

        public int64 hincrby(string key, string field, int64 count) throws RedisError {
            var reply = oper("HINCRBY %s %s %lld", key, field, count);
            return reply.integer;
        }

        public int64 hincr(string key, string field) throws RedisError {
            return hincrby( key, field, 1 );
        }

        public int64 hdecr(string key, string field) throws RedisError {
            return hincrby( key, field, -1 );
        }

        public int64 hlen(string key) throws RedisError {
            var reply = oper("HLEN %s", key);
            return reply.integer;
        }

        public int64 hstrlen(string key, string field) throws RedisError {
            var reply = oper("HSTRLEN %s %s", key, field);
            return reply.integer;
        }
    }
}