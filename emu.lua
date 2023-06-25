
register_meta("yoho", function(meta)
    print(meta.name)
    print(meta.text)
    print(#meta.blocks)
    print(meta.blocks[1].contents)
end)

byte_fn = get_meta_fn("byte")
register_meta("byte", function(meta)
    print("BYTE")
    print(meta.args[1])
    byte_fn(meta)
end)

-- CHAR OUT
map_jsr(0xffd2, function(adr)
    c = reg_a()
    if c == 13 then c = 10 end
    io.write(string.char(c))
end)

name = nil

-- LOAD
map_jsr(0xf322, function(ard)
    a = mem_read(0xd1)
    xy = (mem_read(0xdb)<<8) | mem_read(0xda)

    name = ''
    for i=0,a-1 do
        c = mem_read(xy+i)
        name = name .. string.char(c)
    end
    print("SET NAME:" .. name)
    cbm_load(name)
end)

-- READ KEYBOARD
map_jsr(0xffe4, function(adr)
    a = mem_read(0xd709)
    if a == KEY_DOWN then
        a = 0x11
    elseif a == KEY_UP then
        a = 0x91
    elseif a == KEY_RIGHT then
        a = 29
    elseif a == KEY_LEFT then
        a = 157
    elseif a == KEY_F7 then
        a = 136
    elseif a == KEY_F1 then
        a = 133
    end
    set_a(a)
end)
