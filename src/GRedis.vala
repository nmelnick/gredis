/*
 * GRedis.vala
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

    /**
     * Core connection class for GRedis. To open a connection to a Redis server,
     * create a new instance with a host and a port.
     *
     * This uses composition to add Redis methods for use in a Connection. For
     * documentation on each method, look in the various Operation classes for
     * the type of action required. Operations on root keys are SingleOperation,
     * hash in HashOperation, list in ListOperation.
     *
     * One may access the underlying Hiredis context in the context property.
     */
    public class Connection : Object, Operation, DatabaseOperation,
                              SingleOperation, SetOperation, HashOperation, ListOperation {
        private Redis.Context _context;
        /**
         * Underlying Hiredis context.
         */
        public Redis.Context context { get { return _context; } }
        private static LogHandler logger { get; set; default = new LogHandler(); }

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
