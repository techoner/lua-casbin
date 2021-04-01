--Copyright 2021 The casbin Authors. All Rights Reserved.
--
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.

local util = require("src.util.Util")

describe("util tests", function()

    it("test arrayToString", function()
        assert.are.equals(Util.arrayToString({"data", "data1", "data2", "data3"}), "data, data1, data2, data3")
    end)

    it("test splitCommaDelimited", function()
        assert.are.same(Util.splitCommaDelimited("a,b,c"), {"a", "b", "c"})
        assert.are.same(Util.splitCommaDelimited("a, b, c"), {"a", "b", "c"})
        assert.are.same(Util.splitCommaDelimited("a ,b ,c"), {"a", "b", "c"})
        assert.are.same(Util.splitCommaDelimited("  a,     b   ,c     "), {"a", "b", "c"})
    end)

    it("test escapeAssertion", function()
        assert.are.equals(Util.escapeAssertion("r.attr.value == p.attr"),"r_attr.value == p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value || p.attr"),"r_attp.value || p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value &&p.attr"),"r_attp.value &&p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value >p.attr"),"r_attp.value >p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value <p.attr"),"r_attp.value <p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value -p.attr"),"r_attp.value -p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value +p.attr"),"r_attp.value +p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value *p.attr"),"r_attp.value *p_attr")
        assert.are.equals(Util.escapeAssertion("r.attp.value /p.attr"),"r_attp.value /p_attr")
        assert.are.equals(Util.escapeAssertion("!r.attp.value /p.attr"),"!r_attp.value /p_attr")
        assert.are.equals(Util.escapeAssertion("g(r.sub, p.sub) == p.attr"),"g(r_sub, p_sub) == p_attr")
        assert.are.equals(Util.escapeAssertion("g(r.sub,p.sub) == p.attr"),"g(r_sub,p_sub) == p_attr")
        assert.are.equals(Util.escapeAssertion("(r.attp.value || p.attr)p.u"),"(r_attp.value || p_attr)p_u")
    end)

    it("test removeComments", function()
        assert.are.equals(Util.removeComments("r.act == p.act # comments"), "r.act == p.act")
        assert.are.equals(Util.removeComments("r.act == p.act#comments"), "r.act == p.act")
        assert.are.equals(Util.removeComments("r.act == p.act###"), "r.act == p.act")
        assert.are.equals(Util.removeComments("### comments"), "")
        assert.are.equals(Util.removeComments("r.act == p.act"), "r.act == p.act")
    end)

    it("test arrayEquals", function()
        assert.is.True(Util.arrayEquals({"a", "b", "c"},{"a", "b", "c"}), true)
        assert.is.False(Util.arrayEquals({"a", "b", "c"},{"a", "b"}), false)
        assert.is.False(Util.arrayEquals({"a", "b", "c"},{"a", "c", "b"}), false)
        assert.is.False(Util.arrayEquals({"a", "b", "c"},{}), false)
    end)

    it("test array2DEquals", function()
        assert.is.True(Util.array2DEquals({{"a", "b", "c"}, {"1", "2", "3"}},{{"a", "b", "c"}, {"1", "2", "3"}}), true)
        assert.is.False(Util.array2DEquals({{"a", "b", "c"}, {"1", "2", "3"}}, {{"a", "b", "c"}}), false)
        assert.is.False(Util.array2DEquals({{"a", "b", "c"}, {"1", "2", "3"}}, {{"a", "b", "c"}, {"1", "2"}}), false)
        assert.is.False(Util.array2DEquals({{"a", "b", "c"}, {"1", "2", "3"}}, {{"1", "2", "3"}, {"a", "b", "c"}}), false)
        assert.is.False(Util.array2DEquals({{"a", "b", "c"}, {"1", "2", "3"}}, {}), false)
    end)

    it("test arrayRemoveDuplications", function()
        assert.are.same(Util.arrayRemoveDuplications({"data", "data1", "data2", "data1", "data2", "data3"}),{'data', 'data1', 'data2', 'data3'})
    end)

    it("test trim", function()
        assert.are.equals(Util.trim("abc"),"abc")
        assert.are.equals(Util.trim(" abc "),"abc")
        assert.are.equals(Util.trim("abc   "),"abc")
        assert.are.equals(Util.trim("   abc"),"abc")
    end)

    it("test split", function()
        assert.are.same(Util.split("a ,b ,c", ","), {"a", "b", "c"})
        assert.are.same(Util.split("a,b,c", ","), {"a", "b", "c"})
        assert.are.same(Util.split("a, b, c", ","), {"a", "b", "c"})
        assert.are.same(Util.split("  a,     b   ,c     ", ","), {"a", "b", "c"})
    end)

    it("test isInstance", function()
        local parent = {}
        parent.__index = parent
        local child = {}
        setmetatable(child, parent)
        local notChild = {}
        assert.is.True(Util.isInstance(child, parent))
        assert.is.False(Util.isInstance(notChild, parent))
    end)
end)
