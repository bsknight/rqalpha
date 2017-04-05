# -*- coding: utf-8 -*-
#
# Copyright 2017 Ricequant, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import six


def to_utf8(string):
    try:
        if six.PY2:
            return string.encode('utf-8')
        else:
            return string
    except AttributeError:
        return to_utf8(str(string))
    except UnicodeDecodeError:
        return to_utf8(unicode(string, 'utf-8'))


def from_utf8(string):
    try:
        return string.decode('utf-8')
    except AttributeError:
        return string

try:
    from functools import lru_cache
except ImportError:
    from fastcache import lru_cache
