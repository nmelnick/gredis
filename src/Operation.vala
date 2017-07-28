/*
 * Operation.vala
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
     * Core operation logic.
     */
    public interface Operation {
        public abstract Redis.Context context { get; }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a Redis.Reply.
         */
        public Redis.Reply oper(string format, ...) throws RedisError {
            var list = va_list();
            return voper( format, list );
        }

        /**
         * Run a hiredis operation with the given format and va_list, throw a
         * RedisError on error, otherwise, return a Redis.Reply.
         */
        public abstract Redis.Reply voper(string format, va_list l) throws RedisError;

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a boolean true if the response
         * is a status of "OK".
         */
        public bool oper_simple(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.STATUS) {
                if ( ( (string) reply.str ) == "OK" ) {
                    return true;
                }
            } else if (reply.type == Redis.ReplyType.ERROR) {
                throw new RedisError.GENERAL( (string) reply.str );
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d: %s".printf(reply.type, (string) reply.str));
            }
            return false;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a boolean true if the response
         * is an integer of 1, or false on 0.
         */
        public bool oper_intbool(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.INTEGER) {
                return ( reply.integer == 1 ? true : false );
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d: %s".printf(reply.type, (string) reply.str));
            }
            return false;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return the string value of the
         * response integer or string.
         */
        public string? oper_string(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.INTEGER) {
                return reply.integer.to_string();
            } else if (reply.type == Redis.ReplyType.STRING) {
                return (string) reply.str;
            } else if (reply.type == Redis.ReplyType.STATUS) {
                return (string) reply.str;
            } else if (reply.type == Redis.ReplyType.NIL) {
                return null;
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d: %s".printf(reply.type, (string) reply.str));
            }
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return the array response as a Gee
         * ArrayList.
         */
        public Gee.ArrayList<string> oper_arraylist(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type != Redis.ReplyType.ARRAY) {
                throw new RedisError.UNHANDLED("Unknown reply type %d: %s".printf(reply.type, (string) reply.str));
            }
            var array = new Gee.ArrayList<string>();
            for ( var i = 0; i < reply.element.length; i++ ) {
                array.add( (string) reply.element[i].str );
            }
            return array;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return the array response as a Gee
         * Set.
         */
        public Gee.Set<string> oper_set(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type != Redis.ReplyType.ARRAY) {
                throw new RedisError.UNHANDLED("Unknown reply type %d: %s".printf(reply.type, (string) reply.str));
            }
            var array = new Gee.HashSet<string>();
            for ( var i = 0; i < reply.element.length; i++ ) {
                array.add( (string) reply.element[i].str );
            }
            return array;
        }
    }
}
