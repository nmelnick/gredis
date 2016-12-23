namespace GRedis {
    public errordomain ConnectionError {
        CONNECT_ERROR,
        LIBRARY_ERROR
    }
    public errordomain RedisError {
        IO,
        GENERAL,
        UNHANDLED
    }
    public class Connection {
        public Redis.Context context;

        /**
         * Initialize a new connection to Redis.
         *
         * @param host Hostname or IP address
         * @param port Port number (defaults to 6379)
         * @throw ConnectionError
         */
        public Connection( string host, int port = 6379 ) {
            context = Redis.connect(host, port);
            if (context == null || context.err > 0) {
                if (context != null) {
                    throw new ConnectionError.CONNECT_ERROR((string) context.errstr);
                } else {
                    throw new ConnectionError.LIBRARY_ERROR("Unable to allocate Redis context");
                }
            }
        }

        public bool @set(string key, string value) {
            var reply = context.command("SET %s %s", key, value);
            if (reply == null) {
                if (context.err == Redis.RedisError.IO) {
                    throw new RedisError.IO((string) context.errstr);
                }
                throw new RedisError.GENERAL((string) context.errstr);
            }
            return true;
        }

        public int64 incr(string key) {
            var reply = context.command("INCR %s", key);
            if (reply == null) {
                if (context.err == Redis.RedisError.IO) {
                    throw new RedisError.IO((string) context.errstr);
                }
                throw new RedisError.GENERAL((string) context.errstr);
            }
            return reply.integer;
        }

        public string? @get(string key) {
            var reply = context.command("GET %s", key);
            if (reply == null) {
                if (context.err == Redis.RedisError.IO) {
                    throw new RedisError.IO((string) context.errstr);
                }
                throw new RedisError.GENERAL((string) context.errstr);
            }
            if (reply.type == Redis.ReplyType.INTEGER) {
                return reply.integer.to_string();
            } else if (reply.type == Redis.ReplyType.STRING) {
                return (string) reply.str;
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
        }
    }
}