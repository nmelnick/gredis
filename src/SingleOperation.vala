namespace GRedis {
    public interface SingleOperation : Operation {

        public bool @set(string key, string value) throws RedisError {
            var reply = oper("SET %s %s", key, value);
            return true;
        }

        public bool setnx(string key, string value) throws RedisError {
            var reply = oper("SETNX %s %s", key, value);
            return ( reply.integer == 1 ? true : false );
        }

        public string? @get(string key) throws RedisError {
            var reply = oper("GET %s", key);
            if (reply.type == Redis.ReplyType.INTEGER) {
                return reply.integer.to_string();
            } else if (reply.type == Redis.ReplyType.STRING) {
                return (string) reply.str;
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
        }

        public int64 incr(string key) throws RedisError {
            var reply = oper("INCR %s", key);
            return reply.integer;
        }

        public int64 incrby(string key, int64 count) throws RedisError {
            var reply = oper("INCRBY %s %lld", key, count);
            return reply.integer;
        }

        public int64 decr(string key) throws RedisError {
            var reply = oper("DECR %s", key);
            return reply.integer;
        }

        public int64 decrby(string key, int64 count) throws RedisError {
            var reply = oper("DECRBY %s %lld", key, count);
            return reply.integer;
        }

        public int64 del(string key) throws RedisError {
            var reply = oper("DEL %s", key);
            return reply.integer;
        }

        public bool exists(string key) throws RedisError {
            var reply = oper("EXISTS %s", key);
            return ( reply.integer == 1 ? true : false );
        }

        public int64 strlen(string key) throws RedisError {
            var reply = oper("STRLEN %s", key);
            return reply.integer;
        }

        public int64 append(string key, string value) throws RedisError {
            var reply = oper("APPEND %s %s", key, value);
            return reply.integer;
        }
    }
}