using Gee;

namespace GRedis {
    public class RedisMap : AbstractMap<string,string> {
        private GRedis.Connection connection;
        private string name = null;
        public LogHandler logger { get; set; default = new LogHandler(); }

        /**
         * {@inheritDoc}
         */
        public override Set<Map.Entry<string,string>> entries { owned get { return null; } }

        /**
         * {@inheritDoc}
         */
        public override bool read_only { get { return false; } }

        /**
         * {@inheritDoc}
         */
        public override int size { get {
            try {
                return (int) connection.hlen(name);
            } catch (RedisError e) {
                return 0;
            }
        } } 

        /**
         * {@inheritDoc}
         */
        public override Set<string> keys { owned get { return null; } }

        /**
         * {@inheritDoc}
         */
        public override Collection<string> values { owned get { return null; } }


        public RedisMap(GRedis.Connection connection, string name) {
            this.connection = connection;
            this.name = name;
            assert( name != null );
        }

        public override void clear() {

        }

        public override string @get(string key) {
            try {
                return connection.hget( name, key );
            } catch (RedisError e) {}
            return null;
        }

        public override bool has(string key, string value) {
            return ( has_key(key) && get(key) == value );
        }

        public override bool has_key(string key) {
            try {
                return connection.hexists( name, key );
            } catch (RedisError e) {
                return false;
            }
        }

        public override MapIterator<string, string> map_iterator() {
            return null;
        }

        public override void @set(string key, string value) {
            try {
                connection.hset( name, key, value );
            } catch (RedisError e) {}
        }

        public override bool unset(string key, out string value = null) {
            if ( has_key(key) ) {
                value = get(key);
                try {
                    var num = connection.hdel( name, key );
                    return (num > 0);
                } catch (RedisError e) {
                    return false;
                }
            }
            return false;
        }
    }
}