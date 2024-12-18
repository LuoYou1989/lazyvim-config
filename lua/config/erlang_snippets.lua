local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require "luasnip.extras.postfix".postfix

local function read_fun_var(fun_head, var)
    local head = string.sub(fun_head, 1, 1)
    local result
    local fun_head_len = #fun_head
    if head == "[" then -- 读取列表
        result = string.match(fun_head, "^%b[]")
        if result then
            var.type = "list()"
            fun_head = string.sub(fun_head, #result + 1, fun_head_len)
            return read_fun_var(fun_head, var)
        end
    end
    if head == "#" then
        if fun_head_len > 1 then
            if string.sub(fun_head, 2, 2) == "{" then -- 读取map
                result = string.match(fun_head, "^#%b{}")
                if result then
                    var.type = "map()"
                    fun_head = string.sub(fun_head, #result + 1, fun_head_len)
                    return read_fun_var(fun_head, var)
                end
            else
                result = string.match(fun_head, "^#[%w_]+%b{}")
                if result then
                    var.type= "#".. string.match(fun_head, "^#([%w_]+)%b{}") .. "{}"
                    fun_head = string.sub(fun_head, #result + 1, fun_head_len)
                    return read_fun_var(fun_head, var)
                end
            end
        end
    end
    if head == "," then
        return string.sub(fun_head, 2, fun_head_len)
    end
    if head == "{" then
        result = string.match(fun_head, "^%b{}")
        if result then
            var.type = "tuple()"
            fun_head = string.sub(fun_head, #result + 1, fun_head_len)
            return read_fun_var(fun_head, var)
        end
    end
    if head == "=" then
        fun_head =  string.sub(fun_head, 2, fun_head_len)
        return read_fun_var(fun_head, var)
    end
    result = string.match(fun_head, "^(_*%u[%w_]*)")
    if result then
        var.name = result
        if var.type == nil then
            var.type = "any()"
        end
        fun_head = string.sub(fun_head, #result + 1, fun_head_len)
        return read_fun_var(fun_head, var)
    end
    result = string.match(fun_head, "^(_*[%w_]+)")
    if result then
        var.type = result
        fun_head = string.sub(fun_head, #result + 1, fun_head_len)
        return read_fun_var(fun_head, var)
    end
    return fun_head
end

local function get_fun_vars(fun_head)
    local vars = {}
    local index = 1
    local var
    while #fun_head > 0 do
        var = {}
        fun_head = read_fun_var(fun_head, var)
        if var.type then
            vars[index] = var
            index = index + 1
        else
            return vars
        end
    end
    return vars
end

local function get_vars_guards(vars)
    local guards = {}
    local index = 0
    for _, var in pairs(vars) do
        if var.name then
            index = index + 1
            guards[index] = var
        end
    end
    return index, guards
end

local function get_vars_spec1(vars)
    local vars1 = {}
    for index, var in pairs(vars) do
        if var.name then
            vars1[index] = var.name
        else
            vars1[index] = var.type
        end
    end
    return table.concat(vars1, ", ")

end

local function spec_add_guard(specs, guards, guard_num, input_num)
    for index, guard in pairs(guards) do
        if index == 1 then
            table.insert(specs, t("    when " .. guard.name .. " :: "))
        else
            table.insert(specs, t("    , " .. guard.name .. " :: "))
        end
        table.insert(specs, i(input_num, guard.type))
        if index == guard_num then
            table.insert(specs, t".")
        end
        table.insert(specs, t({"", ""}))
        input_num = input_num + 1
    end
end

local function get_fun_spec(func_head)
    local func_head1 = string.gsub(func_head, " ", "")
    local func_name, vars_str = string.match(func_head1, "^([%w_]*)(%b())")
    if func_name then
        vars_str = string.sub(vars_str, 2, -2)
        local vars = get_fun_vars(vars_str)
        local guard_num, guards = get_vars_guards(vars)
        if guard_num > 0 then
            local specs = {
                t "%% @doc "
                , i(1, "Annotation")
                , t({"", "-spec ".. func_name .. "(" .. get_vars_spec1(vars) .. ") -> "})
                , i(2, "any()")
                , t({"", ""})
            }
            spec_add_guard(specs, guards, guard_num, 3)
            table.insert(specs, t(func_head .. "->"))
            return specs
        else
            return {
                i(1, "")
                , t "%% @doc "
                , i(2, "Annotation")
                , t({"", "-spec ".. func_name .. "(" .. get_vars_spec1(vars) .. ") -> "})
                , i(3, "any()")
                , t(".")
                , t({"", func_head .. "->"})
            }
        end
    end
    return t(func_head .. "->")
end

ls.add_snippets("erlang"
    , {
        postfix(
            {trig = "-", match_pattern = "^(.*)$", desc = "func -spec"}
            ,{
                d(1, function (_, parent)
                    local match_str = parent.snippet.env.POSTFIX_MATCH
                    if match_str then
                        return sn(nil, get_fun_spec(match_str))
                    end
                    return sn(nil, isn(1, t({"->", ""}), ""))
                end, {})
            }
        )
    }
)
