/*
 * HashOperation.vala
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

        /**
         * Returns all field names in the hash stored at key.
         *
         * @param key Hash key
         */
        public Gee.List<string> hkeys(string key) throws RedisError {
            return oper_arraylist("HKEYS %s", key).read_only_view;
        }

        /**
         * Returns all values in the hash stored at key.
         *
         * @param key Hash key
         */
        public Gee.List<string> hvals(string key) throws RedisError {
            return oper_arraylist("HVALS %s", key).read_only_view;
        }

        /**
         * Returns all fields and values of the hash stored at key. In the
         * returned value, every field name is followed by its value, so the
         * length of the reply is twice the size of the hash.
         *
         * @param key Hash key
         */
        public Gee.List<string> hgetall(string key) throws RedisError {
            return oper_arraylist("HGETALL %s", key).read_only_view;
        }

        /**
         * Returns all fields and values of the hash stored at key as a Gee
         * HashMap.
         *
         * @param key Hash key
         */
        public Gee.HashMap<string,string> hgetall_hm(string key) throws RedisError {
            var reply = oper("HGETALL %s", key);
            if (reply.type != Redis.ReplyType.ARRAY) {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
            var hm = new Gee.HashMap<string,string>();
            for ( var i = 0; i < reply.element.length; i++ ) {
                hm.set( (string) reply.element[i].str, (string) reply.element[i + 1].str );
                i++;
            }
            return hm;
        }
    }
}