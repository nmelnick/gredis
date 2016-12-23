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
    public class Connection : Object, Operation, SingleOperation, HashOperation {
        private Redis.Context _context;
        public Redis.Context context { get { return _context; } }

        /**
         * Initialize a new connection to Redis.
         *
         * @param host Hostname or IP address
         * @param port Port number (defaults to 6379)
         * @throw ConnectionError
         */
        public Connection( string host, int port = 6379 ) throws ConnectionError {
            _context = Redis.connect(host, port);
            if (context == null || context.err > 0) {
                if (context != null) {
                    throw new ConnectionError.CONNECT_ERROR((string) context.errstr);
                } else {
                    throw new ConnectionError.LIBRARY_ERROR("Unable to allocate Redis context");
                }
            }
        }
    }
}