namespace GRedis {
    public interface HashOperation : Operation {
        public bool hset(string key, string field, string value) throws RedisError {
            oper("HSET %s %s %s", key, field, value);
            return true;
        }

        public bool hsetnx(string key, string field, string value) throws RedisError {
            var reply = oper("HSETNX %s %s %s", key, field, value);
            return ( reply.integer == 1 ? true : false );
        }

        public string? hget(string key, string field) throws RedisError {
            var reply = oper("HGET %s %s", key, field);
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