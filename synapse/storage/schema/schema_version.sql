/* Copyright 2015 OpenMarket Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CREATE TABLE IF NOT EXISTS schema_version(
    Lock char(1) NOT NULL DEFAULT 'X',  -- Makes sure this table only has one row.
    version INTEGER NOT NULL,
    upgraded BOOL NOT NULL,  -- Whether we reached this version from an upgrade or an initial schema.
    CONSTRAINT schema_version_lock_x CHECK (Lock='X')
    CONSTRAINT schema_version_lock_uniq UNIQUE (Lock)
);

CREATE TABLE IF NOT EXISTS applied_schema_deltas(
    version INTEGER NOT NULL,
    file TEXT NOT NULL,
    CONSTRAINT schema_deltas_ver_file UNIQUE (version, file) ON CONFLICT IGNORE
);

CREATE INDEX IF NOT EXISTS schema_deltas_ver ON applied_schema_deltas(version);
