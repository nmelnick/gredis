namespace GRedis {
    public errordomain ConnectionError {
        CONNECT_ERROR,
        AUTH_ERROR,
        LIBRARY_ERROR
    }

    public errordomain RedisError {
        IO,
        GENERAL,
        UNHANDLED
    }

    public enum Status {
        OK,
        ERROR
    }

    public class Connection : Object, Operation, SingleOperation, HashOperation, ListOperation {
        private Redis.Context _context;
        public Redis.Context context { get { return _context; } }
        public static LogHandler logger { get; set; default = new LogHandler(); }

        /**
         * Initialize a new connection to Redis.
         *
         * @param host Hostname or IP address
         * @param port Port number (defaults to 6379)
         * @throw ConnectionError
         */
        public Connection( string host, int port = 6379, string? password = null ) throws ConnectionError {
            _context = Redis.connect(host, port);
            if (context == null || context.err > 0) {
                if (context != null) {
                    throw new ConnectionError.CONNECT_ERROR((string) context.errstr);
                } else {
                    throw new ConnectionError.LIBRARY_ERROR("Unable to allocate Redis context");
                }
            }
            if ( password != null ) {
                auth(password);
            }
        }

        /**
         * Reconnect to the Redis server using the existing connection
         * credentials.
         */
        public bool reconnect() {
            var reply = context.reconnect();
            if ( reply == Redis.RedisResponse.OK ) {
                return true;
            }
            return false;
        }

        public void auth( string password ) throws ConnectionError {
            try {
                oper_simple("AUTH %s", password);
            } catch (RedisError e) {
                throw new ConnectionError.AUTH_ERROR(e.message);
            }
        }
    }
}