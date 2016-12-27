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

    public enum Status {
        OK,
        ERROR
    }
    
    public delegate void DisconnectCallback(AsyncConnection ac, Status s);
    public delegate void ConnectCallback(AsyncConnection ac, Status s);
    public delegate void CommandCallback(AsyncConnection ac, Status s);

    public class Connection : Object, Operation, SingleOperation, HashOperation {
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
    }

    public class AsyncConnection : Object {
        private Redis.AsyncContext _context;
        private ConnectCallback connect_callback;
        private DisconnectCallback disconnect_callback;

        public Redis.AsyncContext context { get { return _context; } }
        public bool verbose_callbacks { get; set; default = false; }
        public LogHandler logger { get; set; default = new LogHandler(); }

        /**
         * Initialize a new connection to Redis.
         *
         * @param host Hostname or IP address
         * @param port Port number (defaults to 6379)
         * @throw ConnectionError
         */
        public AsyncConnection( string host, int port = 6379, MainContext? c = null ) throws ConnectionError {
            _context = Redis.async_connect(host, port);
            if (context == null || context.err > 0) {
                if (context != null) {
                    throw new ConnectionError.CONNECT_ERROR((string) context.errstr);
                } else {
                    throw new ConnectionError.LIBRARY_ERROR("Unable to allocate Redis context");
                }
            }

            // _context.data = this;
            var source = new Redis.Source(_context);
            source.attach(c);
            _context.set_connect_callback(connect_cb);
            _context.set_disconnect_callback(disconnect_cb);
        }

        public void disconnect() {
            _context.disconnect();
        }

        public void set_connect_callback( ConnectCallback cb ) {
            connect_callback = cb;
        }

        public void set_disconnect_callback( DisconnectCallback cb ) {
            disconnect_callback = cb;
        }

        static void connect_cb( Redis.AsyncContext context, Redis.RedisResponse status ) {
            stdout.printf("a\n");
            var ac = get_self(context);
            if (ac.verbose_callbacks) {
                ac.logger.info("Connect callback: Status %s", status == Redis.RedisResponse.OK ? "OK" : "ERROR" );
            }
            if (ac.connect_callback != null) {
                ac.connect_callback( ac, status == Redis.RedisResponse.OK ? Status.OK : Status.ERROR );
            }
        }

        private static void disconnect_cb( Redis.AsyncContext context, Redis.RedisResponse status ) {
            stdout.printf("b\n");
            var ac = get_self(context);
            if (ac.verbose_callbacks) {
                ac.logger.info("Disconnect callback: Status %s", status == Redis.RedisResponse.OK ? "OK" : "ERROR" );
            }
            if (ac.disconnect_callback != null) {
                ac.disconnect_callback( ac, status == Redis.RedisResponse.OK ? Status.OK : Status.ERROR );
            }
        }

        private static AsyncConnection get_self(Redis.AsyncContext context) {
            stdout.printf("getting self\n");
            return (AsyncConnection) context.data;
        }
    }
}